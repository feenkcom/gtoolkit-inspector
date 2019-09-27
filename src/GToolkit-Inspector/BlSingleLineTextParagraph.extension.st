Extension { #name : #BlSingleLineTextParagraph }

{ #category : #'*GToolkit-Inspector' }
BlSingleLineTextParagraph >> gtMetricsFor: aView [
	<gtView>
	
	^ aView sparta
		title: 'Metrics';
		matchParent;
		embellisher: [ :aSpartaElement |
			aSpartaElement
				layout: BlFrameLayout new;
				addChild: (
					BrEditor new
						hMatchParent;
						vFitContent;
						constraintsDo: [ :c | c frame vertical alignBottom ];
						margin: (BlInsets left: 10);
						text: (String streamContents: [ :aStream |
							aStream
								nextPutAll: 'baseline: '; print: self baseline; cr;
								nextPutAll: 'bounds: '; print: self bounds; cr;
								nextPutAll: 'tight bounds: '; print: self tightBounds; cr;
								nextPutAll: 'loose bounds: '; print: self looseBounds; cr;
								nextPutAll: 'width: '; print: self width; cr;
								nextPutAll: 'advance: '; print: self line advance ]) asRopedText;
						look: BrGlamorousCodeEditorLook) ];
		rendering: [ :aCanvas :anElement |
			aCanvas transform
				by: [ :t | t translateBy: 20@20 ]
				during: [
					aCanvas stroke
						path: (aCanvas shape line: 0 @ self baseline y to: (anElement width - 40) @ self baseline y);
						paint: (Color black alpha: 0.3);
						width: 1;
						draw.

					aCanvas stroke
						path: (self tightBounds);
						paint: (Color blue alpha: 0.2);
						draw.
						
					aCanvas stroke
						path: (self looseBounds);
						paint: (Color red alpha: 0.2);
						draw.
					
					self drawOnSpartaCanvas: aCanvas ].
		]
]
