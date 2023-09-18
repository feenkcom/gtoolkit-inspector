Extension { #name : #ZnResponse }

{ #category : #'*GToolkit-Inspector' }
ZnResponse >> gtJsonFor: aView [
	<gtView>
	self isNoContent ifTrue: [ ^ aView empty ].
	self contentType main = 'application' ifFalse: [ ^ aView empty ].
	self contentType sub = 'json' ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'JSON';
		priority: 10;
		actionButtonIcon: BrGlamorousIcons tree asElement 
			action: [ :aButton | aButton phlow spawnObject: (STONJSON fromString: self contents) ];
		stencil: [ | editorElement textEditor text |
			textEditor := BrTextEditorModel new.
			textEditor styler: JSONParser gtStyler.
			editorElement := BrEditorElement new.
			editorElement editor: textEditor.
			text := (STONJSON toStringPretty: (STONJSON fromString: self contents)) asRopedText.
			text glamorousCodeFontDo: #beNotOverwritableByStyler; glamorousCodeSizeDo: #beNotOverwritableByStyler.
			textEditor text: text.
			editorElement
				padding: (BlInsets all: 10);
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ].
			editorElement ]
]

{ #category : #'*GToolkit-Inspector' }
ZnResponse >> gtResponseFor: aView [
	<gtView>
	^ self statusLine 
		ifNotNil: [ :aStatusLine | 
			(aStatusLine gtHttpFor: aView)
				title: 'Response';
				priority: 25 ] 
		ifNil: [ aView empty ]
]
