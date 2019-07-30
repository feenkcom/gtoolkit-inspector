Extension { #name : #TKTWatchDog }

{ #category : #'*GToolkit-Inspector' }
TKTWatchDog >> gtQueueFor: aView [
	<gtView>

	^pool first gtQueueFor: aView
]
