*GToolkit-Inspector
gtStringFor: aView
	<gtView: 9>
	^ aView explicit
		title: 'String';
		stencil: [ 
			| editorElement |
			editorElement := BrEditorElement new editor: (BrTextEditor new text: self asRopedText).
			editorElement constraintsDo: [ :c | 
				c vertical matchParent. 
				c horizontal matchParent.		
				c padding: (BlInsets all: 10) ]. ]