Extension { #name : #Socket }

{ #category : #'*GToolkit-Inspector' }
Socket >> gtKnownSocketOptions [
	^ $ split: 'ICMP6_FILTER IPV6_CHECKSUM IPV6_DONTFRAG IPV6_JOIN_GROUP IPV6_LEAVE_GROUP IPV6_MULTICAST_HOPS IPV6_MULTICAST_IF IPV6_MULTICAST_LOOP IPV6_NEXTHOP IPV6_PATHMTU IPV6_RECVDSTOPTS IPV6_RECVHOPLIMIT IPV6_RECVHOPOPTS IPV6_RECVPATHMTU IPV6_RECVPKTINFO IPV6_RECVRTHDR IPV6_RECVTCLASS IPV6_UNICAT_HOPS IPV6_USE_MIN_MTU IPV6_V6ONLY IPV6_XXX IP_ADD_MEMBERSHIP IP_ADD_SOURCE_MEMBERSHIP IP_BLOCK_SOURCE IP_DROP_MEMBERSHIP IP_DROP_SOURCE_MEMBERSHIP IP_HDRINCL IP_MULTICAST_IF IP_MULTICAST_LOOP IP_MULTICAST_TTL IP_OPTIONS IP_RCVDSTADDR IP_RCVOPTS IP_RECVDSTADDR IP_RECVIF IP_TOS IP_TTL IP_UNBLOCK_SOURCE MCAST_BLOCK_SOURCE MCAST_JOIN_GROUP MCAST_JOIN_SOURCE_GROUP MCAST_LEAVE_GROUP MCAST_LEAVE_SOURCE_GROUP MCAST_UNBLOCK_SOURCE SO_BROADCAST SO_DEBUG SO_DONTROUTE SO_ERROR SO_KEEPALIVE SO_LINGER SO_OOBINLINE SO_PRIORITY SO_RCVBUF SO_RCVLOWAT SO_RCVTIMEO SO_REUSEADDR SO_REUSEPORT SO_SNDBUF SO_SNDLOWAT SO_SNDTIMEO SO_TYPE SO_USELOOPBACK TCP_ABORT_THRESHOLD TCP_CONN_ABORT_THRESHOLD TCP_CONN_NOTIFY_THRESHOLD TCP_MAXSEG TCP_NODELAY TCP_NOTIFY_THRESHOLD TCP_URGENT_PTR_TYPE UDP_CHECKSUM'
]

{ #category : #'*GToolkit-Inspector' }
Socket >> gtViewSocketInfoFor: aView [
	<gtView>
	^ aView forward
		title: 'Socket info';
		priority: 55;
		object: [ 
			| dictionary | 
			dictionary := OrderedDictionary new.
			[ dictionary
				at: #status put: self statusString;
				at: #remoteAddress put: ($. join: self remoteAddress);
				at: #localAddress put: ($. join: self localAddress);
				at: #remotePort put: self remotePort;
				at: #localPort put: self localPort;
				at: #isConnected put: self isConnected;
				at: #isOtherEndClosed put: self isOtherEndClosed;
				at: #isThisEndClosed put: self isThisEndClosed;
				at: #isUnconnected put: self isUnconnected;
				at: #isUnconnectedOrInvalid put: self isUnconnectedOrInvalid;
				at: #isValid put: self isValid;
				at: #isWaitingForConnection put: self isWaitingForConnection.
			] on: NetworkError, PrimitiveFailed do: [ :exception | 
				dictionary at: #EXCEPTION put: exception ].
			dictionary ];
		view: #gtItemsFor: 
]

{ #category : #'*GToolkit-Inspector' }
Socket >> gtViewSocketOptionsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Socket options';
		priority: 60;
		items: [ 
			self gtKnownSocketOptions sorted collect: [ :each | | result |
				result := [ self getOption: each ]
								on: PrimitiveFailed do: [ #(nil nil) ].
				{ each . result second . result first } ] ];
		column: 'Option' text: #first;
		column: 'Value' text: [ :each | each second ifNil: [ '' ] ifNotNil: [ :value | value ] ];
		column: 'Readonly' text: [ :each | each third ifNil: [ '' ] ifNotNil: [ :value | value = -1 ] ]
]
