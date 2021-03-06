"
I'm a code presenter command who's actions depends on the selected text.
In case no text is selected, the commands will take the text from cursor position to begining of line as an ""ad hoc"" selection.

""context"" needs to conform a certain api to be used here: 

- selectedText
- selectedTextOrLine
- doItReceiver
- doItContext
"
Class {
	#name : #SpCodeSelectionCommand,
	#superclass : #SpToolCommand,
	#category : #'Spec2-Code-Commands-Base'
}

{ #category : #documentation }
SpCodeSelectionCommand class >> documentContextRequiredSelectors [

	^ super documentContextRequiredSelectors, #(selectedTextOrLine)
]

{ #category : #private }
SpCodeSelectionCommand >> evaluate: aString andDo: aBlock [
	"Treat the current selection as an expression; evaluate it and invoke 
	 aBlock with the result."
	| stream result model receiver evaluationContext |
	
	stream := aString readStream.
	model := self context interactionModel.
	receiver := model doItReceiver.
	evaluationContext := model doItContext.
	result := receiver class compiler
		source: stream;
		context: evaluationContext;
		receiver: receiver;
		requestor: model;
		failBlock:  [ ^ nil ];
		evaluate.		

	^ aBlock value: result
]

{ #category : #private }
SpCodeSelectionCommand >> evaluateSelectionAndDo: aBlock [
	"Treat the current selection as an expression; evaluate it and invoke aBlock with the result.
	If no selection is present select the current line."
	| selection |
	
	selection := self selectedTextOrLine.
	selection ifEmpty: [ ^ '' ].
	
	^ self 
		evaluate: selection 
		andDo: aBlock
]

{ #category : #execution }
SpCodeSelectionCommand >> execute [
	"Execute the actions that should be done by the command.
	 This method expect that the context has been put in #context inst. var. if any context is relevant."
	self subclassResponsibility
]

{ #category : #accessing }
SpCodeSelectionCommand >> selectedTextOrLine [

	^ self context selectedTextOrLine
]
