Class {
	#name : #AbstractTreeSingleSelectionMode,
	#superclass : #Object,
	#traits : 'TSpecObservable',
	#classTraits : 'TSpecObservable classTrait',
	#instVars : [
		'#selection => SpecObservableSlot'
	],
	#category : #'Spec-Core-Widgets-Tree'
}

{ #category : #selection }
AbstractTreeSingleSelectionMode >> clearSelection [

	selection := #()
]

{ #category : #initialization }
AbstractTreeSingleSelectionMode >> initialize [
	self class initializeSlots: self.
	selection := #().
	super initialize.

]

{ #category : #testing }
AbstractTreeSingleSelectionMode >> isEmpty [
	
	^ selection isEmpty
]

{ #category : #selection }
AbstractTreeSingleSelectionMode >> replaceOtherSelectionMode: anotherSelection [

	self subclassResponsibility 
]

{ #category : #'API - events' }
AbstractTreeSingleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self property: #selection whenChangedDo: aBlockClosure 
]