Extension { #name : #BlElementIndexedId }

{ #category : #'*GToolkit-Inspector' }
BlElementIndexedId >> asBlocElementCode [
	<return: #String>
	| aString |
	aString := self prefixId asBlocElementCode asString.
	(aString beginsWith: '#') ifTrue: [ 
		aString := aString, ' asBlocElementId' ].
	
	^ aString , ' indexed: ' , self index asString
]
