Extension { #name : #ThisContextSignal }

{ #category : #'*GToolkit-Inspector' }
ThisContextSignal class >> gtExampleMethodStackSignal [
	<gtExample>
	<label: 'MethodStackSignal'>
	
	^ MethodStackSignal new
]

{ #category : #'*GToolkit-Inspector' }
ThisContextSignal >> gtStackFor: aView [
	<gtView>
	^ aView tree
		title: 'Stack';
		items: [ self stack ];
		priority: 15;
		children: [ :anItem | anItem isContext ifTrue: [ anItem gtVariables ] ifFalse: [ #() ] ];
		itemText: [ :anItem | 
			anItem isContext
				ifTrue: [ anItem ]
				ifFalse: [ anItem name asRopedText
						append: ' := ' asRopedText;
						foreground: BrGlamorousColors disabledButtonTextColor;
						append: anItem description ] ];
		send: [ :anItem | anItem isContext ifTrue: [ anItem ] ifFalse: [ anItem value ] ]
]

{ #category : #'*GToolkit-Inspector' }
ThisContextSignal >> gtViewTopMethodFor: aView [
	<gtView>
	^ self stack 
		ifEmpty: [ aView empty  ]
		ifNotEmpty: [ :aStack |
			aStack first gtSourceFor: aView ]
]
