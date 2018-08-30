"
I hold examples with extensions drawn with views that are slow.

[[[
GtInspectorElementWithSlowViews new
]]]

"
Class {
	#name : #GtInspectorElementWithSlowViews,
	#superclass : #Object,
	#category : #'GToolkit-Inspector'
}

{ #category : #ui }
GtInspectorElementWithSlowViews >> gtLong2LastingComputacionFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Even slooower';
		priority: 4;
		stencil: [ 
			6 seconds wait.
			BlTextElement new
				text: 'The slow rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #ui }
GtInspectorElementWithSlowViews >> gtLongLastingComputacionFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Slooow';
		priority: 3;
		stencil: [ 
			3 seconds wait.
			BlTextElement new
				text: 'The slow rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #ui }
GtInspectorElementWithSlowViews >> gtShort2LastingComputacionFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Fast as well';
		priority: 2;
		stencil: [ 
			BlTextElement new
				text: 'I render fast, too.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #ui }
GtInspectorElementWithSlowViews >> gtShortLastingComputacionFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Fast';
		priority: 1;
		stencil: [ 
			BlTextElement new
				text: 'I render fast.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]
