Extension { #name : 'BlHandlerRegistry' }

{ #category : '*GToolkit-Inspector' }
BlHandlerRegistry >> gtHandlersFor: aView [
	<gtView>
	^ aView list
		title: 'Handlers';
		items: [ self handlers ]
]
