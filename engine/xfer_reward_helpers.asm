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
	ld a, [hl]
	;DEBUG
	ld [$D70D], a
	
	;Now we get to generate rewards :]
	;Todo: Rewards
	ret