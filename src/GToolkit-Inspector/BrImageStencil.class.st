"
I create a BlElement with the provided image as background.
"
Class {
	#name : #BrImageStencil,
	#superclass : #BrStencil,
	#instVars : [
		'image'
	],
	#category : #'GToolkit-Inspector-Stencils'
}

{ #category : #'api - instantiation' }
BrImageStencil >> create [
	^ BlElement new
		background: self image;
		size: self image extent
]

{ #category : #'api - instantiation' }
BrImageStencil >> image [
	^ image.
]

{ #category : #'api - instantiation' }
BrImageStencil >> image: anImage [
	image := anImage
]
