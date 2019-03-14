Class {
	#name : #GtWorldMenu,
	#superclass : #Object,
	#category : #'GToolkit-Inspector-World Menu'
}

{ #category : #'api - profiling' }
GtWorldMenu class >> createDefaultMessageTally [
	^ MessageTally new
		reportOtherProcesses: false;
		maxClassNameSize: 1000;
		maxClassPlusSelectorSize: 1000;
		maxTabs: 100
]

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

{ #category : #'api - profiling' }
GtWorldMenu class >> profileAllProcessesUndefinitely [
	(self confirm: 'MessageTally on all processes will start now,
and stop when the cursor goes
to the top of the screen')
		ifTrue: [ BlUniverse defer: [
			| rootMessageTally |
			rootMessageTally := self createDefaultMessageTally.
			rootMessageTally
				reportOtherProcesses: true.
			rootMessageTally 
				spyAllEvery: MessageTally defaultPollPeriod 
				on: [ [ World activeHand position y > 0 ] 
					whileTrue: [ BlUniverse default pulseLoop firePulse ] ].
			GtInspector openOn: rootMessageTally ] ]
]

{ #category : #'world menu - profiling' }
GtWorldMenu class >> profileAllProcessesUndefinitelyMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtprofile)
		parent: #gtoolkit;
		label: 'Profile all processes';
		target: self;
		selector: #profileAllProcessesUndefinitely;
		order: 150;
		help: 'Profile all procesess until the user stops the profiling'
]

{ #category : #'api - profiling' }
GtWorldMenu class >> profileBlocUIProcessForFixedTime [
	| secString secs |
	secString := UIManager default request: 'Profile for how many seconds?' initialAnswer: '4'.
	secString ifNil: [secString := String new].
	secs := secString asNumber asInteger.
	(secs isNil
			or: [secs isZero])
		ifTrue: [^ self].

	[ | rootMessageTally |
		rootMessageTally := self createDefaultMessageTally.
		rootMessageTally 
			spyEvery: MessageTally defaultPollPeriod
			onProcess: BlUniverse default pulseLoop loopProcess
			forMilliseconds: secs * 1000.
		GtInspector openOn: (GtBlocUIProcessTally new
			initializeForRootTally: rootMessageTally). 
			
		"Profiling a single process leave the Timer variable initialized, which prevents any other profiling to take place.
		So once the profilinf is dine clear the profiling process."
		MessageTally terminateTimerProcess. 
	] forkAt: BlUniverse default pulseLoop loopProcess priority + 1.
]

{ #category : #'world menu - profiling' }
GtWorldMenu class >> profileBlocUIProcessForFixedTimeMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtprofile)
		parent: #gtoolkit;
		label: 'Profile Bloc UI process for fixed time';
		target: self;
		selector: #profileBlocUIProcessForFixedTime;
		order: 160;
		help: 'Profile the Bloc UI process for a given time'
]

{ #category : #'api - profiling' }
GtWorldMenu class >> profileBlocUIUndefinitely [
	(self confirm: 'MessageTally the Bloc UI until the
mouse pointer goes to the top of the screen')
		ifTrue: [
			BlUniverse defer: [ 
				| rootMessageTally |
				rootMessageTally := self createDefaultMessageTally.
				rootMessageTally
					reportOtherProcesses: true.
				rootMessageTally 
					spyEvery: MessageTally defaultPollPeriod 
					on: [ [World activeHand position y > 10]
						whileTrue: [BlUniverse default pulseLoop firePulse ] ].
				GtInspector openOn: rootMessageTally ] ]
]

{ #category : #'world menu - profiling' }
GtWorldMenu class >> profileBlocUIUndefinitelyMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtprofile)
		parent: #gtoolkit;
		label: 'Profile the Bloc UI';
		target: self;
		selector: #profileBlocUIUndefinitely;
		order: 160;
		help: 'Profile the Bloc UI until the user stops the profiling'
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
		help: 'Set Pharo Desktop Logo';
		withSeparatorAfter
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
