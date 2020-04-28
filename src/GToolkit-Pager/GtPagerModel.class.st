Class {
	#name : #GtPagerModel,
	#superclass : #BrPagerModel,
	#category : #'GToolkit-Pager-View Model'
}

{ #category : #hooks }
GtPagerModel >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	self pages do: [ :eachPageModel | 
		eachPageModel pager: anElement ].
]

{ #category : #hooks }
GtPagerModel >> onPageAdded: aPageModel [
	super onPageAdded: aPageModel.
	self widgetDo: [ :aWidget |
		aPageModel pager: aWidget ].
]

{ #category : #hooks }
GtPagerModel >> onPageRemoved: aPageModel [
	super onPageRemoved: aPageModel.
	self widgetDo: [ :aWidget |
		aPageModel removePager: aWidget ].
]
