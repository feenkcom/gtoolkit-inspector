Extension { #name : #ZipFileMember }

{ #category : #'*GToolkit-Inspector' }
ZipFileMember >> gtRawJsonFor: aView [
	<gtView>
	( self fileName endsWith: '.json' ) ifFalse:  [ ^ aView empty ].
	^ aView textEditor
		title: 'JSON';
		priority: 10;
		text: [ 
			STONJSON toStringPretty: (
				STONJSON fromString: self contents). ]
]
