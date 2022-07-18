Extension { #name : #BrGlamorousIcons }

{ #category : #'*GToolkit-Inspector' }
BrGlamorousIcons class >> gtIconsFor: aView [
	<gtView>
	<gtClassView>
	^ aView list
			title: 'Icons';
			priority: -10;
			items: self allIcons;
			itemStencil: [ 
				BlElement new
					layout: BlLinearLayout horizontal;
					margin: (BlInsets all: 3);
					constraintsDo: [ :c | 
						c vertical fitContent.
						c horizontal matchParent ];
					addChild: (BlElement new size: 16@16) as: #icon;
					addChild: (BrLabel new 
						aptitude: BrGlamorousLabelAptitude;
						constraintsDo: [:c | c linear vertical alignCenter];
						padding: (BlInsets left: 20 right: 3)) as: #label ];
			itemDataBinder: [ :anElement :anIcon :anIndex |
				anElement 
					replaceChild: (anElement childNamed: #icon) 
					with: (anIcon value asElement)
					as: #icon.
				(anElement childNamed: #label)
					text: anIcon key asString.
				anElement ];
			actionUpdateButtonTooltip: 'Update icon list';
			send: #value
]
