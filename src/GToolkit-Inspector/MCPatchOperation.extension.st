Extension { #name : #MCPatchOperation }

{ #category : #'*GToolkit-Inspector' }
MCPatchOperation >> gtDiff [
	^ GtDiffBuilder
		computeDifferencesFrom: self diffFromSource
		to: self diffToSource
		using: GtLineDiffSplitter new
]

{ #category : #'*GToolkit-Inspector' }
MCPatchOperation >> gtViewGtDiffFor: composite [
	<gtView>
	^ composite forward
		title: 'GtDiff';
		priority: 25;
		object: [ self gtDiff ];
		view: #gtTextView:
]
