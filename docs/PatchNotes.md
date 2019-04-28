# Next Version
## The "Next Version" release
Release Notes:
 * Fixed several serious issues with Berries
  * Berries can no longer underflow the Escape Factor to 255
  * Berries no longer sometimes cause ERROR 48
 * Fixed many Generation 1 bugs
  * A fully parlyzed mon in the middle of a two-turn move no longer becomes invlunerable for the rest of battle
  * Sleep moves no longer bypass all checks on mons that are recharging from using Hyper Beam
  * Celadon Hotel no longer has an invisible PC in the corner
 * Balance Changes
  * Enemy status effects no longer fizzle 25% of the time, have fun
  * Eevee now learns Tail Whip in place of Sand Attack
  * Several more of Eevee's level up moves have been adjusted to be in line with original starters

# Version 0.2.16 "Gen1Bugfix-Release1"
## The "Wow Gen1 sure is broken" release
Release Notes:
* Toxic no longer interacts with other status effects
  * Burn no longer gains damage from the toxic counter if the target rested while toxic poisoned
  * Leech Seed no longer gains damage from and increments the toxic counter
  * Poison no longer gets promoted to toxic poison if the target rested while toxic poisoned
  * Rest properly clears the toxic flag and toxic counter
* NEW: Berries have been added to replace both bait and rocks
  * Berries have been added to several item tables
    * Oak provides one dozen berries and a brief explanation of them when delivering his parcel
    * Berries replace super repel in transfer rewards
    * Berries can be purchased in the Dept Store
  * Berries increase the catch rate of wild pokemon
  * Berries also negate Flee rate increases for the turn they were thrown
    * Note that wild pokemon can still run if Flee rate is already high
* NEW: Safari Mode interface has been updated
  * Safari Mode has a second page full of NONE.
  * Switch between pages using the PAGE command where BAIT used to be

# Version 0.2.0 "Mechanics Overhaul"
## The "Fix and balance safari mode" update
Release Notes:
* Version flags and rom names have been normalized to "LetsGoEeveeGB" and "LetsGoPikachuGB"
  * Internal rom names are LETSGOGBEEVEE and LETSGOGBPIKA
* Capture rate formula has been completely re-written since all balls are Great Balls.
  * Capture formula now uses wild mon's level
  * Capture rate is boosted for each badge the player has earned
  * Capture rate is boosted for each 8 pokemon in the player's pokedex
  * It felt pretty good in single testing but I didn't get to test higher level pokemon
* Flee rate for wild pokemon has been completely reworked
  * Starting flee rate of (WildPKMNSpeed % 256 * 2) is unchanged
  * NEW: Each turn gain additional flee rate equal to 1/8 base speed
  * NEW: Each unsuccessful capture attempt grants flee rate equal to 1/8 base speed
  * Unchanged: Run when flee is above 255 or random(255)
  * On average the player should have around 4 turns for mid-level pokemon with average speed stats before fleeing
* Throw rock and Throw bait are disabled. You can click them all you want but nothing will happen
  * This is because neither were being used in the new capture or flee formulas
* Transfer to Oak now grants 1 base reward from the reward table and 1 GREAT_BALL
  * NEW: Pokemon over level 25 grant +1 reward
  * NEW: Pokemon over level 50 grant an additional +1 reward
  
# Version 0.1.2 "BIG BOY"
## The "Wow I broke it all" Update
This release fixes a flippin' ton of bugs and aims to make the gameplay smoother and more fun. There are still some known issues make sure to check the readme.

Saves are incompatible with 0.1.0 and will be detected as corrupt because I added to the SRAM.

Release Notes:
* Transfer to Oak mechanic fixed to give consistent rewards.
* Starter Pokemon changed to Eevee and Pikachu
* Rival Starter changed to opposite of player
* Rival will choose an Eeveelution and different party members per save file
* Experience gains have been normalized to a 3 Pokemon party when capturing.
  * This means you are encouraged to have more pokemon in your active party when capturing wild pokemon
* Prof Oak rewards the player with 12 balls after returning his parcel to him to help get you started
* EXP ALL text removed. WARNING: DO NOT ACCEPT EXP ALL FROM OAK'S AIDE. Doing so may break your save in a future update
* Old Man tutorial no longer uses Safari Mode and spends the player's balls

# Version 0.1.0 "First Release"
## The "This game is actually kinda playable as I envisioned it" update
First release. Very buggy
Release Notes:
* All wild encounters now use Safari Mode
* Modified backsprites for Vulpix and Clefairy
* Fixed the Focus Energy bug and reworked critical hit rate
  * Crits happen 8.75% of the time
  * Focus Energy and High crit rate moves both add an additional +8.75% crit rate
  * Crit rate currently tops out at roughly 27% (this may need adjustments)
* Gen 1 missing was removed.
  * Note that some moves like Tackle have 90% accuracy in Gen 1
  * Also note that enemies have a static 25% miss rate when using stat reducing moves (EG Growl, Sand attack)
  * If something misses that shouldn't, let me know
* All party mons gain EXP when capturing a wild pokemon
  * This currently mimics EXP ALL and will be changed in a later update
* Ditto is now encountered in imposter battles and has been removed from encounter tables
  * All wild battles have a 1.1% chance to instead be a pre-transformed ditto
* The player can only use great balls in safari mode so I standardized those across all shops
  * Great ball price lowered to 500 from 600
  * Also changed the master ball reward to some great balls
  * Also changed all ball pickups on the ground to be great balls
* Great balls are renamed to Poke Balls. This is a text only change
* The PKMNCenter PC option "Release" has been relplaced with "Transfer"
  * Transferring pokemon to Oak via the PC rewards players with items
  * Since moon stones are on the rewards list they now sell for 1050P$
