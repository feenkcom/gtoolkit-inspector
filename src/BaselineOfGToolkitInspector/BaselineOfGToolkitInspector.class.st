Class {
	#name : #BaselineOfGToolkitInspector,
	#superclass : #BaselineOf,
	#category : 'BaselineOfGToolkitInspector'
}

{ #category : #baseline }
BaselineOfGToolkitInspector >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec	repository: 'github://pharo-graphics/Brick/src' ];
		   baseline: 'Beacon' with: [ spec repository: 'github://pharo-project/pharo-beacon/repository' ];
			baseline: 'GToolkitPlayground' with: [ spec repository: 'github://feenkcom/gtoolkit-playground/src' ];
			package: 'GToolkit-Inspector' with: [spec requires: #(GToolkitPlayground Brick Beacon )]
	]

]
