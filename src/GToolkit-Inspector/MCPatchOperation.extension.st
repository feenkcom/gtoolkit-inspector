Extension { #name : #MCPatchOperation }

{ #category : #'*GToolkit-Inspector' }
MCPatchOperation >> gtActionApplyFor: composite [
	<gtAction>
	^ composite button
		label: 'Apply';
		priority: 20;
		tooltip: 'Apply me in the image';
		action: [ self gtApply ]
]

{ #category : #'*GToolkit-Inspector' }
MCPatchOperation >> gtApply [
	| loader |
	loader := MCPackageLoader new.
	self applyTo: loader.
	loader load
]

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
