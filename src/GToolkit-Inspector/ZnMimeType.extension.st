Extension { #name : #ZnMimeType }

{ #category : #'*GToolkit-Inspector' }
ZnMimeType >> gtMimeTypeFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'MIME type';
		  priority: 20;
		  items: [ {
			{ 'MIME type' . self }.
			{ 'main' . self main }.
			{ 'sub' . self sub }.
			{ 'parameters'
				. String streamContents: [ :out | | first |
					first := true.
					self parameters keysAndValuesDo: [ :key : value |
						first ifFalse: [ out nextPut: $; ].
						first := false.
						out nextPutAll: key; nextPut: $=; nextPutAll: value ] ]
				. self parameters }.
			{ 'binary' . self isBinary }.
			{ 'vendor specific' . self isVendorSpecific } } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]
