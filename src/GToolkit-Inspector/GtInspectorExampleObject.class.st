"
I am used by ${class:GtInspectorExamples}$ as an example object.
The purpose it to exemplify ${class:GtInspector}$.

"
Class {
	#name : #GtInspectorExampleObject,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #'gt-extension' }
GtInspectorExampleObject >> gtViewOneFor: aView [
	<gtView>
	^ aView list
		title: 'One';
		priority: 3;
		items: [ 1 to: 50 ]
]

{ #category : #'gt-extension' }
GtInspectorExampleObject >> gtViewTwoFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Two';
		text: [ String loremIpsum: 2000 ]
]
