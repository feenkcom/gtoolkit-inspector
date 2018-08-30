"
I hold examples with extensions drawn with views that are slow.

[[[
GtInspectorElementWithSlowViews new
]]]

"
Class {
	#name : #GtInspectorElementWithSlowViews,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #'ui - progress' }
GtInspectorElementWithSlowViews >> gtAnyProgressFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Any Progress';
		priority: 7;
		stencil: [ 
			BlTaskProgress signalMessage: 'Obtaining data...'.
			1 second wait.
			BlTaskProgress signalMessage: 'Preparing visualization...'.
			1 second wait.
			BlTextElement new
				text: 'The slow rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'ui - progress' }
GtInspectorElementWithSlowViews >> gtExactProgressFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Exact Progress';
		priority: 5;
		stencil: [ 
			BlTaskItDemoCommand new value.
			BlTextElement new
				text: 'The slow rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

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

{ #category : #'ui - progress' }
GtInspectorElementWithSlowViews >> gtSomeProgressFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Some Progress';
		priority: 6;
		stencil: [ 
			0.5 second wait.
			1 to: 20 do: [ :each |
				BlTaskProgress signal: 'Transferring...' amount: each * 1024.
				(Delay forMilliseconds: 100) wait ].
			BlTextElement new
				text: 'The slow rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]
