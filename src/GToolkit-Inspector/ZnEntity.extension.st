Extension { #name : #ZnEntity }

{ #category : #'*GToolkit-Inspector' }
ZnEntity >> gtEntityFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'Entity';
		  priority: 40;
		  items: [ {
		    { 'entity' . self class . self }.
			{ 'content type' . self contentType ifNil: [ ' ' ] . self contentType}.
			{ 'content length' . self contentLength ifNil: [ '' ] . self contentLength }} ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]
