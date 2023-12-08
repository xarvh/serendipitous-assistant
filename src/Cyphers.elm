module Cyphers exposing (..)


type alias CypherType =
    { name : String
    , levelModifier : Int
    , description : String
    , rolls : List Roll
    , weight : Float
    }


type alias Roll =
    { name : String
    , options : List { weight : Int, effect : String }
    }


list : List CypherType
list =
    [ { name = "Adhesion"
      , description = """Allows for automatic climbing of any surface, even horizontal
ones. Lasts for ten minutes per cypher level.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Age Taker"
      , description = """Begins a process of rejuvenation that removes years from the
wearer’s physiological age. Over the course of the next seven days,
the wearer sheds a number of years equal to three times the cypher’s
level. The cypher doesn’t regress physiological age past the age of
twenty-three.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Analeptic"
      , description = """Restores a number of points equal to the cypher’s level to the
user’s Speed Pool.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Antivenom"
      , description = """Renders user immune to poisons of the cypher’s level or lower
for one hour per cypher level (and ends any such ongoing effects, if
any, already in the user’s system).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Armor Reinforcer"
      , description = """The user’s Armor gains an enhancement for twenty-four hours."""
      , levelModifier = 1
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 1, effect = "+1 to Armor" }
                    , { weight = 1, effect = "+2 to Armor" }
                    , { weight = 1, effect = "+3 to Armor" }
                    , { weight = 1, effect = "+2 to Armor, +5 against damage from fire" }
                    , { weight = 1, effect = "+2 to Armor, +5 against damage from cold" }
                    , { weight = 1, effect = "+2 to Armor, +5 against damage from acid" }
                    ]
              }
            ]
      , weight = 1
      }
    , { name = "Attractor"
      , description = """One unanchored item the user’s size or smaller within long range
(very long range if the cypher level is 8 or higher) is drawn
immediately to them. This takes one round. The item has no momentum when
it arrives.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Banishing"
      , description = """For the next day, each time the user strikes a solid creature or
object, it generates a burst of energy that teleports the creature or
object an immediate distance in a random direction (not up or down). The
teleported creature’s actions (including defense) are hindered on its
next turn (hindered by two steps if the cypher level is 5 or higher).
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Best Tool"
      , description = """Provides an additional asset for any one task using a tool, even
if that means exceeding the normal limit of two assets.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Blackout"
      , description = """An area within immediate range of the user becomes secure
against any effect outside the area that sees, hears, or otherwise
senses what occurs inside. To outside observers, the area is a “blur” to
any sense applied. Taps, scrying sensors, and other direct surveillance
methods are also rendered inoperative within the area for a day.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Blinking"
      , description = """For the next day, each time the user is struck hard enough to
take damage (but not more than once per round), they teleport an
immediate distance in a random direction (not up or down). Since the
user is prepared for this effect and their foe is not, the user’s
defenses are eased for one round after they teleport.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Burst of Speed"
      , description = """For one minute, a user who normally can move a short distance as
an action can move a long distance instead.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Catholicon"
      , description = """Cures any disease of the cypher level or lower.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Chemical Factory"
      , description = """After one hour, the sweat of the user produces 1d6 doses of a
valuable liquid (these doses are not considered cyphers). They must be
used within one week."""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 4, effect = "Euphoric for 1d6 hours" }
                    , { weight = 4, effect = "Hallucinogenic for 1d6 hours" }
                    , { weight = 4, effect = "Stimulant for 1d6 hours" }
                    , { weight = 4, effect = "Depressant for 1d6 hours" }
                    , { weight = 4, effect = "Nutrient supplement" }
                    , { weight = 5, effect = "Antivenom" }
                    , { weight = 5, effect = "Cures disease" }
                    , { weight = 5, effect = "See in the dark for one hour" }
                    , { weight = 10, effect = "Restores a number of Might Pool points equal to cypher level" }
                    , { weight = 10, effect = "Restores a number of Speed Pool points equal to cypher level" }
                    , { weight = 10, effect = "Restores a number of Intellect Pool points equal to cypher level" }
                    , { weight = 10, effect = "Increases Might Edge by 1 for one hour" }
                    , { weight = 10, effect = "Increases Speed Edge by 1 for one hour" }
                    , { weight = 10, effect = "Increases Intellect Edge by 1 for one hour" }
                    , { weight = 5, effect = "Restores all Pools to full" }
                    ]
              }
            ]
      , levelModifier = 0
      , weight = 1
      }
    , { name = "Comprehension"
      , description = """Within five minutes, the user can understand the words of a
specific language keyed to the cypher (two languages if the cypher is
level 5 or higher). This is true even of creatures that do not normally
have a language. If the user could already understand the language, the
cypher has no effect. Once the cypher is used, the effect is permanent,
and the cypher no longer counts against the number of cyphers that a PC
can bear.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Condition Remover"
      , description = """Cures one occurrence of one specific health condition of the
cypher level or lower. It does not prevent the possibility of future
occurrences of the same condition."""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 1, effect = "Addiction to one substance" }
                    , { weight = 1, effect = "Autoimmune disease" }
                    , { weight = 1, effect = "Bacterial infection" }
                    , { weight = 1, effect = "Bad breath" }
                    , { weight = 1, effect = "Blisters" }
                    , { weight = 1, effect = "Bloating" }
                    , { weight = 1, effect = "Cancer" }
                    , { weight = 1, effect = "Chapped lips" }
                    , { weight = 1, effect = "Flatus" }
                    , { weight = 1, effect = "Hangover" }
                    , { weight = 1, effect = "Heartburn" }
                    , { weight = 1, effect = "Hiccups" }
                    , { weight = 1, effect = "Ingrown hairs" }
                    , { weight = 1, effect = "Insomnia" }
                    , { weight = 1, effect = "Joint problem" }
                    , { weight = 1, effect = "Muscle cramp" }
                    , { weight = 1, effect = "Pimples" }
                    , { weight = 1, effect = "Psychosis" }
                    , { weight = 1, effect = "Stiff neck" }
                    , { weight = 1, effect = "Viral infection" }
                    ]
              }
            ]
      , levelModifier = 3
      , weight = 1
      }
    , { name = "Contingent Activator"
      , description = """If the device is activated in conjunction with another cypher,
the user can specify a condition under which the linked cypher will
activate. The linked cypher retains the contingent command until it is
used (either normally or contingently). For example, when this cypher is
linked to a cypher that provides a form of healing or protection, the
user could specify that the linked cypher will activate if they become
damaged to a certain degree or are subject to a particular dangerous
circumstance. Until the linked cypher is used, this cypher continues to
count toward the maximum number of cyphers a PC can carry.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Controlled Blinking"
      , description = """For the next day, each time the user is struck hard enough to
inflict damage (but no more than once per round), they teleport to a
spot they desire within immediate range. Since they are prepared for
this effect and their foe is not, the user’s defenses are eased for one
round after they teleport.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Curative"
      , description = """Restores a number of points equal to the cypher’s level to the
user’s Might Pool.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Curse Bringer"
      , description = """The cypher can be activated when given to an individual who
doesn’t realize its significance. The next time the victim attempts an
important task when the cypher is in their possession, the task is
hindered by three steps.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Darksight"
      , description = """Grants the ability to see in the dark for five hours per cypher
level. (For a more realistic game, this cypher could instead make the
user specialized in low-light spotting.)
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Death Bringer"
      , description = """For the next minute, when the user strikes an NPC or creature of
the cypher level or lower, they can choose to make a second attack roll.
If the second attack roll is a success, the target is killed. If the
target is a PC, the character instead moves down one step on the damage
track.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Density"
      , description = """For the next day, each time the user strikes a solid creature or
object with a weapon, the weapon suddenly increases dramatically in
weight, causing the blow to inflict 2 additional points of damage.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation"
      , description = """Projects a small physical explosive up to a long distance away
that explodes in an immediate radius, inflicting damage equal to the
cypher’s level.
(All damaging detonations inflict a minimum of 2 points of damage to
those in the radius, regardless of attack or defense rolls.)
"""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 10, effect = "Cell-disrupting (harms only flesh)" }
                    , { weight = 20, effect = "Corrosive" }
                    , { weight = 10, effect = "Electrical discharge" }
                    , { weight = 10, effect = "Heat drain (cold)" }
                    , { weight = 25, effect = "Fire" }
                    , { weight = 25, effect = "Shrapnel" }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Detonation (Creature)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes and creates a momentary teleportation gate. A random
creature whose level is equal to or less than the cypher’s level appears
through the gate and attacks the closest target. After about one minute,
the creature vanishes.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Desiccating)"
      , description = """Projects a small physical explosive up to a long distance away
that bursts in an immediate radius, draining moisture from everything
within it. Living creatures take damage equal to the cypher’s level.
Water in the area is vaporized.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Flash)"
      , description = """Projects a small physical explosive up to a long distance away
that bursts in an immediate radius, blinding all within it for one
minute (ten minutes if the cypher is level 4 or higher).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Gravity)"
      , description = """Projects a small physical explosive up to a long distance away
