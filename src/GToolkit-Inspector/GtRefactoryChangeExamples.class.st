Class {
	#name : #GtRefactoryChangeExamples,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-Examples'
}

{ #category : #examples }
GtRefactoryChangeExamples >> applyChangesView [
	<gtExample>
	| scripter |
	scripter := BlScripter new
			element: (self createChanges gtApplyingChangesFor: GtPhlowEmptyView new) asElement.
	^ scripter
]

{ #category : #examples }
GtRefactoryChangeExamples >> applyEmptyFilterChanges [
	<gtExample>
	| scripter |
	scripter := self applyChangesView.
	self assert: (self changesIn: scripter) size equals: 7.
	scripter clickStep: [ :s | s // GtFiltersAddId ].
	scripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				// (GtFilterItemId indexed: 1) ].
	scripter clickStep: [ :s | s // GtFilterSettingsId ].
	(scripter type: 'ZZZZ') play.
	(scripter keyPress: BlKeyboardKey return) play.
	self assert: (self changesIn: scripter) size equals: 1.
	scripter
		clickStep: [ :s | 
			s
				label: 'Apply no changes';
				// #applyButton ].
	self checkClassExists: false.
	^ scripter
]

{ #category : #examples }
GtRefactoryChangeExamples >> applyWithAllDisabled [
	<gtExample>
	| scripter |
	self checkClassExists: false.
	scripter := self disableAllChanges.
	scripter
		clickStep: [ :s | 
			s
				label: 'Apply no changes';
				// #applyButton ].
	self checkClassExists: false.
	^ scripter
]

{ #category : #private }
GtRefactoryChangeExamples >> changesIn: scripter [
	| changes |
	scripter
		checkStep: [ :s | 
			s
				label: 'Find changes';
				// #changes;
				// BrSimpleTree;
				do: [ :each | changes := (each nodeAt: 1) value allChanges ] ].
	^ changes
]

{ #category : #examples }
GtRefactoryChangeExamples >> checkClassExists: aBoolean [
	self assert: (Smalltalk globals includesKey: #Asdf1234) equals: aBoolean
]

{ #category : #private }
GtRefactoryChangeExamples >> checkEnabledIn: scripter are: aBlock [
	(self changesIn: scripter)
		do: [ :change | self assert: change isEnabled equals: (aBlock cull: change) ]
]

{ #category : #examples }
GtRefactoryChangeExamples >> clickHeaderExpandsDiff [
	<gtExample>
	| scripter |
	scripter := self applyChangesView.
	scripter
		checkStep: [ :s | 
			s
				label: 'Open menu';
				// GtUserActivatableChangeWithExpanderElement;
				// BrExpander;
				@ 2;
				do: [ :each | self assert: each isExpanded equals: false ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Open menu';
				// GtUserActivatableChangeWithExpanderElement;
				@ 2 ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Open menu';
				// GtUserActivatableChangeWithExpanderElement;
				// BrExpander;
				@ 2;
				do: [ :each | self assert: each isExpanded equals: true ] ].
	scripter
		clickStep: [ :s | 
			s
				label: 'Open menu';
				// GtUserActivatableChangeWithExpanderElement;
				// #'change-description';
				@ 2 ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Open menu';
				// GtUserActivatableChangeWithExpanderElement;
				// BrExpander;
				@ 2;
				do: [ :each | self assert: each isExpanded equals: false ] ].
	^ scripter
]

{ #category : #examples }
GtRefactoryChangeExamples >> createChanges [
	| namespaces refactorings |
	namespaces := GtRBNamespace new.
	refactorings := {GtRBAddClassWithVarsRefactoring
				model: namespaces
				addClass: #Asdf1234
				superclass: #Object
				subclasses: #()
				category: #Asdf1234.
			GtRBAddClassWithVarsRefactoring
				model: namespaces
				addClass: #Fdsa4321
				superclass: #Asdf1234
				subclasses: #()
				category: #Asdf1234.
			GtRBAddMethodRefactoring
				model: namespaces
				sourceCode: 'asdf ^ 42'
				in: #Asdf1234
				withProtocol: #access.
			GtRBPushDownMethodRefactoring
				model: namespaces
				pushDown: #(#asdf)
				from: #Asdf1234}.
	(GtRBCompositeTransformation new
		model: namespaces;
		refactorings: refactorings) primitiveExecute.
	^ namespaces changes
]

{ #category : #examples }
GtRefactoryChangeExamples >> disableAllChanges [
	<gtExample>
	| scripter |
	scripter := self applyChangesView.
	self checkEnabledIn: scripter are: [ true ].
	scripter
		secondaryClickStep: [ :s | 
			s
				label: 'Open menu';
				// GtUserActivatableChangeWithExpanderElement;
				@ 1 ].
	scripter
		clickStep: [ :s | 
			s
				label: 'disable all';
				onSpaceRoot;
				// #'disable-menu' ].
	self checkEnabledIn: scripter are: [ false ].
	^ scripter
]

{ #category : #examples }
GtRefactoryChangeExamples >> filterChanges [
	<gtExample>
	| scripter |
	scripter := self applyChangesView.
	self assert: (self changesIn: scripter) size equals: 7.
	scripter clickStep: [ :s | s // GtFiltersAddId ].
	scripter
		clickStep: [ :s | 
			s
				onSpaceRoot;
				// (GtFilterItemId indexed: 1) ].
	scripter clickStep: [ :s | s // GtFilterSettingsId ].
	(scripter type: 'Fdsa4321') play.
	(scripter keyPress: BlKeyboardKey return) play.
	self assert: (self changesIn: scripter) size equals: 3.
	^ scripter
]
