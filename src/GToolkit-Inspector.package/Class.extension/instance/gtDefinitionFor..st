*GToolkit-Inspector
gtDefinitionFor: aView
	<gtView>
	^ aView explicit  
		title: 'Definition';
		priority: 1;
		stencil: [ 
		| text styler editor editorElement |

		text := self definition asRopedText" readonly".

		text attributes: {
		BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
		(BrFontSizeAttribute size: 14) beNotOverwritableByStyler }.

		styler := BrRBTextStyler new.

		editor := BrTextEditor new.
		editor styler: styler.
		editor text: text.

		editorElement := BrEditorElement new.
		editorElement constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

		editorElement editor: editor.

		editorElement].