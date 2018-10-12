Extension { #name : #Color }

{ #category : #'*GToolkit-Inspector' }
Color >> gtContrastingColor [
	"See: https://stackoverflow.com/questions/1855884/determine-font-color-based-on-background-color"
	<return: #Color>
	^ self gtLuminanceValue > 0.5
		ifTrue: [ Color black ]
		ifFalse: [ Color white ]
]

{ #category : #'*GToolkit-Inspector' }
Color >> gtLuminanceValue [
	"Eye color favor green color.
	See: https://stackoverflow.com/questions/1855884/determine-font-color-based-on-background-color"
	<return: #Number>
	^ ((0.299 * self red) + (0.587 * self green) + (0.114 * self blue)) "/ 255"
]

{ #category : #'*GToolkit-Inspector' }
Color >> gtPreviewFor: aView [
	<gtView>

	^ aView explicit
		title: 'Preview';
		stencil: [ 
			BlElement new
				background: self;
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (BrEditorElement new
					look: (BrShadowLook new color: self gtContrastingColor);
					background: (self);
					padding: (BlInsets all: 10);
					constraintsDo: [ :c |
						c frame horizontal alignCenter.
						c frame vertical alignCenter.
						c horizontal exact: 200.
						c vertical fitContent ];
					editor: (BrTextEditor new
						text: ((String streamContents: [ :aStream | 
							aStream 
								nextPutAll: 'name: '; print: self name; cr;
		 						nextPutAll: 'RGB red: '; print: self red; cr;
			 					nextPutAll: 'RGB green: '; print: self green; cr;
			 					nextPutAll: 'RGB blue: '; print: self blue; cr;
			 					nextPutAll: 'alpha: '; print: (self alpha * 100) asInteger; nextPut: $%; cr;
			 					nextPutAll: 'HSL hue: '; print: self hue; cr;
			 					nextPutAll: 'HSL saturation: '; print: self hslSaturation; cr;
			 					nextPutAll: 'HSL lightness: '; print: self lightness; cr;
			 					nextPutAll: 'HSV hue: '; print: self hue; cr;
			 					nextPutAll: 'HSV saturation: '; print: self hsvSaturation; cr;
			 					nextPutAll: 'HSV value: '; print: self brightness; cr;
			 					nextPutAll: 'hex: #'; print: self asHexString ]) asRopedText 
									foreground: self gtContrastingColor))) ]
]
