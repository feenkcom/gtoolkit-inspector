Class {
	#name : #Gt2InspectorSelectedTabExtractor,
	#superclass : #Gt2InspectorSelectedTabProtoExtractor,
	#traits : 'TGtElementAssertion',
	#classTraits : 'TGtElementAssertion classTrait',
	#instVars : [
		'inspectorElement'
	],
	#category : #'GToolkit-Inspector-! New - Tab Selector'
}

{ #category : #'api - actions' }
Gt2InspectorSelectedTabExtractor >> extract [
	<return: #Gt2InspectorTabName>
	^ self inspectorElement phlow
		firstChildWithCompositeViewDo: [ :tabGroup | 
			tabGroup viewModel selectedTab widget
				phlow entity 
					ifNotNil: [ :aPhlow | Gt2InspectorTabName new string: aPhlow title asString ]
					ifNil: [ Gt2InspectorTabName null ] ].
]

{ #category : #accessing }
Gt2InspectorSelectedTabExtractor >> inspectorElement [
	<return: #GtInspector>
	^ inspectorElement
]

{ #category : #accessing }
Gt2InspectorSelectedTabExtractor >> inspectorElement: aGtInspector [
	self assertElement: aGtInspector.
	inspectorElement := aGtInspector
]
