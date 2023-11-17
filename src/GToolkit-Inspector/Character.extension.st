Extension { #name : #Character }

{ #category : #'*GToolkit-Inspector' }
Character >> gtPreviewFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Preview';
		priority: 10;
		glamorousCodeFontAndSize;
		fontSize: 64;
		text: [ self ]
]

{ #category : #'*GToolkit-Inspector' }
Character >> gtViewCharacterDetailsFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Details';
		  items: [ { 
			('self' -> self).
			('codepoint' -> self codePoint).
			('unicode' -> (String streamContents: [ :stream | 
								stream << 'U+'.
								self codePoint printOn: stream base: 16 nDigits: 4 ])).
			('unicode character data' -> ([ self unicodeCharacterData ] on: NotFound do: [ '' ])) } ];
		  column: 'Key' text: #key;
		  column: 'Value' text: #value;
		  send: #value
]

{ #category : #'*GToolkit-Inspector' }
Character >> gtViewUnicodeCharacterDetailsIn: composite [
	<gtView>
	| unicodeCharacterData |
	unicodeCharacterData := [ self unicodeCharacterData ] on: NotFound do: [ ^ composite empty ].
	^ composite forward
		title: 'Unicode';
		object: [ unicodeCharacterData ];
		view: #gtViewDetailsIn:
]
