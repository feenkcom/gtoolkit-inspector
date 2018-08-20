*GToolkit-Inspector
gtRawFor: aView
	<gtView>
	^ aView explicit
		title: 'Raw';
		priority: 100;
		stencil: [ 
			| variableNodes list |
			variableNodes := OrderedCollection new: self class allSlots size.
			variableNodes add: (GTInspectorSelfNode hostObject: self).
			self gtInspectorVariableNodesIn: variableNodes.
			list := BrColumnedList new display: variableNodes.
			list addEventHandler: (GtInspectorListToSelectHandler new transformation: [ :aNode | aNode rawValue ]).
			list constraintsDo: [ :c | c padding: (BlInsets top: 10) ].

			list column
				title: 'Icon';
				stencil: [ :aNode :index |
					| icon |
					icon := ([ aNode rawValue gtInspectorIcon ifNil: [ aNode rawValue class systemIcon ] ]
							on: Error 
							do: [ :error | self iconNamed: #smallWarningIcon ]).
					icon asElement].
			list column
				title: 'Variable';
				stencil: [ :aNode :index | 
					| textElement text |
					text := aNode label asRopedText.								
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ] ].
			list column
				title: 'Value';
				stencil: [ :aNode :index |
					| text textElement |
					text := [ aNode rawValue gtDisplayString asRopedText ] 
						on: Error 
						do: [ aNode errorMessage asRopedText foreground: Color red ].
					textElement :=  (BrListLabelStencil matchParent: text) asElement.
					textElement constraintsDo: [ :c | c horizontal matchParent. c padding: (BlInsets left: 10) ].
			  ].
			
			list ]