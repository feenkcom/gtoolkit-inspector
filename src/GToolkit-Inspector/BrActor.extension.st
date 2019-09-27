Extension { #name : #BrActor }

{ #category : #'*GToolkit-Inspector' }
BrActor >> gtChildrenFor: aView [
	<gtView>
	self children ifEmpty: [ ^ aView empty ].
	^ aView list
		title: 'Children';
		priority: 80;
		items: [ self children ]
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

{ #category : #'*GToolkit-Inspector' }
BrActor >> gtPreviewFor: aView [
	<gtView>
	self isAttachedToWidget ifFalse: [ ^ aView empty ].
	^ self widget gtPreviewFor: aView
]
