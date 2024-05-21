Extension { #name : #TestCaseStarted }

{ #category : #'*GToolkit-Inspector' }
TestCaseStarted >> printOn: aStream [
	<gtPharoPatch: #Pharo>
	
	aStream nextPutAll: 'started '.
	super printOn: aStream
]
