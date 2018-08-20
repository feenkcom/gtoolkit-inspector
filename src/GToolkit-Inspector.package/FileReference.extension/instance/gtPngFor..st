*GToolkit-Inspector
gtPngFor: aView
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imagePng ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ]) asElement asPannableElement ]