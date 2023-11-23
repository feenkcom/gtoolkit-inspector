Extension { #name : #ZnStatusLine }

{ #category : #'*GToolkit-Inspector' }
ZnStatusLine >> gtHttpFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'HTTP';
		  priority: 30;
		  items: [ {
			{ 'status line' . String streamContents: [ :out | self writeOn: out ] . self }.
			{ 'version' . self version ifNil: [ '' ] . self version }.
			{ 'code' . self code ifNil: [ '' ] . self code }.
			{ 'reason' . self reason ifNil: [ '' ] . self reason } } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]
