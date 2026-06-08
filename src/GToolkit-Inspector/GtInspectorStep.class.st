Class {
	#name : #GtInspectorStep,
	#superclass : #GtPhlowViewsBasedToolStep,
	#category : #'GToolkit-Inspector-Scripter'
}

{ #category : #'steps - checks' }
GtInspectorStep >> assertInspectedObjectOfType: aClass [
	self assert
		label: ('Assert inspected object has type {1}' format: {aClass name});
		value: [ :anInspector | anInspector object class ]
			equals: aClass;
		onParentStepTarget: self;
		// GtInspector
]

{ #category : #'steps - checks' }
GtInspectorStep >> assertInspectedObjectSatisfies: aBlockClosure description: aStringOrBlockCosure [
	self 
		assertInspectedObjectSatisfies: aBlockClosure 
		description: aStringOrBlockCosure 
		label: 'Assert inspected object matches condition'
]

{ #category : #'steps - checks' }
GtInspectorStep >> assertInspectedObjectSatisfies: aBlockClosure description: aStringOrBlockCosure label: aLabel [
	self assert
		label: aLabel;
		satisfies: [ :anInspectedObject | 
				aBlockClosure value: anInspectedObject  ]
			description: aStringOrBlockCosure;
		onParentStepTarget: self;
		// GtInspector;
		onChildFromMessage: #object
]

{ #category : #'steps - checks' }
GtInspectorStep >> assertInspectedObjectValueFor: aBlockClosure equals: aValue [
	self assert
		label: ('Assert inspected object computation equals value');
		value: [ :anInspectedObject | aBlockClosure value: anInspectedObject ]
			equals: aValue;
		onParentStepTarget: self;
		// GtInspector;
		onChildFromMessage: #object
]

{ #category : #'steps - interactions' }
GtInspectorStep >> clickOnBrowseButton [
	^ self
		substeps2: 'Click on browse button'
		do: [ :aStep | 
			aStep menuStep
				onParentStepTarget: aStep;
				// GtPhlowLabelledViewElementId;
				/ #header;
				openContextMenu.

			aStep menuStep
				clickMenuItemWithId: GtInspectorBrowseButtonId;
				onPopover ]
]

{ #category : #'steps - interactions' }
GtInspectorStep >> clickOnInspectButton [
	^ self
		substeps2: 'Click on inspect button'
		do: [ :aStep | 
			aStep menuStep
				// GtPhlowLabelledViewElementId;
				/ #header;
				openContextMenu.

			aStep menuStep
				clickMenuItemWithId: GtInspectorInspectButtonId;
				onPopover ]
]
