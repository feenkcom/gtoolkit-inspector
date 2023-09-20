Class {
	#name : #GtInspectorWithViews,
	#superclass : #Object,
	#category : 'GToolkit-Inspector-Examples'
}

{ #category : #accessing }
GtInspectorWithViews >> gtExplicitViewWithActionsFor: aView [
	<gtView>
	^ aView explicit 
		title: 'Explicit with actions';
		stencil: [ BlElement new background: Color blue];
		actionButtonLabel: 'Random color' action: [: aButton | 
			(aButton phlow viewContent) 
				allChildrenBreadthFirstDetect: [:each | 
					each phlow entity isKindOf: GtPhlowExplicitView ] 
				ifFound: [:each | each background: Color random] ]
]
