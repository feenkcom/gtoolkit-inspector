Extension { #name : #GtPagerContext }

{ #category : #'*GToolkit-Inspector' }
GtPagerContext >> inspectorTabSelector [
	<return: #Gt2InspectorTabSelector>
	^ self 
		optionAt: #inspectorTabSelector 
		ifAbsentPut: [ Gt2InspectorTabSelector simple ]
]
