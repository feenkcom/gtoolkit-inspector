Extension { #name : #BlEvent }

{ #category : #'*GToolkit-Inspector' }
BlEvent >> gtCurrentTargetFor: aView [
	<gtView>
	^ (self currentTarget isKindOf: BlElement)
		ifFalse: [ ^ aView empty ]
		ifTrue: [ (self currentTarget gtPreviewFor: aView) 
			title: 'Current Target';
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

{ #category : #'*GToolkit-Inspector' }
BlEvent >> gtTraversedTargetsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Traversed Table';
		items: [ self traversedTargets ];
		priority: 3;
		column: 'Icon' do: [ :aColumn |
			aColumn 
				itemStencil: [ :each | (each target asSpartaForm scaledToSize: 16@16) asElement
					margin: (BlInsets top: 3 left: 0 bottom: 3 right: 0 ) ];
				fitContent ];
		column: 'Phase'
			item: [ :each | each type ]
			width: 100;
		column: 'Target'
			item: [ :each | each target ];
		column: 'Dispatcher'
			item: [ :each | each dispatcher ]
]
