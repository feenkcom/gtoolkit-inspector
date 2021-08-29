Extension { #name : 'MemoryLogger' }

{ #category : '*GToolkit-Inspector' }
MemoryLogger >> gtGroupedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Grouped';
		items: [ (self recordings reverse groupedBy: [ :each | each class ]) associations ];
		updateWhen: Announcement in: [ self announcer ];
		column: 'Class' item: [ :each | each key asString ];
		column: 'Instances' item: [ :each | each value size asString  ];
		send: #value
]

{ #category : '*GToolkit-Inspector' }
MemoryLogger >> gtRecordingsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Recordings' translated;
		priority: 50;
		items: [ self recordings reverse ];
		updateWhen: Announcement in: [ self announcer ];
		column: 'Timestamp' translated item: [ :each | each timestamp asString ];
		column: 'Process' translated item: [ :each | each processId asString ];
		column: 'Type' translated item: [ :each | each name ];
		column: 'Contents' translated 
			item: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ]
]

{ #category : '*GToolkit-Inspector' }
MemoryLogger >> gtResetActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousIcons trash;
		tooltip: 'Reset Logger';
		priority: 3;
		action: [ :aButton | self reset ]
]

{ #category : '*GToolkit-Inspector' }
MemoryLogger >> gtStartActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start Logger';
		priority: 1;
		action: [ :aButton | self start ]
]

{ #category : '*GToolkit-Inspector' }
MemoryLogger >> gtStopActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons cancel;
		tooltip: 'Stop Logger';
		priority: 2;
		action: [ :aButton | self stop ]
]

{ #category : '*GToolkit-Inspector' }
MemoryLogger class >> saveBlocGlobalLogger [
	"Collect detailed events for 10 seconds and then save the file"

	| semaphore |

	semaphore := Semaphore new.
	[ BlSpaceRenderSignal dontIgnore.
	BlTaskExecutionSignal clearIgnored.
	10 seconds wait.
	BlSpaceRenderSignal ignore.
	BlTaskExecutionSignal ignoreRepeatedTasks.
	semaphore signal ]
		forkAt: Processor userSchedulingPriority + 5 named: 'Bloc Global Logger'.
	semaphore wait.
	self instance saveStonFile: 'bloclog.stgz' asFileReference
]
