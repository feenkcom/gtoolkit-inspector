Extension { #name : #GtPagerStep }

{ #category : #'*GToolkit-Inspector' }
GtPagerStep >> clickOnInspectorInspectButtonAtPage: anIndex [
	^ self inspectorStep
		label: ('Inspector at page no. {1}' format: { anIndex });
		referenceSender;
		clickOnInspectButton;
		onThisOrBreadthFirstChildOfKind: GtPager;
		// (GtPagerPageElementId indexed: anIndex)
]

{ #category : #'*GToolkit-Inspector' }
GtPagerStep >> dragInspectorPlaygroundAtPage: anIndex verticallyBy: aNumber [
	^ self inspectorStep
		label: ('Inspector at page no. {1}' format: { anIndex });
		referenceSender;
		dragPlaygroundVerticallyBy: aNumber;
		onThisOrBreadthFirstChildOfKind: GtPager;
		// (GtPagerPageElementId indexed: anIndex)
]
