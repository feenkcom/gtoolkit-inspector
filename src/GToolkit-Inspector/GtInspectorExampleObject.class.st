"
I am used by {{gtClass:GtInspectorExamples}} as an example object.
The purpose it to exemplify {{gtClass:GtInspector}}.


"
Class {
	#name : #GtInspectorExampleObject,
	#superclass : #Object,
	#instVars : [
		'collection'
	],
	#category : #'GToolkit-Inspector-Example Samples'
}

{ #category : #accessing }
GtInspectorExampleObject >> collection [
	^ collection
]

{ #category : #'gt-extension' }
GtInspectorExampleObject >> gtViewOneFor: aView [
	<gtView>
	^ aView list
		title: 'One';
		priority: 3;
		items: [ 1 to: 50 ]
]

{ #category : #'gt-extension' }
GtInspectorExampleObject >> gtViewThreeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Three';
		priority: 60;
		items: [ collection ];
		column: 'Value' text: #yourself;
		contextItemLabel: 'Remove item (view update wish)'
			action: [ :anElement :anItem | 
				collection remove: anItem.
				anElement phlow fireViewUpdateWish ];
		contextItemLabel: 'Remove item (tool update wish)'
			action: [ :anElement :anItem | 
				collection remove: anItem.
				anElement phlow fireToolUpdateWish ]
]

{ #category : #'gt-extension' }
GtInspectorExampleObject >> gtViewTwoFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Two';
		text: [ String loremIpsum: 2000 ]
]

{ #category : #initialization }
GtInspectorExampleObject >> initialize [
	super initialize.
	collection := OrderedCollection withAll: (1 to: 10)
]
