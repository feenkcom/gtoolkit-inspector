Extension { #name : #BrTextEditor }

{ #category : #'*GToolkit-Inspector' }
BrTextEditor >> gtLiveFor: aView [
	^ (super gtLiveFor: aView)
		stencil: [ 
			BrEditorElement new 
				editor: self;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]
