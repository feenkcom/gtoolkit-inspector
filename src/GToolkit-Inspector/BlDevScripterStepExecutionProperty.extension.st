Extension { #name : #BlDevScripterStepExecutionProperty }

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStepExecutionProperty >> gtDetails [
	^ OrderedDictionary new 
		at: 'Total duration' put: self totalDuration;
		at: 'Play duration' put: self playDuration;
		at: 'Pulse and sleep duration' put: self pulseDuration;
		at: 'Pulse only duration' put: self pulseWithoutSleepDuration;
		at: 'Total sleep duration' put: self sumUsedDelays;
		at: 'Last sleep duration' put: self lastUsedDelay;
		at: 'Number of pulses' put: self numberOfPulses;
		at: 'Number of sleeps' put: self numberOfUsedDelays;
		yourself
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStepExecutionProperty >> gtDetailsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Details';
		priority: 10;
		items: [ self gtDetails associations ];
		column: 'Name' text: #key;
		column: 'Value'
			text: [ :anAssoc | 
				| aValue |
				aValue := anAssoc value.
				(aValue isKindOf: Duration)
					ifTrue: [ | aTotal aPercentage |
						aTotal := self totalDuration.
						aTotal isZero ifFalse: [ aPercentage := aValue / aTotal ].
						aValue := aValue humanReadablePrintString.

						aPercentage
							ifNotNil: [ aValue := aValue , ' ('
										, (aPercentage asFloat * 100 printShowingDecimalPlaces: 2) , '%)' ] ].
				aValue ]
]

{ #category : #'*GToolkit-Inspector' }
BlDevScripterStepExecutionProperty >> gtUsedDelaysFor: aView [
	<gtView>
	usedDelays ifNil: [ ^ aView empty ].

	^ aView columnedTree
		title: 'Used delays';
		priority: 30;
		items: [ usedDelays ifNil: [ #() ] ];
		column: 'Index' text: [ :_ :anIndex | anIndex ] width: 70;
		column: 'Duration' text: #yourself;
		column: 'Duration' text: #humanReadablePrintString
]
