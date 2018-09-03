Extension { #name : #SymbolicBytecode }

{ #category : #'*GToolkit-Inspector' }
SymbolicBytecode >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		stencil: [ 
			| text styler editor editorElement |

			text := self method sourceCode asRopedText" readonly".
			text attributes: {
				BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler.
				(BrFontSizeAttribute size: 14) beNotOverwritableByStyler }.
				
			(text from: self sourceInterval first to: self sourceInterval last) attributes: { 
				BrTextUnderlineAttribute new 
					paint: (Color fromHexString: 'E57373'); 
					beNotOverwritableByStyler }.

			styler := BrRBTextStyler new.
			styler classOrMetaClass: self method methodClass.

			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.

			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].

			editorElement editor: editor.
			editorElement ]
]
