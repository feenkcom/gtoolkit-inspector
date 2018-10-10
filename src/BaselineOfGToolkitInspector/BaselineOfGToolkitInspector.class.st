"
!Inspector

The inspector offers several operators that can be combined in many ways to adapt the inspection to the context:
- Show multiple views for each object.
- Show connected objects.
- Treat code evaluation like navigation.
- Extend the object while inspecting.

!!Show multiple views for each object

Every object is different and should be allowed to look different, too. Here is an inspector example.

${example:CompiledMethod class>>#gtExampleSimple|expandedPreview=}$

!!Show connected objects

Investigating software systems often requires us to drill through objects to find the answer. Once we do find the answer, we also want to be able to go back throughout the tunnel we went through to link the cause with the effect. This 

${example:FileReference class>>#gtExampleWorkingDirectory|expandedPreview=}$


"
Class {
	#name : #BaselineOfGToolkitInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitInspector
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
