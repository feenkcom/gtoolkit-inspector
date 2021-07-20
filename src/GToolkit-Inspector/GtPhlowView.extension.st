Extension { #name : 'GtPhlowView' }

{ #category : '*GToolkit-Inspector' }
GtPhlowView >> gtUpdateDefinitionsFor: aView [
	<gtView>
	self autoUpdates ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'Auto Updates';
		priority: 7;
		object: [ self autoUpdates ];
		view: #gtDefinitionsFor:
]
