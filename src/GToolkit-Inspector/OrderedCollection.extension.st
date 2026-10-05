Extension { #name : #OrderedCollection }

{ #category : #'*GToolkit-Inspector' }
OrderedCollection >> gtItemsFor: aView [
	<gtView>
	
	^ (super gtItemsFor: aView)
		dynamicPhlowContextItems: [ :anAction :anElement :anObject :aSelection |
			| nodeLabels |
			
			nodeLabels := OrderedCollection new .
			aSelection nodeIdentifiersDo: [ :aNodeIdentifier |
				nodeLabels add: aNodeIdentifier description ].
				
			{anAction button
				icon: BrGlamorousVectorIcons remove ;
				label: 'Remove';
				menuItemPreview: (nodeLabels size = 1 
					ifTrue: [ 'item with index ', nodeLabels first  ] 
					ifFalse: [ 'items with indexes ', nodeLabels asCommaString ]);
				action: [ :currentAction | 
					| identifiersToRemove |
					identifiersToRemove := OrderedCollection new.
					aSelection nodeIdentifiersDo: [ :aNodeIdentifier | 
						identifiersToRemove add: aNodeIdentifier nodeIndex ].
					identifiersToRemove sort.
					identifiersToRemove reverseDo: [ :anIndentifier |
						self removeAt: anIndentifier ].
					currentAction phlow fireViewUpdateWish ]} ]
]

{ #category : #'*GToolkit-Inspector' }
OrderedCollection >> gtSpecificSizeInMemory [
	^ self sizeInMemory + array sizeInMemory
]
