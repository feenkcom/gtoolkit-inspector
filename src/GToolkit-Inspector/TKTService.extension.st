Extension { #name : #TKTService }

{ #category : #'*GToolkit-Inspector' }
TKTService >> gtActionStartFor: anAction [
	<gtAction>
	self isRunning ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 4;
		label: 'Start';
		icon: BrGlamorousIcons play;
		action: [ self launch ]
]

{ #category : #'*GToolkit-Inspector' }
TKTService >> gtActionStopFor: anAction [
	<gtAction>
	self isRunning ifFalse: [ ^ anAction noAction ].
	^ anAction button
		priority: 5;
		label: 'Stop';
		icon: BrGlamorousIcons cancel;
		action: [ self stop ]
]
