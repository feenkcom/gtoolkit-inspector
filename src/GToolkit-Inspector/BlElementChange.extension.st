Extension { #name : #BlElementChange }

{ #category : #'*GToolkit-Inspector' }
BlElementChange >> gtActionCleanFor: anAction [
	<gtAction>
	| action |
	action := anAction explicit.
	^ action stencil: [ :element |
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action: [ 
			| parent refreshedChild |
			records removeAll.
			parent := element parent.
			refreshedChild := element phlow entity asElementDo: [ :x | x ].
			parent removeChild: element.
			parent addChild: refreshedChild.
		];
		icon: BrGlamorousIcons refresh asElement;
		label: 'Clean log'.
	].
]
