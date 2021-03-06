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
                 | MkAp
                 | Alloc Int
                 | Update Int
                 | Pop Int
                 | Slide Int
                 | Eval
                 | Add | Sub | Mul | Div | Neg
                 | Eq | Ne | Lt | Le | Gt | Ge
                 | Cond GmCode GmCode
                 deriving (Eq, Show)


data Node = NNum Int
          | NAp Addr Addr
          | NGlobal Int GmCode
          | NInd Addr
          deriving (Eq, Show)


statIncSteps :: GmStats -> GmStats
statIncSteps = (+ 1)

statGetSteps :: GmStats -> Int
statGetSteps = id

