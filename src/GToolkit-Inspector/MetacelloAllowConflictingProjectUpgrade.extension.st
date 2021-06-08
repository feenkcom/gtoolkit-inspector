Extension { #name : #MetacelloAllowConflictingProjectUpgrade }

{ #category : #'*GToolkit-Inspector' }
MetacelloAllowConflictingProjectUpgrade >> gtViewDiffFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Diff' translated;
		priority: 0;
		text: [ :anEditor |
			| oldReg newReg | 
			oldReg := self existingProjectRegistration.
			newReg := self newProjectRegistration.
			GtEpiceaDiffStencil new
				from: oldReg projectSpec project configuration class name, ' => ', oldReg printString;
				to: newReg projectSpec project configuration class name, ' => ', newReg printString;
				create ];
		action: [ :anAction | 
			anAction button
				icon: BrGlamorousVectorIcons accept;
				tooltip: 'Upgrade';
				priority: 1;
				action: [ self useIncoming ] ];
		action: [ :anAction | 
			anAction button
				icon: BrGlamorousVectorIcons cancel;
				tooltip: 'Use existing';
				priority: 2;
				action: [ self useExisting ] ]
]

{ #category : #'*GToolkit-Inspector' }
MetacelloAllowConflictingProjectUpgrade >> gtViewProjectReferencesFor: aView [
	<gtView>
	| project |
	project := self existingProjectRegistration projectSpec.
	^ aView forward
		title: project name, ' References';
		priority: 0.5;
		object: [  project projectClass ];
		view: #gtAllReferencesFor:
		
]
