Trait {
	#name : #TGtPagerWindowOpener,
	#category : #'GToolkit-Pager-UI'
}

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> createOn: anObject [
	| aWrapper |
	aWrapper := self newWrapperOn: anObject.
	^ GtPager createOn: aWrapper.
]

{ #category : #'private - instance creation' }
TGtPagerWindowOpener classSide >> newEmbelisher [
	^ GtPagerPageEmbellisher new
]

{ #category : #'instance creation' }
TGtPagerWindowOpener classSide >> newOn: anObject [
	"create a tool element on a given object"
	^ self explicitRequirement
]

{ #category : #'private - instance creation' }
TGtPagerWindowOpener classSide >> newTitleFrom: anObject [
	^ anObject printString
]

{ #category : #'private - instance creation' }
TGtPagerWindowOpener classSide >> newWrapperOn: anObject [
	^ GtPagerPageWrapperStencil new
		stencil: [ self newOn: anObject ];
		model: anObject;
		embellisher: self newEmbelisher;
		asElement
]

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> openOn: anObject [
	| aTool |
	aTool := self newWrapperOn: anObject.
	^ GtPager 
		openOn: aTool 
		title: (self newTitleFrom: anObject)
]

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> openOn: anObject from: aSourceElement [
	| aTool |
	aTool :=  self newOn: anObject.
	^ GtPager 
		openOn: aTool 
		title: (self newTitleFrom: anObject)
		from: aSourceElement.
]
