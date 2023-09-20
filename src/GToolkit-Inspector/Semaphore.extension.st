Extension { #name : #Semaphore }

{ #category : #'*GToolkit-Inspector' }
Semaphore >> gtDisplayOn: aStream [

	self printOn: aStream.
	
]

{ #category : #'*GToolkit-Inspector' }
Semaphore >> printOn: aStream [

	self printNameOn: aStream.
	(self isEmpty and: [ excessSignals = 0 ]) ifTrue: [ ^ self ].
	aStream nextPut: $(.
	self isEmpty ifFalse: 
		[ aStream
			print: self size;
			<< ' waiting' ].
	excessSignals > 0 ifTrue:
		[ aStream
			print: excessSignals;
			<< ' excess' ].
	aStream nextPut: $).
	
]
