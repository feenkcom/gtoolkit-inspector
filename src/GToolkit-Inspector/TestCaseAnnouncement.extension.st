Extension { #name : #TestCaseAnnouncement }

{ #category : #'*GToolkit-Inspector' }
TestCaseAnnouncement >> printOn: aStream [
	<gtPharoPatch: #Pharo>
	
	testCase printOn: aStream
]
