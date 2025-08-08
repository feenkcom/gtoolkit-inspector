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
GtInspectorStep >> clickOnBrowseButton [
	^ self click
		referenceSender;
		label: 'Click on browse button';
		// GtInspectorBrowseButtonId
]

{ #category : #'steps - interactions' }
GtInspectorStep >> clickOnInspectButton [
	^ self click
		referenceSender;
		label: 'Click on inspect button';
		// GtInspectorInspectButtonId
]

{ #category : #'steps - interactions' }
GtInspectorStep >> clickOnTabWithName: aTabName [
	^ self click
		referenceSender;
		label: ('Click on inspector tab named {1}' format: { aTabName });
		// GtPhlowCompositeViewElementId;
		// BrTab;
		@ [ :aTab | aTab label asString = aTabName ]
]

{ #category : #'steps - interactions' }
GtInspectorStep >> dragPlaygroundVerticallyBy: aNumber [
	^ (self mouseDragBy: 0 @ aNumber)
		label: ('Drag inspector playground by {1}' format: { aNumber });
		referenceSender;
		// LeInspectorPlaygroundResizerId
]
