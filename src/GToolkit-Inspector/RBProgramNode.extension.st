Extension { #name : #RBProgramNode }

{ #category : #'*GToolkit-Inspector' }
RBProgramNode >> gtTreeFor: aView [
	<gtView> 
	| visitor wrapperFactory |	
	wrapperFactory := RBNodeWrapperFactory new. 
	^ aView mondrian
		title: 'Tree';
		priority: 60;
		painting: [ :view | 
			view nodes shape: [ :each |
				| textElement text |
				text := BlRopedText string: ((each printString) truncateTo:30).
				textElement := BlTextElement new.
				textElement text: text.
				textElement 
				];	
			with: ((self withDeepCollect: #children) collect: [ :each | wrapperFactory wrapperFor: each ]).
			"self halt."
			view edges shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.4) width: 3);
						toHead: (BlArrowheadSimpleArrow new
							border: (BlBorder builder paint: (Color gray alpha: 0.4); width: 3; build))];
						connectFrom: #parent.
			view layout tree ].
]
