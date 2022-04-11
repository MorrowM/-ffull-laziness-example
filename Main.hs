module Main where

main = print z

data Struct = Empty | Node Int Struct 

makeStruct n = if n == 0 then Empty else Node n (makeStruct (n-1))

foldStruct :: (Int -> Int -> Int) -> Struct -> Int
foldStruct op Empty = 0
foldStruct op (Node n s) = n `op` foldStruct op s

z = f (+) <$> [1..10]

f :: (Int -> Int -> Int) -> Int -> Int
f op x = x * foldStruct op y
  where
    y = makeStruct 1000000

{-# NOINLINE f #-}

