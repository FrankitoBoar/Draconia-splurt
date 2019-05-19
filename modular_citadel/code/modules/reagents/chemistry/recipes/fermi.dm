//TO TWEAK:

//Called for every reaction step
/datum/chemical_reaction/fermi/proc/FermiCreate(holder) //You can get holder by reagents.holder WHY DID I LEARN THIS NOW???
	return

//Called when temperature is above a certain threshold
//....Is this too much?
/datum/chemical_reaction/fermi/proc/FermiExplode(src, datum/reagents/holder, volume, temp, pH, Reaction) //You can get holder by reagents.holder WHY DID I LEARN THIS NOW???
	var/Svol = volume
	var/turf/T = get_turf(holder.my_atom)
	if(temp>600)//if hot, start a fire
		switch(temp)
			if (601 to 800)
				for(var/turf/turf in range(1,T))
					new /obj/effect/hotspot(turf)
					volume /= 3
			if (801 to 1100)
				for(var/turf/turf in range(2,T))
					new /obj/effect/hotspot(turf)
					volume /= 4
			if (1101 to INFINITY)
				for(var/turf/turf in range(3,T))
					new /obj/effect/hotspot(turf)
					volume /= 5

	var/datum/effect_system/smoke_spread/chem/smoke_machine/s = new
	if(pH < 2.5)
		s.set_up(/datum/reagent/fermi/fermiAcid, (volume/3), pH*10, T)
		volume /=3
	for (var/reagent in holder.reagent_list)
		var/datum/reagent/R = reagent
		s.set_up(R, R.volume/3, pH*10, T)
		//R.on_reaction(T, volume/10) //Uneeded, I think (hope)
	s.start()

	if (pH > 12)
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(volume/Svol, 1), T, 0, 0)
		e.start()
	message_admins("Fermi explosion at [T], with a temperature of [temp], pH of [pH], containing [holder.reagent_list]")
	return

/datum/chemical_reaction/fermi/eigenstate
	name = "Eigenstasium"
	id = "eigenstate"
	results = list("eigenstate" = 1)
	required_reagents = list("bluespace" = 1, "stable_plasma" = 1, "sugar" = 1)
	mix_message = "zaps brightly into existance, diffusing the energy from the localised gravity well as light"
	//FermiChem vars:
	OptimalTempMin = 350 // Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax = 500 // Upper end for above
	ExplodeTemp = 550 //Temperature at which reaction explodes
	OptimalpHMin = 4 // Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax = 9.5 // Higest value for above
	ReactpHLim = 2 // How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact = 0 // How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT = 4 // How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH = 2 // How sharp the pH exponential curve is (to the power of value)
	ThermicConstant = -2.5 //Temperature change per 1u produced
	HIonRelease = 0.01 //pH change per 1u reaction
	RateUpLim = 5 //Optimal/max rate possible if all conditions are perfect
	FermiChem = TRUE//If the chemical uses the Fermichem reaction mechanics
	FermiExplode = FALSE //If the chemical explodes in a special way


/datum/chemical_reaction/fermi/eigenstate/FermiCreate(datum/reagents/holder)
	var/location = get_turf(holder.my_atom)
	var/datum/reagent/fermi/eigenstate/E = locate(/datum/reagent/fermi/eigenstate) in holder.reagent_list
	E.location_created = location

//serum
/datum/chemical_reaction/fermi/SDGF
	name = "Synthetic-derived growth factor"
	id = "SDGF"
	results = list("SDGF" = 3)
	required_reagents = list("plasma" = 1, "stable_plasma" = 1, "sugar" = 1)
	//required_reagents = list("stable_plasma" = 5, "slimejelly" = 5, "synthflesh" = 10, "blood" = 10)
	//FermiChem vars:
	OptimalTempMin 		= 350 		// Lower area of bell curve for determining heat based rate reactions
	OptimalTempMax 		= 500 		// Upper end for above
	ExplodeTemp 		= 550 		// Temperature at which reaction explodes
	OptimalpHMin 		= 4 		// Lowest value of pH determining pH a 1 value for pH based rate reactions (Plateu phase)
	OptimalpHMax 		= 9.5 		// Higest value for above
	ReactpHLim 			= 2 		// How far out pH wil react, giving impurity place (Exponential phase)
	CatalystFact 		= 0 		// How much the catalyst affects the reaction (0 = no catalyst)
	CurveSharpT 		= 4 		// How sharp the temperature exponential curve is (to the power of value)
	CurveSharppH 		= 2 		// How sharp the pH exponential curve is (to the power of value)
	ThermicConstant		= 20 		// Temperature change per 1u produced
	HIonRelease 		= 0.01 		// pH change per 1u reaction
	RateUpLim 			= 5 		// Optimal/max rate possible if all conditions are perfect
	FermiChem 			= TRUE		// If the chemical uses the Fermichem reaction mechanics
	FermiExplode 		= TRUE		// If the chemical explodes in a special way
	PurityMin 			= 0.25

