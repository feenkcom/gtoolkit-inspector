Extension { #name : #Character }

{ #category : #'*GToolkit-Inspector' }
Character >> gtViewCharacterDetailsFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Details';
		  items: [ 
			  { 
				  ('self' -> self).
				  ('codepoint' -> self codePoint).
				  ('unicode' -> (String streamContents: [ :stream | 
							    stream << 'U+'.
							    self codePoint printOn: stream base: 16 nDigits: 4 ])) } ];
		  column: 'Key' text: #key;
		  column: 'Value' text: [ :each | each value printString ];
		  send: #value
]
