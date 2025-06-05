Extension { #name : #Trait }

{ #category : #'*GToolkit-Inspector' }
Trait >> gtUsersFor: aView [
	<gtView>
	<gtClassView>
	^ aView tree
		title: 'Users';
		items: [ self users asOrderedCollection sorted: #name ascending ];
		children: [ :aClassOrTrait | 
			aClassOrTrait isTrait
				ifTrue: [ aClassOrTrait users asOrderedCollection ]
				ifFalse: [ #() ] ];
		actionUpdateButtonTooltip: 'Update user list';
		sendTool: [ :aClassOrTrait | GtClassCoderTool forClass: aClassOrTrait ];
		actionStencil: [ :aButton | 
				GtSpotterDropdownButtonStencil new
					valuable: [ self users asOrderedCollection sorted: #name ascending ];
					tooltip: 'Search Trait Users';
					objectActOn: [ :anActOnEvent :anItem :theButton | 
						| columnedList userClass |
						anActOnEvent beActed.
						userClass := anActOnEvent objectToSend.
						columnedList := theButton phlow viewContent
								allChildrenBreadthFirstDetect: [ :child | child isKindOf: BrSimpleTree ]
								ifFound: [ :child | child ].
						columnedList scrollToItem: userClass.
						columnedList selectOne: (columnedList viewModel indexOf: userClass).
						theButton phlow spawnObject: userClass ];
					asElement ]
			tooltip: 'Search Trait Users'
]
