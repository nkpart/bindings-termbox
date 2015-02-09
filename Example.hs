module Main where

import Bindings.Termbox
import Data.Char (ord)
import Control.Concurrent (threadDelay)

main :: IO ()
main = do c'tb_init
          c'tb_clear

          drawSomething
          c'tb_present
          threadDelay 2000000
          c'tb_shutdown
          print 3

drawSomething :: IO ()
drawSomething = do c'tb_change_cell 4 4 (ord' '/') c'TB_RED c'TB_DEFAULT

ord' = fromIntegral . ord
