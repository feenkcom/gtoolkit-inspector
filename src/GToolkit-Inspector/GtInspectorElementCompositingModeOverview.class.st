Class {
	#name : #GtInspectorElementCompositingModeOverview,
	#superclass : #Object,
	#instVars : [
		'inspectedElement'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #'gt - extensions' }
GtInspectorElementCompositingModeOverview >> gtOverview [
	^ Array
		streamContents: [ :aStream | 
			GtPhlowOverviewItem new
				name: 'Element';
				if: inspectedElement wantsSeparateCompositingLayer
					description: 'wants separate composition layer';
				if: inspectedElement wantsSeparateCompositingLayer not
					subduedDescription: 'does not want separate composition layer';
				value: inspectedElement;
				toStream: aStream.
			GtPhlowOverviewItem new
				name: 'Element compositing mode';
				if: inspectedElement compositingMode wantsCompositionLayer
					description: 'wants composition layer';
				if: inspectedElement compositingMode wantsCompositionLayer not
					subduedDescription: 'does not want composition layer';
				value: inspectedElement compositingMode;
				toStream: aStream.
			GtPhlowOverviewItem new
				name: 'Element effect';
				if: inspectedElement effect wantsCompositionLayer
					description: 'wants composition layer';
				if: inspectedElement effect wantsCompositionLayer not
					subduedDescription: 'does not want composition layer';
				value: inspectedElement effect;
				toStream: aStream.
			GtPhlowOverviewItem new
				name: 'Element parent';
				if: self parentWantsBufferedLayer description: 'wants bufferend layer';
				if: self parentWantsBufferedLayer not
					subduedDescription: 'does not want buffered layer';
				value: self parentWithBufferedLayer;
				toStream: aStream ]
]

{ #category : #'gt - extensions' }
GtInspectorElementCompositingModeOverview >> gtOverviewFor: aView [
	<gtView>
	inspectedElement ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [ self gtOverview ];
		column: 'Name' text: #name;
		column: 'Value' text: #description;
		send: #value
]

{ #category : #'gt - extensions' }
GtInspectorElementCompositingModeOverview >> gtWithParentsOverviewFor: aView [
	<gtView>
	inspectedElement ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Parents';
		priority: 2;
		items: [ inspectedElement withAllParents ];
		column: 'Element'
			text: #yourself
			weight: 2;
		column: 'Composition layer'
			text: [ :anElement | anElement wantsSeparateCompositingLayer ifTrue: [ 'yes' ] ifFalse: [ '' ] ]
			weight: 1.2;
		column: 'Comp. mode wants'
			text: [ :anElement | 
				anElement compositingMode wantsCompositionLayer
					ifTrue: [ 'yes' ]
					ifFalse: [ '' ] ]
			weight: 1.3;
		column: 'Effect wants'
			text: [ :anElement | anElement effect wantsCompositionLayer ifTrue: [ 'yes' ] ifFalse: [ '' ] ]
			weight: 0.8;
		column: 'Buffered layer'
			text: [ :anElement | anElement compositingMode wantsBufferedLayer ifTrue: [ 'yes' ] ifFalse: [ '' ] ]
			weight: 0.9
]

{ #category : #accessing }
GtInspectorElementCompositingModeOverview >> inspectedElement [
	^ inspectedElement
]

{ #category : #accessing }
GtInspectorElementCompositingModeOverview >> inspectedElement: anObject [
	inspectedElement := anObject
]

{ #category : #testing }
GtInspectorElementCompositingModeOverview >> parentWantsBufferedLayer [
	^ self parentWithBufferedLayer isNotNil
]

{ #category : #accessing }
GtInspectorElementCompositingModeOverview >> parentWithBufferedLayer [
	inspectedElement
		allParentsDo: [ :eachParent | eachParent compositingMode wantsBufferedLayer ifTrue: [ ^ eachParent ] ].

	^ nil
]
