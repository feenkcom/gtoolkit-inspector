Class {
	#name : #GtInspectorPlusIconStencil,
	#superclass : #BrStencil,
	#instVars : [
		'radius',
		'thickness',
		'angle',
		'color'
	],
	#category : #'GToolkit-Inspector-Stencils'
}

{ #category : #'instance creation' }
GtInspectorPlusIconStencil class >> add [
	^ self new
]

{ #category : #'instance creation' }
GtInspectorPlusIconStencil class >> close [
	^ self new angle: 45
]

{ #category : #accessing }
GtInspectorPlusIconStencil >> angle [
	^ angle
]

{ #category : #accessing }
GtInspectorPlusIconStencil >> angle: anObject [
	angle := anObject
]

{ #category : #'api - instantiation' }
GtInspectorPlusIconStencil >> color [
	^ color
]

{ #category : #'api - instantiation' }
GtInspectorPlusIconStencil >> color: aColor [
	color := aColor
]

{ #category : #'api - instantiation' }
GtInspectorPlusIconStencil >> create [
	| aRadius aThickness |
	aRadius := self radius.
	aThickness := self thickness.
	^ BlElement new
		size: (aRadius + aRadius) @ (aRadius + aRadius);
		geometry:
			(BlPolygon
				vertices:
					{((aRadius - aThickness) @ 0).
					((aRadius + aThickness) @ 0).
					((aRadius + aThickness) @ (aRadius - aThickness)).
					((aRadius + aRadius) @ (aRadius - aThickness)).
					((aRadius + aRadius) @ (aRadius + aThickness)).
					((aRadius + aThickness) @ (aRadius + aThickness)).
					((aRadius + aThickness) @ (aRadius + aRadius)).
					((aRadius - aThickness) @ (aRadius + aRadius)).
					((aRadius - aThickness) @ (aRadius + aThickness)).
					(0 @ (aRadius + aThickness)).
					(0 @ (aRadius - aThickness)).
					((aRadius - aThickness) @ (aRadius - aThickness))});
		background: self color;
		transformDo: [ :t | t rotateBy: self angle ]
]

{ #category : #initialization }
GtInspectorPlusIconStencil >> initialize [
	super initialize.

	radius := 5.
	thickness := 1.
	angle := 0.
	color := Color gray
]

{ #category : #accessing }
GtInspectorPlusIconStencil >> radius [
	^ radius
]

{ #category : #accessing }
GtInspectorPlusIconStencil >> radius: anObject [
	radius := anObject
]

{ #category : #accessing }
GtInspectorPlusIconStencil >> thickness [
	^ thickness
]

{ #category : #accessing }
GtInspectorPlusIconStencil >> thickness: aNumber [
	thickness := aNumber
]
