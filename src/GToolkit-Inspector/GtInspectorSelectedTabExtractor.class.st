Class {
	#name : #GtInspectorSelectedTabExtractor,
	#superclass : #Object,
	#traits : 'TBlDebug + TGtElementAssertion',
	#classTraits : 'TBlDebug classTrait + TGtElementAssertion classTrait',
	#instVars : [
		'inspectorElement'
	],
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #'api - actions' }
GtInspectorSelectedTabExtractor >> extractTabName [
	<return: #GtInspectorTabName>
	self inspectorElement phlow
		firstChildWithCompositeViewContentDo: [ :tabGroup | 
			^ tabGroup viewModel selectedTab widget
				phlow entity 
					ifNotNil: [ :aPhlow | 
						GtInspectorTabName new 
							string: aPhlow title asString ]
					ifNil: [ GtInspectorTabName null ] ].
	^ GtInspectorTabName null
]

{ #category : #accessing }
GtInspectorSelectedTabExtractor >> inspectorElement [
	<return: #GtInspector>
	^ inspectorElement
]

{ #category : #accessing }
GtInspectorSelectedTabExtractor >> inspectorElement: aGtInspector [
	self assertElement: aGtInspector.
	inspectorElement := aGtInspector
]
