Extension { #name : 'Process' }

{ #category : '*GToolkit-Inspector' }
Process >> gtId [
	<return: #String>
	^ self hash asString
]

{ #category : '*GToolkit-Inspector' }
Process >> gtInvocatedByElementPreviewFor: aView [
	^ aView empty
]

{ #category : '*GToolkit-Inspector' }
Process >> gtName [
	<return: #BlRope>
	| aText |
	aText := (name 
		ifNil: [ '' ] 
		ifNotNil: #asString) asRopedText.
	aText append: ' ' asRopedText.
	aText append: ((suspendedContext asString asRopedText 
		foreground: BrGlamorousColors disabledButtonTextColor)).
	^ aText
]

{ #category : '*GToolkit-Inspector' }
Process >> gtPSKeysFor: aView [
	<gtView>
	^ aView columnedList
		title: 'PSKeys';
		priority: 5;
		items: [ PSKeys ifNil: #() ];
		column: 'Index' text: #index width: 50;
		column: 'Variable' text: #yourself weight: 3;
		column: 'Value' text: [ :aVariable | (self psValueAt: aVariable index) ifNil: [ aVariable default ] ] weight: 2;
		column: 'Inheritable' 
			icon: [ :aVariable | 
				(InheritablePSKeys includes: aVariable index) 
					ifTrue: [ BrGlamorousIcons greencircle ]
					ifFalse: [ BlElement new
						size: 16@16;
						background: BlBackground transparent ] ]
			width: 85
]
