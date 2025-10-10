Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Inspector' }
ClassDescription >> gtSpecificSizeInMemory [
	^ self sizeInMemory 
		+ self methodDict gtSpecificSizeInMemory
		+ (self 
			forPharo12AndNewer: [
				self protocols gtSpecificSizeInMemory
					+ (self protocols sumNumbers: [ :aProtocol |
						aProtocol gtSpecificSizeInMemory ])] 
			forPharo11: [
				(self basicOrganization 
					ifNil: [ 0 ] 
					ifNotNil: [ self basicOrganization gtSpecificSizeInMemory ])])
]
