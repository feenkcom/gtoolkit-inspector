Extension { #name : #MemoryLogger }

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtGroupedFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Grouped';
		items: [ (self recordings reverse groupedBy: [ :each | each class ]) associations sort: [ :a :b | a key name < b key name ] ];
		updateWhen: Announcement in: [ self announcer ];
		column: 'Class' text: [ :each | each key asString ];
		column: 'Instances' 
			text: [ :each | each value size asString  ]
			width: 80;
		send: [ :anAssoc | 
			| aLogger |
			aLogger := (self class withRecordings: anAssoc value).
			aLogger name: anAssoc key name, ' from ', self name.
			aLogger ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtInterestingAnnouncementsFor: aView [
	<gtView>
	interestingAnnouncements ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Interesting Announcements' translated;
		priority: 60;
		items: [ interestingAnnouncements ifNil: [ #() ] ifNotNil: #asArray ];
		column: '#' text: [ :_ :anIndex | anIndex ] width: 40;
		column: 'Name' translated text: [ :each | each yourself ];
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtRecordingsFor: aView [
	<gtView>
	| aCollectionSize |
	aCollectionSize := 0.
	
	^ aView columnedList
		title: 'Recordings' translated;
		priority: 50;
		items: [ | aCollection | 
			aCollection := self recordings reverse.
			aCollectionSize := aCollection size.
			aCollection ];
		updateWhen: Announcement in: [ self announcer ];
		column: 'Count' text: [ :_ :anIndex | aCollectionSize - anIndex + 1 ] width: 40;
		column: 'Timestamp' translated text: [ :each | each timestamp asString ];
		column: 'Process' translated text: [ :each | each processId asString ];
		column: 'Type' translated text: [ :each | each name ] weight: 2;
		column: 'Contents' translated 
			text: [ :each | String streamContents: [ :s | each printOneLineContentsOn: s ] ] weight: 2;
		actionUpdateButton
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtResetActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousIcons trash;
		tooltip: 'Reset Logger';
		priority: 3;
		action: [ :aButton | self reset ]
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtStartActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons play;
		tooltip: 'Start Logger';
		priority: 1;
		action: [ :aButton | self start ]
]

{ #category : #'*GToolkit-Inspector' }
MemoryLogger >> gtStopActionFor: anAction [
	<gtAction>
	^ anAction button
		icon: BrGlamorousVectorIcons cancel;
		tooltip: 'Stop Logger';
		priority: 2;
		action: [ :aButton | self stop ]
]

{ #category : #'*GToolkit-Inspector' }
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
