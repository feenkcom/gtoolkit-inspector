Extension { #name : #GtPagerStep }

{ #category : #'*GToolkit-Inspector' }
GtPagerStep >> clickOnInspectorInspectButtonAtPage: anIndex [
	^ self inspectorStep
		label: ('Inspector at page no. {1}' format: { anIndex });
		referenceSender;
		clickOnInspectButton;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: GtPager;
		// (GtPagerPageElementId indexed: anIndex)
]

{ #category : #'*GToolkit-Inspector' }
GtPagerStep >> dragInspectorPlaygroundAtPage: anIndex verticallyBy: aNumber [
	^ self inspectorStep
		label: ('Inspector at page no. {1}' format: { anIndex });
		referenceSender;
		dragPlaygroundVerticallyBy: aNumber;
		onParentStepTarget: self;
		onThisOrBreadthFirstChildOfKind: GtPager;
		// (GtPagerPageElementId indexed: anIndex)
]
