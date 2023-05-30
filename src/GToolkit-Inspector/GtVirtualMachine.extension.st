Extension { #name : #GtVirtualMachine }

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachine >> gtEnabledSignals: aView [
	<gtView>
	
	^ aView list
		priority: 3;
		title: 'Enabled signals';
		items: [ self enabledSignals ]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachine >> gtNamedPrimitives: aView [
	<gtView>
	
	^ aView columnedList
		priority: 2;
		title: 'Named primitives';
		items: [ self namedPrimitives ];
		column: 'Primitive' text: [ :each | each primitive ];
		column: 'Plugin' text: [ :each | each plugin ifEmpty: [ 'internal' asRopedText italic ] ]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachine >> gtVirtualMachineInfoJsonFor: aView [
	<gtView>

	^ aView textEditor
		title: 'VM info json';
		priority: 3;
		actionButtonIcon: BrGlamorousIcons tree 
			action: [ :aButton | 
				aButton phlow spawnObject: (GtVirtualMachineSource fromJSONString: self primitiveVirtualMachineInfo) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ self primitiveVirtualMachineInfo ]
]

{ #category : #'*GToolkit-Inspector' }
GtVirtualMachine >> gtVirtualMachineOverviewFor: aView [
	<gtView>

	^ aView forward
		title: 'Overview';
		priority: 2;
		object: [ GtVirtualMachineSource fromJSONString: self primitiveVirtualMachineInfo ];
		view: #gtOverviewFor:
]
