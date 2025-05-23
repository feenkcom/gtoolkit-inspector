"
I hold examples with extensions drawn with views that are slow.

```
GtInspectorElementWithSlowViews new
```


"
Class {
	#name : #GtInspectorElementWithSlowViews,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtAnyProgressFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Any progress';
		priority: 7;
		stencil: [ 
			2 second wait.
			BlTextElement new
				text: 'The Any Progress rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtExactProgressFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Exact progress';
		priority: 5;
		stencil: [ 
			BlTextElement new
				text: 'The Exact Progress rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtLongLastingComputation2For: aView [
	<gtView>
	^ aView explicit 
		title: 'Even slooower' translated;
		priority: 4;
		stencil: [ | text bench |
			bench := [ 10000 factorial ] benchFor: 15 seconds.
			text := String streamContents: [ :s |
				s
					<< 'The Even Slower rendering is now finished (10000 factorial @ ';
					<< bench shortPrintString;
					<< ')' ].
			BlTextElement new
				text: text asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtLongLastingComputationFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Slooow' translated;
		priority: 3;
		stencil: [ | text bench |
			bench := [ 10000 factorial ] benchFor: 3 seconds.
			text := String streamContents: [ :s |
				s
					<< 'The Slow rendering is now finished (10000 factorial @ ';
					<< bench shortPrintString;
					<< ')' ].
			BlTextElement new
				text: text asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtProgressingComputationFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Progressing' translated;
		priority: 5;
		stencil: [ 
			BlTextElement new
				text: 'The Progressing rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtShortLastingComputation2For: aView [
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

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtShortLastingComputationFor: aView [
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

{ #category : #'gt-extension' }
GtInspectorElementWithSlowViews >> gtSomeProgressFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Some progress';
		priority: 6;
		stencil: [ 
			0.5 second wait.
			1 to: 20 do: [ :each |
				(Delay forMilliseconds: 100) wait ].
			BlTextElement new
				text: 'The Some Progress rendering is now finished.' asRopedText;
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical matchParent ] ]
]

{ #category : #examples }
GtInspectorElementWithSlowViews >> itself [
	<gtExample>
	<return: #GtInspectorElementWithSlowViews>
	^ self
]

{ #category : #examples }
GtInspectorElementWithSlowViews >> views [
	<gtExample>
	<return: #GtPhlowLabelledView>
	| aView |
	aView := self gtViewsFor: GtPhlowView empty.
	self assert: aView originalView views size > 8.
	^ aView
]
