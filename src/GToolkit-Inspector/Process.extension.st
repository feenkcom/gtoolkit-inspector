Extension { #name : #Process }

{ #category : #'*GToolkit-Inspector' }
Process >> gtId [
	<return: #String>
	^ self hash asString
]

{ #category : #'*GToolkit-Inspector' }
Process >> gtName [
	<return: #String>
	^ name ifNil: [ '' ] ifNotNil: #asString
]
