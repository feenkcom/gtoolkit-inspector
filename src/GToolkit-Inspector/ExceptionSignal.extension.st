Extension { #name : #ExceptionSignal }

{ #category : #'*GToolkit-Inspector' }
ExceptionSignal class >> gtExampleEmpty [
	<gtExample>
	<label: 'Empty'>
	
	^ self new
]

{ #category : #'*GToolkit-Inspector' }
ExceptionSignal >> gtExceptionStackFor: aView [
	<gtView>
	^ aView tree
		title: 'Exception stack';
		items: [ self exceptionStack ];
		priority: 16;
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
