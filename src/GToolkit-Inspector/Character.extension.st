Extension { #name : #Character }

{ #category : #'*GToolkit-Inspector' }
Character >> gtPreviewFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Preview';
		priority: 10;
		glamorousCodeFontAndSize;
		fontSize: 30;
		text: [ self ]
]

{ #category : #'*GToolkit-Inspector' }
Character >> gtViewUnicodeCharacterDetailsIn: composite [
	<gtView>
	| unicodeCharacterData |
	unicodeCharacterData := [ self unicodeCharacterData ] on: NotFound do: [ ^ composite empty ].
	^ composite forward
		title: 'Unicode details';
		priority: 31;
		object: [ unicodeCharacterData ];
		view: #gtViewDetailsIn:;
		actionButtonIcon: BrGlamorousVectorIcons inspect action: [ :b | b phlow spawnObject: unicodeCharacterData ]
]
