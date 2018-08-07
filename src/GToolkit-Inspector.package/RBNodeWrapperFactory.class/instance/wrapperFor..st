as yet unclassified
wrapperFor: aNode
	^ nodes at: (aNode identityHash) ifAbsentPut: [ RBNodeWrapper new node:aNode factory:self. ]