Extension { #name : #BlRunRopedText }

{ #category : #'*GToolkit-Inspector' }
BlRunRopedText >> gtDisplayText [
	^ self
]

{ #category : #'*GToolkit-Inspector' }
BlRunRopedText >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlRunRopedText >> gtStoreStringFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Serialized';
		priority: 30;
		stencil: [ (GtPharoSnippetCoder new forSource: self storeString) asElement matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlRunRopedText >> gtTextAttributesFor: aView [
	<gtView>
	(self attributesBuilder respondsTo: #attributes)
		ifFalse: [ ^ aView empty ].
	^ aView list
		title: 'Text attributes' translated;
		items: [ self attributesBuilder attributes ]
]

{ #category : #'*GToolkit-Inspector' }
BlRunRopedText >> gtTreeFor: aView [
	<gtView>
	^ self rope 
		ifNil: [ aView empty ]
		ifNotNil: [ self rope gtTreeFor: aView ]
]
