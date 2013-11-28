module GMachine.Types where

import Core.Language
import Utils.Assoc
import Utils.Heap


type GmCode     = [Instruction]
type GmStack    = [Addr]
type GmDump     = [GmDumpItem]
type GmHeap     = Heap Node
type GmGlobals  = ASSOC Name Addr
type GmStats    = Int
type GmDumpItem = (GmCode, GmStack)


data GmState = GmState {
    gmCode               :: GmCode
  , gmStack              :: GmStack
  , gmDump               :: GmDump
  , gmHeap               :: GmHeap
  , gmGlobals            :: GmGlobals
  , gmStats              :: GmStats
} deriving Show


data Instruction = Unwind
                 | PushGlobal Name
                 | PushInt Int
                 | Push Int
                 | MkApp
                 | Update Int
                 | Slide Int
                 deriving (Eq, Show)


data Node = NNum Int
          | NApp Addr Addr
          | NGlobal Int GmCode
          | NIndir Addr
          deriving Show


statIncSteps :: GmStats -> GmStats
statIncSteps = (+ 1)

statGetSteps :: GmStats -> Int
statGetSteps = id
