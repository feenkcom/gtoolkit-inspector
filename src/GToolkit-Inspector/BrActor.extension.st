Extension { #name : #BrActor }

{ #category : #'*GToolkit-Inspector' }
BrActor >> gtChildrenFor: aView [
	<gtView>
	self children ifEmpty: [ ^ aView empty ].
	^ aView tree
		title: 'Children';
		priority: 80;
		items: [ self children ];
		children: #children
]

{ #category : #'*GToolkit-Inspector' }
BrActor >> gtFiltersFor: aView [
	<gtView>
	^ self eventDispatcher gtFiltersFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BrActor >> gtHandlersFor: aView [
	<gtView>
	^ self eventDispatcher gtHandlersFor: aView
]
