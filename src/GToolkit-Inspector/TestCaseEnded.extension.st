Extension { #name : #TestCaseEnded }

{ #category : #'*GToolkit-Inspector' }
TestCaseEnded >> printOn: aStream [
	<gtPharoPatch: #Pharo>
	
	aStream nextPutAll: 'ended   '. "three extra spaces to match in list"
	super printOn: aStream
]
