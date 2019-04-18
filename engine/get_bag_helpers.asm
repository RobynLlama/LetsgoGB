;Get slot ID for item ID
;[wcf91] = Item ID
;c = slot ID
GetBagSlotByItemID:
	;Load inventory
	ld hl, wNumBagItems
	ld c, 0
.SlotLoop
	inc hl
	ld a, [hl]
	ld b, a ; b = ID of current item in table
	ld a, [wcf91] ; Load Item ID
	cp b ; Is this the right item?
	jr z, .SlotBreak ; if so, break
	inc hl
	inc c
	;DEBUG: Shunt result into D70D
	;ld a, c
	;ld [wSafariSteps], a
	ld a, [hl]
	cp $ff ; is it the end of the table?
	jr nz, .SlotLoop
.SlotBreak
	ret
	
GetBagAmount:
; In: b = item ID
; Out: b = how many of that item are in the bag
	ld hl, wNumBagItems
.loop
	inc hl
	ld a, [hli]
	cp $ff
	jr z, .notInBag
	cp b
	jr nz, .loop
	ld a, [hl]
	ld b, a
	ret
.notInBag
	ld b, 0
	ret
