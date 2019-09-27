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
ZipFileMember >> gtJsonFor: aView [
	<gtView>
	( self fileName endsWith: '.json' ) ifFalse:  [ ^ aView empty ].
	^ aView explicit
		title: 'JSON';
		priority: 1;
		actionButtonIcon: BrGlamorousIcons tree asElement 
			action: [ :aButton | aButton phlow spawnObject: (STONJSON fromString: self gtContents) ];
		stencil: [ | editorElement textEditor text |
			textEditor := BrTextEditor new.
			textEditor styler: JSONParser gtStyler.
			editorElement := BrEditorElement new.
			editorElement editor: textEditor.
			text := (STONJSON toStringPretty: (STONJSON fromString: self gtContents)) asRopedText.
			text glamorousCodeFontDo: #beNotOverwritableByStyler; glamorousCodeSizeDo: #beNotOverwritableByStyler.
			textEditor text: text.
			editorElement
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			editorElement ]
]
