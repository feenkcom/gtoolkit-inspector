*GToolkit-Inspector
gtContentsFor: aView
	<gtView: 0>
	self isFile ifFalse: [ ^ aView empty ].
	^ aView 
		title: 'Contents';
		stencil: [ 
			| contents |
			contents := self readStreamDo: [ :stream | 
				| result |
				result := [stream contents ]
					on: Error 
					do: [ (stream binary next: 10000) asString ] ].
			BrEditorElement new 
				editor: (BrTextEditor new text: contents asRopedText);
				constraintsDo: [ :c |
				    c horizontal matchParent.
				    c vertical matchParent ]. ]