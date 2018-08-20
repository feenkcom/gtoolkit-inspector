*GToolkit-Inspector
gtGifFor: aView
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageGif ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | GIFReadWriter formFromStream: stream ]) asElement asPannableElement ]