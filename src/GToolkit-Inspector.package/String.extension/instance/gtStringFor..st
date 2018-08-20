*GToolkit-Inspector
gtStringFor: aView
	<gtView>
	^ aView explicit
		title: 'String';
		priority: 9;
		stencil: [ 
			| editorElement |
			editorElement := BrEditorElement new editor: (BrTextEditor new text: self asRopedText).
			editorElement constraintsDo: [ :c | 
				c vertical matchParent. 
				c horizontal matchParent.		
				c padding: (BlInsets all: 10) ]. ]