baseline
baseline: spec
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Brick' with: [ spec
				repository: 'github://pharo-graphics/Brick/src';
				loads: #core ];
			baseline: 'GToolkitPhlow' with: [ spec repository: 'github://feenkcom/gtoolkit-phlow/src' ];
			package: 'GToolkit-Inspector' with: [spec requires: #(GToolkitPhlow Brick)]
	]
