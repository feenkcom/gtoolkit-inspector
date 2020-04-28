Class {
	#name : #GtPagerPageProtoSelectionContext,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Pager-Contexts'
}

{ #category : #converting }
GtPagerPageProtoSelectionContext >> asElementDo: aOneArgBlock [
	"Create a tool element and execute the block"
	self subclassResponsibility
]
