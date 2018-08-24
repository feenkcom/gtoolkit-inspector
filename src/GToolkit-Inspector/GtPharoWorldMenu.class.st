Class {
	#name : #GtPharoWorldMenu,
	#superclass : #Object,
	#category : 'GToolkit-Inspector-World Menu'
}

{ #category : #'world menu' }
GtPharoWorldMenu class >> documenterClassCommentsMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtdocumenterclasses)
		parent: #gtoolkit;
		label: 'GToolkit Documenter class comments';
		target: self;
		selector: #openAllClassesDocumentedByDocumenter;
		order: 15;
		help: 'Open GToolkit Documenter classes'
]

{ #category : #'world menu' }
GtPharoWorldMenu class >> documenterFilesMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtdocumenterfiles)
		parent: #gtoolkit;
		label: 'GToolkit Documenter files';
		target: self;
		selector: #openAllDocumenterFiles;
		order: 20;
		help: 'Open GToolkit Documenter files'
]

{ #category : #'world menu' }
GtPharoWorldMenu class >> examplesMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtallexamples)
		parent: #gtoolkit;
		label: 'GToolkit All Examples';
		target: self;
		selector: #openAllExamples;
		order: 10;
		help: 'Open GToolkit Examples'
]

{ #category : #'api - actions' }
GtPharoWorldMenu class >> openAllClassesDocumentedByDocumenter [
	GtInspector openOn: (Smalltalk allClassesAndTraits select: [ :eachClassOrTrait | 
		eachClassOrTrait comment includesSubstring: '${' ])
]

{ #category : #'api - actions' }
GtPharoWorldMenu class >> openAllDocumenterFiles [
	GtInspector openOn: (IceRepository registry 
		select: [ :eachRepository | 
			(eachRepository location / 'doc') exists ] 
		thenCollect: [ :eachRepository | 
			(eachRepository location / 'doc') allChildrenMatching: '*.pillar' ])
]

{ #category : #'api - actions' }
GtPharoWorldMenu class >> openAllExamples [
	GtInspector openOn: (GtExampleGroup new examples: Smalltalk gtExamplesContained)
]

{ #category : #'world menu' }
GtPharoWorldMenu class >> playgroundMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtplayground)
		parent: #gtoolkit;
		label: 'GToolkit Playground';
		target: GtInspector;
		selector: #openOnPlayBook;
		order: 5;
		help: 'Open GToolkit Playground';
		iconName: #workspace
]

{ #category : #'world menu' }
GtPharoWorldMenu class >> rootMenuOn: aBuilder [
	<worldMenu>
	(aBuilder group: #gtoolkit)
		order: 0.1;
		iconName: #smallDoItIcon;
		withSeparatorAfter
]