that bursts in an immediate radius, inflicting damage equal to the
cypher’s level by increasing gravity tremendously for one second. All
creatures in the area are crushed to the ground for one round and cannot
take physical actions.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Gravity Inversion)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes, and for one hour gravity reverses within long range of
the explosion.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Massive)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes in a
short-range radius, inflicting damage equal to the cypher’s level.
"""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 10, effect = "Cell-disrupting (harms only flesh)" }
                    , { weight = 20, effect = "Corrosive" }
                    , { weight = 10, effect = "Electrical discharge" }
                    , { weight = 10, effect = "Heat drain (cold)" }
                    , { weight = 25, effect = "Fire" }
                    , { weight = 25, effect = "Shrapnel" }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Detonation (Matter Disruption)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes in an immediate radius, releasing nanites that rearrange
matter in random ways. Inflicts damage equal to the cypher’s level.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Pressure)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes in an immediate radius, inflicting impact damage equal to
the cypher’s level. Also moves unattended objects out of the area if
they weigh less than 20 pounds (9 kg) per cypher level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Singularity)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes and creates a momentary singularity that tears at the
fabric of the universe. Inflicts 20 points of damage to all within short
range, drawing them (or their remains) together to immediate range (if
possible). Player characters in the radius who fail a Might defense roll
move down one step on the damage track.
This cypher always counts as being Level 10.
"""
      , levelModifier = 10
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Sonic)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes with terrifying sound, deafening all in an immediate
radius for ten minutes per cypher level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Detonation (Spawn)"
      , description = """Projects a small physical explosive up to a long distance away
that bursts in an immediate radius, blinding all within it for one
minute and inflicting damage equal to the cypher’s level. The burst
spawns 1d6 additional detonations; in the next round, each additional
detonation flies to a random spot within short range and explodes in an
immediate radius.
"""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 10, effect = "Cell-disrupting (harms only flesh)" }
                    , { weight = 20, effect = "Corrosive" }
                    , { weight = 10, effect = "Electrical discharge" }
                    , { weight = 10, effect = "Heat drain (cold)" }
                    , { weight = 25, effect = "Fire" }
                    , { weight = 25, effect = "Shrapnel" }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Detonation (Web)"
      , description = """Projects a small physical explosive up to a long distance away
that explodes in an immediate radius and creates sticky strands of goo.
PCs caught in the area must use a Might-based action to get out, with
the difficulty determined by the cypher level. NPCs break free if their
level is higher than the cypher level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Disarm"
      , description = """One NPC within immediate range whose level is lower than the
cypher level drops whatever they are holding.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Disguise Module"
      , description = """For the next ten minutes per cypher level, the user’s features
become almost identical to those of one designated person they have
previously interacted with, easing by two steps attempts to disguise the
user as that person. Once designated, the user cannot shift the effect
to look like another person, though they can remove the module to look
like themselves again before the end of the duration.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Disrupting"
      , description = """For the next day, each time the user strikes a solid creature or
object, the attack generates a burst of nanites that directly attack its
organic cells. The target takes 1 additional point of damage. If the
target’s level is less than the cypher’s level, it loses its next
action; otherwise its next action is hindered.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Eagleseye"
      , description = """Grants the ability to see ten times as far as normal for one
hour per cypher level. (For a more realistic game, the eagleseye cypher
could instead give the user two assets on tasks involving seeing to long
distances.)
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Effect Resistance"
      , description = """Provides a chance for additional resistance to directly damaging
