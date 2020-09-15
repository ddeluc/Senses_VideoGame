# CS50 Final Project: Senses

### Game Summary
Senses is a 2D platformer made in Love2D. In this game, the player
must navigate through a dark map with only a radius of visibility
(vision) that surrounds the player and a radar-like mechanic that
indicates where there may be potential enemies (hearing). The player's
objective is to collect three special coins that will allow the player
to completely restore their senses and escape the darkness. Throughout
the game, there are floating ghosts that will follow the player. The
player can attack the ghosts and destroy them, but if they get caught,
it is game over. The level and the enemies are not randomly generated.

### Managing Senses
What makes Senses different from the average platformer is the player's
ability to upgrade their senses. In the game, if the palyer picks up
a special coin, it will allow the player to choose between either
upgrading their vision or their hearing. If the player upgrades their
vision, the visible radius that surrounds the player will become larger,
allowing the player to avoid holes in the map or identify pickups.
Alternatively, if the player chooses to upgrade their hearing then the
frequency at which the ghosts are identified outside of the visible
radius becomes greater giving the player a better sense of where enemies
are. 

### Enemies
Ghosts have to sprites in the game; one for when they are outside of the
visible radius and one for when they are inside. In their normal state, 
ghosts follow a fixed figure-8 path and move at a quicker rate. However,
if the player gets close enough to a ghost, the ghost will begin to follow
the enemy at a slower rate. If the player manages to leave the ghosts
detection radius, then the ghost will resume to a fixed path wherever 
it stopped following the player.

### Player Controller
The player controller in Senses has been modified from what was used in
assignment 4. The player is slower and begins movement with acceleration
rather than instant constant velocity. The player also decelerates once 
the player stops walking. Addtionally, the player cannot control movement
while in the air to add a more realistic effect unlike what the player could
do in assignment 4.

##### Potential Updates
* more levels
* a third added sense: touch
* a more complete sense manager
* score and time
* smoother animation
* more enemies

##### Controls
* jump: up
* attack: space
* walk: left / right


___

**NOTE:** There are some fundamental scripts that I used from the 
previous assignments like StateStack.lua, StateMachine.lua, Animation.lua
and others that were necessary for the very basic structure of a 2D 
platformer. However, I do believe that I have added enough complexity and
originality to this game for it to meet the Final Project requirements.

___



