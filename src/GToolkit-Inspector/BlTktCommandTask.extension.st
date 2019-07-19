Extension { #name : #BlTktCommandTask }

{ #category : #'*GToolkit-Inspector' }
BlTktCommandTask >> gtBlockClosureFor: aView [
	<gtView>
	^ self command
		ifNil: [ aView empty ] 
		ifNotNil: [ :aValuable | aValuable gtBlockClosureFor: aView ]
]
