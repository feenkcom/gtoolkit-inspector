"
I am used by ${class:Gt2InspectorExamples}$ as an example object.
The purpose it to exemplify ${class:Gt2Inspector}$ and ${class:Gt2InspectorModel}$.

"
Class {
	#name : #Gt2InspectorExampleObject,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-! New - Examples'
}

{ #category : #'gt-extension' }
Gt2InspectorExampleObject >> gtViewOneFor: aView [
	<gtView>
	^ aView list
		title: 'One';
		items: [ 1 to: 50 ]
]

{ #category : #'gt-extension' }
Gt2InspectorExampleObject >> gtViewTwoFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Two';
		text: [ String loremIpsum: 2000 ]
]
