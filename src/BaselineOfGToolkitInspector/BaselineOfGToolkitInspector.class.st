"
1. Inspector
The inspector offers several operators that can be combined in many ways to adapt the inspection to the context:
- Show multiple views for each object.
- Show connected objects.
- Treat code evaluation like navigation.
- Extend the object while inspecting.
1. # Show multiple views for each object

Every object is different and should be allowed to look different, too. Here is an inspector example opened on an instance of {{gtClass:CompiledMethod}}.  Take a moment to play with the different tabs.

{{gtExample:CompiledMethod class>>#gtExampleSimple|previewExpanded|noCode}}

Classic inspectors are typically defined as tools that show the interior of an object. In contrast, we define the inspector as a tool to understand an object. Let's go back to our example. A {{gtClass:CompiledMethod}} represents a method, and as we recognize a method by its source code the first view shows exactly that. However, there are other perspectives that are relevant from which to look at such an object, too. For example, when wanting to understand how the internal bytecodes look like we can simply switch to the corresponding view.

This behavior is achieved by asking the object to specify what views make sense for it. This is similar to how objects can print themselves, only we can now define multiple representations that offer interactions. For example, the extension that shows the bytecodes can be seen in {{gtMethod:CompiledCode>>#gtBytecodeFor:}}.

The extension is annotated with the `<gtView>` pragma and is defined as a Phlow view. More details about how to define these views can be found in {{gtClass:BaselineOfGToolkitPhlow}}.
1. # Show connected objects

Investigating software systems often requires us to drill through objects to find in the search for an answer. Once we do find the answer, we also want to be able to go back throughout the tunnel we went through to link the cause with the effect. To this end, we want to keep track of the navigation. This is achieved through the pager interface that is a variation of Miller columns interface.

Take a look at the inspector showing the working directory.

{{gtExample:FileReference class>>#gtExampleWorkingDirectory|noCode=}}

As the instance of {{gtClass:FileReference}} represents a directory, the inspector shows the items of the directory. Clicking on an item selects the corresponding object and prepares it to be shown in a page to the right of the current one. If there does not exist a page to the right before clicking, there will only appear a triangle. Clicking on that triangle spawns the page. Once a page exists to the right, clicking on any other object shows the object. Alternatively, if a page does not yet exist, it can be spawned by double clicking on the list item.

Take a moment to explore your file system. Notice how the exploration does not feel much different from a file navigator. Yet, it happens right in the inspector, the most basic tool we have at our disposal.

This design keeps track of the last navigation path and allows one to go back through the navigation steps to trace the reasoning.
1. # Treat code and navigation the same

Clicking on an item in the list spawns a new object to the right. Another way to obtain an object is via code. In the inspector, the two interactions are treated the same. This is achieved through the Playground. This simple combination enables an endless set of workflows, such as:
- brdging navigation through code,
- code querying, or
- quick prototyping.

Learn more about the Playground at {{gtClass:BaselineOfGToolkitPlayground}}.
1. # Extend the object while inspecting

Each class can define object extensions that are meaningful for inspecting instances of that class. One of the extensions that exists for all objects is the Meta one. This one shows a Coder for editing the class of the current object.

For example, take as look at a {{gtClass:Color}}.

{{gtExample:Color class>>#gtExampleColorRed|noCode|previewHeight=400}}

Now, choose the Meta view, select the {{gtMethod:Color>>#gtPreviewFor:}}, and change the title to something like `'Color'`. Note how accepting the changed code triggers the inspector to update. Similarly, you can add new extensions from whithin the inspector and this will add new views to the current inspector.

This ability stays at the core of moldable development: Software is highly contextual, and for tools to be effective, they have to take that context into account. Thus, if a tool does not yet exist, it is imperative that developers build one. With the ability of extending the inspector during the inspection process, we can support moldable development without imposing a context switch.

 


"
Class {
	#name : #BaselineOfGToolkitInspector,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitInspector
}

{ #category : #baseline }
BaselineOfGToolkitInspector >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'GToolkitPager' with: [
				spec repository: 'github://feenkcom/gtoolkit-pager:v0.8.602/src' ].
		spec
			baseline: 'GToolkitSpotter' with: [
				spec repository: 'github://feenkcom/gtoolkit-spotter:v0.8.573/src' ].
		spec
			baseline: 'GToolkitCompleter' with: [
				spec repository: 'github://feenkcom/gtoolkit-completer:v0.8.594/src' ].
		spec
			baseline: 'GToolkit4Pharo' with: [
				spec repository: 'github://feenkcom/gt4pharo:v0.6.417/src' ].
		spec
			baseline: 'GToolkitExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.8.46/src' ].

		spec package: 'GToolkit-Inspector' with: [
			spec requires: #('GToolkitPager' 'GToolkitSpotter' 'GToolkitCompleter' 'GToolkit4Pharo' 'GToolkitExamples') ].
	]
]
