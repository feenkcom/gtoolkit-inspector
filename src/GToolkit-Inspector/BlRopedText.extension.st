Extension { #name : #BlRopedText }

{ #category : #'*GToolkit-Inspector' }
BlRopedText >> gtDisplayText [
	^ self
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
