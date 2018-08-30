Extension { #name : #BlElement }

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtChangesFor: aView [
	<gtView>
	^ (self changes gtItemsFor: aView) 
		title: 'Changes';
		priority: 30
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtEditorFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Editor';
		priority: 13;
		stencil: [ | theEditors container |
			theEditors := GtDiagrammerFigureEditor editorsOf: self.
			
			container := BlElement new.
			container layout: BlLinearLayout vertical.
			container constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			
			theEditors do: [ :anEditor |
				| aTitle |
				aTitle := BlTextEditElement new text: (anEditor title asRopedText).
				aTitle margin: (BlInsets all: 5). 
				container addChild: aTitle.
				container addChild: anEditor editor ].
			
			container
			 ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		priority: 0;
		stencil: [ self ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtMeasurementChainFor: aView [
	<gtView>
	| withAllParents |
	withAllParents := Array streamContents: [ :aStream |
		| currentElement |
		currentElement := self.
		aStream nextPut: currentElement.
		[ currentElement hasParent ] whileTrue: [ 
			currentElement := currentElement parent.
			aStream nextPut: currentElement ] ].
	
	^ aView explicit 
		title: 'Measurement' translated;
		priority: 15;
		stencil: [
			| list |
			list := BrColumnedList new display: [ withAllParents reversed withIndexCollect: [ :anElement :anIndex |
				{
					#index -> anIndex .
					#spec -> anElement layout previousMeasurementSpec.
					#element -> anElement.
					#layout -> anElement layout
				} asDictionary ]  ].
			list column 
				title: 'Index';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: (each at: #index) gtDisplayString) asElement.
					element constraintsDo: [ :c | c horizontal exact: 50 ]. 
					].
			list column 
				title: 'Width spec';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: ((each at: #spec) ifNotNil: #widthSpec) gtDisplayString ) asElement.
					element constraintsDo: [ :c | c horizontal exact: 100 ]. 
					].
			list column 
				title: 'Height spec';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: ((each at: #spec) ifNotNil: #heightSpec) gtDisplayString ) asElement.
					element constraintsDo: [ :c | c horizontal exact: 100 ]. 
					].
			list column 
				title: 'Layout';
				stencil: [ :each | 
					| element |
					element := (BrListLabelStencil fitContent: (each at: #layout) gtDisplayString ) asElement.
					element constraintsDo: [ :c | c horizontal exact: 100 ]. 
					].
			list column 
				title: 'Element';
				stencil: [ :each | BrListLabelStencil matchParent: (each at: #element) gtDisplayString ].		
			list
			].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtMetricsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Metrics';
		priority: 20;
		stencil: [ BlMetricsInspector new relocate:25@25; for: self ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtOpenInSpaceFor: anAction [
	<gtAction>
	self hasParent ifTrue: [ ^ anAction noAction].
	^ anAction explicit stencil: [
		| button |
		button := BrButton new.
		button
		look: BrGlamorousButtonExteriorRectangularLook + BrGlamorousButtonIconLook; 
		action:  [ self hasParent ifFalse: [ BlSpace new rootDo:[:r| r addChild: self];show ]];
		icon: BrGlamorousIcons play asElement;
		label: 'Open in Space' translated.
	].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Preview';
		priority: 1;
		stencil: [ BlElement new background: self asSpartaForm ]
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtResizersFor: aView [
	<gtView>
	| withAllParents |
	withAllParents := Array streamContents: [ :aStream |
		aStream nextPut: self.
		self parentsDo: [ :anElement | aStream nextPut: anElement ] ].
	
	^ aView explicit
		title: 'Resizers' translated;
		priority: 10;
		stencil: [
			| list |
			list := BrColumnedList new display: withAllParents reversed.
			list column 
				title: 'Icon';
				stencil: [ :each |
					| icon element |
					icon := each asSpartaForm scaledToSize: 16@16.
					element := BlElement new.
					element width: 16.
					element height: 16.
					element margin: (BlInsets all: 3).
					element background: icon.
					element ].
			list column 
				title: 'Width';
				stencil: [ :each | 
					| widthElement |
					widthElement := (BrListLabelStencil matchParent: each constraints horizontal resizer gtDisplayString) asElement.
					widthElement constraintsDo: [ :c | c horizontal exact: 150].
					widthElement ].
			list column 
				title: 'Height';
				stencil: [ :each | 
					| widthElement |
					widthElement := (BrListLabelStencil matchParent: each constraints vertical resizer gtDisplayString) asElement.
					widthElement constraintsDo: [ :c | c horizontal exact: 100].
					widthElement ].
			list column 
				title: 'Layout';
				stencil: [ :each | 
					| widthElement |
					widthElement := (BrListLabelStencil matchParent: each layout gtDisplayString) asElement.
					widthElement constraintsDo: [ :c | c horizontal exact: 150].
					widthElement ].		
			list column 
				title: 'Element';
				stencil: [ :each | (BrListLabelStencil matchParent: each gtDisplayString) ].			
			list
			].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtShortcutsFor: aView [
	<gtView>
	self shortcuts ifEmpty: [ ^ aView empty ].
	^ aView explicit 
		title: 'Shortcuts' translated;
		priority: 10;
		stencil: [
			| list |
			list := BrColumnedList new display: self shortcuts.
			list column 
				title: 'Key';
				stencil: [ :each | BrListLabelStencil matchParent: each combination gtDisplayString ].
			list column 
				title: 'Action';
				stencil: [ :each | BrListLabelStencil matchParent: each action asString ].
			list
			].
]

{ #category : #'*GToolkit-Inspector' }
BlElement >> gtUserDataFor: aView [
	<gtView>
	^ (self userData gtItemsFor: aView) 
		title: 'User data';
		priority: 5
]
