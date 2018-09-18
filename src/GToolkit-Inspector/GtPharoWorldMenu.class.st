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
		help: 'Open GToolkit Documenter files';
		withSeparatorAfter 
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

{ #category : #'api - actions' }
GtPharoWorldMenu class >> openTour [
	GtInspector openOnPlayBook: (GtDocumenter editorForText: BaselineOfGToolkit comment)
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
GtPharoWorldMenu class >> registerInspectorMenuOn: aBuilder [
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
GtPharoWorldMenu class >> registerPlaygroundMenuOn: aBuilder [
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
GtPharoWorldMenu class >> rootMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtoolkit)
		label: 'GToolkit';
		order: 0.1
]

{ #category : #'world menu' }
GtPharoWorldMenu class >> tourMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtintroductionmenu)
		parent: #gtoolkit;
		label: 'GToolkit Tour';
		target: self;
		selector: #openTour;
		order: 9;
		help: 'Open the Glamorous Toolkit Tour'
]

{ #category : #'world menu' }
GtPharoWorldMenu class >> unregisterInspectorMenuOn: aBuilder [
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
GtPharoWorldMenu class >> unregisterPlaygroundMenuOn: aBuilder [
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