effects of all kinds, such as fire, lightning, and the like, for one
day. (It does not provide resistance to blunt force, slashing, or
piercing attacks.) If the level of the effect is of the cypher level or
lower, the user gains an additional defense roll to avoid it. On a
successful defense roll, treat the attack as if the user had succeeded
on their regular defense roll. (If the user is an NPC, a PC attacking
them with this kind of effect must succeed on two attack rolls to harm
them.)
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Effort Enhancer (Combat)"
      , description = """For the next hour, the user can apply one free level of Effort
to any task (including a combat task) without spending points from a
Pool. The free level of Effort provided by this cypher does not count
toward the maximum amount of Effort a character can normally apply to
one task. Once this free level of Effort is used, the effect of the
cypher ends.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Effort Enhancer (Noncombat)"
      , description = """For the next hour, the user can apply one free level of Effort
to a noncombat task without spending points from a Pool. The level of
Effort provided by this cypher does not count toward the maximum amount
of Effort a character can normally apply to one task. Once this free
level of Effort is used, the effect of the cypher ends.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Enduring Shield"
      , description = """For the next day, the user has an asset to Speed defense rolls.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Equipment Cache"
      , description = """The user can rummage around and produce from the cypher a
desired piece of equipment (not an artifact) whose level does not exceed
the cypher’s level. The piece of equipment persists for up to one day,
unless its fundamental nature allows only a single use (such as with a
grenade).
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Farsight"
      , description = """The user can observe a location they have visited previously,
regardless of how far away it is (even across galaxies). This vision
persists for up to ten minutes per cypher level. The character can
switch between viewing this location and viewing their current location
once per round.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Fireproofing"
      , description = """A nonliving object treated by this cypher has Armor against fire
damage equal to the cypher’s level for one day.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Flame-Retardant Wall"
      , description = """Creates an immobile plane of permeable energy up to 20 feet by
20 feet (6 m by 6 m) for one hour per cypher level. The plane conforms
to the space available. Flames passing through the plane are
extinguished.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Force Cube"
      , description = """Creates an immobile cube composed of six planes of solid force,
each 30 feet (9 m) to a side, for one hour. The planes conform to the
space available. (Although a force cube’s walls are not gaseous
permeable, there is likely enough air within for trapped creatures to
breathe for the hour it lasts.)
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Force Field"
      , description = """For the next day, the user is surrounded
by a powerful force field, granting them +1
to Armor (+2 to Armor if the cypher level is
5 or higher).
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Force Screen Projector"
      , description = """Creates an immobile plane of solid force up to 20 feet by 20
feet (6 m by 6 m) for one hour. The plane conforms to the space
available.
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Force Shield Projector"
      , description = """Creates a shimmering energy shield around the user for one hour,
during which time they gain +3 to Armor (or +4 to Armor if the cypher is
level 5 or higher).
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Friction Reducer"
      , description = """Spread across an area up to 10 feet (3 m) square, this makes
things extremely slippery. For one hour per cypher level, movement tasks
in the area are hindered by three steps.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Frigid Wall"
      , description = """Creates a wall of supercooled air up to 30 feet by 30 feet by 1
foot (9 m by 9 m by 30 cm) that inflicts damage equal to the cypher’s
level on anything that passes through it. The wall conforms to the space
available. It lasts for ten minutes.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Gas Bomb"
      , description = """Thrown a short distance, this bursts in a poisonous cloud within
an immediate area. The cloud lingers for 1d6 rounds unless conditions
dictate otherwise.
"""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 10, effect = "Thick smoke: occludes sight while the cloud lasts." }
                    , { weight = 10, effect = "Choking gas: living creatures that breathe lose their actions to choking and coughing for a number of rounds equal to the cypher’s level." }
                    , { weight = 30, effect = "Poison gas: living creatures that breathe suffer damage equal to the cypher’s level." }
                    , { weight = 10, effect = "Corrosive gas: everything suffers damage equal to the cypher’s level." }
                    , { weight = 5, effect = "Hallucinogenic gas: living creatures that breathe lose their actions to hallucinations and visions for a number of rounds equal to the cypher’s level." }
                    , { weight = 5, effect = "Nerve gas: living creatures that breathe suffer Speed damage equal to the cypher’s level." }
                    , { weight = 10, effect = "Mind-numbing gas: living creatures that breathe suffer Intellect damage equal to the cypher’s level." }
                    , { weight = 4, effect = "Fear gas: living creatures that breathe and think flee in a random direction in fear (or are paralyzed with fear) for a number of rounds equal to the cypher’s level." }
                    , { weight = 3, effect = "Amnesia gas: living creatures that breathe and think permanently lose all memory of the last minute." }
                    , { weight = 10, effect = "Sleep gas: living creatures that breathe fall asleep for a number of rounds equal to the cypher’s level or until awoken by a violent action or an extremely loud noise." }
                    , { weight = 3, effect = "Rage gas: living creatures that breathe and think make a melee attack on the nearest creature and continue to do so for a number of rounds equal to the cypher’s level." }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Gravity Nullifier"
      , description = """For one hour, the user can float into the air, moving vertically
up to a short distance per round (but not horizontally without taking
some other action, such as pushing along the ceiling). The user must
weigh less than 50 pounds (23 kg) per level of the cypher.
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Gravity-Nullifying Application"
      , description = """If a nonliving object no larger than a human (two humans if the
cypher level is 6 or higher) is coated by this cypher, it floats 1d20
feet in the air permanently and no longer has weight if carried (though
it needs to be strapped down).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Heat Attack"
      , description = """For the next day, each time the user strikes a solid creature or
