Extension { #name : #BlMorphicWindow }

{ #category : #'*GToolkit-Inspector' }
BlMorphicWindow >> gtActionExportAsPNGFor: anAction [
	<gtAction>
	^ anAction button
			icon: BrGlamorousIcons save asElement;
			action: [ spaceForm exportAsPNGSilently ]
]

{ #category : #'*GToolkit-Inspector' }
BlMorphicWindow >> gtInspectorActionExportAsPNG [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :composite | spaceForm exportAsPNGSilently ];
		icon: GLMUIThemeExtraIcons glamorousSave;
		title: 'Export as PNG'
	 
]
