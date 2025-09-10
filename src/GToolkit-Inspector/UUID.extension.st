Extension { #name : #UUID }

{ #category : #'*GToolkit-Inspector' }
UUID >> gtUUIDDetailsFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Details';
		  priority: 10;
		  items: [ { 
			('string' -> self printString).
			('string36' -> self asString36). } ];
		  column: 'Key' text: #key;
		  column: 'Value' text: #value weight: 5;
		  send: #value
]

{ #category : #'*GToolkit-Inspector' }
UUID >> gtUuidDataFor: aView [
	<gtView>
	
	self forPharo12AndNewer: [] forPharo11: [ ^ aView empty ].

	^ aView forward
		title: 'Hex dump';
		object: [ self uuidData ];
		view: #gtHexDumpFor:
]
