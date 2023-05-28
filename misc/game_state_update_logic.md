The game update logic that gets run whenever a player starts the game goes like this:

1. Check the previous_game_end_time and the game_start_time. Calculate time_elapsed in epoch second.

2. Game state is updated every 60 seconds.

3. Each game state loop contains the change the game should undergo by the end of the loop. 

4. If a cat decides to stop playing, the cat will only leave the toy at the end of game state loop. Even if there is another cat wanting to play with the same toy, that new cat needs to wait until the next game state loop.

5. Within each game state loop

	1. Get the list of room_items in the room.

	2. For each room_item in the room_items list

		1. If room_item is occupied by a cat

			1. Reduce the cat's remaining_attention_to_toy_counter by 1

			2. If the remaining_attention_to_toy_counter reaches 0

				1. Calculate rewards from this cat

				2. remove the cat from the room

				3. Update reward list for this cat

		2. If room_item is not occupied

			1. Create a list of eligible_cats
