Extension { #name : 'BlPaint' }

{ #category : '*GToolkit-Inspector' }
BlPaint >> gtLiveFor: aView [
	^ self gtPreviewFor: aView
]

{ #category : '*GToolkit-Inspector' }
BlPaint >> gtPreviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Preview';
		stencil: [ 
			BlElement new
				background: self;
				constraintsDo: [ :c |
					c margin: (BlInsets all: 10).
					c horizontal matchParent.
					c vertical matchParent ] ]
]
