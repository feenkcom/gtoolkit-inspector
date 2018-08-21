world menu
examplesMenuOn: aBuilder
	<worldMenu>
	(aBuilder item: #gtallexamples)
		parent: #gtoolkit;
		label: 'GToolkit All Examples';
		target: self;
		selector: #openAllExamples;
		order: 10;
		help: 'Open GToolkit Examples'