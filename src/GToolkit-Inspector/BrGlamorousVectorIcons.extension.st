Extension { #name : #BrGlamorousVectorIcons }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousVectorIcons class >> gtIconsFor: aView [
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
					addChild: (eachIcon value asElement asScalableElement size: 64@64);
					addChild: (BrLabel new 
						look: BrGlamorousLabelLook;
						constraintsDo: [:c | c linear vertical alignCenter];
						text: eachIcon key asString;
						padding: (BlInsets left: 20 right: 3)) ];
			send: #value
]
