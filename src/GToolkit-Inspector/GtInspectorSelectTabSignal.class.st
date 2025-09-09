Class {
	#name : #GtInspectorSelectTabSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'tabGroup',
		'selector',
		'selectedTabModel',
		'requestedTabModel'
	],
	#category : #'GToolkit-Inspector-Tab Selector'
}

{ #category : #testing }
GtInspectorSelectTabSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #'gt - extensions' }
GtInspectorSelectTabSignal >> gtOverview [
	^ {GtPhlowOverviewItem new
			name: 'Selector';
			value: self selector.
		GtPhlowOverviewItem new
			name: 'Requested tab model';
			value: self requestedTabModel.
		GtPhlowOverviewItem new
			name: 'Selected tab model';
			value: self selectedTabModel.
		GtPhlowOverviewItem new
			name: 'Tab group';
			value: self tabGroup}
]

{ #category : #'gt - extensions' }
GtInspectorSelectTabSignal >> gtOverviewFor: aView [
	<gtView>
	selector ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Overview';
		priority: 0;
		items: [ self gtOverview ];
		column: 'Name' text: #name weight: 0.3;
		column: 'Value' text: #description;
		send: #value
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> requestedTabModel [
	^ requestedTabModel
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> requestedTabModel: anObject [
	requestedTabModel := anObject
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> selectedTabModel [
	^ selectedTabModel
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> selectedTabModel: anObject [
	selectedTabModel := anObject
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> selector [
	^ selector
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> tabGroup [
	^ tabGroup
]

{ #category : #accessing }
GtInspectorSelectTabSignal >> tabGroup: anObject [
	tabGroup := anObject
]
