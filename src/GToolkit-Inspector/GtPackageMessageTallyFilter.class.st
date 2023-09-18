Class {
	#name : #GtPackageMessageTallyFilter,
	#superclass : #GtMessageTallyFilter,
	#instVars : [
		'packages'
	],
	#category : #'GToolkit-Inspector-Message Tallies'
}

{ #category : #examples }
GtPackageMessageTallyFilter class >> examplePackageFilter [
	<gtExample>
	
	| originalTally newTally package |
	package := thisContext method package.
	originalTally := self messageTallyForInjectInto.
	self assert: [ self hasTallies: originalTally outsidePackage: package ].
	newTally := originalTally applyFilter: (self forPackages: {package}).
	self assert: [ (self hasTallies: newTally outsidePackage: package) not ].
	self assert: newTally tally equals: originalTally tally.
	^ newTally
]

{ #category : #'instance creation' }
GtPackageMessageTallyFilter class >> forPackages: aCollection [
	^ (self new)
		packages: aCollection;
		yourself
]

{ #category : #examples }
GtPackageMessageTallyFilter class >> hasTallies: tally outsidePackage: aPackage [
	^ tally receivers
		anySatisfy: [ :each | each method method package ~~ aPackage or: [ self hasTallies: each outsidePackage: aPackage ] ]
]

{ #category : #filtering }
GtPackageMessageTallyFilter >> createOrReuseTallyFor: childTally in: newTally [
	| newChild |
	newTally receivers
		do:
			[ :each | 
			each method == childTally method
				ifTrue:
					[ each bumpBy: childTally tally.
					^ each ] ].
	newChild := childTally filterCopy.
	newTally addReceiver: newChild.
	^ newChild
]

{ #category : #filtering }
GtPackageMessageTallyFilter >> filter: aMessageTally [
	| newTally |
	newTally := aMessageTally filterCopy.
	self filterChildrenOf: aMessageTally into: newTally.
	^ newTally
]

{ #category : #filtering }
GtPackageMessageTallyFilter >> filterChildrenOf: aMessageTally into: newTally [
	aMessageTally receivers
		do:
			[ :each | 
			| childTally |
			childTally := (self shouldIncludeTally: each)
				ifTrue: [ self createOrReuseTallyFor: each in: newTally ]
				ifFalse: [ newTally ].
			self filterChildrenOf: each into: childTally ]
]

{ #category : #accessing }
GtPackageMessageTallyFilter >> packages [
	^ packages
]

{ #category : #accessing }
GtPackageMessageTallyFilter >> packages: aCollection [
	packages := IdentitySet withAll: aCollection
]

{ #category : #testing }
GtPackageMessageTallyFilter >> shouldIncludeTally: aMessageTally [
	^ packages includes: aMessageTally package
]
