Extension { #name : #BlDevScripterStepProperties }

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStepProperties >> gtPropertiesFor: aView [
	<gtView>
	properties ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Properties';
		priority: 1;
		items: [ self properties ];
		column: 'Type' text: #className;
		column: 'Description' text: #description weight: 2;
		actionUpdateButton
]
