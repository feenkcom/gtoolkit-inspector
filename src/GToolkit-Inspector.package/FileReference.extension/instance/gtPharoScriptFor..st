*GToolkit-Inspector
gtPharoScriptFor: aView
	<gtView>
	(self isFile and: [ self extension = 'st' or: [self extension = 'ph'] ]) ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Script';
		priority: 10;
		stencil: [ 
			GtPharoSnippet new 
				sourceCode: (self readStreamDo: [ :s | s contents ]);
				asElement ]
		"act: [ :text |
			self ensureDelete; writeStreamDo: [ :s | s nextPutAll: text text asString ] ]
			icon: GLMUIThemeExtraIcons glamorousSave
			on: $s
			entitled: 'Save'"