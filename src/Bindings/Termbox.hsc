#include <bindings.dsl.h>
#include <termbox.h>
#include <stdint.h>

module Bindings.Termbox where
#strict_import

#num TB_KEY_F1
#num TB_KEY_F2
#num TB_KEY_F3
#num TB_KEY_F4
#num TB_KEY_F5
#num TB_KEY_F6
#num TB_KEY_F7
#num TB_KEY_F8
#num TB_KEY_F9
#num TB_KEY_F10
#num TB_KEY_F11
#num TB_KEY_F12
#num TB_KEY_INSERT
#num TB_KEY_DELETE
#num TB_KEY_HOME
#num TB_KEY_END
#num TB_KEY_PGUP
#num TB_KEY_PGDN
#num TB_KEY_ARROW_UP
#num TB_KEY_ARROW_DOWN
#num TB_KEY_ARROW_LEFT
#num TB_KEY_ARROW_RIGHT

#num TB_KEY_CTRL_TILDE
#num TB_KEY_CTRL_2
#num TB_KEY_CTRL_A
#num TB_KEY_CTRL_B
#num TB_KEY_CTRL_C
#num TB_KEY_CTRL_D
#num TB_KEY_CTRL_E
#num TB_KEY_CTRL_F
#num TB_KEY_CTRL_G
#num TB_KEY_BACKSPACE
#num TB_KEY_CTRL_H
#num TB_KEY_TAB
#num TB_KEY_CTRL_I
#num TB_KEY_CTRL_J
#num TB_KEY_CTRL_K
#num TB_KEY_CTRL_L
#num TB_KEY_ENTER
#num TB_KEY_CTRL_M
#num TB_KEY_CTRL_N
#num TB_KEY_CTRL_O
#num TB_KEY_CTRL_P
#num TB_KEY_CTRL_Q
#num TB_KEY_CTRL_R
#num TB_KEY_CTRL_S
#num TB_KEY_CTRL_T
#num TB_KEY_CTRL_U
#num TB_KEY_CTRL_V
#num TB_KEY_CTRL_W
#num TB_KEY_CTRL_X
#num TB_KEY_CTRL_Y
#num TB_KEY_CTRL_Z
#num TB_KEY_ESC
#num TB_KEY_CTRL_LSQ_BRACKET
#num TB_KEY_CTRL_3
#num TB_KEY_CTRL_4
#num TB_KEY_CTRL_BACKSLASH
#num TB_KEY_CTRL_5
#num TB_KEY_CTRL_RSQ_BRACKET
#num TB_KEY_CTRL_6
#num TB_KEY_CTRL_7
#num TB_KEY_CTRL_SLASH
#num TB_KEY_CTRL_UNDERSCORE
#num TB_KEY_SPACE
#num TB_KEY_BACKSPACE2
#num TB_KEY_CTRL_8

#num TB_MOD_ALT

#num TB_DEFAULT
#num TB_BLACK
#num TB_RED
#num TB_GREEN
#num TB_YELLOW
#num TB_BLUE
#num TB_MAGENTA
#num TB_CYAN
#num TB_WHITE

#num TB_BOLD
#num TB_UNDERLINE
#num TB_REVERSE

#starttype struct tb_cell
#field ch , CUInt
#field fg , CUShort
#field bg , CUShort
#stoptype

#num TB_EVENT_KEY
#num TB_EVENT_RESIZE

#starttype struct tb_event
#field type , CUChar
#field mod , CUChar
#field key , CUShort
#field ch , CUInt
#field w , CInt
#field h , CInt
#stoptype

#num TB_EUNSUPPORTED_TERMINAL
#num TB_EFAILED_TO_OPEN_TTY
#num TB_EPIPE_TRAP_ERROR

#ccall tb_init , IO CInt
#ccall tb_shutdown , IO ()

#ccall tb_width , IO CInt
#ccall tb_height , IO CInt

#ccall tb_clear , IO ()
#ccall tb_set_clear_attributes , CUShort -> CUShort -> IO ()

#ccall tb_present , IO ()

#num TB_HIDE_CURSOR
#ccall tb_set_cursor , CInt -> CInt -> IO ()

#ccall tb_put_cell , CInt -> CInt -> Ptr <tb_cell> -> IO ()
#ccall tb_change_cell , CInt -> CInt -> CUInt -> CUShort -> CUShort -> IO ()

-- Deprecated
#ccall tb_blit , CInt -> CInt -> CInt -> CInt -> Ptr <tb_cell> -> IO ()

#ccall tb_cell_buffer , IO (Ptr <tb_cell>)

#num TB_INPUT_CURRENT
#num TB_INPUT_ESC
#num TB_INPUT_ALT

#ccall tb_select_input_mode , CInt -> IO CInt

#num TB_OUTPUT_CURRENT
#num TB_OUTPUT_NORMAL
#num TB_OUTPUT_256
#num TB_OUTPUT_216
#num TB_OUTPUT_GRAYSCALE

#ccall tb_select_output_mode , CInt -> IO CInt

#ccall tb_peek_event , Ptr <struct tb_event> -> CInt -> IO CInt
#ccall tb_poll_event , Ptr <struct tb_event> -> IO CInt

#num TB_EOF

#ccall tb_utf8_char_length , CChar -> IO CInt
#ccall tb_utf8_char_to_unicode , Ptr CUInt -> CString -> IO CInt
#ccall tb_utf8_unicode_to_char , Ptr CChar -> CUInt -> IO CInt
