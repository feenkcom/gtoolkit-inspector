*GToolkit-Inspector
gtHeadersFor: aView
	<gtView>
	^ (self headers gtHeadersFor: aView)
			priority: 30;
			title: (self headers headers size asString, ' headers')
			