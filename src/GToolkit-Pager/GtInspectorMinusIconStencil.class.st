Class {
	#name : #GtInspectorMinusIconStencil,
	#superclass : #BrStencil,
	#instVars : [
		'radius',
		'thickness',
		'angle'
	],
	#category : #'GToolkit-Pager-Stencils and Builders'
}

{ #category : #'instance creation' }
GtInspectorMinusIconStencil class >> minus [
	^ self new
]

{ #category : #accessing }
GtInspectorMinusIconStencil >> angle [
	^ angle
]

{ #category : #accessing }
GtInspectorMinusIconStencil >> angle: anObject [
	angle := anObject
]

{ #category : #'api - instantiation' }
GtInspectorMinusIconStencil >> create [
	| aRadius aThickness |

	aRadius := self radius.
	aThickness := self thickness.

	^ BlElement new
		size: (aRadius + aRadius) @ (aRadius + aRadius);
		geometry: (BlPolygon vertices: { 
			0@(aRadius + aThickness). 0@(aRadius - aThickness). (aRadius + aRadius)@(aRadius - aThickness). (aRadius + aRadius)@(aRadius + aThickness). 0@(aRadius + aThickness) } );
		background: Color gray;
		transformDo: [ :t | t rotateBy: self angle ]
]

{ #category : #initialization }
GtInspectorMinusIconStencil >> initialize [
	super initialize.

	radius := 5.
	thickness := 1.
	angle := 0
]

{ #category : #accessing }
GtInspectorMinusIconStencil >> radius [
	^ radius
]

{ #category : #accessing }
GtInspectorMinusIconStencil >> radius: anObject [
	radius := anObject
]

{ #category : #accessing }
GtInspectorMinusIconStencil >> thickness [
	^ thickness
]

{ #category : #accessing }
GtInspectorMinusIconStencil >> thickness: aNumber [
	thickness := aNumber
]
