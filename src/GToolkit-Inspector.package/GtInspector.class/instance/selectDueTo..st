api - inspector
selectDueTo: anEvent
	| aSourceElement |
	
	aSourceElement := anEvent sourceElement.
	
	self
		findPageContaining: aSourceElement
		ifPresent: [ :aPageElement |
			| aSelectedObject |
			
			aSelectedObject := anEvent object.
			
		]
		ifAbsent: [ ].