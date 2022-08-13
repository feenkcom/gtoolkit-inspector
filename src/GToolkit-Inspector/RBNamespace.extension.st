Extension { #name : #RBNamespace }

{ #category : #'*GToolkit-Inspector' }
RBNamespace >> gtApplyingChangesFor: aView [
	<gtView>
	self changes ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Applying changes';
		priority: 1;
		object: [ self changes ];
		view: #gtApplyingChangesFor:
]

{ #category : #'*GToolkit-Inspector' }
RBNamespace >> gtChangedClassesFor: aView [
	<gtView>
	changedClasses ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Changed classes';
		priority: 29;
		object: [ changedClasses ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Inspector' }
RBNamespace >> gtChangesFor: aView [
	<gtView>
	self changes ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Changes';
		priority: 2;
		object: [ self changes ];
		view: #gtChangesFor:
]

{ #category : #'*GToolkit-Inspector' }
RBNamespace >> gtRemovedClassesFor: aView [
	<gtView>
	removedClasses ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Removed classes';
		priority: 30;
		items: [ removedClasses asOrderedCollection ]
]
