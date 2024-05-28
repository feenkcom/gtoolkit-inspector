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
		icon: BrGlamorousIcons accept;
		tooltip: 'Load this change in the image';
		priority: 10;
		action: [ self asMCMethodDefinition load ]
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
