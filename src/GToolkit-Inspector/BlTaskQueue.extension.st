Extension { #name : 'BlTaskQueue' }

{ #category : '*GToolkit-Inspector' }
BlTaskQueue >> gtTasksFor: aView [
	<gtView>
	^ aView list 
		title: 'Tasks';
		items: [ self tasks ifNil: [ #() ] ];
		actionUpdateButtonTooltip: 'Update task list'
]
