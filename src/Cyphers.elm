module Cyphers exposing (..)


type alias CypherType =
    { name : String
    , levelModifier : Int
    , description : String
    , rolls : List Roll
    }


type alias Roll =
    { name : String
    , options : List { weight : Int, effect : String }
    }


list : List CypherType
list =
    [ { description = "Allows for automatic climbing of any surface, even horizontal ones. Lasts for twenty minutes."
      , levelModifier = 0
      , name = "ADHESION"
      , rolls = []
      }
    , { description = "Restores a number of points equal to the cypher’s level to the user’s Body Pool."
      , levelModifier = 2
      , name = "ANALEPTIC"
      , rolls = []
      }
    , { description = "Renders user immune to poisons of the same level or lower (and ends any such ongoing effects, if any, already in the user’s system)."
      , levelModifier = 2
      , name = "ANTIVENOM"
      , rolls = []
      }
    , { description = "One unanchored item your size or smaller within long range is drawn immediately to you. This takes one round. The item has no momentum when it arrives."
      , levelModifier = 4
      , name = "ATTRACTOR"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, each time you strike a solid creature or object (with a weapon or your fist), a burst of energy teleports it an immediate distance in a random direction (not up or down). The difficulty of a teleported creature’s actions (including defense) is modified by one step to its detriment on its next turn."
      , levelModifier = 0
      , name = "BANISHING"
      , rolls = []
      }
    , { description = "An area within immediate range of the user becomes secure against any effect outside the area that sees, hears, or otherwise senses what occurs inside. To outside observers, the area is a “blur” to any sense applied. Taps, scrying sensors, and other direct feed surveillance methods are also rendered inoperative within the area for twenty-four hours"
      , levelModifier = 2
      , name = "BLACKOUT"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, each time you are struck hard enough to take damage (but not more than once per round), you teleport an immediate distance in a random direction (not up or down). Since you are prepared for this effect and your foe is not, the difficulty of your defense roll is modified by one step to your benefit for one round after you teleport."
      , levelModifier = 0
      , name = "BLINKING"
      , rolls = []
      }
    , { description = "Cures any disease of the same level or lower."
      , levelModifier = 2
      , name = "CATHOLICON"
      , rolls = []
      }
    , { description = "Within five minutes, the user can understand the words of a specific language keyed to the cypher. This is true even of creatures that do not normally have a language. If the user could already understand the language, the cypher has no effect. Once the cypher is used, the effect is permanent, and this cypher no longer counts against the number of cyphers that a PC can bear."
      , levelModifier = 1
      , name = "COMPREHENSION"
      , rolls = []
      }
    , { description = "Provides an additional asset for\nany one task using a tool, even if that\nmeans exceeding the normal limit of\ntwo assets. Level: 1d6 + 2"
      , levelModifier = 0
      , name = "BEST TOOL"
      , rolls = []
      }
    , { description = "You get the result of having rolled a double 6 on your next action."
      , levelModifier = 0
      , name = "PERFECTION"
      , rolls = []
      }
    , { description = "For one minute, a user that\nnormally moves a short distance as an\naction moves a long distance instead."
      , levelModifier = 0
      , name = "BURST OF SPEED"
      , rolls = []
      }
    , { description = "One NPC of a level lower than\nthe cypher within immediate range\ndecides to leave, using his next five\nrounds to move away quickly."
      , levelModifier = 1
      , name = "REPEL"
      , rolls = []
      }
    , { description = "One NPC of a level lower than the\ncypher within immediate range drops\nwhatever he is holding."
      , levelModifier = 1
      , name = "DISARM"
      , rolls = []
      }
    , { description = "Cures one occurrence of\na specific health condition. It does\nnot prevent the possibility of future\noccurrences of the same condition."
      , levelModifier = 3
      , name = "CONDITION REMOVER"
      , rolls =
            [ { name = "Condition:"
              , options =
                    [ { effect = "Addiction to one substance", weight = 1 }
                    , { effect = "Autoimmune disease", weight = 1 }
                    , { effect = "Bacterial infection", weight = 1 }
                    , { effect = "Bad breath", weight = 1 }
                    , { effect = "Blisters", weight = 1 }
                    , { effect = "Bloating", weight = 1 }
                    , { effect = "Cancer", weight = 1 }
                    , { effect = "Chapped lips", weight = 1 }
                    , { effect = "Flatus", weight = 1 }
                    , { effect = "Heartburn", weight = 1 }
                    , { effect = "Hiccups", weight = 1 }
                    , { effect = "Ingrown hairs", weight = 1 }
                    , { effect = "Insomnia", weight = 1 }
                    , { effect = "Joint problem", weight = 1 }
                    , { effect = "Muscle cramp", weight = 1 }
                    , { effect = "Pimples", weight = 1 }
                    , { effect = "Psychosis", weight = 1 }
                    , { effect = "Stiff neck", weight = 1 }
                    , { effect = "Viral infection", weight = 1 }
                    , { effect = "Hangover", weight = 1 }
                    ]
              }
            ]
      }
    , { description = "If the device is activated\nin conjunction with another cypher,\nthe user can specify a condition\nunder which the linked cypher will\nactivate. The linked cypher retains the\ncontingent command until it is used\n(either normally or contingently). For\nexample, when this cypher is linked to a\ncypher that provides a form of healing\nor protection, the user could specify\nthat the linked cypher will activate if he\nbecomes damaged to a certain degree\nor is subject to a particular dangerous\ncircumstance. Until the linked cypher\nis used, this cypher continues to count\ntoward the maximum number of\ncyphers a PC can carry."
      , levelModifier = 2
      , name = "CONTINGENT ACTIVATOR"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, each\ntime you are struck hard enough to\ninflict damage (but no more than once\nper round), you teleport to a spot you\ndesire within immediate range. Since\nyou are prepared for this effect and your\nfoe is not, the difficulty of your defense\nrolls is modified by one step to your\nbenefit for one round after you teleport."
      , levelModifier = 2
      , name = "CONTROLLED BLINKING"
      , rolls = []
      }
    , { description = "Restores a number of points\nequal to the cypher’s level to the user’s\nMight Pool."
      , levelModifier = 2
      , name = "CURATIVE"
      , rolls = []
      }
    , { description = "The curse bringer can be activated\nwhen given to an individual who doesn’t\nrealize its significance. The next time the\nvictim attempts an important task when\nthe cypher is in her possession, the\ndifficulty of the task is modified by three\nsteps to her detriment."
      , levelModifier = 1
      , name = "CURSE BRINGER"
      , rolls = []
      }
    , { description = "Grants the ability to see in the\ndark for eight hours."
      , levelModifier = 0
      , name = "DARKSIGHT"
      , rolls = []
      }
    , { description = "For the next minute, when the user\nstrikes an NPC or creature whose level\nis equal to or less than the cypher’s\nlevel, she can choose to make a second\nattack roll. If the second attack roll is a\nsuccess, the target is killed. If the target\nis a PC, the character instead moves\ndown one step on the damage track."
      , levelModifier = 0
      , name = "DEATH BRINGER"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, each\ntime you strike a solid creature or object\nwith a weapon, the weapon suddenly\nincreases dramatically in weight,\ncausing the blow to inflict 2 additional\npoints of damage."
      , levelModifier = 0
      , name = "DENSITY"
      , rolls = []
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that explodes in\nan immediate radius, inflicting damage\nequal to the cypher’s level."
      , levelModifier = 2
      , name = "DETONATION"
      , rolls =
            [ { name = "Type of damage:"
              , options =
                    [ { effect = "Cell-disrupting (harms only flesh)", weight = 10 }
                    , { effect = "Corrosive", weight = 20 }
                    , { effect = "Electrical discharge", weight = 10 }
                    , { effect = "Heat drain (cold)", weight = 10 }
                    , { effect = "Fire", weight = 25 }
                    , { effect = "Shrapnel", weight = 25 }
                    ]
              }
            ]
      }
    , { description = "Projects a small physical explosive\nup to a long distance away that explodes\nand creates a momentary teleportation\ngate. A random creature whose level is\nequal to or less than the cypher’s level\nappears through the gate and attacks\nthe closest target."
      , levelModifier = 1
      , name = "DETONATION (CREATURE)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive\nup to a long distance away that bursts\nin an immediate radius, draining\nmoisture from everything within it.\nLiving creatures take damage equal to\nthe cypher’s level. Water in the area is\nvaporized."
      , levelModifier = 2
      , name = "DETONATION (DESICCATING)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that bursts in an\nimmediate radius, blinding all within it\nfor one minute."
      , levelModifier = 2
      , name = "DETONATION (FLASH)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive\nup to a long distance away that bursts in\nan immediate radius, inflicting damage\nequal to the cypher’s level by increasing\ngravity tremendously for one second. All\ncreatures in the area are crushed to the\nground for one round and cannot take\nphysical actions."
      , levelModifier = 2
      , name = "DETONATION (GRAVITY)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that explodes,\nand for one hour gravity reverses within\nlong range of the explosion."
      , levelModifier = 1
      , name = "DETONATION (GRAVITY INVERSION)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that explodes in\na short-range radius, inflicting damage\nequal to the cypher’s level."
      , levelModifier = 2
      , name = "DETONATION (MASSIVE)"
      , rolls =
            [ { name = "Type of damage:"
              , options =
                    [ { effect = "Cell-disrupting (harms only flesh)", weight = 10 }
                    , { effect = "Corrosive", weight = 20 }
                    , { effect = "Electrical discharge", weight = 10 }
                    , { effect = "Heat drain (cold)", weight = 10 }
                    , { effect = "Fire", weight = 25 }
                    , { effect = "Shrapnel", weight = 25 }
                    ]
              }
            ]
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that explodes in\nan immediate radius, releasing nanites\nthat rearrange matter in random ways.\nInflicts damage equal to the cypher’s\nlevel."
      , levelModifier = 4
      , name = "DETONATION (MATTER DISRUPTION)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that explodes in\nan immediate radius, inflicting impact\ndamage equal to the cypher’s level. Also\nmoves unattended objects out of the\narea if they weigh less than 20 pounds\n(9 kg) per cypher level."
      , levelModifier = 2
      , name = "DETONATION (PRESSURE)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive\nup to a long distance away that explodes\nand creates a momentary singularity that\ntears at the fabric of the universe. Inflicts\n20 points of damage to all within short\nrange, drawing them (or their remains)\ntogether to immediate range (if possible).\nPlayer characters in the radius who fail a\nMight defense roll move down one step\non the damage track."
      , levelModifier = 0
      , name = "DETONATION (SINGULARITY)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive\nup to a long distance away that explodes\nwith terrifying sound, deafening all in an\nimmediate radius."
      , levelModifier = 2
      , name = "DETONATION (SONIC)"
      , rolls = []
      }
    , { description = "Projects a small physical explosive\nup to a long distance away that bursts\nin an immediate radius, blinding all\nwithin it for one minute and inflicting\ndamage equal to the cypher’s level.\nThe burst spawns 1d6 additional\ndetonations; in the next round, each\nadditional detonation flies to a random\nspot within short range and explodes in\nan immediate radius."
      , levelModifier = 2
      , name = "DETONATION (SPAWN)"
      , rolls =
            [ { name = "Type of damage dealt by all detonations:"
              , options =
                    [ { effect = "Cell-disrupting (harms only flesh)", weight = 10 }
                    , { effect = "Corrosive", weight = 20 }
                    , { effect = "Electrical discharge", weight = 10 }
                    , { effect = "Heat drain (cold)", weight = 10 }
                    , { effect = "Fire", weight = 25 }
                    , { effect = "Shrapnel", weight = 25 }
                    ]
              }
            ]
      }
    , { description = "Projects a small physical explosive up\nto a long distance away that explodes in\nan immediate radius and creates sticky\nstrands of goo. PCs caught in the area\nmust use a Might-based action to get\nout, with the difficulty determined by\nthe cypher level. NPCs break free if their\nlevel is higher than the cypher level."
      , levelModifier = 2
      , name = "DETONATION (WEB)"
      , rolls = []
      }
    , { description = "For the next hour, the user’s features\nbecome almost identical to those of one\ndesignated person she has previously\ninteracted with. This lowers the difficulty\nby two steps when the user attempts to\ndisguise herself as the designated person.\nOnce designated, the user cannot shift the\neffect to look like another person, though\nshe can remove the module to look like\nherself again before the end of the hour."
      , levelModifier = 2
      , name = "DISGUISE MODULE"
      , rolls = []
      }
    , { description = "For the next twenty-four hours,\neach time you strike a solid creature or\nobject, you generate a burst of nanites\nthat directly attack its organic cells.\nThe target takes 1 additional point of\ndamage and loses its next action."
      , levelModifier = 0
      , name = "DISRUPTING"
      , rolls = []
      }
    , { description = "Grants the ability to see ten\ntimes as far as normal for one hour."
      , levelModifier = 0
      , name = "EAGLESEYE"
      , rolls = []
      }
    , { description = "Provides a chance for additional\nresistance to directly damaging effects\nof all kinds, such as fire, lightning, and\nthe like for a day. (It does not provide\nresistance to blunt force, slashing, or\npiercing attacks.) If the level of the effect\nis less than or equal to the level of the\ncypher, the user gains an additional\ndefense roll to avoid it. On a successful\ndefense roll, treat the attack as if the user\nhad succeeded on his regular defense roll."
      , levelModifier = 1
      , name = "EFFECT RESISTANCE"
      , rolls = []
      }
    , { description = "The user can apply one level\nof Effort to a noncombat task without\nspending points from a Pool. The level of\nEffort provided by this cypher does not\ncount toward the maximum amount of\nEffort a character can normally apply to\none task."
      , levelModifier = 0
      , name = "EFFORT ENHANCER"
      , rolls = []
      }
    , { description = "For the next hour, the user\ncan apply one level of Effort to any\ntask (including a combat task) without\nspending points from a Pool. The level\nof Effort provided by this cypher does\nnot count toward the maximum amount\nof Effort a character can normally apply\nto one task."
      , levelModifier = 1
      , name = "EFFORT ENHANCER (COMBAT)"
      , rolls = []
      }
    , { description = "For the next day, the user has\nan asset to Speed defense rolls."
      , levelModifier = 4
      , name = "ENDURING SHIELD"
      , rolls = []
      }
    , { description = "The user can rummage around and\nproduce from the cypher a desired piece\nof equipment (not an artifact) whose\nlevel does not exceed the cypher’s\nlevel. The piece of equipment persists\nfor up to twenty-four hours, unless its\nfundamental nature allows only a single\nuse (such as with a grenade)."
      , levelModifier = 1
      , name = "EQUIPMENT CACHE"
      , rolls = []
      }
    , { description = "The user can observe a location he\nhas visited previously, regardless of how\nfar away it is (even across galaxies). Thi"
      , levelModifier = 1
      , name = "FARSIGHT"
      , rolls = []
      }
    , { description = "A nonliving object treated by this cypher\nhas Armor against fire damage equal to the\ncypher’s level for twenty-four hours."
      , levelModifier = 4
      , name = "FIREPROOFING"
      , rolls = []
      }
    , { description = "Creates an immobile plane of permeable\nenergy up to 20 feet by 20 feet (6 m by 6\nm) for one hour. The plane conforms to the\nspace available. Flames passing through\nthe plane are extinguished."
      , levelModifier = 0
      , name = "FLAME-RETARDANT WALL"
      , rolls = []
      }
    , { description = "Creates an immobile cube composed\nof six planes of solid force, each 30 feet\n(9 m) to a side, for one hour. The planes\nconform to the space available."
      , levelModifier = 3
      , name = "FORCE CUBE"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, the\nuser is surrounded by a powerful force\nfield, granting her +2 to Armor."
      , levelModifier = 0
      , name = "FORCE FIELD"
      , rolls = []
      }
    , { description = "Creates an immobile plane of solid\nforce up to 20 feet by 20 feet (6 m by 6\nm) for one hour. The plane conforms to\nthe space available."
      , levelModifier = 3
      , name = "FORCE SCREEN PROJECTOR"
      , rolls = []
      }
    , { description = "Creates a shimmering energy shield\naround the user for one hour, during\nwhich time he gains +3 to Armor (or +4 to\nArmor if the cypher is level 5 or higher)."
      , levelModifier = 3
      , name = "FORCE SHIELD PROJECTOR"
      , rolls = []
      }
    , { description = "Spread across an area up to 10\nfeet (3 m) square, this makes things\nextremely slippery. For one hour, the\ndifficulty of movement tasks in the area\nis increased by three steps."
      , levelModifier = 0
      , name = "FRICTION REDUCER"
      , rolls = []
      }
    , { description = "Creates a wall of supercooled air up\nto 30 feet by 30 feet by 1 foot (9 m by 9 m\nby 30 cm) that inflicts damage equal to\nthe cypher’s level on anything that passes\nthrough it. The wall conforms to the\nspace available. It lasts for ten minutes."
      , levelModifier = 2
      , name = "FRIGID WALL"
      , rolls = []
      }
    , { description = "Thrown a short distance, this\nbursts in a poisonous cloud within an\nimmediate area. The cloud lingers for\n1d6 rounds unless conditions dictate\notherwise."
      , levelModifier = 2
      , name = "GAS BOMB"
      , rolls =
            [ { name = "Effect:"
              , options =
                    [ { effect = "Thick smoke: occludes sight while the cloud lasts.", weight = 10 }
                    , { effect = "Choking gas: living creatures that breathe lose their actions to choking and coughing for a number of rounds equal to the cypher’s level.", weight = 10 }
                    , { effect = "Poison gas: living creatures that breathe suffer damage equal to the cypher’s level.", weight = 30 }
                    , { effect = "Corrosive gas: everything suffers damage equal to the cypher’s level.", weight = 10 }
                    , { effect = "Hallucinogenic gas: living creatures that breathe lose their actions to hallucinations and visions for a number of rounds equal to the cypher’s level.", weight = 5 }
                    , { effect = "Nerve gas: living creatures that breathe suffer Speed damage equal to the cypher’s level.", weight = 5 }
                    , { effect = "Mind-numbing gas: living creatures that breathe suffer Intellect damage equal to the cypher’s level.", weight = 10 }
                    , { effect = "Fear gas: living creatures that breathe and think flee in a random direction in fear (or are paralyzed with fear) for a number of rounds equal to the cypher’s level.", weight = 3 }
                    , { effect = "Amnesia gas: living creatures that breathe and think permanently lose all memory of the last minute.", weight = 1 }
                    , { effect = "Sleep gas: living creatures that breathe fall asleep for a number of rounds equal to the cypher’s level or until awoken by a violent action or an extremely loud noise.", weight = 10 }
                    , { effect = "Rage gas: living creatures that breathe and think make a melee attack on the nearest creature and continue to do so for a number of rounds equal to the cypher’s level.", weight = 4 }
                    ]
              }
            ]
      }
    , { description = "For one hour, the user can float into\nthe air, moving vertically up to a short\ndistance per round (but not horizontally\nwithout taking some other action, such\nas pushing along the ceiling). The user\nmust weigh less than 50 pounds (23 kg)\nper level of the cypher."
      , levelModifier = 3
      , name = "GRAVITY NULLIFIER"
      , rolls = []
      }
    , { description = "If a nonliving object no larger than a\nperson is coated by this cypher, it floats\n1d20 feet in the air permanently and no\nlonger has weight if carried (though it\nneeds to be strapped down)."
      , levelModifier = 2
      , name = "GRAVITY-NULLIFYING APPLICATION"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, each\ntime you strike a solid creature or object,\nyou generate a burst of heat that inflicts\n2 additional points of damage."
      , levelModifier = 0
      , name = "HEAT ATTACK"
      , rolls = []
      }
    , { description = "With long-range movement, this\nintelligent missile tracks and attacks a\nspecified target, which must be within\nsight when selected. If it misses, it\ncontinues to attack one additional time\nper cypher level until it hits. For example,\na level 4 hunter/seeker will attack a\nmaximum of five times. Different\nhunter/seekers have different effects:\n01–50 Inflicts 8 points of damage.\n51–80 Bears a poisoned needle that inflicts 3 points of damage plus poison.\n81–90 Explodes, inflicting 6 points of damage to all within immediate range.\n91–95 Shocks for 4 points of electricity damage, and stuns for one round per cypher level.\n96–00 Covers target in sticky goo that immediately hardens, holding him fast until he breaks free with a Might action (difficulty equal to the cypher’s level + 2)."
      , levelModifier = 0
      , name = "HUNTER/SEEKER"
      , rolls = []
      }
    , { description = "Projects one of the following\nimmobile images in the area described\nfor one hour. The image appears 25\nfeet (8 m) away from the user. Scenes\ninclude movement, sound, and smell."
      , levelModifier = 0
      , name = "IMAGE PROJECTOR"
      , rolls =
            [ { name = "Image:"
              , options =
                    [ { effect = "Terrifying creature of an unknown species, perhaps no longer alive in the world (10-foot [3 m] cube)", weight = 20 }
                    , { effect = "Huge machine that obscures sight (30-foot [9 m] cube)", weight = 20 }
                    , { effect = "Beautiful pastoral scene (50-foot [15 m] cube)", weight = 10 }
                    , { effect = "Food that looks delicious but may not be familiar (10-foot [3 m] cube)", weight = 10 }
                    , { effect = "Solid color that obscures sight (50-foot [15 m] cube)", weight = 20 }
                    , { effect = "Incomprehensible scene that is disorienting and strange (20-foot [6 m] cube)", weight = 20 }
                    ]
              }
            ]
      }
    , { description = "Creates a wall of extreme heat up to\n30 feet by 30 feet by 1 foot (9 m by 9 m\nby 30 cm) that inflicts damage equal\nto the cypher’s level on anything that\npasses through it. The wall conforms\nto the space available. It lasts for ten\nminutes."
      , levelModifier = 2
      , name = "INFERNO WALL"
      , rolls = []
      }
    , { description = "Tiny capsule launches and moves at\ngreat speed, mapping and scanning an\nunknown area. It moves 500 feet (152\nm) per level, scanning an area up to\n50 feet (15 m) per level away from it. It\nidentifies basic layout, creatures, and\nmajor energy sources. Its movement is\nblocked by any physical or energy barrier."
      , levelModifier = 0
      , name = "INFILTRATOR"
      , rolls = []
      }
    , { description = "Over the course of one day, the user\ncan activate the cypher a total number of\ntimes equal to its level. Each time, she\ncan select a living creature within long\nrange and learn the following about it:\nlevel, origin, species, name, and possibly\nother facts (such as an individual’s\ncredit score, home address, phone\nnumber, and related information)."
      , levelModifier = 2
      , name = "INFORMATION SENSOR"
      , rolls = []
      }
    , { description = "Small device expands into a\nhumanoid automaton that is roughly 2\nfeet (60 cm) tall. Its level is equal to the\ncypher’s level, and it can understand the\nverbal commands of the character who\nactivated it. Commanding the servant\nis not an action. It can make attacks or\nperform actions as ordered to the best\nof its abilities, but it cannot speak.\nThe automaton has short-range movement\nbut never goes farther than long range\naway from the character who activated\nit. At the GM’s discretion, the servant\nmight have specialized knowledge, such\nas how to operate a particular device.\nOtherwise, it has no special knowledge.\nIn any case, the servant is not artificially\nintelligent or capable of initiating action.\nIt does only as commanded.\nThe servant operates for one hour per\ncypher level."
      , levelModifier = 0
      , name = "INSTANT SERVANT"
      , rolls = []
      }
    , { description = "With the addition of water and air,\nthis expands into a simple one-room\nstructure with a door and a transparent\nwindow. The structure is 10 feet by 10\nfeet by 20 feet (3 m by 3 m by 6 m). It is\npermanent and immobile once created."
      , levelModifier = 3
      , name = "INSTANT SHELTER"
      , rolls = []
      }
    , { description = "Adds 1 to the user’s Intellect\nEdge for one hour."
      , levelModifier = 2
      , name = "INTELLECT BOOSTER"
      , rolls = []
      }
    , { description = "The difficulty of any task\ninvolving intelligent deduction—such\nas playing chess, inferring a connection\nbetween clues, solving a mathematical\nproblem, finding a bug in computer\ncode, and so on—is decreased by two\nsteps for the user for one hour. In the\nsubsequent hour, the strain increases\nthe difficulty for the same tasks by two\nsteps."
      , levelModifier = 0
      , name = "INTELLIGENCE ENHANCEMENT"
      , rolls = []
      }
    , { description = "For the next twenty-four\nhours, the character has training in a\npredetermined skill. Although the skill\ncould be anything (including something\nspecific to the operation of a particular\ndevice)"
      , levelModifier = 0
      , name = "KNOWLEDGE ENHANCEMENT"
      , rolls =
            [ { name = "Bonus:"
              , options =
                    [ { effect = "Melee attacks", weight = 10 }
                    , { effect = "Ranged attacks", weight = 10 }
                    , { effect = "One type of academic or esoteric lore (biology, history, magic, and so on)", weight = 20 }
                    , { effect = "Repairing (sometimes specific to one device)", weight = 10 }
                    , { effect = "Crafting (usually specific to one thing)", weight = 10 }
                    , { effect = "Persuasion", weight = 10 }
                    , { effect = "Healing", weight = 5 }
                    , { effect = "Speed defense", weight = 5 }
                    , { effect = "Intellect defense", weight = 5 }
                    , { effect = "Swimming", weight = 6 }
                    , { effect = "Riding", weight = 5 }
                    , { effect = "Sneaking", weight = 5 }
                    ]
              }
            ]
      }
    , { description = "Creates a wall of electric bolts up to\n30 feet by 30 feet by 1 foot (9 m by 9 m\nby 30 cm) that inflicts damage equal to\nthe cypher’s level on anything that passes\nthrough it. The wall conforms to the\nspace available. It lasts for ten minutes."
      , levelModifier = 2
      , name = "LIGHTNING WALL"
      , rolls = []
      }
    , { description = "Splits into two pieces; one is affixed\nto a device and the other to a character.\nThe character can then use his mind to\ncontrol the device at long range, bidding\nit to do anything it could do normally.\nThus, a device could be activated\nor deactivated, and a vehicle could\nbe piloted. The control lasts for ten\nminutes, and once the device is chosen,\nit cannot be changed."
      , levelModifier = 2
      , name = "MACHINE CONTROL"
      , rolls = []
      }
    , { description = "The user throws this cypher at a\ntarget within short range, and it drills\ninto the target for one round, inflicting\ndamage equal to the cypher’s level. If\nthe target is made of metal or wearing\nmetal (such as armor), the difficulty of\nthe attack is decreased by one step."
      , levelModifier = 2
      , name = "MAGNETIC ATTACK DRILL"
      , rolls = []
      }
    , { description = "Establishes a connection with one\nmetal object within short range that a\nhuman could hold in one hand. The\nuser can then move or manipulate the\nobject anywhere within short range (each\nmovement or manipulation is an action).\nFor example, he could wield a weapon or\ndrag a helm affixed to a foe’s head to and\nfro. The connection lasts for ten rounds."
      , levelModifier = 2
      , name = "MAGNETIC MASTER"
      , rolls = []
      }
    , { description = "For ten minutes, metal objects\ncannot come within immediate range of\nthe user. Metal items already in the area\nwhen the device is activated are slowly\npushed out."
      , levelModifier = 2
      , name = "MAGNETIC SHIELD"
      , rolls = []
      }
    , { description = "Over the course of one day, the user\ncan activate the cypher a total number\nof times equal to its level. Each time,\nshe can affect an object she can see\nwithin long range that is not too heavy\nfor her to affect physically. The effect\nmust occur over the course of a round\nand could include closing or opening a\ndoor, keying in a number on a keypad,\ntransferring an object a short distance,\nwresting an object from another\ncreature’s grasp (on a successful Might-\nbased roll), or pushing a creature an\nimmediate distance."
      , levelModifier = 2
      , name = "MANIPULATION BEAM"
      , rolls = []
      }
    , { description = "The user can target one nonliving\nobject within long range that is her\nsize or smaller and whose level is less\nthan or equal to the cypher’s level. The\nobject is transferred directly to a random\nlocation at least 100 miles (161 km)\naway. If the GM feels it appropriate to\nthe circumstances, only a portion of an\nobject is transferred (a portion whose\nvolume is no more than the user’s)."
      , levelModifier = 3
      , name = "MATTER TRANSFERENCE RAY"
      , rolls = []
      }
    , { description = "Restores a number of points\nequal to the cypher’s level to the user’s\nIntellect Pool."
      , levelModifier = 2
      , name = "MEDITATION AID"
      , rolls = []
      }
    , { description = "The user selects a point within long\nrange, and the minds of all thinking\ncreatures within immediate range of that\npoint are attacked. Victims are dazed\nand take no action for a round, and they\nhave no memory of the preceding hour."
      , levelModifier = 2
      , name = "MEMORY SWITCH"
      , rolls = []
      }
    , { description = "Two rounds after being activated,\nthe device creates an invisible field that\nfills an area within short range and lasts\nfor one minute. The field scrambles\nthe mental processes of all thinking\ncreatures. The effect lasts as long as they\nremain in the field and for 1d6 rounds\nafter, although an Intellect defense roll is\nallowed each round to act normally (both\nin the field and after leaving it). Each\nmental scrambler is keyed to a specific\neffect."
      , levelModifier = 2
      , name = "MENTAL SCRAMBLER"
      , rolls =
            [ { name = "Effect:"
              , options =
                    [ { effect = "Victims cannot act.", weight = 30 }
                    , { effect = "Victims cannot speak.", weight = 10 }
                    , { effect = "Victims move slowly (immediate range) and clumsily.", weight = 10 }
                    , { effect = "Victims cannot see or hear.", weight = 10 }
                    , { effect = "Victims lose all sense of direction, depth, and proportion.", weight = 10 }
                    , { effect = "Victims do not recognize anyone they know.", weight = 10 }
                    , { effect = "Victims suffer partial amnesia.", weight = 8 }
                    , { effect = "Victims suffer total amnesia.", weight = 6 }
                    , { effect = "Victims lose all inhibitions, revealing secrets and performing surprising actions.", weight = 4 }
                    , { effect = "Victims’ ethics are inverted.", weight = 2 }
                    ]
              }
            ]
      }
    , { description = "Produces a stream of foam that\ncovers an area about 3 feet by 3 feet (1\nm by 1 m), transforming any metal that\nit touches into a substance as brittle as\nthin glass. The foam affects metal to a\ndepth of about 6 inches (15 cm)."
      , levelModifier = 2
      , name = "METAL DEATH"
      , rolls = []
      }
    , { description = "Lets the user speak telepathically\nwith creatures he can see within short\nrange for up to one hour. The user can’t\nread a target’s thoughts, except those\nthat are specifically “transmitted.” This\neffect transcends normal language\nbarriers, but a target must have a mind\nthat allows for such communication to\nbe possible."
      , levelModifier = 1
      , name = "MIND MELD"
      , rolls = []
      }
    , { description = "Creates an immobile plane of\npermeable energy up to 20 feet by 20\nfeet (6 m by 6 m) for one hour. The\nplane conforms to the space available.\nIntelligent creatures passing through the\nplane fall unconscious for up to one hour,\nor until slapped awake or damaged."
      , levelModifier = 2
      , name = "MIND-RESTRICTING WALL"
      , rolls = []
      }
    , { description = "The user gains +5 to Armor\nagainst Intellect damage."
      , levelModifier = 0
      , name = "MIND STABILIZER"
      , rolls = []
      }
    , { description = "Produces a 6-inch (15 cm) blade\nthat’s the same level as the cypher. The\nblade cuts through any material of a\nlevel lower than its own. If used as a\nweapon, it is a light weapon that ignores\nArmor of a level lower than its own. The\nblade lasts for ten minutes."
      , levelModifier = 2
      , name = "MONOBLADE"
      , rolls = []
      }
    , { description = "The user gains a horn in the center\nof his forehead. The horn is deadly\nsharp and strong, and it spirals down\nto a solid base where it fuses with his\nflesh and bone. The user is specialized\nin making melee attacks with the horn,\nwhich is considered a medium weapon.\nThe horn lasts for a number of hours\nequal to the cypher’s level."
      , levelModifier = 3
      , name = "MONOHORN"
      , rolls = []
      }
    , { description = "For one hour, this cypher\nindicates when any movement occurs\nwithin short range, and when large\ncreatures or objects move within long\nrange (the cypher distinguishes between\nthe two). It also indicates the number\nand size of the creatures or objects in\nmotion."
      , levelModifier = 2
      , name = "MOTION SENSOR"
      , rolls = []
      }
    , { description = "The user and all creatures within\nimmediate range gain +5 to Armor\nagainst damage of a specified kind for\none hour."
      , levelModifier = 3
      , name = "NULL FIELD"
      , rolls =
            [ { name = "Effect:"
              , options =
                    [ { effect = "Fire", weight = 12 }
                    , { effect = "Cold", weight = 15 }
                    , { effect = "Acid", weight = 12 }
                    , { effect = "Psychic", weight = 13 }
                    , { effect = "Sonic", weight = 13 }
                    , { effect = "Electrical", weight = 7 }
                    , { effect = "Poison", weight = 12 }
                    , { effect = "Blunt force", weight = 11 }
                    , { effect = "Slashing and piercing", weight = 5 }
                    ]
              }
            ]
      }
    , { description = "The user can immediately end one\nongoing effect within long range that\nis produced by an artifact, cypher, or\nspecial ability."
      , levelModifier = 3
      , name = "NULLIFICATION RAY"
      , rolls = []
      }
    , { description = "The user can go without food\nand water for a number of days equal to\nthe cypher’s level without ill effect."
      , levelModifier = 1
      , name = "NUTRITION AND HYDRATION"
      , rolls = []
      }
    , { description = "Allows the user to mentally\nrecord everything she sees for thirty\nseconds and store the recording\npermanently in her long-term memory.\nThis cypher is useful for watching\nsomeone pick a specific lock, enter a\ncomplex code, or do something else that\nhappens quickly."
      , levelModifier = 0
      , name = "PERFECT MEMORY"
      , rolls = []
      }
    , { description = "Creates an aura of temperature and\natmosphere that will sustain a human\nsafely for twenty-four hours. The aura\nextends to 1 foot (30 cm) around the user. It\ndoes not protect against sudden flashes of\ntemperature change (such as from a heat\nray). A small number of these cyphers (1%)\naccommodate the preferred environment\nof a nonhuman, nonterrestrial creature."
      , levelModifier = 2
      , name = "PERSONAL ENVIRONMENT FIELD"
      , rolls = []
      }
    , { description = "Puts the user out of phase for one\nminute. During this time, she can pass\nthrough solid objects as though she\nwere entirely insubstantial, like a ghost.\nShe cannot make physical attacks or be\nphysically attacked."
      , levelModifier = 1
      , name = "PHASE CHANGER"
      , rolls = []
      }
    , { description = "Puts a portion of a physical structure\n(like a wall or floor) out of phase for\none hour. It affects an area equal to a\n10-foot (3 m) cube. While the area is\nout of phase, creatures and objects can\npass through it as if it were not there,\nalthough one cannot see through it, and\nit blocks light."
      , levelModifier = 2
      , name = "PHASE DISRUPTOR"
      , rolls = []
      }
    , { description = "The victim feels a specific emotion\nfor one hour."
      , levelModifier = 2
      , name = "POISON (EMOTION)"
      , rolls =
            [ { name = "Effect:"
              , options =
                    [ { effect = "Anger. Likely to attack anyone who disagrees with him. Very hard to interact with; the difficulty of all such actions is increased by two steps.", weight = 20 }
                    , { effect = "Fear. Flees in terror for one minute when threatened.", weight = 20 }
                    , { effect = "Lust. Cannot focus on any nonsexual activity.", weight = 20 }
                    , { effect = "Sadness. The difficulty of all tasks is increased by one step.", weight = 15 }
                    , { effect = "Complacency. Has no motivation. The difficulty of all tasks is increased by two steps.", weight = 10 }
                    , { effect = "Joy. Easy to interact with in a pleasant manner; the difficulty of all such actions is decreased by one step.", weight = 10 }
                    , { effect = "Love. Much easier to interact with; the difficulty of all such actions is decreased by two steps, but temporary attachment is likely.", weight = 5 }
                    ]
              }
            ]
      }
    , { description = "Once this substance enters the\nbloodstream, it travels to the brain\nand reorganizes into an explosive that\ndetonates when activated, inflicting 10\npoints of damage (ignoring Armor)."
      , levelModifier = 1
      , name = "POISON (EXPLOSIVE)"
      , rolls =
            [ { name = "Means of detonation:"
              , options =
                    [ { effect = "The detonator is activated (must be within long range).", weight = 25 }
                    , { effect = "A specified amount of time passes.", weight = 15 }
                    , { effect = "The victim takes a specific action.", weight = 10 }
                    , { effect = "A specific note is sung or played on an instrument within short range.", weight = 5 }
                    , { effect = "The victim smells a specific scent within immediate range.", weight = 5 }
                    , { effect = "The victim comes within long range of the detonator.", weight = 20 }
                    , { effect = "The victim is no longer within long range of the detonator.", weight = 20 }
                    ]
              }
            ]
      }
    , { description = "The victim must carry out a specific\naction in response to a specific trigger."
      , levelModifier = 2
      , name = "POISON (MIND CONTROLLING)"
      , rolls =
            [ { name = "Effect:"
              , options =
                    [ { effect = "Lies down for one minute with eyes closed when told to do so.", weight = 20 }
                    , { effect = "Flees in terror for one minute when threatened.", weight = 20 }
                    , { effect = "Answers questions truthfully for one minute.", weight = 1 }
                    , { effect = "Attacks close friend for one round when within immediate range.", weight = 1 }
                    , { effect = "Obeys next verbal command given (if it is understood).", weight = 10 }
                    , { effect = "For twenty-four hours, becomes sexually attracted to the next creature of its own species that it sees.", weight = 10 }
                    , { effect = "Moves toward the next red object seen in lieu of all other actions, ignoring self- preservation.", weight = 5 }
                    ]
              }
            ]
      }
    , { description = "The victim suffers Intellect damage\nequal to the cypher’s level and cannot\ntake actions for a number of rounds\nequal to the cypher’s level."
      , levelModifier = 2
      , name = "POISON (MIND DISRUPTING)"
      , rolls = []
      }
    , { description = "Allows the user to project a one-time,\none-way telepathic message of up to\nten words, with an unlimited range, to\nanyone he knows."
      , levelModifier = 2
      , name = "PSYCHIC COMMUNIQUE"
      , rolls = []
      }
    , { description = "Delivers a powerful burst of radiation\nthat disrupts the tissue of any creature\ntouched, inflicting damage equal to the\ncypher’s level."
      , levelModifier = 4
      , name = "RADIATION SPIKE"
      , rolls = []
      }
    , { description = "Allows the user to project a ray of\ndestructive energy up to 200 feet (61 m)\nthat inflicts damage equal to the cypher’s\nlevel."
      , levelModifier = 2
      , name = "RAY EMITTER"
      , rolls =
            [ { name = "Type of damage:"
              , options =
                    [ { effect = "Heat/concentrated light", weight = 50 }
                    , { effect = "Cell-disrupting radiation", weight = 10 }
                    , { effect = "Force", weight = 20 }
                    , { effect = "Magnetic wave", weight = 7 }
                    , { effect = "Molecular bond disruption", weight = 6 }
                    , { effect = "Concentrated cold", weight = 7 }
                    ]
              }
            ]
      }
    , { description = "Allows the user to project a ray up to\n200 feet (61 m) that forces a target to\nobey the next verbal command given (if\nit is understood)."
      , levelModifier = 2
      , name = "RAY EMITTER (COMMAND)"
      , rolls = []
      }
    , { description = "Allows the user to project a ray up to\n200 feet (61 m) that causes the target to\nflee in terror for one minute."
      , levelModifier = 2
      , name = "RAY EMITTER (FEAR)"
      , rolls = []
      }
    , { description = "Allows the user to project a ray up to\n200 feet (61 m) that causes the target to\nattack its nearest ally for one round."
      , levelModifier = 2
      , name = "RAY EMITTER (FRIEND SLAYING)"
      , rolls = []
      }
    , { description = "Allows the user to project a ray of\ndestructive energy up to 200 feet (61\nm) that inflicts Intellect damage equal\nto the cypher’s level. Also, the victim\ncannot take actions for a number of\nrounds equal to the cypher’s level."
      , levelModifier = 2
      , name = "RAY EMITTER (MIND DISRUPTING)"
      , rolls = []
      }
    , { description = "Allows the user to project a ray of\nenergy up to 200 feet (61 m) that numbs\none limb of the target, making it useless\nfor one minute. A small number of these\ndevices (5%) induce numbness that\nlasts for one hour."
      , levelModifier = 2
      , name = "RAY EMITTER (NUMBING)"
      , rolls = []
      }
    , { description = "Allows the user to project a ray\nof energy up to 200 feet (61 m) that\nparalyzes the target for one minute. A\nsmall number of these devices (5%)\ninduce paralysis that lasts for one hour."
      , levelModifier = 2
      , name = "RAY EMITTER (PARALYSIS)"
      , rolls = []
      }
    , { description = "Once activated, the cypher does not\nmove—ever—even if activated in midair.\nA Might action will dislodge it, but then\nit is ruined."
      , levelModifier = 4
      , name = "REALITY SPIKE"
      , rolls = []
      }
    , { description = "The difficulty of any task\ninvolving manual dexterity—such as\npickpocketing, lockpicking, juggling,\noperating on a patient, defusing a\nbomb, and so on—is decreased by two\nsteps for one hour."
      , levelModifier = 0
      , name = "REFLEX ENHANCER"
      , rolls = []
      }
    , { description = "Restores a number of points\nequal to the cypher’s level to one\nrandom stat Pool."
      , levelModifier = 2
      , name = "REJUVENATOR"
      , rolls =
            [ { name = "Pool:"
              , options =
                    [ { effect = "Might Pool", weight = 50 }
                    , { effect = "Speed Pool", weight = 25 }
                    , { effect = "Intellect Pool", weight = 25 }
                    ]
              }
            ]
      }
    , { description = "Allows the user to recall any\none experience she’s ever had. The\nexperience can be no longer than one\nminute, but the recall is perfect, so (for\nexample) if she saw someone dial a\nphone, she will remember the number."
      , levelModifier = 0
      , name = "REMEMBERING"
      , rolls = []
      }
    , { description = "For one hour, the user can see\neverything going on in the vicinity of\nthe cypher, regardless of the distance\nbetween them."
      , levelModifier = 0
      , name = "REMOTE VIEWER"
      , rolls = []
      }
    , { description = "The cypher becomes a multiarmed\nsphere that floats. It repairs one\ndesignated item (of a level equal to or\nless than its own) that has been damaged\nbut not destroyed. The repair unit can\nalso create spare parts, unless the GM\nrules that the parts are too specialized or\nrare (in which case, the unit repairs the\ndevice except for the specialized part).\nRepair time is 1d100 + 20 minutes."
      , levelModifier = 0
      , name = "REPAIR UNIT"
      , rolls = []
      }
    , { description = "For the next minute, the user’s\nranged weapon fires one additional time\nwith ammo fabricated by the cypher. The\nweapon wielder can aim the free shot at\nthe same target as the initiating shot, or\nat a target next to the first one."
      , levelModifier = 1
      , name = "REPEATER"
      , rolls = []
      }
    , { description = "For the next twenty-four hours,\nanyone striking the user receives a small\nburst of electricity that inflicts 1 point of\ndamage (no action or roll required)."
      , levelModifier = 0
      , name = "RETALIATION"
      , rolls = []
      }
    , { description = "The user can ask the GM one\nquestion and get a general answer. The\nGM assigns a level to the question, so\nthe more obscure the answer, the more\ndifficult the task. Generally, knowledge that\na PC could find by looking somewhere\nother than his current location is level 1,\nand obscure knowledge of the past is level\n7. Gaining knowledge of the future is level\n10, and such knowledge is always open to\ninterpretation."
      , levelModifier = 0
      , name = "SECRET"
      , rolls = []
      }
    , { description = "For one week, the user’s cells are coated\nwith a protective veneer that resists damage\n(+1 to Armor) and decreases the difficulty of\nMight defense rolls by two steps. However,\nhealing is more difficult during this time; all\nrecovery rolls suffer a –1 penalty."
      , levelModifier = 0
      , name = "SHEEN"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, each\ntime the user strikes a solid creature\nor object, the user generates a burst of\nelectricity, inflicting 1 additional point of\ndamage."
      , levelModifier = 0
      , name = "SHOCK ATTACK"
      , rolls = []
      }
    , { description = "Delivers a powerful burst of\nelectricity that shocks any creature\ntouched, inflicting damage equal to the\ncypher’s level."
      , levelModifier = 4
      , name = "SHOCKER"
      , rolls = []
      }
    , { description = "Dramatically but temporarily\nalters the user’s mind and body so she\ncan perform one specific physical action\nwith the difficulty decreased by three\nsteps. Once activated, this boost can\nbe used a number of times equal to the\ncypher’s level, but only within a twenty-\nfour-hour period. The boost takes effect\neach time the action is performed. For\nexample, a level 3 cypher boosts the first\nthree times that action is attempted. The\naction can be one of many possibilities."
      , levelModifier = 0
      , name = "SKILL BOOST"
      , rolls =
            [ { name = "Skill:"
              , options =
                    [ { effect = "Melee attack", weight = 15 }
                    , { effect = "Ranged attack", weight = 15 }
                    , { effect = "Speed defense", weight = 10 }
                    , { effect = "Might defense", weight = 10 }
                    , { effect = "Intellect defense", weight = 10 }
                    , { effect = "Jumping", weight = 8 }
                    , { effect = "Climbing", weight = 8 }
                    , { effect = "Running", weight = 8 }
                    , { effect = "Swimming", weight = 8 }
                    , { effect = "Sneaking", weight = 2 }
                    , { effect = "Balancing", weight = 2 }
                    , { effect = "Perceiving", weight = 2 }
                    , { effect = "Carrying", weight = 1 }
                    , { effect = "Escaping", weight = 1 }
                    ]
              }
            ]
      }
    , { description = "To activate the cypher, the user must\nsucceed on a melee attack against a\ncreature about the size of the user and\nwhose level does not exceed the cypher’s\nlevel. The cypher bonds to the target,\nwho immediately becomes calm. The\ntarget awaits the user’s commands and\ncarries out all orders to the best of its\nability. The target remains so enslaved\nfor a number of hours equal to the\ncypher’s level minus the target’s level.\n(If the result is 0, the target remains\nenslaved for one minute.)"
      , levelModifier = 2
      , name = "SLAVE MAKER"
      , rolls = []
      }
    , { description = "Touch puts the victim to sleep for\nten minutes or until awoken by a violent\naction or an extremely loud noise."
      , levelModifier = 0
      , name = "SLEEP INDUCER"
      , rolls = []
      }
    , { description = "For the next hour, the effective range\nof the user’s ranged weapon increases\nto 2 miles (3 km)."
      , levelModifier = 0
      , name = "SNIPER MODULE"
      , rolls = []
      }
    , { description = "Dissolves 1 cubic foot of material\neach round. After one round per cypher\nlevel, the cypher becomes inert."
      , levelModifier = 0
      , name = "SOLVENT"
      , rolls = []
      }
    , { description = "Draws all sound within long range\ninto the device for one round per cypher\nlevel. Within the affected area, no sound\ncan be heard."
      , levelModifier = 2
      , name = "SONIC HOLE"
      , rolls = []
      }
    , { description = "Dampens all sound within\nimmediate range, providing an asset\nfor all creatures in the area to attempt\nstealth actions."
      , levelModifier = 2
      , name = "SOUND DAMPENER"
      , rolls = []
      }
    , { description = "When affixed to a device that affects\na single target at range, that range\nis increased to 1 mile (2 km) with no\npenalties. Space is temporarily warped\nin terms of seeing and reaching the\ntarget. If direct line of sight is important\nto the device’s effect, it remains\nimportant."
      , levelModifier = 4
      , name = "SPATIAL WARP"
      , rolls = []
      }
    , { description = "Adds 1 to Speed Edge for one\nhour."
      , levelModifier = 2
      , name = "SPEED BOOST"
      , rolls = []
      }
    , { description = "Produces a tiny spying object that\nresists detection as a level 8 creature.\nThe object moves at great speed,\nmapping and scanning an unknown\narea. It moves 500 feet (152 m) per level,\nscanning an area up to 50 feet (15 m)\naway from it. It identifies basic layout,\ncreatures, and major energy sources. Its\nmovement is blocked by any physical or\nenergy barrier. At the end of its mapping\nrun, it returns to the user and reports. If\nit discovers a predefined target during\nits run (such as “a creature of level 5\nor higher,” “a locked door,” “a major\nenergy source,” and so on), it detonates\ninstead, dealing electrical and shrapnel\ndamage equal to the cypher’s level to all\ncreatures and objects in short range."
      , levelModifier = 2
      , name = "SPY"
      , rolls = []
      }
    , { description = "Puts a subject into stasis for a\nnumber of days equal to the cypher’s\nlevel, or until it is violently disturbed. An\nobject in stasis does not age and comes\nout of the stasis alive and in the same\ncondition as it went in, with no memory\nof the period of inactivity."
      , levelModifier = 0
      , name = "STASIS KEEPER"
      , rolls = []
      }
    , { description = "Decreases the difficulty of the\nnext action taken by three steps."
      , levelModifier = 0
      , name = "STIM"
      , rolls = []
      }
    , { description = "Adds 1 to Might Edge for one\nhour."
      , levelModifier = 2
      , name = "STRENGTH BOOST"
      , rolls = []
      }
    , { description = "The difficulty of any\nnoncombat task involving raw\nstrength—such as breaking down a\ndoor, lifting a heavy boulder, forcing\nopen elevator doors, competing in a\nweightlifting competition, and so on—is\ndecreased by two steps for one hour."
      , levelModifier = 0
      , name = "STRENGTH ENHANCER"
      , rolls = []
      }
    , { description = "Two rounds after being activated,\nthe device creates an invisible field that\nfills a specified area (such as a cube of a\ncertain size) within long range. The field\nlasts for one minute. It affects the minds\nof thinking beings within the field,\npreventing them from taking hostile\nactions. The effect lasts as long as they\nremain in the field and for 1d6 rounds\nafter, although an Intellect defense roll\nis allowed each round to act normally\n(both in the field and after leaving it)."
      , levelModifier = 3
      , name = "SUBDUAL FIELD"
      , rolls = []
      }
    , { description = "For one hour, the device enables\nlong-range mental communication with\nanyone the user can see."
      , levelModifier = 2
      , name = "TELEPATHY"
      , rolls = []
      }
    , { description = "User teleports up to 100 × the cypher\nlevel in feet to a location he can see. He\narrives safely with his possessions but\ncannot take anything else with him."
      , levelModifier = 2
      , name = "TELEPORTER (BOUNDER)"
      , rolls = []
      }
    , { description = "User teleports anywhere in the galaxy\nto a location he has previously visited\nor seen. He arrives safely with his\npossessions but cannot take anything\nelse with him."
      , levelModifier = 4
      , name = "TELEPORTER (INTERSTELLAR)"
      , rolls = []
      }
    , { description = "User teleports anywhere on the\nplanet to a location he has previously\nvisited or seen. He arrives safely with his\npossessions but cannot take anything\nelse with him."
      , levelModifier = 4
      , name = "TELEPORTER (PLANETARY)"
      , rolls = []
      }
    , { description = "User teleports up to 100 × the cypher\nlevel in miles to a location he has\npreviously visited or seen. He arrives\nsafely with his possessions but cannot\ntake anything else with him."
      , levelModifier = 4
      , name = "TELEPORTER (TRAVELER)"
      , rolls = []
      }
    , { description = "Displays moving images and sound,\nup to ten minutes in length, depicting\nevents that occurred at the current\nlocation up to one year prior. The user\nspecifies the time period shown by the\nviewer."
      , levelModifier = 4
      , name = "TEMPORAL VIEWER"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, when\nthe user is attacked, she moves in rapid,\nseemingly random jumps, a few inches\nto one side or the other. This is an asset\nthat modifies attacks by two steps in her\nfavor."
      , levelModifier = 0
      , name = "TIME DILATION (DEFENSIVE)"
      , rolls = []
      }
    , { description = "For the next twenty-four hours, when\nthe user makes a melee attack, she\nmoves at almost instantaneous speed,\nmodifying her attacks by two steps in\nher favor."
      , levelModifier = 0
      , name = "TIME DILATION (OFFENSIVE)"
      , rolls = []
      }
    , { description = "For the next hour, the user\nregains 1 point lost to damage per\nround, up to a total number of points\nequal to twice the cypher’s level. As each\npoint is regained, he chooses which\nPool to add it to. If all his Pools are at\nmaximum, the regeneration pauses until\nhe takes more damage, at which point it\nbegins again (if any time remains in the\nhour) until the duration expires."
      , levelModifier = 4
      , name = "TISSUE REGENERATION"
      , rolls = []
      }
    , { description = "Fires a microscopic tracer that clings\nto any surface within short range. For\nthe next twenty-four hours, the launcher\nshows the distance and direction to\nthe tracer, as long as it is in the same\ndimension."
      , levelModifier = 0
      , name = "TRACER"
      , rolls = []
      }
    , { description = "A nonintelligent animal immediately\nand perfectly learns one trick it is\ncapable of physically performing\n(roll over, heel, spin, shake, go to an\nindicated place within long range, and\nso on). The trick must be designated\nwhen the cypher is activated."
      , levelModifier = 0
      , name = "TRICK EMBEDDER"
      , rolls = []
      }
    , { description = "Provides power appropriate to\nanother device for up to a day. The\ndevice to be powered can be as simple\nas a light source or as complex as a\nsmall starcraft, assuming the cypher’s\nlevel is equal to the item’s power\nrequirements. A desk lamp is a level\n1 power requirement, a car engine is\na level 5 power requirement, and a\nstarship is a level 10 power requirement."
      , levelModifier = 4
      , name = "UNINTERRUPTIBLE POWER SOURCE"
      , rolls = []
      }
    , { description = "The user becomes invisible for\nten minutes, during which time she\nis specialized in stealth and Speed\ndefense tasks. This effect ends if she\ndoes something to reveal her presence\nor position—attacking, using an ability,\nmoving a large object, and so on. If this\noccurs, she can regain the remaining\ninvisibility effect by taking an action to\nfocus on hiding her position."
      , levelModifier = 2
      , name = "VANISHER"
      , rolls = []
      }
    , { description = "Changes the appearance of one\nhuman-sized creature. The change\ntakes ten minutes to apply and lasts for\ntwenty-four hours."
      , levelModifier = 0
      , name = "VISAGE CHANGER"
      , rolls = []
      }
    , { description = "Projects holographic images of the\nuser to confuse attackers. The images\nappear around the user, giving him an\nasset to Speed defense actions for ten\nminutes."
      , levelModifier = 0
      , name = "VISUAL DISPLACEMENT"
      , rolls = []
      }
    , { description = "For twenty-four hours, translates\neverything said by the user into a\nlanguage that anyone can understand."
      , levelModifier = 0
      , name = "VOCAL TRANSLATOR"
      , rolls = []
      }
    , { description = "Keeps the user warm and\ncomfortable, even in the harshest cold\ntemperatures, for twenty-four hours.\nDuring this time, the user has Armor\nequal to the cypher’s level that protects\nagainst cold damage."
      , levelModifier = 0
      , name = "WARMTH"
      , rolls = []
      }
    , { description = "The user can breathe underwater and\noperate at any depth (without facing\ndebilitating consequences of changing\npressure) for eight hours."
      , levelModifier = 0
      , name = "WATER ADAPTER"
      , rolls = []
      }
    , { description = "Modifies a weapon’s attack in a\nparticular fashion for one hour. Roll a"
      , levelModifier = 2
      , name = "WEAPON ENHANCEMENT"
      , rolls =
            [ { name = "Effect:"
              , options =
                    [ { effect = "Decreases difficulty of attack by one step", weight = 10 }
                    , { effect = "Deals bonus electrical damage equal to cypher level", weight = 10 }
                    , { effect = "Deals bonus cold damage equal to cypher level", weight = 10 }
                    , { effect = "Deals bonus poison damage equal to cypher level", weight = 10 }
                    , { effect = "Deals bonus acid damage equal to cypher level", weight = 10 }
                    , { effect = "Deals bonus fire damage equal to cypher level", weight = 10 }
                    , { effect = "Deals bonus sonic damage equal to cypher level", weight = 10 }
                    , { effect = "Deals bonus psychic damage equal to cypher level", weight = 10 }
                    , { effect = "Knockback (on 18–20 on successful attack roll, target knocked back 30 feet [9 m])", weight = 10 }
                    , { effect = "Holding (on 18–20 on successful attack roll, target can’t act on its next turn)", weight = 5 }
                    , { effect = "Decreases difficulty of attack by two steps", weight = 2 }
                    , { effect = "Banishing (on 18–20 on successful attack roll, target is sent to random location at least 100 miles [161 km] away)", weight = 1 }
                    , { effect = "Explodes, inflicting damage equal to cypher level to all within immediate range", weight = 1 }
                    , { effect = "Heart-seeking (on 18–20 on successful attack roll, target is killed)", weight = 1 }
                    ]
              }
            ]
      }
    , { description = "User can fly at her normal running\nspeed for one hour."
      , levelModifier = 2
      , name = "WINGS"
      , rolls = []
      }
    , { description = "Allows the user to see through up to\n2 feet (60 cm) of material, if the cypher’s\nlevel is higher than the material’s level.\nThe effect lasts for one minute."
      , levelModifier = 4
      , name = "X-RAY VIEWER"
      , rolls = []
      }
    , { description = "Renders an inanimate object outside\nthe effects of most energy for one\nminute. This means the object cannot be\nharmed, moved, or manipulated in any\nway. It remains in place (even in midair)."
      , levelModifier = 3
      , name = "ZERO POINT FIELD"
      , rolls = []
      }
    , { description = "If you use an ability that affects a\nsingle target, this cypher expands the\neffect so it includes the immediate\narea around that target. If the power\nnormally affects an immediate area,\nthe area becomes short. Short areas\nare increased to long. Abilities with\nlong-distance areas become 500-foot\n(152 m) areas. All other areas double\nin radius size."
      , levelModifier = 1
      , name = "AREA BOOST"
      , rolls = []
      }
    , { description = "If you use an ability that affects a\nsingle target at short range or farther,\nthe range drops to immediate, but\nthe ability affects all targets within\nimmediate range."
      , levelModifier = 2
      , name = "BURST BOOST"
      , rolls = []
      }
    , { description = "If you use an ability that inflicts\ndamage, it inflicts additional damage\nequal to this cypher’s level."
      , levelModifier = 2
      , name = "DAMAGE BOOST"
      , rolls = []
      }
    , { description = "The difficulty of using one of your\nabilities is reduced by one step."
      , levelModifier = 0
      , name = "EFFICACY BOOST"
      , rolls = []
      }
    , { description = "If you use an ability that has a stat\nPool cost, the cost is reduced to 0."
      , levelModifier = 0
      , name = "ENERGY BOOST"
      , rolls = []
      }
    , { description = "The difficulty of using one of your\nabilities is reduced by a number of\nsteps equal to this cypher’s level."
      , levelModifier = 1
      , name = "MAJOR EFFICACY BOOST"
      , rolls = []
      }
    , { description = "The range of one of your abilities\nincreases. Something that affects\nonly you can now affect someone\nyou touch. Abilities requiring touch\ncan affect anyone within immediate\nrange. An ability with immediate range\nbecomes one with short range. Short-\nrange powers become long range.\nLong-range powers increase to 500\nfeet (152 m). All other ranges double."
      , levelModifier = 1
      , name = "RANGE BOOST"
      , rolls = []
      }
    , { description = "If you use an ability that affects\na target at range, you can affect an\nadditional target within the same\nrange."
      , levelModifier = 2
      , name = "TARGET BOOST"
      , rolls = []
      }
    ]
