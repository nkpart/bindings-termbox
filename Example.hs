module Main where

import Foreign
import Prelude hiding (length, init)
import Data.Maybe (fromMaybe)
import Bindings.Termbox
import Data.Sequence (empty, length)
import Control.Lens
import Control.Monad.State.Strict

main :: IO ()
main =
  do c'tb_init
     c'tb_clear
     execStateT drawLoop empty
     c'tb_shutdown

  where drawLoop =
          do ev <- liftIO peekEvent
             let key = c'tb_event'key ev
                 ch = c'tb_event'ch ev
             when ( key /= c'TB_KEY_CTRL_C ) $ do
                modify $ if isBackspace key
                            then fromMaybe empty . preview _init
                            else (|> ch)
                next <- get
                liftIO $ do itraverse (\i c -> drawSomething i . fromIntegral . toInteger $ c) next
                            c'tb_set_cursor (4 + fromIntegral (length next) ) 4
                            c'tb_present
                drawLoop

isBackspace x = x == c'TB_KEY_BACKSPACE || x == 127

drawSomething ix c = c'tb_change_cell (4 + fromIntegral ix) 4 c ( c'TB_RED .|. c'TB_BOLD ) c'TB_DEFAULT

peekEvent = alloca $ \ptr -> c'tb_poll_event ptr >> peek ptr
