Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*GToolkit-Inspector' }
TKTCommonQueueWorkerPool >> gtFailedTasksFor: aView [
	failedTasks ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Failed Tasks';
		items: [ failedTasks ]
]
