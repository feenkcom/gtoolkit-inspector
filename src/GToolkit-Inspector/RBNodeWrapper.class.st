"
I wrap a RBProgramNode so I can be used by a Mondrian visualization as some of  the RBProgramNode subclasses have  a custom implementation of >>= and it can show two different nodes as being the same node. This in turn will mess up the Mondrian visualization. 
My responsability is to overwrite >>= so that distinct nodes are seen as distinct by Mondrian.
"
Class {
	#name : #RBNodeWrapper,
	#superclass : #Object,
	#instVars : [
		'node',
		'factory'
	],
	#category : #'GToolkit-Inspector-Utility'
}

{ #category : #comparing }
RBNodeWrapper >> = anObject [
	^ self == anObject 
]

{ #category : #accessing }
RBNodeWrapper >> node [
	^ node
]

{ #category : #accessing }
RBNodeWrapper >> node: anObject [
	node := anObject
]

{ #category : #accessing }
RBNodeWrapper >> node: anObject factory: aFactory [
	node := anObject.
	factory := aFactory
]

{ #category : #comparing }
RBNodeWrapper >> parent [ 
	^ factory wrapperFor: node parent
]

{ #category : #comparing }
RBNodeWrapper >> printString [  
	^ node printString
]
