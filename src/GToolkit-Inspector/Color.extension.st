Extension { #name : #Color }

{ #category : #'*GToolkit-Inspector' }
Color >> gtPreviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Preview';
		stencil: [ 
			BlElement new
				background: self;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ] ]
]
