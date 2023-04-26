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
	| aScripter |
	aScripter := self clickOnOverviewInTheFirstPagerPage.

	aScripter
		substeps: 'Display back the live tab in the first page'
		do: [ :aStep | 
			aStep click
				label: 'Select Live tab';
				// (GtPagerPageElementId indexed: 1);
				// GtInspector;
				// GtPhlowCompositeViewElementId;
				// #tabbar;
				onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Live' ] ];
				play.

			aStep assert
				label: 'Assert pane one live view';
				satisfies: [ :aContainer | 
					aContainer isElementPreviewView ];
				// (GtPagerPageElementId indexed: 1);
				// GtInspectorElementLiveViewContainer;
				play.

			aStep assert
				label: 'Assert pane two live view';
				satisfies: [ :aContainer | 
					aContainer isElementLiveView ];
				// (GtPagerPageElementId indexed: 2);
				// GtInspectorElementLiveViewContainer;
				play ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> clickOnOverviewInTheFirstPagerPage [
	<gtExample>
	| aScripter |
	aScripter := self elementInSecondPagerPage.

	aScripter
		substeps: 'Display overview tab in the first page'
		do: [ :aStep | 
			aStep click
				label: 'Select Verview tab';
				// (GtPagerPageElementId indexed: 1);
				// GtInspector;
				// GtPhlowCompositeViewElementId;
				// #tabbar;
				onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Overview' ] ];
				play.

			aStep assert
				label: 'Assert pane one live view';
				notExists;
				// (GtPagerPageElementId indexed: 1);
				// GtInspectorElementLiveViewContainer;
				play.

			aStep assert
				label: 'Assert pane two live view';
				satisfies: [ :aContainer | 
					aContainer isElementLiveView ];
				// (GtPagerPageElementId indexed: 2);
				// GtInspectorElementLiveViewContainer;
				play ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> clickOverviewInTheSecondPagerPage [
	<gtExample>
	| aScripter |
	aScripter := self clickBackOnLiveInTheFirstPagerPage.

	aScripter
		substeps: 'Display the overview tab in the second page'
		do: [ :aStep | 
			aStep click
				label: 'Select Live tab';
				// (GtPagerPageElementId indexed: 2);
				// GtInspector;
				// GtPhlowCompositeViewElementId;
				// #tabbar;
				onChildFromBlock: [ :anElement | anElement children detect: [ :each | each label asString = 'Overview' ] ];
				play.

			aStep assert
				label: 'Assert pane one live view';
				satisfies: [ :aContainer | 
					aContainer isElementLiveView ];
				// (GtPagerPageElementId indexed: 1);
				// GtInspectorElementLiveViewContainer;
				play.

			aStep assert
				label: 'Assert pane two live view';
				notExists;
				// (GtPagerPageElementId indexed: 2);
				// GtInspectorElementLiveViewContainer;
				play ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> elementInPager [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithModel: [ BlElement new
					size: 50 @ 100;
					background: (Color blue alpha: 0.5);
					relocate: 100 @ 100 ]
			element: [ :anElementToPreview | 
				GtPager createWrappedOn: (
					GtInspector forObject: anElementToPreview) ].
			
	aScripter assert
		label: 'Assert live view';
		satisfies: [ :aContainer | 
			aContainer isElementLiveView ];
		// (GtPagerPageElementId indexed: 1);
		// GtInspectorElementLiveViewContainer;
		play.

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> elementInSecondPagerPage [
	<gtExample>
	| aScripter |
	aScripter := self elementInPager.


	aScripter
		substeps: 'Element in the second pane'
		do: [ :aStep | 
			aStep click
				label: 'Spawn the second inspector';
				// GtInspectorInspectButtonId;
				play.

			aStep assert
				label: 'Assert pane one live view';
				satisfies: [ :aContainer | 
					aContainer isElementLiveView ];
				// (GtPagerPageElementId indexed: 1);
				// GtInspectorElementLiveViewContainer;
				play.

			aStep assert
				label: 'Assert pane two live view';
				satisfies: [ :aContainer | 
					aContainer isElementPreviewView ];
				// (GtPagerPageElementId indexed: 2);
				// GtInspectorElementLiveViewContainer;
				play. ].

	^ aScripter
]

{ #category : #examples }
GtInspectorElementLiveViewContainerByScripterExamples >> twoPagerPagesWithInspectedElement [
	<gtExample>
	| aScripter |
	aScripter := self clickBackOnLiveInTheFirstPagerPage.

	^ aScripter elementWithoutParent
]
