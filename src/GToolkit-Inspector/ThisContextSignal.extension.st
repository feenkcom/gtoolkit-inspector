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
	^ aView list
		title: 'Stack';
		priority: 50;
		items: [  self stack ]
]

{ #category : #'*GToolkit-Inspector' }
ThisContextSignal >> gtViewTopMethodFor: aView [
	<gtView>
	^ self stack 
		ifEmpty: [ aView empty  ]
		ifNotEmpty: [ :aStack |
			aStack first gtSourceFor: aView ]
]
