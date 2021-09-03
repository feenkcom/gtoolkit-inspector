Extension { #name : 'MetaLink' }

{ #category : '*GToolkit-Inspector' }
MetaLink >> gtOptionsFor: aView [
	<gtView>
	self options ifNil: [ ^ aView empty ].
	^ aView list
		title: 'Options';
		priority: 20;
		items: [ self options asSortedCollection ]
]

{ #category : '*GToolkit-Inspector' }
MetaLink >> gtPluginsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Plugins';
		priority: 5;
		items: [ RFReification subclasses ];
		column: 'Plugin' text: #yourself;
		column: 'Supported Nodes' text: #entities weight: 2.
]
