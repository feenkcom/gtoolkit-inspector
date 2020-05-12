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
	^ GtPagerWrapperElement new
		tool: (self newOn: anObject);
		model: anObject;
		embellisher: self newEmbelisher
]

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> openOn: anObject [
	^ self openOn: anObject title: (self newTitleFrom: anObject).
]

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> openOn: anObject from: aSourceElement [
	^ self 
		openOn: anObject 
		title: (self newTitleFrom: anObject) 
		from: aSourceElement
]

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> openOn: anObject title: aTitle [
	| aTool |
	aTool := self newWrapperOn: anObject.
	^ GtPager 
		openOn: aTool 
		title: aTitle
]

{ #category : #'window creation' }
TGtPagerWindowOpener classSide >> openOn: anObject title: aTitle from: aSourceElement [
	| aTool |
	aTool :=  self newWrapperOn: anObject.
	^ GtPager 
		openOn: aTool 
		title: aTitle
		from: aSourceElement.
]
