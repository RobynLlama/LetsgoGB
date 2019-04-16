;Get rewards for transferring selected pokemon
;[wWhichPokemon] = selected mon slot Id
;add 33 for each mon past the first
GetXferReward:
	;Just jump to $da99 if its 0
	ld a, [wWhichPokemon] ;cf92
	ld hl, $da99
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
	;this is where we load the level from the mon data
	ld c, [hl]
	
	;Now we get to generate rewards :]
.GiveReward
	;Load reward table
	ld hl, RewardItemsTable
	;get a random number
	call Random
	;clamp it to 64
	and %00111111
	;Stuff it into b and prepare DE
	ld b, a
	;clear carry
	xor a
	;Check if its an item reward
	ld a, 41
	cp b
	jr nc, .CheckDone
	;Add Reward
	;Remove blank slots
	ld a, b
	ld b, 40
	;Subtract the first 40 blanks from the table
	sub b
	;Load reward table
	ld hl, RewardItemsTable
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
	ret
	
; Reward Table
RewardItemsTable:
	; ~62% nothing
	; ~28% : 41 - 58: Basic Reward
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db GREAT_BALL
	db POTION
	db POTION
	db POTION
	db POTION
	db POTION
	db POTION
	db REPEL
	db REPEL
	db REPEL
	db REPEL
	db SUPER_POTION
	db SUPER_POTION
	db SUPER_POTION
	; ~9% : 59 - 64: Super Reward
	db HYPER_POTION
	db HYPER_POTION
	db RARE_CANDY
	db RARE_CANDY
	db MOON_STONE
	db NUGGET
	