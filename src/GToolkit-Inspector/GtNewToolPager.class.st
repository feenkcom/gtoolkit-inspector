"
A tool is a class that knows how to answer ==asElement==
"
Class {
	#name : #GtNewToolPager,
	#superclass : #BlElement,
	#instVars : [
		'brickPager',
		'systemListener',
		'toolPages'
	],
	#category : #'GToolkit-Inspector-New'
}

{ #category : #initialization }
GtNewToolPager >> initialize [
	super initialize.

	brickPager := BrPager new.
	brickPager constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: brickPager.
	systemListener := GtInspectorSystemChangesHandler new inspector: self.
	toolPages := OrderedCollection new
]

{ #category : #api }
GtNewToolPager >> spawnInitialWith: aTool [
]
