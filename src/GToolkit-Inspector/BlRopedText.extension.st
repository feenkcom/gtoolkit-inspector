Extension { #name : #BlRopedText }

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtTreeFor: aView [
	<gtView>
	^ self rope 
		ifNil: [ aView empty ]
		ifNotNil: [ self rope gtTreeFor: aView ]
]
