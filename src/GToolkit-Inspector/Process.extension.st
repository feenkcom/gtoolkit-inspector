Extension { #name : #Process }

{ #category : #'*GToolkit-Inspector' }
Process >> gtId [
	<return: #String>
	^ self hash asString
]

{ #category : #'*GToolkit-Inspector' }
Process >> gtInvocatedByElementPreviewFor: aView [
	^ aView empty
]

{ #category : #'*GToolkit-Inspector' }
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
