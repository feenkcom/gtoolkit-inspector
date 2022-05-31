Extension { #name : #BlAbstractRopedText }

{ #category : #'*GToolkit-Inspector' }
BlAbstractRopedText >> gtDisplayText [
	^ self
]

{ #category : #'*GToolkit-Inspector' }
BlAbstractRopedText >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : #'*GToolkit-Inspector' }
BlAbstractRopedText >> gtStoreStringFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Serialized';
		priority: 30;
		stencil: [ (GtPharoSnippetCoder new forSource: self storeString) asElement matchParent ]
]

{ #category : #'*GToolkit-Inspector' }
BlAbstractRopedText >> gtTextAttributesFor: aView [
	<gtView>
	
	[ ^ aView list
		title: 'Text attributes' translated;
		items: [ self attributesBuilder attributes ] ]
		onDNU: #attributes
		do: [ ^ aView empty ]
]

{ #category : #'*GToolkit-Inspector' }
BlAbstractRopedText >> gtTreeFor: aView [
	<gtView>
	^ self rope 
		ifNil: [ aView empty ]
		ifNotNil: [ self rope gtTreeFor: aView ]
]
