*GToolkit-Inspector
gtLiveFor: aView
	^ (super gtLiveFor: aView)
		stencil: [ 
			BrEditorElement new 
				editor: self;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]