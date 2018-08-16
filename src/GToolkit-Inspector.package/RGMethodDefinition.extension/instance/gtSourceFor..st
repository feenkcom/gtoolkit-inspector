*GToolkit-Inspector
gtSourceFor: aView
	<gtView: 0>
	^ aView explicit
		title: 'Source';
		stencil: [ 
		| text styler editor editorElement |

		text := self sourceCode asRopedText" readonly".

		text attributes: {
		BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BrFontSizeAttribute size: 14) beNotOverwritableByStyler }.

		styler := BrRBTextStyler new.
		styler classOrMetaClass: self methodClass.

		editor := BrTextEditor new.
		editor styler: styler.
		editor text: text.

		editorElement := BrEditorElement new.
		editorElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

		editorElement editor: editor.

		editorElement].