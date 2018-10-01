Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtSourceCodeFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source code';
		stencil: [ 
			| editor text styler |
			text := self source asRopedText.
			editor := BrTextEditor new text: text.
			styler := BrRBTextStyler new.
			styler classOrMetaClass: self methodNode compiledMethod methodClass.
			editor styler: styler.
			text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler }.
			text 
				attributes: {
					BrTextUnderlineAttribute new 
						paint: (BrGlamorousColors lightBorderColor alpha: 0.5); 
						beNotOverwritableByStyler} 
				from: self start 
				to: self stop.
			BrEditorElement new
				editor: editor;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtTreeFor: aView [
	<gtView> 
	| wrapperFactory |	
	wrapperFactory := RBNodeWrapperFactory new. 
	^ aView mondrian
		title: 'Tree';
		priority: 60;
		painting: [ :view | 
			view nodes 
				shape: [ :each |
					| textElement text |
					text := BlRopedText string: ((each printString) truncateTo:30).
					textElement := BlTextElement new.
					textElement text: text.
					textElement 	
						when: BlClickEvent 
						do: [ :e | 
							textElement fireEvent: (GtPhlowObjectToSpawn new object: each node; sourceElement: textElement).
							e consumed: true ].
					textElement ];	
				with: ((self withDeepCollect: #children) collect: [ :each | wrapperFactory wrapperFor: each ]).
			view edges connectFrom: #parent.
			view layout tree ].
]
