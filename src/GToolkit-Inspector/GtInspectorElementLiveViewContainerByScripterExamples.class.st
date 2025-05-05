Class {
	#name : #GtInspectorElementLiveViewContainerByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> clickBackOnLiveInTheFirstPagerPage [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self clickOnOverviewInTheFirstPagerPage.

	aScripter
		substeps: 'Display back the live tab in the first page'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Select Live tab';
						// (GtPagerPageElementId indexed: 1);
						// GtInspector;
						// GtPhlowCompositeViewElementId;
						// #tabbar;
						onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Live' ] ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane one live view';
						satisfies: [ :aContainer | aContainer isElementPreviewView ];
						// (GtPagerPageElementId indexed: 1);
						// GtInspectorElementLiveViewContainer ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane two live view';
						satisfies: [ :aContainer | aContainer isElementLiveView ];
						// (GtPagerPageElementId indexed: 2);
						// GtInspectorElementLiveViewContainer ] ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> clickOnOverviewInTheFirstPagerPage [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self elementInSecondPagerPage.

	aScripter
		substeps: 'Display overview tab in the first page'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Select Verview tab';
						// (GtPagerPageElementId indexed: 1);
						// GtInspector;
						// GtPhlowCompositeViewElementId;
						// #tabbar;
						onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Overview' ] ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane one live view';
						notExists;
						// (GtPagerPageElementId indexed: 1);
						// GtInspectorElementLiveViewContainer ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane two live view';
						satisfies: [ :aContainer | aContainer isElementLiveView ];
						// (GtPagerPageElementId indexed: 2);
						// GtInspectorElementLiveViewContainer ] ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> clickOverviewInTheSecondPagerPage [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self clickBackOnLiveInTheFirstPagerPage.

	aScripter
		substeps: 'Display the overview tab in the second page'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Select Live tab';
						// (GtPagerPageElementId indexed: 2);
						// GtInspector;
						// GtPhlowCompositeViewElementId;
						// #tabbar;
						onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Overview' ] ] ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane one live view';
						satisfies: [ :aContainer | aContainer isElementLiveView ];
						// (GtPagerPageElementId indexed: 1);
						// GtInspectorElementLiveViewContainer ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane two live view';
						notExists;
						// (GtPagerPageElementId indexed: 2);
						// GtInspectorElementLiveViewContainer ] ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> elementInPager [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ BlElement new
					size: 50 @ 100;
					background: (Color blue alpha: 0.5);
					relocate: 100 @ 100 ]
			element: [ :anElementToPreview | GtPager createWrappedOn: (GtInspector forObject: anElementToPreview) ].

	aScripter
		assertStep: [ :s | 
			s
				label: 'Assert live view';
				satisfies: [ :aContainer | aContainer isElementLiveView ];
				// (GtPagerPageElementId indexed: 1);
				// GtInspectorElementLiveViewContainer ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> elementInSecondPagerPage [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self elementInPager.


	aScripter
		substeps: 'Element in the second pane'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Spawn the second inspector';
						// GtInspectorInspectButtonId ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane one live view';
						satisfies: [ :aContainer | aContainer isElementLiveView ];
						// (GtPagerPageElementId indexed: 1);
						// GtInspectorElementLiveViewContainer ].

			aStep
				assertStep: [ :s | 
					s
						label: 'Assert pane two live view';
						satisfies: [ :aContainer | aContainer isElementPreviewView ];
						// (GtPagerPageElementId indexed: 2);
						// GtInspectorElementLiveViewContainer ] ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> twoPagerPagesWithInspectedElement [
	<gtExample>
	<return: #GtPager>
	| aScripter |
	aScripter := self clickBackOnLiveInTheFirstPagerPage.

	^ aScripter elementWithoutParent
]
