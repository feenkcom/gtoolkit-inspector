Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtChangesFor: aView [
	<gtView>
	^ aView tree
		title: 'Changes';
		items: [ {self} ];
		children: #gtChildren;
		expandAll;
		itemStencil: [ :aNodeType | 
			| element executeButton |
			element := BrHorizontalPane new vFitContent hMatchParent.
			element
				addChild:
					(BrLabel new
						look: BrGlamorousListLabelLook;
						text: '').
			executeButton := BrButton new.
			executeButton
				beTinySize;
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousVectorIcons accept;
				label: 'Accept changes';
				constraintsDo: [ :c | 
					c linear vertical alignCenter.
					c margin: c margin + (BlInsets left: 5) ].
			element addChild: executeButton.
			element ];
		itemDataBinder: [ :aPaneElement :anItemObject :aTreeNode |
			(aPaneElement childAt: 1) text: anItemObject gtLabel.
			(aPaneElement childAt: 2) action: [ anItemObject execute ] ]
]

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtChildren [
	^ self changes
]

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtLabel [
	^ self changes
		ifNotNil: [ self changes size asString, ' changes' ] 
		ifNil: [ '0 changes' ]
]
