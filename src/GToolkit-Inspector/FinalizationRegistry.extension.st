Extension { #name : #FinalizationRegistry }

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry class >> gtInspectDefaultInstanceFor: anAction [
	<gtClassAction>
	<gtAction>
	
		^ anAction button
		label: 'Default';
		tooltip: 'Inspect the default instance';
		priority: 10;
		icon: BrGlamorousVectorIcons inspect;
		action: [ :aButton | 
			aButton phlow spawnObject: self default ]
]

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry class >> gtViewDefaultEphemeronsByFinalizerTypeFor: anAction [
	<gtClassView>
	<gtView>
	
		^ anAction forward 
				title: 'Default By Finalizer Type';
				priority: 32.1;
				object: [ self default ];
				view: #gtViewEphemeronsByFinalizerTypeFor: ;
				actionButtonIcon: BrGlamorousVectorIcons inspect 
					label: 'Default' 
					tooltip: 'Inspect the default instance' 
					action: [ :aButton |
						aButton phlow spawnObject: self default]
]

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry class >> gtViewDefaultEphemeronsByKeyClassFor: anAction [
	<gtClassView>
	<gtView>
	
		^ anAction forward 
				title: 'Default By Class';
				priority: 32.1;
				object: [ self default ];
				view: #gtViewEphemeronsByKeyClassFor:;
				actionButtonIcon: BrGlamorousVectorIcons inspect 
					label: 'Default' 
					tooltip: 'Inspect the default instance' 
					action: [ :aButton |
						aButton phlow spawnObject: self default]
]

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry >> gtViewEphemeronsByFinalizerTypeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'By Finalyser Type';
		priority: 109;
		items: [ [ ((self gtCurrentEphemerons
				groupedBy: [ :each | each value class ])
				associations sorted: [ :assoc | assoc value size ] descending)
				asOrderedDictionary ] value associations ];
		column: 'Ephemeron Type' text: [ :assoc | assoc key ];
		column: 'Ephemeron Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry >> gtViewEphemeronsByKeyClassFor: aView [
	<gtView>
	^ aView columnedList
		title: 'By Class';
		priority: 105;
		items: [ [ ((self gtCurrentEphemerons groupedBy: [ :each | each key class ])
				associations sorted: [ :assoc | assoc value size ] descending)
				asOrderedDictionary ] value associations ];
		column: 'Class' text: [ :assoc | assoc key ];
		column: 'Ephemeron Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry >> gtViewEphemeronsByKeyPackageFor: aView [
	<gtView>
	^ aView columnedList
		title: 'By Package';
		priority: 106;
		items: [ [ ((self gtCurrentEphemerons
				groupedBy: [ :each | each key class package ])
				associations sorted: [ :assoc | assoc value size ] descending)
				asOrderedDictionary ] value associations ];
		column: 'Package' text: [ :assoc | assoc key ];
		column: 'Ephemeron Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]

{ #category : #'*GToolkit-Inspector' }
FinalizationRegistry >> gtViewEphemeronsByTargetObjectFor: aView [
	<gtView>
	^ aView columnedList
		title: 'By Instance';
		priority: 107;
		items: [ [ ((self gtCurrentEphemerons
					groupedBy: [ :each | each key ])
					associations sorted: [ :assoc | assoc value size ] descending)
					asOrderedDictionary ] value associations ];
		column: 'Package' text: [ :assoc | assoc key ];
		column: 'Ephemeron Count' text: [ :assoc | assoc value size ];
		send: [ :assoc | assoc value ]
]
