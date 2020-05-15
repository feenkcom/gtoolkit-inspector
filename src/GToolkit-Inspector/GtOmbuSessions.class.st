Class {
	#name : #GtOmbuSessions,
	#superclass : #Object,
	#instVars : [
		'directory'
	],
	#category : #'GToolkit-Inspector-Convenience and Utilities'
}

{ #category : #accessing }
GtOmbuSessions class >> default [
	"Answer an instance of the receiver on the default Ombu Sessions directory"

	| directory |

	directory := (FileLocator imageDirectory / 'pharo-local/ombu-sessions') resolve.
	directory isDirectory 
		ifTrue: [ ^ self new directory: directory ].
	self error: 'Can''t find default ombu-sessions directory'.
]

{ #category : #'instance creation' }
GtOmbuSessions class >> directory: aFileReference [
	"Open the receiver on the supplied directory"

	^ self new directory: aFileReference
]

{ #category : #accessing }
GtOmbuSessions >> directory [
	^ directory
]

{ #category : #accessing }
GtOmbuSessions >> directory: aFileReference [

	aFileReference isDirectory ifFalse: 
		[ self error: 'OmbuSession directory must be a directory' ].
	directory := aFileReference
]

{ #category : #ui }
GtOmbuSessions >> gtItemsFor: aView [
	<gtView>
	directory isDirectory
		ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Sessions' translated;
		priority: 10;
		items: [ | children |
			children := (directory directories sorted: [:a :b | a basename < b basename ]) , (directory files sorted: [:a :b | a basename < b basename ]).
			children := directory isRoot
				ifTrue: [ children ]
				ifFalse: [ children asOrderedCollection
						addFirst: directory parent;
						yourself ].
			children ];
		column: 'Icon' translated
			do: [ :column | 
			column
				item: [ :each | 
					each isDirectory
						ifTrue: [ BrGlamorousIcons folder ]
						ifFalse: [ BrGlamorousIcons file ] ];
				rowStencil: [ :eachIcon | eachIcon asElement margin: (BlInsets left: 5 right: 5) ];
				noResize ];
		column: 'Name' translated
			do: [ :column | 
			column
				item: [ :each | 
					(directory isChildOf: each)
						ifTrue: [ '..' ]
						ifFalse: [ each basename asString ] ];
				matchParent ];
		column: 'Size' translated
			do:
				[ :column | column item: [ :each | each humanReadableSize asString ] ];
		column: 'Creation' translated
			do: [ :column | 
			column
				item: [ :each | 
					String
						streamContents: [ :s | 
							each creationTime printYMDOn: s.
							s nextPut: Character space.
							each creationTime printHMSOn: s ] ] ];
		send: [ :file | GtEpicea new ombuFile: file ]
]