object, the attack generates a burst of heat that inflicts 2 additional
points of damage.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Hunter/Seeker"
      , description = """With long-range movement, this intelligent missile tracks and
attacks a specified target (target must be within sight when
selected). If it misses, it continues to attack one additional time
per cypher level until it hits. For example, a level 4
hunter/seeker will attack a maximum of five times.
"""
      , rolls =
            [ { name = "Type of attack"
              , options =
                    [ { weight = 50, effect = "Inflicts 8 points of damage." }
                    , { weight = 30, effect = "Bears a poisoned needle that inflicts 3 points of damage plus poison." }
                    , { weight = 10, effect = "Explodes, inflicting 6 points of damage to all within immediate range." }
                    , { weight = 5, effect = "Shocks for 4 points of electricity damage, and stuns for one round per cypher level." }
                    , { weight = 5, effect = "Covers target in sticky goo that immediately hardens, holding them fast until they break free with a Might action (difficulty equal to the cypher’s level + 2)." }
                    ]
              }
            ]
      , levelModifier = 0
      , weight = 1
      }
    , { name = "Image Projector"
      , description = """Projects one of the following immobile images in the area
described for one hour. The image appears up to a close distance from
the user (long distance if the cypher level is 4 or higher, very long
distance if the cypher level is 6 or higher). Scenes include movement,
sound, and smell."""
      , rolls =
            [ { name = "Image"
              , options =
                    [ { weight = 20, effect = "Terrifying creature of an unknown species, perhaps no longer alive in the world (10-foot [3 m] cube)" }
                    , { weight = 20, effect = "Huge machine that obscures sight (30-foot [9 m] cube)" }
                    , { weight = 10, effect = "Beautiful pastoral scene (50-foot [15 m] cube)" }
                    , { weight = 10, effect = "Food that looks delicious but may not be familiar (10-foot [3 m] cube)" }
                    , { weight = 20, effect = "Solid color that obscures sight (50-foot [15 m] cube)" }
                    , { weight = 20, effect = "Incomprehensible scene that is disorienting and strange (20-foot [6 m] cube)" }
                    ]
              }
            ]
      , levelModifier = 0
      , weight = 1
      }
    , { name = "Inferno Wall"
      , description = """Creates a wall of extreme heat up to 30 feet by 30 feet by 1
foot (9 m by 9 m by 30 cm) that inflicts damage equal to the cypher’s
level on anything that passes through it. The wall conforms to the space
available. It lasts for ten minutes.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Infiltrator"
      , description = """Tiny capsule launches and moves at great speed, mapping and
scanning an unknown area. It moves 500 feet (150 m) per level, scanning
an area up to 50 feet (15 m) per level away from it. It identifies basic
layout, creatures, and major energy sources and either transmits this
information back to the user (perhaps by telepathy or an electronic
signal) or returns to the user to show what it saw. Its movement is
blocked by any physical or energy barrier.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Information Sensor"
      , description = """Over the course of one day, the user can activate the cypher a
total number of times equal to its level. Each time, they can select a
living creature within long range and learn the following about it:
level, origin, species, name, and possibly other facts (such as an
individual’s credit score, home address, phone number, and related
information).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Instant Servant"
      , description = """Small device expands into a humanoid automaton that is roughly 2
feet (60 cm) tall. Its level is equal to the cypher’s level, and it can
understand the verbal commands of the character who activated it. Once
the servant is activated, commanding it is not an action. It can make
attacks or perform actions as ordered to the best of its abilities, but
it cannot speak.

The automaton has short-range movement but never goes farther than long
range from the character who activated it. At the GM’s discretion, the
servant might have specialized knowledge, such as how to operate a
particular device. Otherwise, it has no special knowledge. In any case,
the servant is not artificially intelligent or capable of initiating
action. It does only as commanded.

The servant operates for one hour per cypher level.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Instant Shelter"
      , description = """With the addition of water and air, this cypher expands into a
simple one-room structure with a door and a transparent window (two
rooms with an internal door if the cypher level is 7 or higher). The
structure is 10 feet by 10 feet by 20 feet (3 m by 3 m by 6 m). It is
made from a durable, nonflammable material similar to sandstone, and is
permanent and immobile once created.
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Intellect Booster"
      , description = """Adds 1 to the user’s Intellect Edge for one hour (or 2 if the
cypher is level 5 or higher).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Intelligence Enhancement"
      , description = """All of the user’s tasks involving intelligent deduction—such as
playing chess, inferring a connection between clues, solving a
mathematical problem, finding a bug in computer code, and so on—are
eased by two steps for one hour. In the subsequent hour, the strain
hinders the same tasks by two steps.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Knowledge Enhancement"
      , description = """For the next day, the character has training in a predetermined
skill (or two skills if the cypher is level 5 or higher). The skill
could be anything (including something specific to the operation of a
particular device). (It is easy
to get addicted to the quick hit of training that comes from knowledge
enhancement cyphers. Characters who rely on them too often may find
themselves at a disadvantage when they run out, presenting a great
opportunity for GM intrusion.)
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Lightning Wall"
      , description = """Creates a wall of electric bolts up to 30 feet by 30 feet by 1
foot (9 m by 9 m by 30 cm) that inflicts damage equal to the cypher’s
level on anything that passes through it. The wall conforms to the space
available. It lasts for ten minutes.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Machine Control"
      , description = """Splits into two pieces; one is affixed to a device and the other
to a character. The character can then use their mind to control the
device at long range, bidding it to do anything it could do normally.
Thus, a device could be activated or deactivated, and a vehicle could be
piloted. The control lasts for ten minutes per cypher level, and once
the device is chosen, it cannot be changed.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Magnetic Attack Drill"
      , description = """The user throws this cypher at a target within short range, and
it drills into the target for one round, inflicting damage equal to the
cypher’s level. If the target is made of metal or wearing metal (such as
armor), the attack is eased.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Magnetic Master"
      , description = """Establishes a connection with one metal object within short
range that a human could hold in one hand. The user can then move or
manipulate the object anywhere within short range (each movement or
manipulation is an action). For example, they could wield a weapon or
drag a helm affixed to a foe’s head to and fro. The connection lasts for
ten rounds per cypher level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Magnetic Shield"
      , description = """For ten minutes per cypher level, metal objects cannot come
within immediate range of the user. Metal items already in the area when
the device is activated are slowly pushed out.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Manipulation Beam"
      , description = """Over the course of one day, the user can activate the cypher a
total number of times equal to its level. Each time, they can affect an
object they can see within long range that is not too heavy for them to
affect physically. The effect must occur over the course of a round and
could include closing or opening a door, keying in a number on a keypad,
transferring an object a short distance, wresting an object from another
creature’s grasp (on a successful Might-based roll), or pushing a
creature an immediate distance. (A manipulation beam could be used to
operate a computer at a distance, which would make some infiltration and
hacking jobs easier.)
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Matter Transference Ray"
      , description = """The user can target one nonliving object within long range that
is their size or smaller of the cypher level or lower. The object is
transferred directly to a random location at least 100 miles (160 km)
away. If the GM feels it appropriate to the circumstances, only a
portion of an object is transferred (a portion whose volume is no more
than the user’s).
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Meditation Aid"
      , description = """Restores a number of points equal to the cypher’s level to the
user’s Intellect Pool.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Memory Switch"
      , description = """The user selects a point within long range, and the minds of all
thinking creatures within immediate range of that point are attacked.
Victims are dazed and take no action for a round, and they have no
memory of the preceding hour.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Mental Scrambler"
      , description = """Two rounds after being activated, the device creates an
invisible field that fills an area within short range and lasts for one
minute. The field scrambles the mental processes of all thinking
creatures. The effect lasts as long as they remain in the field and for
1d6 rounds after, although an Intellect defense roll is allowed each
round to act normally (both in the field and after leaving it). Each
mental scrambler is keyed to a specific effect.
"""
      , rolls =
            [ { name = "Effect"
              , options =
                    [ { weight = 30, effect = "Victims cannot act." }
                    , { weight = 10, effect = "Victims cannot speak." }
                    , { weight = 10, effect = "Victims move slowly (immediate range) and clumsily." }
                    , { weight = 10, effect = "Victims cannot see or hear." }
                    , { weight = 10, effect = "Victims lose all sense of direction, depth, and proportion." }
                    , { weight = 10, effect = "Victims do not recognize anyone they know." }
                    , { weight = 8, effect = "Victims suffer partial amnesia." }
                    , { weight = 6, effect = "Victims suffer total amnesia." }
                    , { weight = 4, effect = "Victims lose all inhibitions, revealing secrets and performing surprising actions." }
                    , { weight = 2, effect = "Victims’ ethics are inverted." }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Metal Death"
      , description = """Produces a stream of foam that covers an area about 3 feet by 3
feet (1 m by 1 m), transforming any metal that it touches into a
substance as brittle as thin glass. The foam affects metal to a depth of
about 6 inches (15 cm).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Mind Meld"
      , description = """Lets the user speak telepathically with creatures they can see
within short range for up to one hour. The user can’t read a target’s
thoughts, except those that are specifically “transmitted.”
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Mind-Restricting Wall"
      , description = """Creates an immobile plane of permeable energy up to 20 feet by
20 feet (6 m by 6 m) for one hour. The plane conforms to the space
available. Intelligent creatures passing through the plane fall
unconscious for up to one hour, or until slapped awake or damaged.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Mind Stabilizer"
      , description = """The user gains +5 to Armor against Intellect damage.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Monoblade"
      , description = """Produces a 6-inch (15 cm) blade that’s the same level as the
cypher. The blade cuts through any material of a level lower than its
own. If used as a weapon, it is a light weapon that ignores Armor of a
level lower than its own. The blade lasts for ten minutes.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Monohorn"
      , description = """The user gains a horn in the center of their forehead. The horn
is deadly sharp and strong, and it spirals down to a solid base where it
fuses with their flesh and bone. The user is specialized in making melee
attacks with the horn, which is considered a medium weapon. The horn
lasts for a number of hours equal to the cypher’s level.
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Motion Sensor"
      , description = """For one hour per cypher level, the user knows when any movement
occurs within short range, and when large creatures or objects move
within long range (the cypher distinguishes between the two). It also
indicates the number and size of the creatures or objects in motion.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Null Field"
      , description = """The user and all creatures within immediate range gain +3 to
Armor (+5 if the cypher is level 8 or higher) against damage of a
specified kind for one hour.
"""
      , rolls =
            [ { name = "Damage kind"
              , options =
                    [ { weight = 12, effect = "Fire" }
                    , { weight = 15, effect = "Cold" }
                    , { weight = 12, effect = "Acid" }
                    , { weight = 13, effect = "Psychic" }
                    , { weight = 13, effect = "Sonic" }
                    , { weight = 7, effect = "Electrical" }
                    , { weight = 12, effect = "Poison" }
                    , { weight = 11, effect = "Blunt force" }
                    , { weight = 5, effect = "Slashing and piercing" }
                    ]
              }
            ]
      , levelModifier = 3
      , weight = 1
      }
    , { name = "Nullification Ray"
      , description = """The user can immediately end one ongoing effect within long
range that is produced by an artifact, cypher, or special ability.
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Nutrition and Hydration"
      , description = """The user can go without food and water for a number of days
equal to the cypher’s level without ill effect.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Perfect Memory"
      , description = """Allows the user to mentally record everything they see for
thirty seconds per cypher level and store the recording permanently in
their long-term memory. This cypher is useful for watching someone pick
a specific lock, enter a complex code, or do something else that happens
quickly.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Perfection"
      , description = """The user treats their next action as if they had rolled a
natural 20.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Personal Environment Field"
      , description = """Creates an aura of temperature and atmosphere that will sustain
a human safely for a day. The aura extends to 1 foot (30 cm) around the
user (double that radius if the cypher is level 7 or higher). It does
not protect against sudden flashes of temperature change (such as from a
heat ray). A small number of these cyphers (1%) accommodate the
preferred environment of a nonhuman, nonterrestrial creature.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Phase Changer"
      , description = """Puts the user out of phase for one minute (two minutes if the
cypher is level 6 or higher). During this time, they can pass through
solid objects as though they were entirely insubstantial, like a ghost.
They cannot make physical attacks or be physically attacked.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Phase Disruptor"
      , description = """Puts a portion of a physical structure (like a wall or floor)
out of phase for one hour. It affects an area equal to one 5-foot (1.5
m) cube per cypher level. While the area is out of phase, creatures and
objects can pass through it as if it were not there, although one cannot
see through it, and it blocks light.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Poison (Emotion)"
      , description = """The victim feels a specific emotion for one hour."""
      , rolls =
            [ { name = "Emotion"
              , options =
                    [ { weight = 20, effect = "Anger. Likely to attack anyone who disagrees with them.  Very hard to interact with; all such actions are hindered by two steps." }
                    , { weight = 20, effect = "Fear. Flees in terror for one minute when threatened." }
                    , { weight = 20, effect = "Lust. Cannot focus on any nonsexual activity." }
                    , { weight = 15, effect = "Sadness. All tasks are hindered." }
                    , { weight = 10, effect = "Complacency. Has no motivation. All tasks are hindered by two steps." }
                    , { weight = 10, effect = "Joy. Easy to interact with in a pleasant manner; all pleasant interaction tasks are eased." }
                    , { weight = 5, effect = "Love. Much easier to interact with; all interaction tasks are eased by two steps, but temporary attachment is likely." }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Poison (Explosive)"
      , description = """Once this substance enters the bloodstream, it travels to the
brain and reorganizes into an explosive that detonates when activated,
inflicting 10 points of damage (ignores Armor)."""
      , rolls =
            [ { name = "Trigger"
              , options =
                    [ { weight = 25, effect = "The detonator is activated (must be within long range)." }
                    , { weight = 15, effect = "A specified amount of time passes." }
                    , { weight = 10, effect = "The victim takes a specific action." }
                    , { weight = 5, effect = "A specific note is sung or played on an instrument within short range." }
                    , { weight = 5, effect = "The victim smells a specific scent within immediate range." }
                    , { weight = 20, effect = "The victim comes within long range of the detonator." }
                    , { weight = 20, effect = "The victim is no longer within long range of the detonator." }
                    ]
              }
            ]
      , levelModifier = 1
      , weight = 1
      }
    , { name = "Poison (Mind Controlling)"
      , description = """The victim must carry out a specific action in response to a specific trigger."""
      , rolls =
            [ { name = "Action"
              , options =
                    [ { weight = 20, effect = "Lies down for one minute with eyes closed when told to do so." }
                    , { weight = 20, effect = "Flees in terror for one minute when threatened." }
                    , { weight = 20, effect = "Answers questions truthfully for one minute." }
                    , { weight = 15, effect = "Attacks close friend for one round when within immediate range." }
                    , { weight = 10, effect = "Obeys next verbal command given (if it is understood)." }
                    , { weight = 10, effect = "For one day, becomes sexually attracted to the next creature of its own species that it sees." }
                    , { weight = 5, effect = "For one minute, moves toward the next red object seen in lieu of all other actions, ignoring self-preservation." }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Poison (Mind Disrupting)"
      , description = """The victim suffers Intellect damage equal to the cypher’s level
and cannot take actions for a number of rounds equal to the cypher’s
level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Psychic Communique"
      , description = """Allows the user to project a one-time,
one-way telepathic message of up to ten words per cypher level, with
an unlimited range, to anyone they know.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Radiation Spike"
      , description = """Delivers a powerful burst of radiation that disrupts the tissue
of any creature touched, inflicting damage equal to the cypher’s level.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Ray Emitter"
      , description = """Allows the user to project a ray of destructive energy up to
very long range that inflicts damage equal to the cypher’s level."""
      , rolls =
            [ { name = "Effect"
              , options =
                    [ { weight = 50, effect = "Heat/concentrated light" }
                    , { weight = 10, effect = "Cell-disrupting radiation" }
                    , { weight = 20, effect = "Force" }
                    , { weight = 7, effect = "Magnetic wave" }
                    , { weight = 6, effect = "Molecular bond disruption" }
                    , { weight = 6, effect = "Concentrated cold" }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Ray Emitter (Command)"
      , description = """Allows the user to project a ray up to long range (very long
range if the cypher is level 6 or higher) that forces a target to obey
the next verbal command given (if it is understood) for one round per
cypher level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Ray Emitter (Fear)"
      , description = """Allows the user to project a ray up to long range (very long
range if the cypher is level 6 or higher) that causes the target to flee
in terror for one minute.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Ray Emitter (Friend Slaying)"
      , description = """Allows the user to project a ray up to long range (very long
range if the cypher is level 6 or higher) that causes the target to
attack its nearest ally for one round.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Ray Emitter (Mind Disrupting)"
      , description = """Allows the user to project a ray of destructive energy up to
very long range that inflicts Intellect damage equal to the cypher’s
level. Also, the victim cannot take actions for a number of rounds equal
to the cypher’s level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Ray Emitter (Numbing)"
      , description = """Allows the user to project a ray of energy up to long range
(very long range if the cypher is level 6 or higher) that numbs one limb
of the target, making it useless for one minute. A small number of these
devices (5%) induce numbness that lasts for one hour.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Ray Emitter (Paralysis)"
      , description = """Allows the user to project a ray of energy up to very long range
that paralyzes the target for one minute. A small number of these
devices (5%) induce paralysis that lasts for one hour.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Reality Spike"
      , description = """Once activated, the cypher does not move—ever—even if activated
in midair. A Might action will dislodge it, but then it is ruined.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Reflex Enhancer"
      , description = """All tasks involving manual dexterity—such as pickpocketing,
lockpicking, juggling, operating on a patient, defusing a bomb, and so
on—are eased by two steps for one hour.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Rejuvenator"
      , description = """Restores a number of points equal to the cypher’s level to one random stat Pool."""
      , rolls =
            [ { name = ""
              , options =
                    [ { weight = 50, effect = "Might Pool" }
                    , { weight = 25, effect = "Speed Pool" }
                    , { weight = 25, effect = "Intellect Pool" }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Remembering"
      , description = """Allows the user to recall any one experience they’ve ever had.
The experience can be no longer than one minute per cypher level, but
the recall is perfect, so (for example) if they saw someone dial a
phone, they will remember the number.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Remote Viewer"
      , description = """For one hour per cypher level, the user can see everything going
on in the vicinity of the cypher, regardless of the distance between
them.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Repair Unit"
      , description = """The cypher becomes a multiarmed sphere that floats. It repairs
one designated item (of its own level or lower) that has been damaged
but not destroyed. The repair unit can also create spare parts, unless
the GM rules that the parts are too specialized or rare (in which case,
the unit repairs the device except for the specialized part). Repair
time is 1d100 + 20 minutes.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Repeater"
      , description = """For the next minute, the user’s ranged weapon fires one
additional time with ammo fabricated by the cypher. The weapon wielder
can aim the free shot at the same target, or at a different target next
to the first one.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Repel"
      , description = """One NPC within immediate range who is of a level lower than the
cypher decides to leave, using their next five rounds to move away
quickly.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Retaliation"
      , description = """For the next day, anyone striking the user receives a small
burst of electricity that inflicts 1 point of damage (2 points if the
cypher is level 4 or higher, 3 points if the cypher is level 6 or
higher). No action or roll is required by the user.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Secret"
      , description = """The user can ask the GM one question and get a general answer.
The GM assigns a level to the question, so the more obscure the answer,
the more difficult the task. Generally, knowledge that a PC could find
by looking somewhere other than their current location is level 1, and
obscure knowledge of the past is level 7. Gaining knowledge of the
future is level 10, and such knowledge is always open to interpretation.
The cypher cannot provide an answer to a question above its level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Sheen"
      , description = """For one week, the user’s cells are coated with a protective
veneer that resists damage (+1 to Armor, or +2 to Armor if the cypher is
level 5 or higher) and eases Might defense rolls by two steps. However,
healing is more difficult during this time; all recovery rolls suffer a
–1 penalty.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Shock Attack"
      , description = """For the next day, each time the user strikes a solid creature or
object, the attack generates a burst of electricity, inflicting 1
additional point of damage (2 points if the cypher is level 4 or higher,
3 points if the cypher is level 6 or higher).
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Shocker"
      , description = """Delivers a powerful burst of electricity that shocks any creature touched, inflicting damage equal to the cypher’s level."""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Skill Boost"
      , description = """Dramatically but temporarily alters the user’s mind and body so
they can ease one specific kind of physical action by three steps. Once
activated, this boost can be used a number of times equal to the
cypher’s level, but only within a twenty-four-hour period. The boost
takes effect each time the action is performed. For example, a level 3
cypher boosts the first three times that action is attempted."""
      , rolls =
            [ { name = "Skill"
              , options =
                    [ { weight = 15, effect = "Melee attack" }
                    , { weight = 15, effect = "Ranged attack" }
                    , { weight = 10, effect = "Speed defense" }
                    , { weight = 10, effect = "Might defense" }
                    , { weight = 10, effect = "Intellect defense" }
                    , { weight = 8, effect = "Jumping" }
                    , { weight = 8, effect = "Climbing" }
                    , { weight = 8, effect = "Running" }
                    , { weight = 8, effect = "Swimming" }
                    , { weight = 2, effect = "Sneaking" }
                    , { weight = 2, effect = "Balancing" }
                    , { weight = 2, effect = "Perceiving" }
                    , { weight = 1, effect = "Carrying" }
                    , { weight = 1, effect = "Escaping" }
                    ]
              }
            ]
      , levelModifier = 0
      , weight = 1
      }
    , { name = "Slave Maker"
      , description = """To activate the cypher, the user must succeed on a melee attack
against a creature about the size of the user and whose level does not
exceed the cypher’s level. The cypher bonds to the target, who
immediately becomes calm. The target awaits the user’s commands and
carries out all orders to the best of its ability. The target remains so
enslaved for a number of hours equal to the cypher’s level minus the
target’s level. (If the result is 0, the target is enslaved for only one
minute.)
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Sleep Inducer"
      , description = """Touch puts the victim to sleep for ten minutes per cypher level
or until awoken by a violent action or an extremely loud noise.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Sniper Module"
      , description = """For the next hour per cypher level, the effective range of the
user’s ranged weapon increases by one category (immediate to short,
short to long, long to very long, very long to 1,000 feet [300 m]). A
weapon with a range greater than very long has its range doubled.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Solvent"
      , description = """Dissolves 1 cubic foot of material each round. After one round
per cypher level, the cypher becomes inert.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Sonic Hole"
      , description = """Draws all sound within long range into the device for one round
per cypher level. Within the affected area, no sound can be heard.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Sound Dampener"
      , description = """Dampens all sound within immediate range for one minute per
cypher level, providing an asset on stealth actions by all creatures in
the area.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Spatial Warp"
      , description = """When affixed to a device that affects a single target at range,
that range is increased to 1 mile (1.5 km) with no penalties. Space is
temporarily warped in terms of seeing and reaching the target. If direct
line of sight is important to the device’s effect, it remains important.
The spatial warp lasts 10 minutes per cypher level.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Speed Boost"
      , description = """Adds 1 to the user’s Speed Edge for one hour (adds 2 if the
cypher is level 5 or higher).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Spy"
      , description = """Produces a tiny spying object that resists detection as a level
8 creature. The object moves at great speed, mapping and scanning an
unknown area. It moves 500 feet (150 m) per level, scanning an area up
to 50 feet (15 m) away from it. It identifies basic layout, creatures,
and major energy sources. Its movement is blocked by any physical or
energy barrier. At the end of its mapping run, it returns to the user
and reports. If it discovers a predefined target during its run (such as
“a creature of level 5 or higher,” “a locked door,” “a major energy
source,” and so on), it detonates instead, dealing damage equal to the
cypher’s level (half electrical damage, half shrapnel damage) to all
creatures and objects in short range.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Stasis Keeper"
      , description = """Puts a subject into stasis for a number of days equal to the
cypher’s level, or until it is violently disturbed. An object in stasis
does not age and comes out of the stasis alive and in the same condition
as it went in, with no memory of the period of inactivity.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Stim"
      , description = """Eases the user’s next action taken by three steps.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Strength Boost"
      , description = """Adds 1 to Might Edge for one hour (or 2 if the cypher is level 5
or higher).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Strength Enhancer"
      , description = """All noncombat tasks involving raw strength—such as breaking down
a door, lifting a heavy boulder, forcing open elevator doors, competing
in a weightlifting competition, and so on—are eased by two steps for one
hour.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Subdual Field"
      , description = """Two rounds after being activated, the device creates an
invisible field that fills a specified area (such as a cube a short
distance across) within long range. The field lasts for one minute. It
affects the minds of thinking beings within the field, preventing them
from taking hostile actions. The effect lasts as long as they remain in
the field and for 1d6 rounds after, although an Intellect defense roll
is allowed each round to act normally (both in the field and after
leaving it).
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Telepathy"
      , description = """For one hour, the device enables
long-range mental communication with anyone the user can see.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Teleporter (Bounder)"
      , description = """User teleports up to 100 × the cypher level in feet to a
location they can see. They arrive safely with their possessions but
cannot take anything else with them.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Teleporter (Interstellar)"
      , description = """User teleports anywhere in the galaxy to a location they have
previously visited or seen. They arrive safely with their possessions
but cannot take anything else with them.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Teleporter (Planetary)"
      , description = """User teleports anywhere on the planet to a location they have
previously visited or seen. They arrive safely with their possessions
but cannot take anything else with them.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Teleporter (Traveler)"
      , description = """User teleports up to 100 × the cypher level in miles to a
location they have previously visited or seen. They arrive safely with
their possessions but cannot take anything else with them.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Temporal Viewer"
      , description = """Displays moving images and sound, up to ten minutes per cypher
level in length, depicting events that occurred at the current location
up to one year prior. The user specifies the time period shown by the
viewer.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Time Dilation (Defensive)"
      , description = """For the next twenty-four hours, when the user is attacked, they
move in rapid, seemingly random jumps, a few inches to one side or the
other. This is an asset that modifies the user’s defense rolls by two
steps (three steps if the cypher is level 6 or higher).
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Time Dilation (Offensive)"
      , description = """For the next twenty-four hours, when the user makes a melee
attack, they move at almost instantaneous speed, easing their attacks by
two steps (three steps if the cypher is level 6 or higher).
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Tissue Regeneration"
      , description = """For the next hour, the user regains 1 point lost to damage per
round, up to a total number of points equal to twice the cypher’s level.
As each point is regained, they choose which Pool to add it to. If all
their Pools are at maximum, the regeneration pauses until they take more
damage, at which point it begins again (if any time remains in the hour)
until the duration expires.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Tracer"
      , description = """Fires a microscopic tracer that clings to any surface within
short range. For the next twenty-four hours, the launcher shows the
distance and direction to the tracer, as long as it is within 1 mile
(100 miles if the cypher is level 3 or higher, in the same dimension if
the cypher is level 6 or higher).
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Trick Embedder"
      , description = """A nonintelligent animal immediately and perfectly learns one
trick (two tricks if the cypher is level 4 or higher) it is capable of
physically performing (roll over, heel, spin, shake, go to an indicated
place within long range, and so on). The trick must be designated when
the cypher is activated.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Uninterruptible Power Source"
      , description = """Provides power to another device for
up to a day. The device to be powered
can be as simple as a light source or as
complex as a small starcraft, assuming the
cypher’s level is equal to the item’s power
requirements. A desk lamp is a level 1
power requirement, a car engine is a level
5 power requirement, and a starship is a level 10 power requirement.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Vanisher"
      , description = """The user becomes invisible for five minutes per cypher level,
during which time they are specialized in stealth and Speed defense
tasks. This effect ends if they do something to reveal their presence or
position—attacking, using an ability, moving a large object, and so on.
If this occurs, they can regain the remaining invisibility effect by
taking an action to focus on hiding their position.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Visage Changer"
      , description = """Changes the appearance of one
human-sized creature, providing an asset to disguise tasks (easing
them by two steps if the cypher is level 5 or higher). The change
takes ten minutes to apply and lasts for twenty-four hours.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Visual Displacement Device"
      , description = """Projects holographic images of the user to confuse attackers.
The images appear around the user, giving them an asset to Speed defense
actions for ten minutes per cypher level.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Vocal Translator"
      , description = """For twenty-four hours per cypher level, translates everything
said by the user into a language that anyone can understand.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Warmth"
      , description = """Keeps the user warm and comfortable, even in the harshest cold
temperatures, for twenty-four hours. During this time, the user has
Armor equal to the cypher’s level that protects against cold damage.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Water Adapter"
      , description = """The user can breathe underwater and operate at any depth
(without facing the debilitating consequences of changing pressure) for
four hours per cypher level. This cypher can also be used in the regular
atmosphere, allowing the user to ignore ill effects from very low or
very high atmospheric pressure. The cypher does not protect against
vacuum.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Weapon Enhancement"
      , description = """Modifies a weapon’s attack in a particular fashion for ten minutes per cypher level."""
      , rolls =
            [ { name = "Effect"
              , options =
                    [ { weight = 10, effect = "Eases attack by one step" }
                    , { weight = 10, effect = "Deals bonus electrical damage equal to cypher level" }
                    , { weight = 10, effect = "Deals bonus cold damage equal to cypher level" }
                    , { weight = 10, effect = "Deals bonus poison damage equal to cypher level" }
                    , { weight = 10, effect = "Deals bonus acid damage equal to cypher level" }
                    , { weight = 10, effect = "Deals bonus fire damage equal to cypher level" }
                    , { weight = 10, effect = "Deals bonus sonic damage equal to cypher level" }
                    , { weight = 10, effect = "Deals bonus psychic damage equal to cypher level" }
                    , { weight = 10, effect = "Knockback (on 18–20 on successful attack roll, target knocked back 30 feet [9 m])" }
                    , { weight = 5, effect = "Holding (on 18–20 on successful attack roll, target can’t act on its next turn)" }
                    , { weight = 2, effect = "Eases attack by two steps" }
                    , { weight = 1, effect = "Banishing (on 18–20 on successful attack roll, target is sent to random location at least 100 miles [160 km] away)" }
                    , { weight = 1, effect = "Explodes, inflicting damage equal to cypher level to all within immediate range" }
                    , { weight = 1, effect = "Heart-seeking (on 18–20 on successful attack roll, target is killed)" }
                    ]
              }
            ]
      , levelModifier = 2
      , weight = 1
      }
    , { name = "Wings"
      , description = """User can fly at their normal running speed for ten minutes per
cypher level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "X-Ray Viewer"
      , description = """Allows the user to see through up to 2 feet (60 cm) of material
of a level lower than the cypher. The effect lasts for one minute per
cypher level.
"""
      , levelModifier = 4
      , rolls = []
      , weight = 1
      }
    , { name = "Zero Point Field"
      , description = """Renders an inanimate object outside the effects of most energy
for one minute. This means the object cannot be harmed, moved, or
manipulated in any way. It remains in place (even in midair).
"""
      , levelModifier = 3
      , rolls = []
      , weight = 1
      }
    , { name = "Area Boost"
      , description = """This cypher boosts an ability that affects a single target. The
ability expands the effect so it includes the immediate area around that
target. If the ability normally affects an immediate area, the area
becomes short. Short areas are increased to long. Long areas are
increased to very long. Abilities with very long areas become 1,000-foot
(300 m) areas. All other areas double in radius.
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Burst Boost"
      , description = """This cypher boosts an ability that affects a single target at
short range or farther. The range decreases to immediate, but the
ability affects all targets within immediate range.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Damage Boost"
      , description = """This cypher boosts an ability that inflicts points of damage.
The ability inflicts additional damage equal to this cypher’s level.
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    , { name = "Efficacy Boost (Major)"
      , description = """This cypher boosts an ability that requires a skill roll. The
use of the ability is eased by two steps. This kind of cypher might be
appropriate only in superhero campaigns, at least with any regularity.)
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Efficacy Boost (Minor)"
      , description = """This cypher boosts an ability that requires a skill roll. The
use of the ability is eased.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Energy Boost"
      , description = """This cypher boosts an ability that has a stat Pool cost. The
cost is reduced to 0.
"""
      , levelModifier = 0
      , rolls = []
      , weight = 1
      }
    , { name = "Range Boost"
      , description = """This cypher boosts the range of an ability. Something that
affects only you can now affect someone you touch. Any other ability
increases its range by one category (touch to immediate, immediate to
short, short to long, long to very long, very long to 1,000 feet [300
m], or double for any range longer than very long).
"""
      , levelModifier = 1
      , rolls = []
      , weight = 1
      }
    , { name = "Target Boost"
      , description = """This cypher boosts an ability that affects a target at a range
greater than touch. It can affect a second target within range (if the
ability is an attack, make a separate attack roll for the second
creature).
"""
      , levelModifier = 2
      , rolls = []
      , weight = 1
      }
    ]
