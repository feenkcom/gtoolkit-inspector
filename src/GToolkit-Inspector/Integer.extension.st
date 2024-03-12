Extension { #name : #Integer }

{ #category : #'*GToolkit-Inspector' }
Integer >> gtDisplayOn: stream [
	self
		printSeparatedBy: $'
		every: 3
		signed: false
		on: stream
]
