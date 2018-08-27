Extension { #name : #GLMAnnouncingCollection }

{ #category : #'*GToolkit-Inspector' }
GLMAnnouncingCollection >> gtAddRandomItemAction: anAction [
	<gtAction>
	| action |
	action := anAction explicit.
	^ action stencil: [ :element |
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action: [ 
			self add:'random'.
		];
		icon: BrGlamorousIcons add asElement;
		label: 'Add random element'.
	].
]

{ #category : #'*GToolkit-Inspector' }
GLMAnnouncingCollection >> gtItemsFor: aView [
    <gtView>
    ^ aView explicit
        title: 'Items';
        priority: 50;
        stencil: [ 
            | list refreshBlock |
            list := BrColumnedList new
                addEventHandler: GtInspectorListToSelectHandler new;
                display: self asOrderedCollection.
				refreshBlock := [  list look request: BrListItemsRequest new].
				self when: GLMItemAdded do: refreshBlock.
				self when: GLMItemChanged do: refreshBlock.
				self when: GLMItemRemoved do: refreshBlock.
            list column
                title: 'Item';
                stencil: [ :each :anIndex | BrListLabelStencil new text: each gtDisplayString ].
            list ]
]

{ #category : #'*GToolkit-Inspector' }
GLMAnnouncingCollection >> gtRemoveRandomItemAction: anAction [
	<gtAction>
	| action |
	action := anAction explicit.
	^ action stencil: [ :element |
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action: [ 
			self remove: 'random'.
		];
		icon: BrGlamorousIcons remove asElement;
		label: 'Remove random element'.
	].
]
