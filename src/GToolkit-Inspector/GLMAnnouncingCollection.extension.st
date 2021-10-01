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
		aptitude: BrGlamorousButtonWithIconAptitude; 
		action: [ 
			self add:'random'.
		];
		icon: BrGlamorousVectorIcons add;
		label: 'Add random element'.
	].
]

{ #category : #'*GToolkit-Inspector' }
GLMAnnouncingCollection >> gtItemsFor: aView [
    <gtView>
    ^ aView list
        title: 'Items';
        priority: 50;
		  updateWhen: GLMItemAdded in: [ self ];
		  updateWhen: GLMItemChanged in: [ self ];
		  updateWhen: GLMItemRemoved in: [ self ];
		  items: [ self asOrderedCollection ];
		  itemText: [ :each | each gtDisplayString]
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
		aptitude: BrGlamorousButtonWithIconAptitude; 
		action: [ 
			self remove: 'random'.
		];
		icon: BrGlamorousVectorIcons remove;
		label: 'Remove random element'.
	].
]
