Class {
	#name : #GtInspectorStep,
	#superclass : #BlDevScripterToolActionStep,
	#category : #'GToolkit-Inspector-Scripter'
}

{ #category : #'steps - checks' }
GtInspectorStep >> assertSelectedTabWithName: aName [
	self assert
		label: ('Assert selected tab is {1}' format: {aName});
		satisfies: [ :aBrTabGroup | 
				aBrTabGroup viewModel hasSelectedTab
					and: [ aBrTabGroup viewModel selectedTab tabLabel text asString = aName asString ] ]
			description: [ 'There must be a selected tab with name {1}' format: {aName} ];
		onParentStepTarget: self;
		// GtPhlowCompositeViewElementId
]

{ #category : #'steps - interactions' }
GtInspectorStep >> clickOnInspectButton [
	^ self click
		referenceSender;
		label: 'Click on play and inspect button';
		// GtInspectorInspectButtonId
]

{ #category : #'steps - interactions' }
GtInspectorStep >> dragPlaygroundVerticallyBy: aNumber [
	^ (self mouseDragBy: 0 @ aNumber)
		label: ('Drag inspector playground by {1}' format: { aNumber });
		referenceSender;
		// LeInspectorPlaygroundResizerId
]