/datum/chemical_reaction/fermi/SDGF/FermiExplode(src, datum/reagents/holder, volume, temp, pH, Reaction)//Spawns an angery teratoma!! Spooky..! be careful!! TODO: Add teratoma slime subspecies
	var/turf/T = get_turf(holder.my_atom)
	var/mob/living/simple_animal/slime/S = new(T,"grey")//should work, in theory
	S.damage_coeff = list(BRUTE = 0.9 , BURN = 2, TOX = 1, CLONE = 1, STAMINA = 0, OXY = 1)//I dunno how slimes work cause fire is burny
	S.name = "Living teratoma"
	S.real_name = "Living teratoma"//horrifying!!
	S.rabid = 1//Make them an angery boi, grr grr
	to_chat("<span class='warning'>The cells clump up into a horrifying tumour!</span>")

/datum/chemical_reaction/fermi/BElarger
	name = "Sucubus milk"
	id = "BElarger"
	results = list("BElarger" = 6)
	required_reagents = list("salglu_solution" = 1, "milk" = 5, "synthflesh" = 2, "silicon" = 2, "aphro" = 2)
	//FermiChem vars:
	OptimalTempMin 			= 200
	OptimalTempMax			= 800
	ExplodeTemp 			= 900
	OptimalpHMin 			= 5
	OptimalpHMax 			= 10
	ReactpHLim 				= 3
	CatalystFact 			= 0
	CurveSharpT 			= 2
	CurveSharppH 			= 2
	ThermicConstant 		= 1
	HIonRelease 			= 0.1
	RateUpLim 				= 10
	FermiChem				= TRUE
	FermiExplode 			= TRUE
	PurityMin 				= 0.1

/datum/chemical_reaction/fermi/BElarger/FermiExplode(src, datum/reagents/holder, volume, temp, pH, Reaction)
	//var/obj/item/organ/genital/breasts/B =
	new /obj/item/organ/genital/breasts(holder.my_atom)
	var/list/seen = viewers(5, get_turf(holder.my_atom))
	for(var/mob/M in seen)
		to_chat(M, "<span class='warning'>The reaction suddenly condenses, creating a pair of breasts!</b></span>")//OwO
	..()

/datum/chemical_reaction/fermi/PElarger //Vars needed
	name = "Incubus draft"
	id = "PElarger"
	results = list("PElarger" = 3)
	required_reagents = list("plasma" = 1, "stable_plasma" = 1, "sugar" = 1)
	required_catalysts = list("blood" = 1)
	//required_reagents = list("stable_plasma" = 5, "slimejelly" = 5, "synthflesh" = 10, "blood" = 10)
	//FermiChem vars:
	OptimalTempMin 			= 200
	OptimalTempMax			= 800
	ExplodeTemp 			= 900
	OptimalpHMin 			= 5
	OptimalpHMax 			= 10
	ReactpHLim 				= 3
	CatalystFact 			= 0
	CurveSharpT 			= 2
	CurveSharppH 			= 2
	ThermicConstant 		= 1
	HIonRelease 			= 0.1
	RateUpLim 				= 10
	FermiChem				= TRUE
	FermiExplode 			= TRUE
	PurityMin 				= 0.1

/datum/chemical_reaction/fermi/PElarger/FermiExplode(src, datum/reagents/holder, volume, temp, pH, Reaction)
	//var/obj/item/organ/genital/penis/nP =
	new /obj/item/organ/genital/penis(holder.my_atom)
	var/list/seen = viewers(5, get_turf(holder.my_atom))
	for(var/mob/M in seen)
		to_chat(M, "<span class='warning'>The reaction suddenly condenses, creating a penis!</b></span>")//OwO
	..()

/datum/chemical_reaction/fermi/astral //Vars needed
	name = "Astrogen"
	id = "astral"
	results = list("astral" = 3)
	required_reagents = list("eigenstasium" = 1, "plasma" = 1, "synaptizine" = 1, "aluminium" = 5)
	//required_reagents = list("stable_plasma" = 5, "slimejelly" = 5, "synthflesh" = 10, "blood" = 10)
	//FermiChem vars:
	OptimalTempMin 			= 200
	OptimalTempMax			= 800
	ExplodeTemp 			= 900
	OptimalpHMin 			= 5
	OptimalpHMax 			= 10
	ReactpHLim 				= 3
	CatalystFact 			= 0
	CurveSharpT 			= 2
	CurveSharppH 			= 2
	ThermicConstant 		= 1
	HIonRelease 			= 0.1
	RateUpLim 				= 10
	FermiChem				= TRUE
	FermiExplode 			= TRUE
	PurityMin 				= 0.25


