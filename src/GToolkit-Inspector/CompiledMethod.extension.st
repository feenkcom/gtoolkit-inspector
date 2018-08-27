Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Inspector' }
CompiledMethod >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons browse asElement;
				action: [ self browse ] ];
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

			editorElement]
]
