Extension { #name : #TextDiffBuilder }

{ #category : #'*GToolkit-Inspector' }
TextDiffBuilder >> asElement [
	^ GtDiffElement on: self
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
				append: string asRopedText;
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
				append: string asRopedText;
				append: String cr asRopedText ].
	^ text
]
