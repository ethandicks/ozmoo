; --- ZERO PAGE --
; BASIC not much used, so many positions free to use
; memory bank control
zero_datadirection    = $00
zero_processorports   = $01
; available zero page variables (pseudo registers)
z_opcode              = $02
mempointer            = $03 ; 2 bytes
mem_temp              = $05 ; 2 bytes
z_extended_opcode	  = $07
z_canonical_opcode	  = $08
z_opcode_number       = $09
zp_pc_h               = $0a
zp_pc_l               = $0b
z_opcode_opcount      = $0c ; 0 = 0OP, 1=1OP, 2=2OP, 3=VAR
z_operand_count		  = $0d
zword				  = $0e ; 6 bytes

zp_mempos             = $14 ; 2 bytes

z_operand_value_high_arr = $16 ; !byte 0, 0, 0, 0, 0, 0, 0, 0
z_operand_value_low_arr = $1e ;  !byte 0, 0, 0, 0, 0, 0, 0, 0
z_operand_type_arr = z_operand_value_low_arr

; NOTE: This entire block, except last byte of z_pc_mempointer and z_pc_mempointer_is_unsafe is saved!
z_local_vars_ptr      = $26 ; 2 bytes
z_local_var_count	  = $28
stack_pushed_bytes	  = $29 ; !byte 0, 0
stack_ptr             = $2b ; 2 bytes
stack_top_value 	  = $2d ; 2 bytes !byte 0, 0
stack_has_top_value   = $2f ; !byte 0
z_pc				  = $30 ; 3 bytes (last byte shared with z_pc_mempointer)
z_pc_mempointer		  = $32 ; 2 bytes (first byte shared with z_pc)
z_pc_mempointer_is_unsafe = $34

zp_save_start = z_local_vars_ptr
zp_bytes_to_save = z_pc + 3 - z_local_vars_ptr

zchar_triplet_cnt	  = $35
packed_text			  = $36 ; 2 bytes
alphabet_offset		  = $38
escape_char			  = $39
escape_char_counter	  = $3a
abbreviation_command  = $40

parse_array           = $41 ; 2 bytes (22 was bad?)
string_array          = $43 ; 2 bytes (24 was bad?)
;terminators_ptr       = $45 ; 2 bytes

z_address			  = $45 ; 3 bytes
z_address_temp		  = $48

object_tree_ptr       = $49 ; 2 bytes
default_properties_ptr = $52 ; 2 bytes (47 was bad?)
z_trace_index		  = $54
z_exe_mode	  		  = $55

stack_tmp			  = $56; !byte 0, 0, 0, 0, 0
z_global_vars_start	  = $5b ; 2 bytes
zchars				  = $5d ; 3 bytes

vmap_quick_index_match= $60
vmap_next_quick_index = $61
vmap_quick_index	  = $62 ; Must follow vmap_next_quick_index!
vmap_quick_index_length = 6 ; Says how many bytes vmap_quick_index_uses

z_temp				  = $68 ; 12 bytes (Only dictionary encoding uses more than 6)



vmem_temp			  = $92 ; 2 bytes
alphabet_table		  = $96 ; 2 bytes

zp_cursorswitch       = $cc
zp_screenline         = $d1 ; 2 bytes current line (pointer to screen memory)
zp_screencolumn       = $d3 ; current cursor column
zp_screenrow          = $d6 ; current cursor row
zp_temp               = $fb ; 5 bytes

print_buffer		  = $100 ; 41 bytes

memory_buffer         =	$02a7
memory_buffer_length  = 89

first_banked_memory_page = $d0 ; Normally $d0 (meaning $d000-$ffff needs banking for read/write access) 

charset_switchable 	  = $291

datasette_buffer_start= $0334 ; Actually starts at 33c, but the eight bytes before that are unused
datasette_buffer_end  = $03fb

; --- BASIC rom routines ---
;basic_printstring     = $ab1e ; write string in a/y (LO </HI >)
;basic_printinteger    = $bdcd ; write integer value in a/x

; --- I/O registers ---
reg_screen_char_mode  = $d018 
reg_bordercolor       = $d020
reg_backgroundcolor   = $d021 

; --- Kernel routines ---
kernel_setcursor      = $e50c ; set cursor to x/y (row/column)
kernel_reset          = $fce2 ; cold reset of the C64
kernel_scnkey         = $ff9f ; scan the keyboard
kernel_setlfs         = $ffba ; set file parameters
kernel_setnam         = $ffbd ; set file name
kernel_open           = $ffc0 ; open a file
kernel_close          = $ffc3 ; close a file
kernel_chkin          = $ffc6 ; define file as default input
kernel_chkout         = $ffc9 ; define file as default output
kernel_clrchn         = $ffcc ; close default input/output files
kernel_readchar       = $ffcf ; read byte from default input into a
;use streams_print_output instead of kernel_printchar
;($ffd2 only allowed for input/output in screen.asm and text.asm)
kernel_printchar      = $ffd2 ; write char in a
kernel_load           = $ffd5 ; load file
kernel_save           = $ffd8 ; save file
kernel_readtime       = $ffde ; get time of day in a/x/y
kernel_getchar        = $ffe4 ; get a character
kernel_plot           = $fff0 ; set (c=1)/get (c=0) cursor: x=row, y=column


; story file header constants
header_version = $0
header_flags_1 = $1
header_high_mem = $4
header_initial_pc = $6
header_dictionary = $8
header_object_table = $a
header_globals = $c
header_static_mem = $e
header_flags_2 = $10
header_abbreviations = $18
header_filelength = $1a
header_checksum = $1c
header_interpreter_number = $1e
header_interpreter_version = $1f
header_screen_height_lines = $20
header_screen_width_chars = $21
header_screen_width_units = $22
header_screen_height_units = $24
header_font_width_units = $26
header_font_height_units = $27
header_default_bg_color = $2c
header_default_fg_color = $2d
header_terminating_chars_table = $2e
header_standard_revision_number = $32
header_alphabet_table = $34
header_header_extension_table = $36


