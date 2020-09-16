Extension { #name : #Trait }

{ #category : #'*GToolkit-Inspector' }
Trait >> gtUsersFor: aView [
	<gtView>
	<gtClassView>
	^ aView tree
		title: 'Users';
		items: [ self users asOrderedCollection ];
		children: [ :aClassOrTrait | 
			aClassOrTrait isTrait
				ifTrue: [ aClassOrTrait users asOrderedCollection ]
				ifFalse: [ #() ] ]
]
