Extension { #name : #MCWorkingCopy }

{ #category : #'*GToolkit-Inspector' }
MCWorkingCopy >> gtDisplayOn: stream [
	ancestry ancestors isEmpty 
		ifTrue: [ 
			super displayStringOn: stream. stream nextPutAll: ' (unsaved)' ]
		ifFalse: [ 
			ancestry ancestors first displayStringOn: stream.
			self needsSaving ifTrue: [ stream nextPutAll: ' (modified)' ] ]
		
]
