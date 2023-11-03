Extension { #name : #ZnUTFEncoder }

{ #category : #'*GToolkit-Inspector' }
ZnUTFEncoder >> gtViewCharacterDomainSampleFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Character domain sample';
		priority: 15;
		items: [ (1 to: 16r024F) collect: #asCharacter ];
		column: 'Character' text: [ :character | character ];
		column: 'Codepoint' text: [ :character | character codePoint ];
		column: 'Unicode' text: [ :character | 
			String streamContents: [ :stream | 
				stream << 'U+'.
				character codePoint printOn: stream base: 16 nDigits: 4 ] ];
		column: 'Encoded decimal' text: [ :character |
			(self encodeString: character asString) printString ];
		column: 'Encoded hexadecimal' text: [ :character |
			String streamContents: [ :stream | 
				(self encodeString: character asString) do: [ :each | 
					each printOn: stream base: 16 nDigits: 2 ] ] ]
]
