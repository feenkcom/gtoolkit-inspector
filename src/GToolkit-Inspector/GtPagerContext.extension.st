Extension { #name : #GtPagerContext }

{ #category : #'*GToolkit-Inspector' }
GtPagerContext >> inspectorTabSelector [
	<return: #GtInspectorTabSelector>
	^ self 
		optionAt: #inspectorTabSelector 
		ifAbsentPut: [ GtInspectorTabSelector simple ]
]
