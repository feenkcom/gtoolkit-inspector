Extension { #name : #ZnCookieJar }

{ #category : #'*GToolkit-Inspector' }
ZnCookieJar >> gtCookiesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'CookieJar';
		priority: 30;
		items: [ self cookies asOrderedCollection ];
		column: 'domain' text: #domain;
		column: 'path' text: #path;
		column: 'name' text: #name;
		column: 'value' text: #value weight: 2
]
