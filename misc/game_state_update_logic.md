1. The outermost loops are run every 60 seconds. This loop is the only loop uses seconds as the unit.
2. All inner loops operate on counter, increment and decrement by 1 each time.
3. The calculation done within each outermost loop determines the end state by the end of that 60 seconds.
4. Each toy can only be occupied by one cat a time.
5. Each cat can only occupy a toy a time.
6. If a cat's attention counter reaches 0 at the end of an outermost loop, the cat will leave the cat.
7. The end state of the initial outermost loop of a cat encountering a toy, the cat's attention counter should be 1 less than the total attention.

```
Calculate the time elapsed from the previous game end time and the game start time.

Load the game state json file into a game state dictionary.

Within each game state loop, the game state update function is called with the game state dictionary. The remaining time is reduced by 60 seconds. When the remaining time reaches 0, overwrite the game state json file.

	Get the list of room items.
	
	For each room item
	
		If the room item is occupied by a cat
		
			Reduce the cat's remaining attention to toy counter by 1.
			
			If the remaining attention to toy counter reaches 0
			
				Calculate the cat's reward
				
				Remove the cat from the room
				
				Update this cat's entry on the reward list
		
		If the room item is not occupied by a cat
		
			Get a list of eligible cats. Get a list of cats from the eligible cat list whose favorite toy is the room item
			
			Select a cat from the eligible favourite toy cat list to occupy the room item
			
			
```
