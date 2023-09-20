Extension { #name : #ZipArchiveMember }

{ #category : #'*GToolkit-Inspector' }
ZipArchiveMember >> gtContentsFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Contents';
		text: [ 
			[ self contents asByteArray utf8Decoded asRopedText ]
				on: Error do: [ :anException |
					self contents asString asRopedText ] ]
]
