data Proposition = P | Q | IfThen Proposition Proposition
  deriving (Show, Eq)

data Justification = Assumption | ModusPonens Int Int
  deriving (Show, Eq)

data ProofLine = ProofLine {
  dependencies :: [Int],
  proposition :: Proposition,
  justification :: Justification
} deriving (Show)

type Proof = [ProofLine]

validLine :: Proof -> Int -> Bool
validLine proof i
  | i < 0 || i >= length proof = False
  | otherwise = 
      case proof !! i of
        ProofLine refs prop Assumption -> refs == Set.singleton i
        ProofLine refs prop (ModusPonens m n) -> validModusPonens proof i m n prop refs
        _ -> False

validModusPonens :: Proof -> Int -> Int -> Int -> Proposition -> Set.Set Int -> Bool
validModusPonens proof i m n propI refsI
  | m >= i || n >= i || m < 0 || n < 0 = False
  | otherwise =
      case (proof !! m, proof !! n) of
        (ProofLine refsM (IfThen x y), ProofLine refsN z) ->
          propI == y && x == z && refsI == Set.union refsM refsN
        _ -> False

exampleProof :: Proof
exampleProof = [
  ProofLine (Set.fromList [0]) P Assumption,                          -- Line 0: Assume P
  ProofLine (Set.fromList [1]) (IfThen P Q) Assumption,               -- Line 1: Assume IfThen P Q
  ProofLine (Set.fromList [0, 1]) Q (ModusPonens 0 1),               -- Line 2: Valid Modus Ponens, Q from lines 0 and 1
  ProofLine (Set.fromList [1, 2]) P (ModusPonens 1 2)                -- Line 3: Invalid Modus Ponens, P from lines 1 and 2
  ]

