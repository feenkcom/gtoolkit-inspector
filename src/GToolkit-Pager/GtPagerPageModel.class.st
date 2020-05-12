Class {
	#name : #GtPagerPageModel,
	#superclass : #GtPagerPageProtoModel,
	#category : #'GToolkit-Pager-View Model'
}

{ #category : #accessing }
GtPagerPageModel >> contentElement [
	^ self embellisher contentElement
]

{ #category : #defaults }
GtPagerPageModel >> defaultEmbellisher [
	^ GtPagerPageEmbellisher new
]

{ #category : #notifying }
GtPagerPageModel >> notifyPageAdded: aPage in: aPager [
	aPage = self ifFalse: [ ^ self ].
	self widgetDo: [ :aWrapper | 
		aWrapper tool dispatchEvent:
			(GtPagerPageAddedEvent new
				pager: aPager;
				page: aPage) ]
]

{ #category : #notifying }
GtPagerPageModel >> notifyPageRemoved: aPage from: aPager [
	aPage = self ifFalse: [ ^ self ].
	self widgetDo: [ :aWrapper | 
		aWrapper tool dispatchEvent:
			(GtPagerPageRemovedEvent new
				pager: aPager;
				page: aPage) ]
]

{ #category : #configuration }
GtPagerPageModel >> pager: aPager [
	super pager: aPager.
	self embellisher pager: aPager.
	aPager
		when: BrPagerPageAddedEvent
			do: [ :anEvent | self notifyPageAdded: anEvent page in: aPager ];
		when: BrPagerPageRemovedEvent
			do: [ :anEvent | self notifyPageRemoved: anEvent page from: aPager ]
]

{ #category : #configuration }
GtPagerPageModel >> removePager: aPager [
	super removePager: aPager.
	self embellisher removePager: aPager.
]
