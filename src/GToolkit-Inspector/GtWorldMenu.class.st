Class {
	#name : #GtWorldMenu,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-World Menu'
}

{ #category : #'world menu' }
GtWorldMenu class >> documentationExplorerOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtintroductionmenu)
		parent: #gtoolkit;
		label: 'GToolkit Documentation Explorer';
		target: self;
		selector: #openGToolkitDocumentationExplorer;
		order: 10;
		help: 'Open the Glamorous Toolkit Documentation'
]

{ #category : #'world menu' }
GtWorldMenu class >> documenterClassCommentsMenuOn: aBuilder [
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
GtWorldMenu class >> documenterFilesMenuOn: aBuilder [
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
GtWorldMenu class >> examplesExplorerMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtexamplesexplorer)
		parent: #gtoolkit;
		label: 'GToolkit Examples Explorer';
		target: self;
		selector: #openGToolkitExamplesExplorer;
		order: 10;
		help: 'Open GToolkit Examples Explorer'
]

{ #category : #'api - actions' }
GtWorldMenu class >> openAllClassesDocumentedByDocumenter [
	GtInspector openOn: (Smalltalk allClassesAndTraits select: [ :eachClassOrTrait | 
		eachClassOrTrait comment includesSubstring: '${' ])
]

{ #category : #'api - actions' }
GtWorldMenu class >> openAllDocumenterFiles [
	GtInspector openOn: GtIcebergUtility pillarDocuments
]

{ #category : #'api - actions' }
GtWorldMenu class >> openGToolkitDocumentationExplorer [
	GtInspector openOn: GtRlGToolkitDocumentationExplorer buildForGToolkitProject
]

{ #category : #'api - actions' }
GtWorldMenu class >> openGToolkitExamplesExplorer [
	GtInspector openOn: GtRlGToolkitExamplesExplorer buildForGToolkitProject
]

{ #category : #'api - actions' }
GtWorldMenu class >> openGToolkitRepositoriesExplorer [
	GtInspector openOn: GtRlGToolkitRepositoriesExplorer buildForGToolkitProject
]

{ #category : #'api - actions' }
GtWorldMenu class >> openTour [
	GtInspector openOnPlayBook: (GtDocument forClass: BaselineOfGToolkit)
]

{ #category : #'world menu' }
GtWorldMenu class >> playgroundMenuOn: aBuilder [
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
GtWorldMenu class >> registerInspectorMenuOn: aBuilder [
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
GtWorldMenu class >> registerPlaygroundMenuOn: aBuilder [
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
GtWorldMenu class >> repositoriesExplorerMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtrepositoriesexplorer)
		parent: #gtoolkit;
		label: 'GToolkit Repositories Explorer';
		target: self;
		selector: #openGToolkitRepositoriesExplorer;
		order: 11;
		help: 'Open the GToolkit Repositories Explorer'
]

{ #category : #'world menu' }
GtWorldMenu class >> rootMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtoolkit)
		label: 'GToolkit';
		icon: BrGlamorousIcons gt;
		order: 0.1
]

{ #category : #'api - actions' }
GtWorldMenu class >> setGtDesktopLogo [
	| aLogoFile |
	aLogoFile := GtIcebergUtility documentAtPath: (Path * 'feenkcom' / 'gtoolkit-inspector' / 'doc' / 'gt.png').
	aLogoFile exists ifFalse: [ ^ self inform: (aLogoFile fullName asString, ' does not exist') ].
	PolymorphSystemSettings 
		showDesktopLogo: true;
		desktopLogoFileName: nil;
		desktopLogoFileName: aLogoFile fullName
]

{ #category : #'world menu' }
GtWorldMenu class >> setGtDesktopLogoMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #setGtDesktopLogo)
		parent: #gtoolkit;
		label: 'Set Gt Desktop Logo';
		target: self;
		selector: #setGtDesktopLogo;
		order: 100;
		help: 'Set GToolkit Desktop Logo'
]

{ #category : #'api - actions' }
GtWorldMenu class >> setPharoDesktopLogo [
	PolymorphSystemSettings 
		showDesktopLogo: true;
		desktopLogoFileName: nil;
		setDesktopLogoWith: PolymorphSystemSettings pharoLogo
]

{ #category : #'world menu' }
GtWorldMenu class >> setPharoDesktopLogoMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #setPharoDesktopLogo)
		parent: #gtoolkit;
		label: 'Set Pharo Desktop Logo';
		target: self;
		selector: #setPharoDesktopLogo;
		order: 101;
		help: 'Set Pharo Desktop Logo'
]

{ #category : #'world menu' }
GtWorldMenu class >> tourMenuOn: aBuilder [
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
GtWorldMenu class >> unregisterInspectorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #unregisterinspector)
		parent: #gtoolkit;
		label: 'Unregister GToolkit Inspector';
		target: GtInspectorToolRegistryAdaptor;
		selector: #unregister;
		enabledBlock: [ GtInspectorToolRegistryAdaptor isRegistered ];
		order: 61;
		help: 'Unregister GToolkit Inspector';
		withSeparatorAfter
]

{ #category : #'world menu' }
GtWorldMenu class >> unregisterPlaygroundMenuOn: aBuilder [
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

{ #category : #'world menu' }
GtWorldMenu class >> useBlocHostsDescriptionMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #useblochosts)
		parent: #gtoolkit;
		label: 'Experimental features:';
		target: self;
		selector: #yourself;
		enabled: false;
		order: 71;
		help: 'All Bloc windows must be closed before switching.'
]

{ #category : #'world menu' }
GtWorldMenu class >> useBlocHostsDescriptionTwoMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #useblochoststwo)
		parent: #gtoolkit;
		label: '  ... close all Bloc windows before switching';
		target: self;
		selector: #yourself;
		enabled: false;
		order: 71.5;
		help: 'All Bloc windows must be closed before switching.'
]

{ #category : #'api - actions' }
GtWorldMenu class >> useMorphicWindows [
	BlUniverse reset.
	Bloc preferableHostClass: BlMorphicWindowHost
]

{ #category : #'world menu' }
GtWorldMenu class >> useNativeMorphicMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #usemorphicwindows)
		parent: #gtoolkit;
		label: '  Use Morphic Windows';
		target: self;
		selector: #useMorphicWindows;
		enabled: [ Bloc preferableHostClass ~= BlMorphicWindowHost ];
		order: 73;
		help: 'All Bloc windows must be closed in advance.';
		withSeparatorAfter
]

{ #category : #'api - actions' }
GtWorldMenu class >> useNativeWindows [
	World closeAllWindowsDiscardingChanges.
	BlUniverse reset.
	Bloc preferableHostClass: BlOSWindowHost
]

{ #category : #'world menu' }
GtWorldMenu class >> useNativeWindowsMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #usenativewindows)
		parent: #gtoolkit;
		label: '  Use Native Windows';
		target: self;
		selector: #useNativeWindows;
		enabled: [ Bloc preferableHostClass ~= BlOSWindowHost ];
		order: 72;
		help: 'All Bloc windows must be closed in advance.'
]
