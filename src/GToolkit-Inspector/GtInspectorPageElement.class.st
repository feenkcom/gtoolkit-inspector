Class {
	#name : #GtInspectorPageElement,
	#superclass : #BrPagerPageElement,
	#instVars : [
		'weight'
	],
	#category : #'GToolkit-Inspector-Brick'
}

{ #category : #initialization }
GtInspectorPageElement >> initialize [
	super initialize.
	
	weight := 0.5
]

{ #category : #layout }
GtInspectorPageElement >> onMeasure: anExtentMeasurementSpec [
	| aWidthSpec aHeightSpec |
	
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	
	self constraints horizontal resizer isMatchParent
		ifTrue: [ aWidthSpec := BlMeasurementSpec exact: aWidthSpec size * self weight ].

	super onMeasure: aWidthSpec @ aHeightSpec.
	
	
]

{ #category : #accessing }
GtInspectorPageElement >> weight [
	^ weight
]

{ #category : #accessing }
GtInspectorPageElement >> weight: aNumber [
	weight := aNumber.
	self requestLayout
]
