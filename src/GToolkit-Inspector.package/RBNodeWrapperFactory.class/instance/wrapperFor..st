as yet unclassified
wrapperFor: aNode
	^ nodes at: aNode ifAbsentPut: [ RBNodeWrapper new node:aNode factory:self. ]