Extension { #name : #TKTWatchDog }

{ #category : #'*GToolkit-Inspector' }
TKTWatchDog >> gtQueueFor: aView [
	<gtView>
	^ self pool 
		ifNil: [ aView empty ] 
		ifNotNil: [ :aPool | aPool gtQueueFor: aView ]
]
