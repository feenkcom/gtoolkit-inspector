Extension { #name : #ZnUrl }

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtActionWebBrowseFor: anAction [
    <gtAction>
    ^ anAction explicit stencil: [
        BrButton new
            aptitude: BrGlamorousButtonWithIconAptitude;
            action:  [ WebBrowser openOn: self ];
            icon: BrGlamorousIcons go asElement;
            label: 'Open in Web Browser' translated ]
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtCopyActionFor: anAction [
	<gtAction>

	^ anAction button 
		tooltip: 'Copy URL';
		icon: BrGlamorousVectorIcons clipboard;
		action: [ :aButton | Clipboard clipboardText: self printString ]
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtPreviewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Preview';
		priority: 10;
		stencil: [ | container |
			container := BlElement new
					layout: BlLinearLayout horizontal;
					padding: (BlInsets all: 5);
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ].
			self hasScheme ifTrue: [
				container addChild: (self 
					newLabel: self scheme
					withLegend: 'scheme'
					primary: true).
				container addChild: (self
					newLabel: '://'
					withLegend: nil
					primary: false) ].
			self hasUsername ifTrue: [
				container addChild: (self
					newLabel: self username
					withLegend: 'username'
					primary: true).
				self hasPassword ifTrue: [
					container addChild: (self
						newLabel: ':'
						withLegend: nil
						primary: false).
					container addChild: (self
						newLabel: self password
						withLegend: 'password'
						primary: true) ]. 
				container addChild: (self
					newLabel: '@'
					withLegend: nil
					primary: false) ].
			self hasHost ifTrue: [ 
				container addChild: (self
					newLabel: self host
					withLegend: 'host'
					primary: true) ].
			self hasPort ifTrue: [
				container addChild: (self
					newLabel: ':'
					withLegend: nil
					primary: false).
				container addChild: (self
					newLabel: self port
					withLegend: 'port'
					primary: true) ].
			self hasPath ifTrue: [
				container addChild: (self
					newLabel: self pathPrintString
					withLegend: (self isSlash ifTrue: [ nil ] ifFalse: [ 'path' ])
					primary: true) ].
			self hasQuery ifTrue: [
				container addChild: (self
					newLabel: '?'
					withLegend: nil
					primary: false).
				container addChild: (self
					newLabel: (String streamContents: [ :out | self printQueryOn: out ]) allButFirst
					withLegend: 'query'
					primary: true) ].
			self hasFragment ifTrue: [
				container addChild: (self
					newLabel: '#'
					withLegend: nil
					primary: false).
				container addChild: (self
					newLabel: self fragment
					withLegend: 'fragment'
					primary: true) ].
			container ]
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtQueryFor: aView [
	<gtView>
	query ifNil: [ ^ aView empty ].
	^ aView columnedList
		  title: 'Query';
		  priority: 30;
		  items: [ query associations ];
		  column: 'Property' text: #key;
		  column: 'Value' text: #value weight: 3;
		  send: #value
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtSegmentsFor: aView [
	<gtView>
	segments ifNil: [ ^ aView empty ].
	^ aView columnedList
		  title: 'Segments';
		  priority: 25;
		  items: [ segments ];
		  column: 'Index' text: [ :_ :index | index ];
		  column: 'Value' text: #yourself weight: 3 
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'URL';
		  priority: 20;
		  items: [ {
			"Note: we show the internal values, not the external encoded representation"
			{ 'URL' . self printString . self }.
			{ 'scheme'
				. self scheme ifNil: [ self schemeOrDefault asRopedText foreground: Color gray ]
				. self scheme }.
			{ 'host' . self host ifNil: [ '' ] . self host }.
			{ 'port' 
				. self port ifNil: [ (self portOrDefault ifNil: '') asRopedText foreground: Color gray ] 
				. self port }.
			{ 'username' . self username ifNil: [ '' ] . self username }.
			{ 'password' . self password ifNil: [ '' ] . self password}.
			{ 'path' . '/' , self path . self pathSegments }.
			{ 'query' 
				. self query 
					ifNil: [ '' ] 
					ifNotNil: [ String streamContents: [ :out | | first |
						out nextPut: $?.
						first := true.
						self queryDo: [ :key :value |
							first ifFalse: [ out nextPut: $& ].
							first := false.
							out nextPutAll: key.
							value ifNotNil: [ out nextPut: $=; nextPutAll: value ] ] ] ]
				. self query }.
			{ 'fragment'
				. self fragment ifNil: [ '' ] ifNotNil: [ '#' , self fragment ]
				. self fragment } } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtWebpageFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Webpage';
		stencil: [ GtWebViewElement new url: self asString ]
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> newLabel: label withLegend: legend primary: primary [
	| container largeLabel smallLabel center |
	container := BlElement new
			layout: BlLinearLayout vertical;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ].
	largeLabel := BrLabel new
			aptitude: (BrGlamorousLabelAptitude new
					perform: (primary ifTrue: #yourself ifFalse: #thin);
					foreground: (primary ifTrue: [ Color black ] ifFalse: [ Color gray ]);
					fontSize: 32);
			text: label.
	container addChild: largeLabel.
	legend
		ifNotNil: [ smallLabel := BrLabel new
					aptitude: (BrGlamorousLabelAptitude new thin
							foreground: Color gray;
							fontSize: 10);
					text: legend;
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ].
			center := BlElement new
					constraintsDo: [ :c | 
						c horizontal matchParent.
						c vertical matchParent ];
					layout: BlLinearLayout new alignCenter.
			center addChild: smallLabel.
			container addChild: center ].
	^ container
]
