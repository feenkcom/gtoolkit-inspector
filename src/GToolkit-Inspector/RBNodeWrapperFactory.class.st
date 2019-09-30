"
I create and store wrapper nodes so that the links (parent - children) between wrapper nodes can be estabilshed just like for wrapped nodes.
"
Class {
	#name : #RBNodeWrapperFactory,
	#superclass : #Object,
	#instVars : [
		'nodes'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #initialization }
RBNodeWrapperFactory >> initialize [
	nodes := IdentityDictionary new.
]

{ #category : #'as yet unclassified' }
RBNodeWrapperFactory >> wrapperFor: aNode [
	^ nodes at: aNode ifAbsentPut: [ RBNodeWrapper new node:aNode factory:self. ]
]
