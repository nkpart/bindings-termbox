module Main where

import Foreign (alloca, peek, (.|.))
import Foreign.C.Types (CUInt)
import Prelude hiding (length, init)
import Data.Maybe (fromMaybe)
import Control.Concurrent (threadDelay)
import Data.Char (ord)
import Bindings.Termbox
import Data.Sequence (empty, length, Seq)
import Control.Lens
import Control.Monad.State.Strict (execStateT, liftIO, when, modify, get)

main :: IO ()
main =
  do c'tb_init
     c'tb_clear
     drawSomething (-2::Int) (fromIntegral . ord $ '>')
     execStateT drawLoop empty
     c'tb_shutdown
  where drawLoop =
          do next <- get
             liftIO $ do itraverse (\i c -> drawSomething i . fromIntegral . toInteger $ c) next
                         c'tb_set_cursor (4 + fromIntegral (length next) ) 4
                         c'tb_present
             ev <- liftIO peekEvent
             let key = c'tb_event'key ev
                 ch = c'tb_event'ch ev
             when ( key /= c'TB_KEY_CTRL_C ) $ do
                 modify $ if isBackspace key
                             then initOrEmpty
                             else (|> ch)
                 drawLoop

initOrEmpty :: Seq a -> Seq a
initOrEmpty = fromMaybe empty . preview _init

isBackspace :: (Eq a, Num a) => a -> Bool
isBackspace x = x == c'TB_KEY_BACKSPACE || x == 127

drawSomething :: Integral a => a -> CUInt -> IO ()
drawSomething i c =
  c'tb_change_cell (4 + fromIntegral i)
                   4
                   c
                   (c'TB_RED .|. c'TB_BOLD)
                   c'TB_DEFAULT

peekEvent :: IO C'tb_event
peekEvent = alloca $ \ptr -> c'tb_poll_event ptr >> peek ptr

readmeExample :: IO ()
readmeExample =
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
