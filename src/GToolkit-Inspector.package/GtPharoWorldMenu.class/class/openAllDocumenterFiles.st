api - actions
openAllDocumenterFiles
	GtInspector openOn: (IceRepository registry 
		select: [ :eachRepository | 
			(eachRepository location / 'doc') exists ] 
		thenCollect: [ :eachRepository | 
			(eachRepository location / 'doc') allChildrenMatching: '*.pillar' ])