Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtImplementorsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Implementors';
		priority: 11;
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod implementors.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Index';
				stencil: [ :aClass :anIndex |
					BlTextElement new
						width: 30;
						margin: (BlInsets all: 3);
						text: (anIndex asString asRopedText foreground: Color gray) ].
			list column
				title: 'Method';
				stencil: [ :each :index | BrListLabelStencil new text: each gtDisplayString ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtSendersFor: aView [
	<gtView>
	^ aView explicit
		title: 'Senders';
		priority: 10;
		stencil: [ 
			| list |
			list := BrColumnedList new display: self compiledMethod senders.
			list addEventHandler: GtInspectorListToSelectHandler new.
			list column
				title: 'Index';
				stencil: [ :aClass :anIndex |
					BlTextElement new
						width: 30;
						margin: (BlInsets all: 3);
						text: (anIndex asString asRopedText foreground: Color gray) ].
			list column
				title: 'Method';
				stencil: [ :each :index | BrListLabelStencil new text: each gtDisplayString ].
			list ]
]

{ #category : #'*GToolkit-Inspector' }
RGMethodDefinition >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 0;
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons browse asElement;
				action: [ self browse ] ];
		actionStencil: [ :tab | 
			BrButton new 
				look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook;
				icon: BrGlamorousIcons accept asElement;
				action: [ self methodClass compile: tab viewContentElement editor text asString ] ];
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
]
