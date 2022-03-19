Extension { #name : #CompiledBlock }

{ #category : #'*GToolkit-Inspector' }
CompiledBlock >> gtDisplayOn: stream [
	self printOn: stream
]

{ #category : #'*GToolkit-Inspector' }
CompiledBlock >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		priority: 1;
		object: [ self sourceNode ];
		view: #gtSourceCodeFor:;
		actionButtonIcon: BrGlamorousIcons inspect 
			tooltip: 'Inspect Block' 
			action: [ :aButton | 
				aButton phlow spawnObject: self ]
]
