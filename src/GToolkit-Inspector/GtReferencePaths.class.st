Class {
	#name : #GtReferencePaths,
	#superclass : #Object,
	#traits : 'TGtGroupWithItems',
	#classTraits : 'TGtGroupWithItems classTrait',
	#category : #'GToolkit-Inspector-Reference Path'
}

{ #category : #accessing }
GtReferencePaths class >> to: anObject [
	| paths |
	paths := (GtReferenceFinder findAllPathsTo: anObject) collect: [ :each | GtReferencePath simplify: each ].
	^ self withAll: paths
]

{ #category : #cleaning }
GtReferencePaths >> cleanOut [
	self items do: #cleanOut.
	items := nil
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

{ #category : #updating }
GtReferencePaths >> simplify [
	"Recomputes simplified paths"

	^ self items do: #simplify
]

{ #category : #accessing }
GtReferencePaths >> targetObject [
	<return: #GtReferencePathItem>
	^ items anyOne targetObject
]
