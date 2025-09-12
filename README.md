# GodotBlackjack
A Blackjack simulator in Godot. 

The plan is to use this to make my first ever real game and learn how to use cards in Godot as a foundation for a "dream-game" I have planned in the future. As this is my first ever Godot project and my first ever game development project, I have learned the following things so far from this:
	- How to use composition more than inheritance to make more dynamic objects
	- Creating UIs
	- Managing scenes
	- Managing state universally
	- Using button assets (KennyNL's CC0 assets)
	- Etc.
	
And here are some things I want to learn and test with this project:
	- Sound mixing (i.e. using a card flip sound whenever a card is flipped over in tandem with having a master volume, music volume, sfx volume slider in the pause menu in the settings)
	- Natural delay (i.e. the dealer now plays the game correctly but the game runs too fast on the CPU and just ends before all the animations are done) 
	- Maybe add some funny feature so it's not literally Blackjack (as a separate game -- the simulator is more of a testing ground)


As of right now, the full game works. As in, you can open the game, play a game of Blackjack, and go again or quit. I would like to add the above features mentioned so I can learn more about them and then be able to put out an actual real game with the skills I have.

Current things to fix/add:
	- There is an unintended behavior with the animations where, since the win/loss screen doesn't wait for the signal for the dealer to finish drawing, there is no suspense and the dealer draws while the game calculates that you've already lost seconds ago. Need to fix that
	- I want to make the UI prettier lol it's just a PNG on the background
	- Sound for card_flip and card_draw, which exist in the Kenney CC0 pack that I'm using
