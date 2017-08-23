#Code walkthrough

## Index.html -> root div

## index.js -> render root element

## app.js
* Bootstrapping
* combineReducers -> each reducer, gets a node in state
* Render containers, with simple styles

## Controller container
* Providing props to the ControllerComponent
* AddNewToSequence when mounted

##ControllerComponent
* Show buttons if now playing sequence
* Bind functions to buttons

##ControllerContainer
* AddNewToSequence

##modules/sequence
* All redux logic
* Actions creator - addNewToSequence
* Sends action
* Handled in reducer

###(playSequence) 
* Sends multiple actions based on state

#Demo
* First actions allredy sent -> lifecycle
* Add new button -> diff
* Play! button
* Show master 

* (Log exception with state and action debug)
