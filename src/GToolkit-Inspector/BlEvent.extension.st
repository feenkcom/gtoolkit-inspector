Extension { #name : #BlEvent }

{ #category : #'*GToolkit-Inspector' }
BlEvent >> gtCurrentTargetFor: aView [
	<gtView>
	^ (self currentTarget isKindOf: BlElement)
		ifFalse: [ ^ aView empty ]
		ifTrue: [ (self currentTarget gtPreviewFor: aView) 
			title: 'Current target';
			priority: 5 ]
]

{ #category : #'*GToolkit-Inspector' }
BlEvent >> gtTargetFor: aView [
	<gtView>
	^ (self target isKindOf: BlElement)
		ifFalse: [ ^ aView empty ]
		ifTrue: [ (self target gtPreviewFor: aView) 
			title: 'Target';
			priority: 4 ]
]
