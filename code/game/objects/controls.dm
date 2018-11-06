/obj/structure/gatecontrol
	name = "gate control"
	desc = "Controls nearby gates."
	icon = 'icons/obj/structures.dmi'
	icon_state = "gate_control"
	anchored = TRUE
	var/open = TRUE
	var/cooldown = 0
	density = TRUE

/obj/structure/gatecontrol/attack_hand(var/mob/user as mob)
	if (cooldown <= world.time - 60)
		if (open)
			visible_message("[user] closes the gates!")
			open = FALSE
			cooldown = world.time
			for (var/obj/structure/gate/G in range(6,src.loc))
				playsound(loc, 'sound/effects/castle_gate.ogg', 100)
				G.icon_state = "gate_closing"
				spawn(30)
					G.icon_state = "gate0"
					G.density = TRUE
			return
		else
			visible_message("[user] opens the gates!")
			open = TRUE
			cooldown = world.time
			for (var/obj/structure/gate/G in range(6,src.loc))
				playsound(loc, 'sound/effects/castle_gate.ogg', 100)
				spawn(30)
					G.icon_state = "gate1"
					G.density = FALSE
			return

/obj/structure/gate
	name = "gate"
	desc = "An iron gate."
	icon = 'icons/obj/doors/material_doors.dmi'
	icon_state = "gate0"
	anchored = TRUE
	density = TRUE
	var/health = 600
	var/maxhealth = 600

/obj/structure/gate/open
	name = "gate"
	desc = "An iron gate."
	icon = 'icons/obj/doors/material_doors.dmi'
	icon_state = "gate1"
	anchored = TRUE
	density = FALSE

/obj/structure/gate/ex_act(severity)
	switch(severity)
		if (1.0)
			health -= 150
		if (2.0)
			health -= 100
		if (3.0)
			health -= 50
	if (health <= 0)
		visible_message("<span class='danger'>\The [src] is blown apart!</span>")
		qdel(src)
		return
