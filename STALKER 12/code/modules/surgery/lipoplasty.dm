/datum/surgery/lipoplasty
	name = "lipoplasty"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/cut_fat, /datum/surgery_step/remove_fat, /datum/surgery_step/close)
	possible_locs = list("chest")

/datum/surgery/lipoplasty/can_start(mob/user, mob/living/carbon/target)
	if(target.disabilities & FAT)
		return 1
	return 0


//cut fat
/datum/surgery_step/cut_fat
	name = "cut excess fat"
	implements = list(/obj/item/weapon/circular_saw = 100, /obj/item/weapon/melee/energy/sword/cyborg/saw = 100, /obj/item/weapon/kitchen/knife/hatchet = 35, /obj/item/weapon/kitchen/knife/butcher = 25)
	time = 64

/datum/surgery_step/cut_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] begins to cut away [target]'s excess fat.", "<span class='notice'>You begin to cut away [target]'s excess fat...</span>")

/datum/surgery_step/cut_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] cuts [target]'s excess fat loose!", "<span class='notice'>You cut [target]'s excess fat loose.</span>")
	return 1

//remove fat
/datum/surgery_step/remove_fat
	name = "remove loose fat"
	implements = list(/obj/item/weapon/retractor = 100, /obj/item/weapon/screwdriver = 45, /obj/item/weapon/wirecutters = 35)
	time = 32

/datum/surgery_step/remove_fat/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] begins to extract [target]'s loose fat!", "<span class='notice'>You begin to extract [target]'s loose fat...</span>")

/datum/surgery_step/remove_fat/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] extracts [target]'s fat!", "<span class='notice'>You extract [target]'s fat.</span>")
	target.overeatduration = 0 //patient is unfatted
	var/removednutriment = target.nutrition
	target.nutrition = NUTRITION_LEVEL_WELL_FED
	removednutriment -= 450 //whatever was removed goes into the meat
	var/obj/item/weapon/reagent_containers/food/snacks/meat/slab/human/newmeat = new
	newmeat.name = "fatty meat"
	newmeat.desc = "Extremely fatty tissue taken from a patient."
	newmeat.reagents.add_reagent ("nutriment", (removednutriment / 15)) //To balance with nutriment_factor of nutriment
	var/obj/item/meatslab = newmeat
	meatslab.loc = target.loc
	return 1