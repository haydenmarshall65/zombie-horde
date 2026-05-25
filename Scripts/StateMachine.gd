class_name StateMachine extends Node

# This script is used to manage the states of a character. It is nested in the 
# player tree and contains a dictionary of all the states in the tree. It then
# manages the transitions between states, and calls the State.update() function
# of the current state.

@export var initial_state: BaseState
var current_state: BaseState
var states: Dictionary = {}

# Called when the node enters the scene tree for the first time.
# Connects the Transitioned signal to the on_child_transition() function
# and initializes the states dictionary from the child nodes in the tree.
func _ready() -> void:
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.on_enter_state()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
# If there is a current state, it calls the update() function of that state.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		

# When a state is Transitioned, this function is called.
# gets the correct state from the tree and calls the on_exit_state()
# of previous state and the on_enter_state() of the new state.
func on_child_transition(state, new_state_name) -> void:
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.on_exit_state()
	
	new_state.on_enter_state()
	
	current_state = new_state
