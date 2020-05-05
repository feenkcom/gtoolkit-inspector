Extension { #name : #GtPagerToolContext }

{ #category : #'*GToolkit-Inspector' }
GtPagerToolContext >> inspectorTabSelector [
	<return: #Gt2InspectorTabSelector>
	^ self 
		optionAt: #inspectorTabSelector 
		ifAbsentPut: [ Gt2InspectorTabSelector simple ]
]
