Extension { #name : #BrTextAttributesHowToGuide }

{ #category : #'*GToolkit-Inspector' }
BrTextAttributesHowToGuide >> linkInText [
	<gtExample>
	| text |
	text := 'You can click on this.' asRopedText.
	(text from: 9 to: 13) attributes: {
		BlTextForegroundAttribute new paint: Color blue.
		BrTextHoverStylableAttribute new 
			attribute: (BlTextUnderlineAttribute new paint: Color blue).
		BrTextClickAttribute new 
			action: [ :aTBrTextEditorTextualPiece :aTarget :aTextEditor :anEvent | Gt2Inspector openOn: aTBrTextEditorTextualPiece text ] }.
	^ text 
]
