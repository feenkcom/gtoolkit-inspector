Class {
	#name : #GtWorldMenu,
	#superclass : #Object,
	#category : 'GToolkit-Inspector-World Menu'
}

{ #category : #'world menu' }
GtWorldMenu class >> coderMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtcoder)
		parent: #gtoolkit;
		label: 'gt Coder';
		target: self;
		selector: #openCoder;
		order: 6;
		help: 'Open GToolkit Coer'";
		iconName: #workspace"
]

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
		label: 'gt Documentation Explorer';
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
		label: 'gt Documenter class comments';
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
		label: 'gt Documenter files';
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
		label: 'gt Examples Explorer';
		target: self;
		selector: #openGToolkitExamplesExplorer;
		order: 10;
		help: 'Open GToolkit Examples Explorer'
]

{ #category : #'world menu' }
GtWorldMenu class >> gtWorldMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtworld)
		parent: #gtoolkit;
		label: 'gt World';
		target: self;
		selector: #openWorld;
		order: 1;
		help: 'Open the GToolkit World'
]

{ #category : #'api - actions' }
GtWorldMenu class >> openAllClassesDocumentedByDocumenter [
	GtInspector openOn: (Smalltalk allClassesAndTraits select: [ :eachClassOrTrait | 
		eachClassOrTrait comment includesSubstring: '${' ])
]

{ #category : #'api - actions' }
GtWorldMenu class >> openAllDocumenterFiles [
	GtInspector openOn: GtResourcesUtility default pillarDocuments
]

{ #category : #'api - actions' }
GtWorldMenu class >> openCoder [
	GtCoder new openInPager maximized
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
	GtPager 
		openWrappedOn: (GtDocumenter forClass: BaselineOfGToolkit) 
		title: 'GToolkit Tour'
]

{ #category : #'api - actions' }
GtWorldMenu class >> openWorld [
	GtWorld open
]

{ #category : #'world menu' }
GtWorldMenu class >> playgroundMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #gtplayground)
		parent: #gtoolkit;
		label: 'gt Playground';
		target: GtPlaygroundToolRegistryAdaptor;
		selector: #open;
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
	| secString secs aMorphicUIProcess |
	secString := UIManager default request: 'Profile for how many seconds?' initialAnswer: '4'.
	secString ifNil: [secString := String new].
	secs := secString asNumber asInteger.
	(secs isNil
			or: [secs isZero])
		ifTrue: [^ self].
	
	aMorphicUIProcess := nil.
	BlParallelUniverse morphic uiProcessDo: [ :aProcess | aMorphicUIProcess := aProcess ].
	aMorphicUIProcess
		ifNil: [ ^ self ].

	[ | rootMessageTally |
		rootMessageTally := self createDefaultMessageTally.
		rootMessageTally 
			spyEvery: MessageTally defaultPollPeriod
			onProcess: aMorphicUIProcess
			forMilliseconds: secs * 1000.
		GtBlocUIProcessTally inspectTally: rootMessageTally.
			
		"Profiling a single process leave the Timer variable initialized, which prevents any other profiling to take place.
		So once the profilinf is dine clear the profiling process."
		MessageTally terminateTimerProcess. 
	] forkAt: aMorphicUIProcess priority + 1.
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
GtWorldMenu class >> registerNewInspectorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #registernewinspector)
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
		label: 'gt Repositories Explorer';
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
	aLogoFile := GtResourcesUtility resourceAtPath: (Path * 'feenkcom' / 'gtoolkit-inspector' / 'doc' / 'gt.png').
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
		label: 'gt Tour';
		target: self;
		selector: #openTour;
		order: 9;
		help: 'Open the Glamorous Toolkit Tour'
]

{ #category : #'world menu' }
GtWorldMenu class >> unregisterNewInspectorMenuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #unregisternewinspector)
		parent: #gtoolkit;
		label: 'Unregister GToolkit Inspector';
		target: GtInspectorToolRegistryAdaptor;
		selector: #unregister;
		enabledBlock: [ GtInspectorToolRegistryAdaptor isRegistered ];
		order: 62;
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
