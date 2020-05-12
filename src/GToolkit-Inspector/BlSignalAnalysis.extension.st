Extension { #name : #BlSignalAnalysis }

{ #category : #'*GToolkit-Inspector' }
BlSignalAnalysis class >> gtInspectCircularMemory [
	"Open an inspector on an instance of the receiver analysing the default CircularMemoryLogger"

	^Gt2Inspector openOn: (self logger: CircularMemoryLogger instance)
]

{ #category : #'*GToolkit-Inspector' }
BlSignalAnalysis class >> gtInspectFile: aFileReference [

	^Gt2Inspector openOn: 
		(self logger: 
			(MemoryLogger fromStonFile: aFileReference))
]

{ #category : #'*GToolkit-Inspector' }
BlSignalAnalysis class >> gtInspectLogger: aSignalLogger [

	^ Gt2Inspector openOn: (self logger: aSignalLogger)
]

{ #category : #'*GToolkit-Inspector' }
BlSignalAnalysis class >> inspectFileContents: aFileReference [
	"Convenience method for debugging the logger itself - 
	inspect the contents of the supplied file, which is assumed to be a GZip encoded text file"

	Gt2Inspector openOn: (aFileReference asFileReference binaryReadStreamDo: [ :bstream |
		(ZnCharacterReadStream 
			on: (GZipReadStream on: bstream)
			encoding: 'utf8') upToEnd ])
]
