/obj/item/reagent_containers/food/drinks/mate
    name = "mate"
    desc = "Un rico matezuli para disfrutar con la familia"
    icon = 'icons/obj/drinks.dmi'
    icon_state = "mate2"
	amount_per_transfer_from_this = 10
	volume = 40
	custom_materials = list(/datum/material/wood=500)
	max_integrity = 20
	spillable = TRUE
	obj_flags = UNIQUE_RENAME
	drop_sound = 'sound/items/handling/drinkglass_drop.ogg'
	pickup_sound = 'sound/items/handling/drinkglass_pickup.ogg'
	custom_price = PRICE_REALLY_CHEAP

/obj/item/reagent_containers/food/drinks/mate/filled/mate
    name = "Mate"
    desc = "Un mate lleno de rica agua y yerba"
    icon_state = "mate1"