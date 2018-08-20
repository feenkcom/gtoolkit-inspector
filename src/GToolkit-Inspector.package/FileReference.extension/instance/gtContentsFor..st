*GToolkit-Inspector
gtContentsFor: aView
	<gtView>
	self isFile ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Contents';
		priority: 50;
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