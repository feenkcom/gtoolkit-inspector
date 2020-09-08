Extension { #name : #BrTextAttributesHowToGuide }

{ #category : #'*GToolkit-Inspector' }
BrTextAttributesHowToGuide >> linkInText [
	<gtExample>
	| text |
	text := 'You can click on this.' asRopedText.
	(text from: 9 to: 13)
		attributes:
			{(BlTextForegroundAttribute new paint: Color blue).
			(BrTextHoverStylableAttribute new
				attribute: (BlTextUnderlineAttribute new color: Color blue)).
			(BrTextClickAttribute new
				action:
					[ :aTBrTextEditorTextualPiece :aTarget :aTextEditor :anEvent | GtInspector openOn: aTBrTextEditorTextualPiece text ])}.
	^ text
]
