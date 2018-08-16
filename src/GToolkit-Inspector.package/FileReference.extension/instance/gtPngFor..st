*GToolkit-Inspector
gtPngFor: aView
	<gtView: 0>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imagePng ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ]) asElement asPannableElement ]