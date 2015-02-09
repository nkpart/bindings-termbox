module Main where

import Foreign (alloca, peek, (.|.))
import Foreign.C.Types (CUInt)
import Prelude hiding (length, init)
import Data.Maybe (fromMaybe)
import Bindings.Termbox
import Data.Sequence (empty, length, Seq)
import Control.Lens
import Control.Monad.State.Strict (execStateT, liftIO, when, modify, get)

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
                            then initOrEmpty
                            else (|> ch)
                next <- get
                liftIO $ do itraverse (\i c -> drawSomething i . fromIntegral . toInteger $ c) next
                            c'tb_set_cursor (4 + fromIntegral (length next) ) 4
                            c'tb_present
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
