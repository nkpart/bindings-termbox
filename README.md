# bindings-termbox
Low level bindings to the termbox library:

  * https://github.com/nsf/termbox
  
```haskell
import Data.Char (ord)
import Control.Concurrent (threadDelay)
import Foreign ((.|.))
import Bindings.Termbox
main :: IO ()
main =
  do c'tb_init
     c'tb_clear
     c'tb_change_cell 0 0 (ord' 'H') c'TB_BLUE c'TB_YELLOW
     c'tb_change_cell 1 0 (ord' 'e') c'TB_BLUE c'TB_RED
     c'tb_change_cell 2 0 (ord' 'l') c'TB_BLUE c'TB_RED
     c'tb_change_cell 3 0 (ord' 'l') c'TB_BLUE c'TB_RED
     c'tb_change_cell 4 0 (ord' 'o') c'TB_BLUE c'TB_RED
     c'tb_change_cell 5 2 (ord' ' ') c'TB_DEFAULT c'TB_DEFAULT
     c'tb_change_cell 6 2 (ord' 'W') c'TB_BLUE c'TB_YELLOW
     c'tb_change_cell 7 2 (ord' 'o') c'TB_BLUE c'TB_RED
     c'tb_change_cell 8 2 (ord' 'r') c'TB_BLUE c'TB_RED
     c'tb_change_cell 9 2 (ord' 'l') c'TB_BLUE c'TB_RED
     c'tb_change_cell 10 2 (ord' 'd') c'TB_BLUE c'TB_RED
     c'tb_change_cell 11 2 (ord' '!') ( c'TB_BLUE .|. c'TB_BOLD ) c'TB_RED
     c'tb_present
     threadDelay 2000000
     c'tb_shutdown
  where ord' = fromIntegral . ord


```
