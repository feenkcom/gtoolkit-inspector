Extension { #name : #IceRepositoryCreator }

{ #category : #'*GToolkit-Inspector' }
IceRepositoryCreator class >> fromUrl: aUrl to: aFileReference [
	^ self new 
		remote: (IceGitRemote url: aUrl);
  location: aFileReference;
  createRepository
]
