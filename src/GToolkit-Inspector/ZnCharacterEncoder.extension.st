Extension { #name : #ZnCharacterEncoder }

{ #category : #'*GToolkit-Inspector' }
ZnCharacterEncoder class >> gtSpotterCharacterEncodersFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Character encoders';
		items: [ (self knownEncodingIdentifiers collect: [ : id | id asZnCharacterEncoder]) sort: #identifier ascending ];
		itemName: [ :encoder | encoder identifier ];
		filterBySubstring
]

{ #category : #'*GToolkit-Inspector' }
ZnCharacterEncoder >> gtViewEncoderDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 10;
		items: [ { 
			('identifier' -> self identifier).
			('encoding length' -> (self isFixedLength ifTrue: [ #fixed ] ifFalse: [ #variable ])).
			('strict' -> self isStrict).
			('endianness' -> self endianness) } ];
		  column: 'Key' text: #key;
		  column: 'Value' text: #value;
		  send: #value
]

{ #category : #'*GToolkit-Inspector' }
ZnCharacterEncoder class >> gtViewEncodingIdentifiersFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Encodings';
		priority: 9;
		items: [ self knownEncodingIdentifiers sorted: #yourself ascending ];
		column: 'Id' text: [ :id | id ];
		send: [ :id | self newForEncoding: id ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					object: self;
					tooltip: 'Search character encoders by identifier';
					id: GtPharoSearchCodeButtonId;
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						(anItem isKindOf: ZnCharacterEncoder) ifTrue: [ 
							| columnedList |
							columnedList := theButton phlow viewContent 
								allChildrenBreadthFirstDetect: [ :child | 
									child isKindOf:  BrColumnedList ] 
								ifFound: [ :child | child ].
							columnedList scrollToItem: anItem.
							columnedList selectOne: (columnedList items indexOf: anItem).
							anActOnEvent beActed ] ];
					asElement ]
			tooltip: 'Search character encoders by identifier'
]
