Extension { #name : #TestCaseStarted }

{ #category : #'*GToolkit-Inspector' }
TestCaseStarted >> printOn: aStream [

	aStream nextPutAll: 'started '.
	super printOn: aStream
]
