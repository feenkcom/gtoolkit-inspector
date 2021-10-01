Extension { #name : #ZipFileMember }

{ #category : #'*GToolkit-Inspector' }
ZipFileMember >> gtFigureFor: aView [
	<gtView>
		
	| anExtension aMimeType |
	anExtension := ($. split: self localFileName) last.
	aMimeType := ZnMimeType forFilenameExtension: anExtension.
	(aMimeType matches: (ZnMimeType main: 'image' sub: '*')) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			| anElement |
			anElement := (GtFileUtility 
				imageElementFromBytes: self gtBytes 
				named: self localFileName).
			anElement contentElement addAptitude: BrShadowAptitude.
			anElement contentElement margin: (BlInsets all: 10).
			anElement zoomableElement margin: (BlInsets all: 10).
			anElement margin: (BlInsets all: 10).
			anElement ]
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
