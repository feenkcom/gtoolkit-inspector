Extension { #name : #BlTaskSignalAnalysis }

{ #category : #'*GToolkit-Inspector' }
BlTaskSignalAnalysis class >> gtInspectCircularMemory [
	"Open an inspector on an instance of the receiver analysing the default CircularMemoryLogger"

	^GtInspector openOn: (self logger: CircularMemoryLogger instance)
]

{ #category : #'*GToolkit-Inspector' }
BlTaskSignalAnalysis class >> gtInspectFile: aFileReference [

	^GtInspector openOn: 
		(self logger: 
			(MemoryLogger fromStonFile: aFileReference))
]

{ #category : #'*GToolkit-Inspector' }
BlTaskSignalAnalysis class >> gtInspectLogger: aSignalLogger [

	^ GtInspector openOn: (self logger: aSignalLogger)
]

{ #category : #'*GToolkit-Inspector' }
BlTaskSignalAnalysis class >> inspectFileContents: aFileReference [
	"Convenience method for debugging the logger itself - 
	inspect the contents of the supplied file, which is assumed to be a GZip encoded text file"

	GtInspector openOn: (aFileReference asFileReference binaryReadStreamDo: [ :bstream |
		(ZnCharacterReadStream 
			on: (GZipReadStream on: bstream)
			encoding: 'utf8') upToEnd ])
]
