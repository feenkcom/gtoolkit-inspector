baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'GToolkitPhlow' with: [ spec repository: 'github://feenkcom/gtoolkit-phlow/src' ];
			package: 'GToolkit-Inspector' with: [spec requires: #(GToolkitPhlow)]
	]
