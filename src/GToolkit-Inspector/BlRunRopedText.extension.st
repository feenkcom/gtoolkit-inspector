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
		title: 'Store on';
		priority: 30;
		stencil: [ (GtPharoSnippetCoder new
				forSource: self storeString;
				format;
				subscribeToSystem;
				asExpandedOnlyElement) vFitContentLimited ];
		actionButtonIcon: BrGlamorousVectorIcons playinspect
			tooltip: 'Do it and go'
			action: [ :button | 
				button phlow
					spawnObject: (Smalltalk compiler evaluate: (String streamContents: [ :s | self storeOn: s ])) ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
BlRunRopedText >> gtTreeFor: aView [
	<gtView>
	^ self rope 
		ifNil: [ aView empty ]
		ifNotNil: [ self rope gtTreeFor: aView ]
]
