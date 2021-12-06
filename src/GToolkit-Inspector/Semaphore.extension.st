Extension { #name : #Semaphore }

{ #category : #'*GToolkit-Inspector' }
Semaphore >> gtDisplayOn: aStream [

	self printOn: aStream.
	
]

{ #category : #'*GToolkit-Inspector' }
Semaphore >> printOn: aStream [

	self printNameOn: aStream.
	aStream 
		nextPut: $(;
		print: self size;
		<< ' waiting, ';
		print: excessSignals;
		<< ' excess)'.
	
]
