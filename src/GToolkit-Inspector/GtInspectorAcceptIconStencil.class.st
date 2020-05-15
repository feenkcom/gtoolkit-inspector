Class {
	#name : #GtInspectorAcceptIconStencil,
	#superclass : #BrStencil,
	#instVars : [
		'radius',
		'thickness',
		'angle',
		'color'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'instance creation' }
GtInspectorAcceptIconStencil class >> add [
	^ self new
]

{ #category : #'instance creation' }
GtInspectorAcceptIconStencil class >> close [
	^ self new angle: 45
]

{ #category : #accessing }
GtInspectorAcceptIconStencil >> angle [
	^ angle
]

{ #category : #accessing }
GtInspectorAcceptIconStencil >> angle: anObject [
	angle := anObject
]

{ #category : #'api - instantiation' }
GtInspectorAcceptIconStencil >> color [
	^ color
]

{ #category : #'api - instantiation' }
GtInspectorAcceptIconStencil >> color: aColor [
	color := aColor
]

{ #category : #'api - instantiation' }
GtInspectorAcceptIconStencil >> create [
	| aRadius aThickness |
	aRadius := self radius.
	aThickness := self thickness.
	^ BlElement new
		size: (aRadius + aRadius) @ (aRadius + aRadius);
		geometry:
			(BlPolygon
				vertices:
					{(0 @ 0).
					((aThickness + aThickness) @ 0).
					((aThickness + aThickness) @ (aRadius - aThickness)).
					((aRadius + aRadius) @ (aRadius - aThickness)).
					((aRadius + aRadius) @ (aRadius + aThickness)).
					((0) @ (aRadius + aThickness)) });
		background: self color;
		transformDo: [ :t | t rotateBy: -45 ]
]

{ #category : #initialization }
GtInspectorAcceptIconStencil >> initialize [
	super initialize.

	radius := 5.
	thickness := 1.
	color := Color gray
]

{ #category : #accessing }
GtInspectorAcceptIconStencil >> radius [
	^ radius
]

{ #category : #accessing }
GtInspectorAcceptIconStencil >> radius: anObject [
	radius := anObject
]

{ #category : #accessing }
GtInspectorAcceptIconStencil >> thickness [
	^ thickness
]

{ #category : #accessing }
GtInspectorAcceptIconStencil >> thickness: aNumber [
	thickness := aNumber
]
