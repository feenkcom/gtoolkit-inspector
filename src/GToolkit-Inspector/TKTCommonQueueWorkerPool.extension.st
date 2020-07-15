Extension { #name : #TKTCommonQueueWorkerPool }

{ #category : #'*GToolkit-Inspector' }
TKTCommonQueueWorkerPool >> gtFailedTasksFor: aView [
	<gtView>
	failedTasks isEmptyOrNil
		ifTrue: [ ^ aView empty ].
	^ aView list
		title: 'Failed Tasks';
		items: [ self failedTasks ];
		itemText: [ :anExecution | anExecution name ];
		actionButtonIcon: BrGlamorousIcons trash
			tooltip: 'Remove failed tasks'
			action: [ :aButton :aTab | 
				failedTasks := OrderedCollection new.
				aTab viewContentElement phlow update ];
		actionUpdateButtonTooltip: 'Update failed tasks list'
]

{ #category : #'*GToolkit-Inspector' }
TKTCommonQueueWorkerPool >> gtQueueFor: aView [
	<gtView>
	^ aView list
		title: 'Queue';
		priority: 90;
		items: [ self taskQueue itemArray reject: #isZombie thenCollect: #object ];
		itemText: [ :eachExecution | 
			[ eachExecution ifNotNil: #name ]
				on: Error
				do: [ :ex | '(unknown name)' ] ];
		send: [ :eachExecution | eachExecution ifNotNil: #task ]
]
