Extension { #name : #ZnSimplifiedByteEncoder }

{ #category : #'*GToolkit-Inspector' }
ZnSimplifiedByteEncoder >> gtViewByteDomainFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Byte domain';
		priority: 20;
		items: [ self byteDomain sorted: #yourself ascending ];
		column: 'Decimal' text: [ :byte | byte ];
		column: 'Hexadecimal' text: [ :byte |
			String streamContents: [ :stream | 
				byte printOn: stream base: 16 nDigits: 2 ] ];
		column: 'Decoded character' text: [ :byte |
			(self decodeBytes: (ByteArray with: byte)) first ];
		column: 'Decoded codepoint' text: [ :byte |
			(self decodeBytes: (ByteArray with: byte)) first codePoint ];
		column: 'Decoded unicode' text: [ :byte | 
			String streamContents: [ :stream | 
				stream << 'U+'.
				(self decodeBytes: (ByteArray with: byte)) 
					first codePoint printOn: stream base: 16 nDigits: 4 ] ]
]

{ #category : #'*GToolkit-Inspector' }
ZnSimplifiedByteEncoder >> gtViewCharacterDomainFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Character domain';
		priority: 15;
		items: [ self characterDomain sorted: #yourself ascending ];
		column: 'Character' text: [ :character | character ];
		column: 'Codepoint' text: [ :character | character codePoint ];
		column: 'Unicode' text: [ :character | 
			String streamContents: [ :stream | 
				stream << 'U+'.
				character codePoint printOn: stream base: 16 nDigits: 4 ] ];
		column: 'Encoded decimal' text: [ :character |
			(self encodeString: character asString) first ];
		column: 'Encoded hexadecimal' text: [ :character |
			String streamContents: [ :stream | 
				(self encodeString: character asString)
					first printOn: stream base: 16 nDigits: 2 ] ]
]
