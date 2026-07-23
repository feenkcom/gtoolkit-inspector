"
I demonstrate how to use {{gtClass:GtInspectorStep}} — a domain-specific tool step for asserting inspector state.

{{gtClass:GtInspectorStep}} inherits from {{gtClass:GtPhlowViewsBasedToolStep}} and adds inspector-specific assertions: checking the inspected object type, values, and clicking browse/inspect buttons.

Access it via `scripter inspectorStep`.

## Example

{{gtExample:BlScripterInspectorStepUsageExamples>>#inspectorOnNumberAssertType|previewExpanded=true|previewHeight=300}}
"
Class {
	#name : #GtScripterInspectorStepUsageExamples,
	#superclass : #BlScripterStepUsageExamples,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtScripterInspectorStepUsageExamples >> inspectorClickTabAndAssert [
	"Demonstrates using inspectorStep to click on a tab and assert selection.
	Uses inherited methods from GtPhlowViewsBasedToolStep."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (GtInspector createOn: 42).
	
	aScripter inspectorStep
		label: 'Switch to the Print view from Preview';
		assertSelectedTabWithName: 'Preview';
		assertHasTabWithName: 'Print';
		clickOnTabWithName: 'Print';
		assertSelectedTabWithName: 'Print';
		play.
		
	^ aScripter
]

{ #category : #examples }
GtScripterInspectorStepUsageExamples >> inspectorInPagerClickInspectSpawnsPane [
	"Demonstrates clicking the inspect button in an inspector within a pager.
	Verifies that a second pane is spawned with the same inspected object."
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (GtPagerSettings usedPager 
		createWrappedOn: (GtInspectorTool forObject: 42)).
		
	aScripter inspectorStep
		label: 'Click on the inspect button';
		clickOnInspectButton;
		play.
		
	aScripter inspectorStep
		label: 'Check the object in the second pane';
		onPagerPaneWithIndex: 2;
		assertInspectedObjectOfType: SmallInteger;
		play.
		
	^ aScripter
]

{ #category : #examples }
GtScripterInspectorStepUsageExamples >> inspectorOnCollectionAssertSatisfies [
	"Demonstrates using inspectorStep to assert a condition on the inspected object.
	Uses GtInspectorStep>>assertInspectedObjectSatisfies:description:"
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (GtInspector createOn: #(1 2 3)).
	
	aScripter inspectorStep
		label: 'Assert object size';
		assertInspectedObjectSatisfies: [ :anArray | anArray size = 3 ]
			description: 'Array should have 3 elements';
		play.
		
	^ aScripter
]

{ #category : #examples }
GtScripterInspectorStepUsageExamples >> inspectorOnNumberAssertType [
	"Demonstrates using inspectorStep to assert the type of the inspected object.
	Uses GtInspectorStep>>assertInspectedObjectOfType:"
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (GtInspector createOn: 42).
	
	aScripter inspectorStep
		label: 'Assert object type';
		assertInspectedObjectOfType: SmallInteger;
		play.
		
	^ aScripter
]

{ #category : #examples }
GtScripterInspectorStepUsageExamples >> inspectorOnStringAssertValue [
	"Demonstrates using inspectorStep to assert a value computed from the inspected object.
	Uses GtInspectorStep>>assertInspectedObjectValueFor:equals:"
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter element: (GtInspector createOn: 'hello world').
	
	aScripter inspectorStep
		label: 'Assert object size';
		assertInspectedObjectValueFor: [ :aString | aString size ]
			equals: 11;
		play.
		
	^ aScripter
]
