Extension { #name : #BlRopedText }

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtDisplayText [
	^ self
]

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtStoreStringFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Serialized';
		priority: 30;
		stencil: [ (GtPharoSnippetCoder new forSource: self storeString) asElement matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtTextAttributesFor: aView [
	<gtView>
	(self attributesBuilder respondsTo: #attributes)
		ifFalse: [ ^ aView empty ].
	^ aView list
		title: 'Text attributes' translated;
		items: [ self attributesBuilder attributes ]
]

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtTreeFor: aView [
	<gtView>
	^ self rope 
		ifNil: [ aView empty ]
		ifNotNil: [ self rope gtTreeFor: aView ]
]
