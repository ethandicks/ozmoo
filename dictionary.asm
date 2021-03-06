dict_entries !byte 0, 0
dict_len_entries !byte 0
dict_num_entries !byte 0,0
dict_ordered	!byte 0 ; Holds 0 for false or $ff for true
num_terminators !byte 0
terminators !byte 0,0,0,0,0,0,0,0,0,0

parse_dictionary
	; parameters: dictionary address in (a,x)
    jsr set_z_address
    ; read terminators
    jsr read_next_byte
!ifdef DEBUG {
    jsr newline
}
    cmp #10 ; max num terminators
    bcc +
    lda #ERROR_TOO_MANY_TERMINATORS
    jsr fatalerror
+   sta num_terminators
    ldy #0
-   jsr read_next_byte
    sta terminators,y
    iny
    cpy num_terminators
    bne -
    ; read entries
    jsr read_next_byte
    sta dict_len_entries

	lda #$ff
	sta dict_ordered
    jsr read_next_byte
    sta dict_num_entries
	tay
    jsr read_next_byte
    sta dict_num_entries + 1
; Check if ordered dictionary
	cpy #$80
	bcc .ordered
	inc dict_ordered ; Set to 0
	; Invert dict_num_entries and add one
	eor #$ff
	clc
	adc #1
	sta dict_num_entries + 1
	tya 
	eor #$ff
	adc #0
	sta dict_num_entries
.ordered	
    jsr get_z_address
    stx dict_entries
    sta dict_entries  + 1
    rts

;show_dictionary
;    ; show all entries (assume at least one)
;    lda #0
;    sta .dict_x
;    sta .dict_x + 1
;    ldx dict_entries
;    lda dict_entries + 1
;    jsr set_z_address
;-   ; show the dictonary word
;    jsr print_addr
;    jsr newline
;    ; skip the extra data bytes
;    lda dict_len_entries
;    sec
;!ifndef Z4PLUS {
;    sbc #4
;}
;!ifdef Z4PLUS {
;    sbc #6
;}
;    tay
;--  jsr read_next_byte
;    dey
;    bne --
;    ; increase the loop counter
;    inc .dict_x + 1
;    bne +
;    inc .dict_x
;    ; counter < dict_num_entries?
;+   lda dict_num_entries + 1
;    cmp .dict_x + 1
;    bne -
;    lda dict_num_entries
;    cmp .dict_x 
;    bne -
;    rts
;.dict_x: !byte 0,0
