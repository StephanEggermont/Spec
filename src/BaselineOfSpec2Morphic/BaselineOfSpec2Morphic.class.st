Class {
	#name : #BaselineOfSpec2Morphic,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpec2Morphic
}

{ #category : #baseline }
BaselineOfSpec2Morphic >> baseline: spec [
	<baseline>
	
	spec for: #common do: [ 
		self spec2: spec.
		
		spec
			"MorphicCore"
			package: 'Spec2-Adapters-Morphic' with: [ spec requires: #('Spec2') ];
			package: 'Spec2-Code-Morphic' with: [ spec requires: #('Spec2' 'Spec2-Adapters-Morphic') ];
			package: 'Spec2-Morphic' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			"Tests"
			package: 'Spec2-Morphic-Examples' with: [ spec requires: #('Spec2-Morphic') ];
			package: 'Spec2-Backend-Tests' with: [ spec requires: #('Spec2-Adapters-Morphic') ];
			package: 'Spec2-Morphic-Backend-Tests' with: [ spec requires: #('Spec2' 'Spec2-Adapters-Morphic' 'Spec2-Backend-Tests') ];
			package: 'Spec2-Adapters-Morphic-Tests' with: [ spec requires: #('Spec2-Backend-Tests') ];
			package: 'Spec2-Morphic-Tests' with: [ spec requires: #('Spec2-Morphic' 'Spec2-Backend-Tests') ]
		 ].
	
	spec group: 'Core' with: #('Spec2' 'Spec2-Morphic' 'Spec2-Adapters-Morphic' ).
	spec group: 'Code' with: #('Core' 'Spec2-Code-Morphic').
	spec group: 'Support' with: #('Core' 'Spec2-Morphic-Examples').
	spec group: 'Tests' with: #(
		'Core' 
		'Spec2-Adapters-Morphic-Tests' 
		'Spec2-Morphic-Tests' 
		'Spec2-Morphic-Backend-Tests' 
		'Spec2-Backend-Tests').
	spec group: 'Base' with: #(
		'Spec2'
		'Core'
		'Support').
		
	spec group: 'default' with: #('Base' 'Code' 'Tests'). 
]

{ #category : #acccessing }
BaselineOfSpec2Morphic >> project [
	"Atomic loading is needed for Spec because we are moving classes of package and it breaks their subclasses. 
	
	Here is an explanation I wrote on Discord:
	
«The problem with Obsolete classes is that classes with subclasses were moved from Spec-Core to Spec-Deprecated80. 

When updating Spec it will first load Spec-Core. This will delete the class and its subclasses will be migrated to an obsolete superclass. 
Then Spec-Deprecated80 is loaded but it does not migrate the subclasses of the obsolete class to it. (Apparently there is an intern working on that Pablo told me).»

We need to use atomic loading only during update of existing Spec upgrade"

	^self class environment at: #SpPresenter 
		ifPresent: [
			super project
				loadType: #atomic;
				yourself ] 
		ifAbsent: [ 		
			super project
				loadType: #linear;
				yourself  ]

	 
]

{ #category : #'external projects' }
BaselineOfSpec2Morphic >> spec2: spec [

	spec baseline: 'Spec2' with: [ 
		spec repository: self packageRepositoryURL"'github://pharo-spec/Spec'" ]
]