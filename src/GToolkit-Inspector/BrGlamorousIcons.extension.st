Extension { #name : #BrGlamorousIcons }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousIcons class >> gtIconsFor: aView [
	<gtView>
	<gtClassView>
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
						padding: (BlInsets left: 6 right: 3));
					addChild: (BlElement new 
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical exact: eachIcon value height ]) ]
]
