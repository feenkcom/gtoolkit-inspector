Extension { #name : #ZnRequestLine }

{ #category : #'*GToolkit-Inspector' }
ZnRequestLine >> gtHttpFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'HTTP';
		  priority: 30;
		  items: [ {
			{ 'request line' . String streamContents: [ :out | self writeOn: out ] . self }.
			{ 'method' . self method ifNil: [ '' ] . self method }.
			{ 'uri' . self uri ifNil: [ '' ] . self uri }.
			{ 'version' . self version ifNil: [ '' ] . self version } } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]

{ #category : #'*GToolkit-Inspector' }
ZnRequestLine >> gtQueryFor: aView [
	<gtView>
	^ aView forward
		title: 'Query';
		priority: 40;
		object: [ self uri ];
		view: #gtQueryFor:
]
