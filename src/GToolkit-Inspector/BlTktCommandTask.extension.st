Extension { #name : 'BlTktCommandTask' }

{ #category : '*GToolkit-Inspector' }
BlTktCommandTask >> gtBlockClosureFor: aView [
	<gtView>
	^ self command
		ifNil: [ aView empty ] 
		ifNotNil: [ :aValuable | aValuable gtBlockClosureFor: aView ]
]

{ #category : '*GToolkit-Inspector' }
BlTktCommandTask >> gtDecoratedCommandsFor: aView [
	<gtView>
	^ self command 
		ifNil: [ aView empty ]
		ifNotNil: [ :aCommand | aCommand gtDecoratedCommandsFor: aView ]
]
