;Get rewards for transferring selected pokemon
;[wWhichPokemon] = selected mon slot Id
;add 33 for each mon past the first
GetXferReward:
	;Just jump to first one if its 0
	ld a, [wWhichPokemon] ;cf92
	;This can't be hardcoded anymore
	ld hl, wNumInBox
	;Add offset to level data
	ld de, $0019
	add hl, de
	cp 0
	jr z, .DoneMath1
	
	;else we gotta do math
	;b is our counter
	ld b, a
	;Setup 16bit addition
	ld a, $00
	ld d, a
	ld a, $21
	ld e, a
	;Load the base address for the box storage + level offset
	
	;Add the offset to the level as many times as register b
.AddLoop
	add hl, de
	dec b
	jr nz, .AddLoop
	
.DoneMath1
	;Load level from box struct
	ld a, [hl]
	
	;Base value is 1 reward
	ld c, $01
	
	;Is level higher than 25
	cp 25
	jr c, .NoBonus25
	;Bonus reward
	inc c
.NoBonus25
	
	;same but for 50
	cp 50
	jr c, .GiveReward
	;Bonus reward
	inc c
	
	;Now we get to generate rewards :]
	;Re-write number 3 :]]]]]
.GiveReward
	;Load reward table
	ld hl, RewardItemsTable
	;get a random number
	call Random
	;clamp it to 32
	and %00011111
	
	;Load reward table pointer
	ld hl, RewardItemsTable
	;Increase pointer by the random number
	ld e, a
	ld d, $00
	add hl, de
	
	;load the reward
	ld a, [hl]
	;Add to inventory
	ld hl, wNumBagItems
	ld [wcf91], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory
.CheckDone
	dec c
	jr nz, .GiveReward

.DoneRewards
	;Always give at least a ball back
	ld hl, wNumBagItems
	ld a, GREAT_BALL
	ld [wcf91], a
	ld a, 1
	ld [wItemQuantity], a
	call AddItemToInventory
	
	ret
	
; Reward Table
RewardItemsTable:
	;~21.8% GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	;25% POTION or BERRY
	db POTION
	db POTION
	db POTION
	db POTION
	db POTION
	db POTION
	db POTION
	db POTION
	;~15.6% REPEL
	db REPEL
	db REPEL
	db REPEL
	db REPEL
	db REPEL
	;~9.3% SUPER_REPEL
	db BERRY
	db BERRY
	db BERRY
	;~9.3% SUPER_POTION
	db SUPER_POTION
	db SUPER_POTION
	db SUPER_POTION
	;6.25% HYPER_POTION
	db HYPER_POTION
	db HYPER_POTION
	;6.25% RARE_CANDY
	db RARE_CANDY
	db RARE_CANDY
	;~3% MOON_STONE
	db MOON_STONE
	;~3% NUGGET
	db NUGGET
	