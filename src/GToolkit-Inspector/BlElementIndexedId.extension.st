Extension { #name : #BlElementIndexedId }

{ #category : #'*GToolkit-Inspector' }
BlElementIndexedId >> asBlocElementCode [
	<return: #String>
	^ self prefixId asBlocElementCode asString , ' indexed: ' , self index asString
]
