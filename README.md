# BTSummon

## Author
Sapphire

## Description
Summons arbitrary actors akin to the default `summon [actor name]` command with *corrected rotation*. By default, actors (such as projectiles) cannot be spawned above a certain angle preventing you from being able to "shoot" rockets (for example) above you. This mutator applies the instigator's view rotation to the spawned actor.

## Usage
`mutate summon [actor name]`

e.g.

`mutate summon rocketmk2`

**N.B.** package prefixes (Botpack, UnrealI, UnrealShare) may be omitted as the mutator will automatically prefix these to the actor name. When using the example command above, the mutator will attempt to spawn in the following order:

1. `rocketmk2`
1. `Botpack.rocketmk2`
1. `UnrealI.rocketmk2`
1. `UnrealShare.rocketmk2`

The instigator will be notified if nothing is spawned after all attempts.

## Monsters
Also available is the ability to spawn a random monster via `mutate summon monstra`. This will summon a random creature from a total of 39 actors (mostly monsters, but also cows, birds, and nalis).

## Version
2019-01-26

## Website
https://bunnytrack.net/
