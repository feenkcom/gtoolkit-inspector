Extension { #name : #ZipArchiveMember }

{ #category : #'*GToolkit-Inspector' }
ZipArchiveMember >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		text: [ self contents asString asRopedText ]
]
