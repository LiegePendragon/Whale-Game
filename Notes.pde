/*
==================Title Screen=====================
Moby-Dick: A Whaling Game <centered, large>
Press any key to begin <centered, below, smaller>
Rising sun or other graphic in background

==================Character Select=================
Choose yer <lookout, harpooner>! <centered, top, large>
Three panels displaying character options with descriptions and portraits per role
Lookouts (affect spout game): ✓✓✓
  * Ishmael ✓
    - Transcendental Moment: 40% chance to offer a piece of wisdom contained in a confusing mess of symbols each level ✓
    - Plot Armor: Allowed one wrong guess on a spout per level ✓
    - Seeker of Spiritual Knowledge (hidden): If with Queequeg, double Transcendental Moment chance ✓
    150x275
  * Starbuck ✓
    - Man of Faith: 40% chance to offer a piece of Biblical advice each level ✓
    - Practicality: Earn 10% more money from whale kills ✓
    - Pacifist (hidden): If with Ahab, double Practicality money ✓
    150x275
  * Flask ✓
    - Surface-Level Thinking: Will not offer any deep insights ✓
    - Murderous Intent: 1% chance to instantly execute any whale spotted ✓
    - Fight Over Flight (hidden): If with Daggoo, Murderous Intent chance increases to 5% ✓
    150x275

Harpooners (affect harpoon game): ✓✓✓
  * Ahab ✓
    - Monomaniac: Harpooning a whale brings it 10% closer to the boat, 25% for Moby-Dick ✓
    - Laser Focus: Gain an extra harpoon for first throw per level ✓
    - Position of Command (hidden): If with Starbuck, double Monomaniac distance ✓
    300x550
  * Queequeg ✓
    - Mysterious Tatoos: Target area on whale is 10% larger ✓
    - Yojo's Guidance: 15% chance to instantly capture a whale if harpoon hits ✓
    - Spiritual Advisor (hidden): If with Ishmael, double Yojo's Guidance chance ✓
    150x275
  * Daggoo ✓
    - Inner Strength: Harpoon throws are 20% more powerful ✓
    - Level Head: Ignores the rocking of the boat ✓
    - Calm in the Storm (hidden): If with Flask, double Innate Strength's power ✓
    150x275

==================Menu/Level Select================
Map of South America coast in background following ship journey
  * 1 = nantucket/south NA
  * 2 = Near middle of Brazil
  * 3 = South SA, start around Cape Horn
  * 4 = Around Cape Horn
Level markers = water spouts
Dotted path as ship progresses
Credits
Achievements

============Gamemode 1: Spot Whale Spout===========
When click on level marker "There she blows!" <Large, transition>
Multiple animated water spouts on screen in ocean (scale with difficulty)
Click on the odd one out to get sperm whale (get money for kill) otherwise <other whale> (no money for kill but still passes level)
Lookout effects mostly happen here
Clicking on spout pops up <transition> and go to harpoon game

============Gamemode 2: Harpoon Whale=====================
In small whale boat, harpooner (custom via char select) at prow
Animated oars pulling boat, whale offscreen to right
Scroll arrow to look at whale/throw harpoon
Get three initial attempts to land one harpoon on head area of whale
When whale hit, attach a line and decrease distance to boat
Each miss at this point increases whale distance, if it gets too far away it flees
1/3 additive chance (+harpooner bonus) to capture whale per additional harpoon hit plus reels whale in a bit
When caught, "You caught a <whale type> worth <money amount>" appear
Transition out of level to menu, move boat forward

============Gamemode 3: Moby-Dick Boss====================
Same as Gamemode 2, except need to attach # of harpoons equivalent to encounter number
Once Moby-Dick is hit the requisite number of times:
  * if 1st or 2nd encounter, breaks the boat?, flees
  * if 3rd encounter, break boat and ship <cutscene, probably>

=================="Chapter" Breakdown=====================
Chapter 1: Welcome to Whaling
* level 1 - tutorial for spot spout game
* level 1.5 - tutorial for harpoon game
* Cutscene - Ahab talk about white whale, offer the doubloon

Chapter 2: A Fateful Encounter
* level 1 - spout
* level 1.5 - harpoon
* level 2 - spout
* level 2.5 - harpoon
* level 3 (boss) - first encounter with Moby Dick, once hit it will break line (follow first encounter in book)
* Cutscene - follow book after first failure

Chapter 3: Pursuit
* level 1 - spout
* level 1.5 - harpoon
* level 2 - spout
* level 2.5 - harpoon
* level 3 (boss) - second encounter with Moby Dick, on one hit it will move, on second hit line will attach (follow second encounter in book)
* Cutscene - follow book after second failure

Chapter 4: Revenge
* level 1 - spout
* level 1.5 - harpoon
* level 2 - spout
* level 2.5 - harpoon
* level 3 (boss) - third encounter with Moby Dick, need to hit it three times to attach  (follow third encounter in book)
  - if win, moby dick takes the boat down with it
* Ending cutscene (follow end/epilogue of book)

*/
