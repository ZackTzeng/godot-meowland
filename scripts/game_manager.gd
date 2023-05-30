extends Node

## GameManager contains functions that can manage the game state.
##
## GameManager contains the game state update logics. The update() function is called when a user starts the game.
## The update_game_state_loop() is called for each game state loop, ie every 60 seconds.
## Current assumptions:
##  - no concept of food
##  - all cats leave the same amount of reward_state
##  - all cats' attentions to toy counters are the same
##  - cats leave the full amount of rewards when the occupied item is removed or replaced prematurely
##  - cats don't pick from their favourite toy
##  - previous end time state is the new starting time when it should be the actual end time
##
## @tutorial:            https://the/tutorial1/url.com
## @tutorial(Tutorial2): https://the/tutorial2/url.com


# some explanation
func update(_room_state_dict, _cats_data_dict, _items_data_dict):
	var room_state_dict = _room_state_dict
	var cats_data_dict = _cats_data_dict
	var items_data_dict = _items_data_dict
	
	var unit_time_counter = 10

	var new_start_time = Time.get_unix_time_from_system()
	var new_start_time_counter = int(new_start_time) / unit_time_counter
	
	if room_state_dict['previous_end_time'] == 0:
		room_state_dict['previous_end_time'] = new_start_time
	
	var previous_end_time = room_state_dict['previous_end_time']
	var previous_end_time_counter = int(previous_end_time) / unit_time_counter
	
	var time_counter_elapsed = new_start_time_counter - previous_end_time_counter

	while time_counter_elapsed > 0:
		update_game_state_loop(room_state_dict, cats_data_dict, items_data_dict)
		time_counter_elapsed = max(time_counter_elapsed - 1, 0)
		
	room_state_dict['previous_end_time'] = new_start_time
	return room_state_dict


# some explanation
func update_game_state_loop(_room_state_dict, _cats_data_dict, _items_data_dict):
#	var time_elapsed = _time_elapsed
	var room_state_dict = _room_state_dict
	var cats_data_dict = _cats_data_dict
	var items_data_dict = _items_data_dict

	var room_items = room_state_dict['room_items'].keys()
	for room_item in room_items:
		# check if the room item has been occupied by a cat
		if room_state_dict['room_items'][room_item]['occupant'] != '':
#			var occupied_cat = room_state_dict['room_items'][room_item]['occupant']
#			# reduce the cat's attention to toy counter by 1
			room_state_dict['room_items'][room_item]['remaining_attention'] -= 1

			# if the cat is no longer interested in the toy
			if room_state_dict['room_items'][room_item]['remaining_attention'] == 0:
				var cat_with_reward = room_state_dict['room_items'][room_item]['occupant']
				var reward = 5
				# update the cat's reward
				if ! cat_with_reward in room_state_dict['rewards'].keys():
					room_state_dict['rewards'][cat_with_reward] = 0
				room_state_dict['rewards'][cat_with_reward] += reward
				room_state_dict['room_items'][room_item]['occupant'] = ''
#				room_state_dict['room_items'][room_item]['remaining_attention'] = 0
				room_state_dict['room_cats'].erase(cat_with_reward)
					
		# if the room item is not occupied by a cat
		else:
			var absent_cats = []
			for cat in cats_data_dict.keys():
				if not cat in room_state_dict['room_cats']:
					absent_cats.append(cat)
			var attracted_cat = absent_cats[RandomNumberGenerator.new().randi_range(0, absent_cats.size()-1)]
			if attracted_cat != '':
				room_state_dict['room_items'][room_item]['occupant'] = attracted_cat
				room_state_dict['room_items'][room_item]['remaining_attention'] = cats_data_dict[attracted_cat]['total_attention'] - 1
				room_state_dict['room_cats'].append(attracted_cat)
				
				
