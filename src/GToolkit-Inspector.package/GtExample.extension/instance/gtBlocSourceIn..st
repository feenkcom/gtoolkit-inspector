*GToolkit-Inspector
gtBlocSourceIn: aView
	<gtView: 40>
	^ aView
		title: 'Source';
		stencil: [ 
			| text styler editor editorElement |
			text := self method sourceCode asRopedText.
			text attributes: { BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler}.
			styler := GtExamplesStyler new classOrMetaClass: self methodClass.
			editor := BrTextEditor new.
			editor styler: styler.
			editor text: text.
			editorElement := BrEditorElement new.
			editorElement constraintsDo: [ :c |
			    c horizontal matchParent.
			    c vertical matchParent ].
			editorElement editor: editor ];
		actionStencil: [ BrButton new 
			look: BrMaterialToggleIconifiedLook  ;
			icon: GLMUIThemeExtraIcons glamorousBrowse asElement ;
			action: [ self method browse ] 
		]