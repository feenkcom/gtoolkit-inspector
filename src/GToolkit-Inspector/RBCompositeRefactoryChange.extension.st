Extension { #name : #RBCompositeRefactoryChange }

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtChangesFor: aView [
	<gtView>
	^ aView tree
		title: 'Changes';
		items: [ {self} ];
		children: #gtChildren;
		itemStencil: [ :each | 
			| element executeButton |
			element := BlElement new.
			element
				look:
					(BrLayoutLook frame
						hMatchParent;
						vFitContent).
			element
				addChild:
					(BrLabel new
						look: BrGlamorousListLabelLook;
						text: each gtLabel).
			executeButton := BrButton new.
			executeButton
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons accept asElement;
				constraintsDo: [ :c | c frame horizontal alignRight ];
				action: [ each execute ].
			element addChild: executeButton.
			element ]
]

{ #category : #'*GToolkit-Inspector' }
RBCompositeRefactoryChange >> gtChildren [
	^ self changes
]
