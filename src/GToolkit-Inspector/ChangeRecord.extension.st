Extension { #name : #ChangeRecord }

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> currentSourceCodeInImage [
	^ self isMethodDefinedInImage 
		ifTrue: [ self methodClass sourceCodeAt: self methodSelector ] 
		ifFalse: [ '' ]
]

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> gtActionLoadVersionFor: anAction [
	<gtAction>
	
	^ anAction button 
		label: 'Load';
		icon: BrGlamorousVectorIcons accept;
		tooltip: 'Load this change in the image';
		priority: 10;
		action: [ self gtLoadWithUndo ]
]

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> gtLoadWithUndo [
	"Load the method of this change record through a recorded change,
	so that it can be undone and keeps the undo history.
	If its class is not in the image, load it as Monticello does"

	| aClass |
	self type == #method ifFalse: [ ^ self ].
	aClass := self methodClass ifNil: [ ^ self asMCMethodDefinition load ].
	
	GtRefactoryChangeManager instance
		performChange: (RBAddMethodChange
				compile: self sourceCode
				in: aClass
				classified: self protocol)
]

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> gtSourceFor: aView [
	<gtView>
	^ aView textEditor 
		title: 'Source';
		priority: 5;
		aptitude: BrGlamorousCodeEditorAptitude;
		styler: (BrRBTextStyler new
			 classOrMetaClass: self methodClass);
		text: [self sourceCode]
]

{ #category : #'*GToolkit-Inspector' }
ChangeRecord >> gtViewDiffWithInImageCodeFor: aView [
	<gtView>
	
	^ aView explicit 
		title: 'Diff (current)';
		priority: 10;
		stencil: [ 
			| change styler |

			change := GtDiffBuilder
				computeDifferencesFrom: self sourceCode 
				to: self currentSourceCodeInImage
				using: GtSmaCCDiffSplitter forPharo.
				
			styler := GtCodeDiffRBTextStyler new.

			GtDiffElementWithLabelStencil new
				fromLabelText: 'Version';
				toLabelText: 'Image';
				change: change;
				styler: styler ] 
]
