Extension { #name : #TextDiffBuilder }

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> asElement [
	| element left right |
	element := BlElement new.
	element
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	left := BrTextEditor new.
	left text: self previousRopedText.
	self newStyler ifNotNil: [ :styler | left styler: styler ].
	element
		addChild:
			(BrEditor new
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				look: BrGlamorousCodeEditorLook new;
				editor: left).
	right := BrTextEditor new.
	right text: self newRopedText.
	self newStyler ifNotNil: [ :styler | right styler: styler ].
	element
		addChild:
			(BrEditor new
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent ];
				look: BrGlamorousCodeEditorLook new;
				editor: right).
	^ element
]

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> newRopedText [
	| text |
	text := '' asRopedText.
	self
		patchSequenceDoIfMatch: [ :string | 
			text
				append: string asRopedText;
				append: String cr asRopedText ]
		ifInsert: [ :string | 
			text
				append:
					(string asRopedText
						attributes:
							{(BlTextUnderlineAttribute new
								paint: Color green;
								width: 2;
								beNotOverwritableByStyler)});
				append: String cr asRopedText ]
		ifRemove: [ :string |  ].
	^ text
]

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> newStyler [
	^ nil
]

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> previousRopedText [
	| text |
	text := '' asRopedText.
	self
		patchSequenceDoIfMatch: [ :string | 
			text
				append: string asRopedText;
				append: String cr asRopedText ]
		ifInsert: [ :string |  ]
		ifRemove: [ :string | 
			text
				append:
					(string asRopedText
						attributes:
							{(BlTextUnderlineAttribute new
								paint: Color red;
								width: 2;
								beNotOverwritableByStyler)});
				append: String cr asRopedText ].
	^ text
]
