Class {
	#name : #GtReferencePaths,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-Inspector'
}

{ #category : #accessing }
GtReferencePaths class >> to: anObject [
	| paths |
	paths := (GtReferenceFinder findAllPathsTo: GtWorld allInstances anyOne) collect: [ :each | GtReferencePath new objects: each ].
	^ self withAll: paths
]

{ #category : #views }
GtReferencePaths >> gtPathsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Paths';
		items: [ self items ];
		column: 'Path' text: [ :each | each ];
		column: 'Size' text: [ :each | each size ] width: 100
]

{ #category : #accessing }
GtReferencePaths >> paths [
]
