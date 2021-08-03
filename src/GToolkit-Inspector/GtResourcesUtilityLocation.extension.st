Extension { #name : 'GtResourcesUtilityLocation' }

{ #category : '*GToolkit-Inspector' }
GtResourcesUtilityLocation >> gtLocationFor: aView [
	<gtView>
	^ ((self resourceAtPath: Path * '.') gtPathFor: aView)
		title: 'Location'
]

{ #category : '*GToolkit-Inspector' }
GtResourcesUtilityLocation >> gtPathExampleFor: aView [
	<gtView>
	^ ((self resourceAtPath: Path * 'subdirectory' / 'file.txt') gtPathFor: aView)
		title: 'Example'
]
