# CCCG
CMPM 121

Patterns used:

State: used for different states that cards can be in
Prototype: used for different card types
Subclass Sandbox: used for different card powers

Postmortem:
I think that this issues in this code come less from not using different patterns but instead from the general code structure. 
There's quite a bit of magic numbers and similar issues, so I would probably clean that up. I do think that I could have
made better use of the subclass sandbox, though. Since a lot of the card powers are just simple for loops I decided not to use
the pattern for those ones, but I think it probably would have been better to use them.

Credit:
Used some code from lecture for the deck shuffling and a little bit of grabber.lua.