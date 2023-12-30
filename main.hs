import qualified Data.Set as Set
import Data.Maybe (fromJust)

data Proposition = P | Q | IfThen Proposition Proposition
  deriving (Show, Eq)

data Justification = Assumption | ModusPonens Int Int
  deriving (Show, Eq)

data ProofLine = ProofLine {
  lineReferences :: Set.Set Int,
  proposition :: Proposition,
  justification :: Justification
} deriving (Show)

type Proof = [ProofLine]

getPropositionOfLine :: Proof -> Int -> Maybe Proposition
getPropositionOfLine proof lineNumber
  | lineNumber < 0 || lineNumber >= length proof = Nothing
  | otherwise = Just $ proposition (proof !! lineNumber)

getReferencesOfLine :: Proof -> Int -> Maybe (Set.Set Int)
getReferencesOfLine proof lineNumber
  | lineNumber < 0 || lineNumber >= length proof = Nothing
  | otherwise = Just $ lineReferences (proof !! lineNumber)

validLine :: Proof -> Int -> Bool
validLine proof i
  | i < 0 || i >= length proof = False
  | otherwise = 
      case proof !! i of
        ProofLine refs prop Assumption -> refs == Set.singleton i
        ProofLine refs prop (ModusPonens m n) -> validModusPonens proof i m n
        _ -> False

validModusPonens :: Proof -> Int -> Int -> Int -> Bool
validModusPonens proof i m n
  | m >= i || n >= i || m < 0 || n < 0 = False
  | otherwise = 
      case (getPropositionOfLine proof m, getPropositionOfLine proof n, getPropositionOfLine proof i, getReferencesOfLine proof i) of
        (Just (IfThen x y), Just z, Just propI, Just refsI) ->
          propI == y && x == z && refsI == Set.union (fromJust $ getReferencesOfLine proof m) (fromJust $ getReferencesOfLine proof n)
        _ -> False

getL :: Proof -> Int -> Maybe ProofLine
getL proof index
  | index < 0 || index >= length proof = Nothing
  | otherwise = Just (proof !! index)
        
exampleProof :: Proof
exampleProof = [
  ProofLine (Set.fromList [0]) (IfThen P Q) Assumption,               -- Line 1: Assume IfThen P Q
  ProofLine (Set.fromList [1]) P Assumption,                          -- Line 0: Assume P
  ProofLine (Set.fromList [0, 1]) Q (ModusPonens 0 1),               -- Line 2: Valid Modus Ponens, Q from lines 0 and 1
  ProofLine (Set.fromList [1, 2]) P (ModusPonens 1 2)                -- Line 3: Invalid Modus Ponens, P from lines 1 and 2
  ]

