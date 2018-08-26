Extension { #name : #BlText }

{ #category : #'*GToolkit-Inspector' }
BlText >> gtTextFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Text';
		stencil: [
			BrEditorElement new 
				editor: (BrTextEditor new text: self);
				constraintsDo: [ :c |
					c vertical matchParent.
					c horizontal matchParent ] ]
]
