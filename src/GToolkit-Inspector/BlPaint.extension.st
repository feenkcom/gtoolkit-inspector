Extension { #name : #BlPaint }

{ #category : #'*GToolkit-Inspector' }
BlPaint >> gtPreviewFor: aView [
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
