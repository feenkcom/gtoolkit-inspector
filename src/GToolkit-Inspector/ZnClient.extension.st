Extension { #name : #ZnClient }

{ #category : #'*GToolkit-Inspector' }
ZnClient >> gtCloseActionFor: anAction [
	<gtAction>
	self isConnected ifFalse: [ ^ anAction noAction ].
	^ anAction button
		icon: BrGlamorousVectorIcons shutdown;
		tooltip: 'Close HTTP client connection';
		priority: 10;
		action: [ self close ]
]

{ #category : #'*GToolkit-Inspector' }
ZnClient >> gtCurlFor: aView [
	<gtView>
	
	self request ifNil: [ ^ aView empty ].
	self request requestLine ifNil: [ ^ aView empty ].
	self request method ifNil: [ ^ aView empty ].
	self request uri ifNil: [ ^ aView empty ].
	
	^ aView textEditor
		title: 'CURL';
		priority: 80;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		text: [ [ self curl ] on: Error do: [ :anException | 
			'Client is not initialized yet: ', anException displayString  ] ]
]

{ #category : #'*GToolkit-Inspector' }
ZnClient >> gtHttpFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'HTTP';
		  priority: 30;
		  items: [ {
			{ 'request' 
				. self request 
					ifNil: [ '' ] 
					ifNotNil: [
						self request requestLine 
							ifNil: [ '' ]
							ifNotNil: [ :line | 
								String streamContents: [ :out |
									line printMethodAndUriOn: out.
									line version ifNotNil: [ :version | out space; nextPutAll: version ] ] ] ]
				. self  request}.
			{ 'response'
				. self response 
					ifNil: [ '' ]
					ifNotNil: [
						self response statusLine
							ifNil: [ '' ]
							ifNotNil: [ :line | String streamContents: [ :out | line writeOn: out ] ] ] 
				. self response }.
			{ 'connected' . self isConnected. self connection }.
			{ 'success' . self response ifNil: [ '' ] ifNotNil: [ self isSuccess ]. self response }.
			{ 'log level' . logLevel }.
			{ 'last used' . lastUsed ifNil: [ '' ] ifNotNil: [ DateAndTime fromUnixTime: lastUsed ] } } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last;
		  actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
ZnClient >> gtOptionsFor: aView [
	<gtView>
	^ aView forward 
		title: 'Options';
		priority: 50;
		object: [ | allBindings |
			allBindings := self localOptions allBindings.
			(ZnClient gtMethodsInClass 
				& (#optionAt:ifAbsent: gtReferences | #optionAt:ifAbsentPut: gtReferences)) contents 
					do: [ :each | | selector |
						selector := each selector.
						selector numArgs isZero ifTrue: [ 
							allBindings at: selector put: (self perform: selector) ] ].
			OrderedDictionary withAll: (allBindings associations sort: #key ascending) ];
		view: #gtTreeFor:
]
