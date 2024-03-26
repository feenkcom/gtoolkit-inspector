Extension { #name : #Integer }

{ #category : #'*GToolkit-Inspector' }
Integer >> gtDisplayOn: stream [
	"Overridden to use space as a thousands separator"
	
	self
		printSeparatedBy: Character space
		every: 3
		signed: false
		on: stream
]
