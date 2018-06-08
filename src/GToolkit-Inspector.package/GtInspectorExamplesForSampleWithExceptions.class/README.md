!Dealing with errors in custom views

Inspecting the following snippet produces an inspector in which two views have an exception:
- one has an excpetion during the creation of the view, and 
- one has an exception in the stencil that creates the actual element to be displayed.

In both cases, the inspector offers a clean way to investigate the error: 

[[[
GtInspectorSampleWithExceptionsInExtensions new
]]]
