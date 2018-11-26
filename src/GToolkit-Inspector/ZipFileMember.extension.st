Extension { #name : #ZipFileMember }

{ #category : #'*GToolkit-Inspector' }
ZipFileMember >> gtFigureFor: aView [
	<gtView>
		
	| tmpDir tmpFile |
	tmpDir := FileLocator temp asFileReference.
	self extractInDirectory: tmpDir.
	tmpFile := tmpDir / self localFileName.
	
	(tmpFile isFile and: [ tmpFile mimeTypes notNil and: [ 
			tmpFile mimeTypes anySatisfy: [ :eachMimeType |  
				eachMimeType matches: (ZnMimeType main: 'image' sub: '*') ] ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ GtFileUtility imageElementFromFileReference: tmpFile ]
]

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
