Class {
	#name : #GtWorld,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-World Menu'
}

{ #category : #'world menu' }
GtWorld class >> allExamplesMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtallexamples)
		parent: #gtoolkit;
		label: 'All Examples';
		target: self;
		selector: #openAllExamples;
		order: 10;
		help: 'Open All Examples'
]

{ #category : #'world menu' }
GtWorld class >> documenterClassCommentsMenuOn: aBuilder [
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
GtWorld class >> documenterFilesMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtdocumenterfiles)
		parent: #gtoolkit;
		label: 'GToolkit Documenter files';
		target: self;
		selector: #openAllDocumenterFiles;
		order: 20;
		help: 'Open GToolkit Documenter files';
		withSeparatorAfter 
]

{ #category : #'world menu' }
GtWorld class >> gtExamplesMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtallgtexamples)
		parent: #gtoolkit;
		label: 'All GToolkit Examples';
		target: self;
		selector: #openAllGToolkitExamples;
		order: 11;
		help: 'Open All GToolkit Examples'
]

{ #category : #'api - actions' }
GtWorld class >> openAllClassesDocumentedByDocumenter [
	GtInspector openOn: (Smalltalk allClassesAndTraits select: [ :eachClassOrTrait | 
		eachClassOrTrait comment includesSubstring: '${' ])
]

{ #category : #'api - actions' }
GtWorld class >> openAllDocumenterFiles [
	GtInspector openOn: GtIcebergUtility pillarDocuments
]

{ #category : #'api - actions' }
GtWorld class >> openAllExamples [
	GtInspector openOn: (GtExampleGroup withAll: Smalltalk gtExamplesContained)
]

{ #category : #'api - actions' }
GtWorld class >> openAllGToolkitExamples [
	GtInspector openOn: (GtExampleGroup withAll: (Smalltalk gtExamplesContained select: [:each | each method package name beginsWith: 'GToolkit']))
]

{ #category : #'api - actions' }
GtWorld class >> openTour [
	GtInspector openOnPlayBook: (Gt2Document forClass: BaselineOfGToolkit)
]

{ #category : #'world menu' }
GtWorld class >> playgroundMenuOn: aBuilder [
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
GtWorld class >> registerInspectorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #registerinspector)
		parent: #gtoolkit;
		label: 'Register GToolkit Inspector';
		target: GtInspectorToolRegistryAdaptor;
		selector: #register;
		enabledBlock: [ GtInspectorToolRegistryAdaptor isRegistered not ];
		order: 60;
		help: 'Register GToolkit Inspector'
]

{ #category : #'world menu' }
GtWorld class >> registerPlaygroundMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #registerplayground)
		parent: #gtoolkit;
		label: 'Register GToolkit Playground';
		target: GtPlaygroundToolRegistryAdaptor;
		selector: #register;
		enabledBlock: [ GtPlaygroundToolRegistryAdaptor isRegistered not ];
		order: 50;
		help: 'Register GToolkit Playground'
]

{ #category : #'world menu' }
GtWorld class >> rootMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtoolkit)
		label: 'GToolkit';
		icon: BrGlamorousIcons gt;
		order: 0.1
]

{ #category : #'world menu' }
GtWorld class >> tourMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtintroductionmenu)
		parent: #gtoolkit;
		label: 'Glamorous Toolkit Tour';
		target: self;
		selector: #openTour;
		order: 9;
		help: 'Open the Glamorous Toolkit Tour'
]

{ #category : #'world menu' }
GtWorld class >> unregisterInspectorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #unregisterinspector)
		parent: #gtoolkit;
		label: 'Unregister GToolkit Inspector';
		target: GtInspectorToolRegistryAdaptor;
		selector: #unregister;
		enabledBlock: [ GtInspectorToolRegistryAdaptor isRegistered ];
		order: 61;
		help: 'Unregister GToolkit Inspector'
]

{ #category : #'world menu' }
GtWorld class >> unregisterPlaygroundMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #unregisterplayground)
		parent: #gtoolkit;
		label: 'Unregister GToolkit Playground';
		target: GtPlaygroundToolRegistryAdaptor;
		selector: #unregister;
		enabledBlock: [ GtPlaygroundToolRegistryAdaptor isRegistered ];
		order: 51;
		help: 'Unregister GToolkit Playground'
]
