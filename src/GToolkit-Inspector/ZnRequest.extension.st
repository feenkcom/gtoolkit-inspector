Extension { #name : #ZnRequest }

{ #category : #'*GToolkit-Inspector' }
ZnRequest >> gtJsonFor: aView [
	<gtView>
	self hasEntity ifFalse: [ ^ aView empty ].
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
ZnRequest >> gtRequestQueryFor: aView [
	<gtView>
	^ aView forward
		title: 'Request query';
		priority: 45;
		object: [ self requestLine ];
		view: #gtQueryFor:
]

{ #category : #'*GToolkit-Inspector' }
ZnRequest >> gtViewRequestLineTextFor: aView [
	<gtView>
	^ aView forward
		title: 'Request';
		priority: 45;
		object: [ self requestLine ];
		view: #gtViewRequestLineTextFor:
]
