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
Color >> gtOpaqueColorOn: aBackgroundColor [
	| a1 r1 g1 b1 r2 g2 b2 |
	(self alpha closeTo: 1)
		ifTrue: [ ^ self ].
		
	(self alpha closeTo: 0)
		ifTrue: [ ^ aBackgroundColor ].
		
	a1 := self alpha.
	r1 := self red. r2 := aBackgroundColor red.
	g1 := self green. g2 := aBackgroundColor green.
	b1 := self blue. b2 := aBackgroundColor blue.
		
	^ Color
		r: r2 + ((r1 - r2) * a1)
		g: g2 + ((g1 - g2) * a1)
		b: b2 + ((b1 - b2) * a1)
]

{ #category : #'*GToolkit-Inspector' }
Color >> gtOpaqueColorOnWhite [
	^ self gtOpaqueColorOn: Color white
]

{ #category : #'*GToolkit-Inspector' }
Color >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		stencil: [ 
			| list |
			list := BrColumnedList new.
			list margin: (BlInsets all: 10).
			list items: { 
				'name:' -> self name .
				'RGB red:' -> self red .
				'RGB green:' -> self green .
				'RGB blue:' -> self blue .
				'alpha:' -> (self alpha * 100) asInteger .
				'HSL hue:' -> self hue .
				'HSL saturation:' -> self hslSaturation .
				'HSL lightness: ' -> self lightness .
				'HSV hue:' -> self hue .
				'HSV saturation:' -> self hsvSaturation .
				'HSV value:' -> self brightness .
				'hex:' -> ('#', self asHexString) }.
			list column title: 'Property'; stencil: [ :assoc | BrColumnCellLabelStencil new text: assoc key asRopedText glamorousRegularFont ].
			list column title: 'Value'; stencil: [ :assoc | BrColumnCellLabelStencil new text: assoc value asRopedText glamorousRegularFont].
			BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: (
					BlElement new
						look: (BrShadowLook new);
						background: Color white;
						constraintsDo: [ :c |
							c frame horizontal alignCenter.
							c frame vertical alignCenter.
							c horizontal exact: 300.
							c vertical fitContent ];
						layout: BlLinearLayout horizontal;
						addChild: (BlElement new background: self; constraintsDo: [:c | c vertical matchParent. c horizontal exact: 70 ]);
						addChild: list) ]
]
