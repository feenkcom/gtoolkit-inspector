*GToolkit-Inspector
gtJpgFor: aView
	<gtView>
	(self isFile and: [ self mimeTypes notNil and: [ self mimeTypes first matches: ZnMimeType imageJpeg ] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Picture';
		priority: 10;
		stencil: [ 
			(self binaryReadStreamDo: [ :stream | JPEGReadWriter formFromStream: stream ]) asElement asPannableElement ]