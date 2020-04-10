Extension { #name : #BrGlamorousVectorIcons }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousVectorIcons class >> gtIconsFor: aView [
	<gtView>
	^ aView list
			title: 'Icons';
			priority: -10;
			items: self allIcons;
			itemStencil: [ :eachIcon | 
				BlElement new
					layout: BlLinearLayout horizontal;
					margin: (BlInsets all: 3);
					constraintsDo: [ :c | c vertical fitContent ];
					addChild: eachIcon value asElement;
					addChild: (BlTextElement new 
						text: eachIcon key asString asRopedText;
						padding: (BlInsets left: 6 right: 3)) ]
]
