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
ZnUrl >> gtQueryFor: aView [
	<gtView>
	query ifNil: [ ^ aView empty ].
	^ aView columnedList
		  title: 'Query';
		  priority: 3;
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
		  priority: 2;
		  items: [ segments ];
		  column: 'Index' text: [ :_ :index | index ];
		  column: 'Value' text: #yourself weight: 3 
]

{ #category : #'*GToolkit-Inspector' }
ZnUrl >> gtUrlFor: aView [
	<gtView>
	^ aView columnedList
		  title: 'URL';
		  priority: 1;
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
							out nextPutAll: key; nextPut: $=; nextPutAll: value ] ] ]
				. self query }.
			{ 'fragment'
				. self fragment ifNil: [ '' ] ifNotNil: [ '#' , self fragment ]
				. self fragment } } ];
		  column: 'Key' text: #first;
		  column: 'Value' text: #second weight: 5;
		  send: #last
]