/datum/chemical_reaction/fermi/enthrall //Vars needed
	name = "MKUltra"
	id = "enthrall"
	results = list("enthrall" = 3)
	required_reagents = list("iron" = 1, "iodine" = 1)
	//required_reagents = list("cocoa" = 1, "astral" = 1, "mindbreaker" = 1, "psicodine" = 1, "happiness" = 1)
	required_catalysts = list("blood" = 1)
	//required_reagents = list("stable_plasma" = 5, "slimejelly" = 5, "synthflesh" = 10, "blood" = 10)
	//FermiChem vars:
	OptimalTempMin 			= 780
	OptimalTempMax			= 800
	ExplodeTemp 			= 820
	OptimalpHMin 			= 1
	OptimalpHMax 			= 2
	ReactpHLim 				= 2
	//CatalystFact 			= 0
	CurveSharpT 			= 0.5
	CurveSharppH 			= 4
	ThermicConstant 		= 20
	HIonRelease 			= 0.1
	RateUpLim 				= 5
	FermiChem				= TRUE
	FermiExplode 			= TRUE
	PurityMin 				= 0.15

/datum/chemical_reaction/fermi/enthrall/on_reaction(datum/reagents/holder)
	message_admins("On reaction for enthral proc'd")
	var/datum/reagent/blood/B = locate(/datum/reagent/blood) in holder.reagent_list
	var/datum/reagent/fermi/enthrall/E = locate(/datum/reagent/fermi/enthrall) in holder.reagent_list
	if (B.["gender"] == "female")
		E.creatorGender = "Mistress"
	else
		E.creatorGender = "Master"
	E.creatorName = B.["real_name"]
	E.creatorID = B.["ckey"]
	message_admins("name: [creatorName], ID: [creatorID], gender: [creatorGender], creator:[creator]")
	..()
	//var/enthrallID = B.get_blood_data()

/datum/chemical_reaction/fermi/enthrall/FermiExplode(src, datum/reagents/holder, volume, temp, pH, Reaction)
	var/turf/T = get_turf(holder.my_atom)
	var/datum/effect_system/smoke_spread/chem/smoke_machine/s = new
	s.set_up("enthrallExplo", volume, pH*10, T)
	s.start()
	..()

/datum/chemical_reaction/fermi/hatmium
	name = "Hat growth serum"
	id = "hatmium"
	results = list("hatmium" = 5)
	required_reagents = list("whiskey" = 1, "nutriment" = 3, "cooking_oil" = 2, "iron" = 1, "blackpepper" = 3)
	//mix_message = ""
	//FermiChem vars:
	OptimalTempMin 	= 500
	OptimalTempMax 	= 650
	ExplodeTemp 	= 750
	OptimalpHMin 	= 10
	OptimalpHMax 	= 14
	ReactpHLim 		= 1
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 4
	CurveSharppH 	= 0.5
	ThermicConstant = -2.5
	HIonRelease 	= 0.01
	RateUpLim 		= 5
	FermiChem 		= TRUE
	//FermiExplode 	= FALSE
	//PurityMin		= 0.15

/datum/chemical_reaction/fermi/hatmium/FermiExplode(src, datum/reagents/holder, volume, temp, pH, Reaction)
	var/obj/item/clothing/head/hattip/hat = new /obj/item/clothing/head/hattip(get_turf(holder.my_atom))
	hat.animate_atom_living()
	var/list/seen = viewers(5, get_turf(holder.my_atom))
	for(var/mob/M in seen)
		to_chat(M, "<span class='warning'>The makes an off sounding pop, as a hat suddenly climbs out of the beaker!</b></span>")
	..()

/datum/chemical_reaction/fermi/furranium //low temp and medium pH
	name = "Furranium"
	id = "furranium"
	results = list("furranium" = 5)
	required_reagents = list("aphro" = 1, "moonsugar" = 1, "silver" = 1, "salglu_solution" = 1)
	//mix_message = ""
	//FermiChem vars:
	OptimalTempMin 	= 350
	OptimalTempMax 	= 600
	ExplodeTemp 	= 700
	OptimalpHMin 	= 8
	OptimalpHMax 	= 10
	ReactpHLim 		= 1
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 2
	CurveSharppH 	= 0.5
	ThermicConstant = -2
	HIonRelease 	= -0.1
	RateUpLim 		= 10
	FermiChem 		= TRUE
	//FermiExplode 	= FALSE
	//PurityMin		= 0.15

//Nano-b-gone
/datum/chemical_reaction/fermi/naninte_b_gone
	name = "Naninte bain"
	id = "naninte_b_gone"
	results = list("naninte_b_gone" = 5)
	required_reagents = list("synthflesh" = 5, "uranium" = 1, "iron" = 1, "salglu_solution" = 3)
	mix_message = "the reaction gurgles, encapsulating the reagents in flesh."
	//FermiChem vars:
	OptimalTempMin 	= 450
	OptimalTempMax 	= 600
	ExplodeTemp 	= 700
	OptimalpHMin 	= 6
	OptimalpHMax 	= 8
	ReactpHLim 		= 1
	//CatalystFact 	= 0 //To do 1
	CurveSharpT 	= 4
	CurveSharppH 	= 2
	ThermicConstant = -2.5
	HIonRelease 	= 0.01
	RateUpLim 		= 5
	FermiChem 		= TRUE
	//FermiExplode 	= FALSE
	//PurityMin		= 0.15
