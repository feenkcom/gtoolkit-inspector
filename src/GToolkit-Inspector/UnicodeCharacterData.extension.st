Extension { #name : #UnicodeCharacterData }

{ #category : #'*GToolkit-Inspector' }
UnicodeCharacterData >> gtPreviewFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Preview';
		priority: 10;
		glamorousCodeFontAndSize;
		fontSize: 64;
		text: [ self character ]
]

{ #category : #'*GToolkit-Inspector' }
UnicodeCharacterData class >> gtSpotterUnicodeCharacterDatabaseFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Unicode character database';
		items: [ self database values sorted ];
		itemName: [ :each | each printString ];
		filterBySubstring
]

{ #category : #'*GToolkit-Inspector' }
UnicodeCharacterData >> gtViewDetailsIn: composite [
	<gtView>
	^ composite columnedList
		title: 'Details';
		items: [ {
			{ 'codepoint'. self codePoint }.
			{ 'codepoint hex'. 
					String streamContents: [ :stream | 
						stream << 'U+'.
						self codePoint printOn: stream base: 16 nDigits: 4 ].
					self codePoint }.
			{ 'character'. self character printString. self character }.
			{ 'name'. self name }.
			{ 'old name'. self oldName ifNil: [ '' ]. self oldName }.
			{ 'general category'. self generalCategory }.
			{ 'canonical combining class'. self canonicalCombiningClass }.
			{ 'bidirectional category'. self bidirectionalCategory }.
			{ 'mirrored'. self mirrored }.
			{ 'uppercase'. 
					self uppercase ifNotNil: [ :n | Character codePoint: n ] ifNil: [ '' ]. 
					self class forCodePoint: self uppercase ifAbsent: [] }.
			{ 'lowercase'. 
					self lowercase ifNotNil: [ :n | Character codePoint: n ] ifNil: [ '' ]. 
					self class forCodePoint: self lowercase ifAbsent: [] }.
			{ 'titlecase'. 
					self titlecase ifNotNil: [ :n | Character codePoint: n ] ifNil: [ '' ]. 
					self class forCodePoint: self titlecase ifAbsent: [] }.
			{ 'decimal digit value'. self decimalDigitValue ifNil: [ '' ]. self decimalDigitValue }.
			{ 'digit value'. self digitValue ifNil: [ '' ]. self digitValue }.
			{ 'numeric value'. self numericValue ifNil: [ '' ]. self numericValue }.
			{ 'decomposition'. self decompositionDescription. self decompositionAsUCDs } } ];
		column: 'Key' text: #first;
		column: 'Value' text: #second;
		send: #last
]

{ #category : #'*GToolkit-Inspector' }
UnicodeCharacterData class >> gtViewUnicodeCharacterDatabaseFor: view [
	<gtClassView>
	^ view columnedList
		title: 'Database';
		items: [ self database values sorted ];
		column: 'Unicode' text: [ :each | each printString ] weight: 4;
		column: 'Character' text: [ :each | each character ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					object: self;
					tooltip: 'Search Unicode character database';
					id: GtPharoSearchCodeButtonId;
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						| target |
						target := anActOnEvent objectToSend.
						(target isKindOf: UnicodeCharacterData) 
							ifTrue: [ 
								| columnedList |
						
								columnedList := theButton phlow viewContent 
									allChildrenBreadthFirstDetect: [ :child | 
										child isKindOf:  BrColumnedList ] 
									ifFound: [ :child | child ].
								columnedList scrollToItem: target.
								columnedList selectOne: (columnedList items indexOf: target).
								
								anActOnEvent beActed ] ];
					asElement ]
			tooltip: 'Search Unicode character database'
]
