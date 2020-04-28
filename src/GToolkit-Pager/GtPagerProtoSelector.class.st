Class {
	#name : #GtPagerProtoSelector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Pager-Strategies'
}

{ #category : #'api - scrolling' }
GtPagerProtoSelector >> select: aSelectedObject with: aPhlowTool after: aPageElement [
	self subclassResponsibility
]

{ #category : #'api - scrolling' }
GtPagerProtoSelector >> spawn: aSelectedObject with: aPhlowTool after: aPageElement [
	self subclassResponsibility
]
