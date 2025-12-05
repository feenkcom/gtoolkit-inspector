Extension { #name : #Behavior }

{ #category : #'*GToolkit-Inspector' }
Behavior >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ (layout 
				ifNil: [ 0 ] 
				ifNotNil: [ :aLayout | aLayout gtSpecificSizeInMemory])
]
