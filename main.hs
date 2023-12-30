data Proposition = P | Q | IfThen Proposition Proposition
  deriving (Show, Eq)

data Justification = Assumption | ModusPonens Int Int
  deriving (Show, Eq)

data ProofLine = ProofLine {
  proposition :: Proposition,
  justification :: Justification
} deriving (Show)

type Proof = [ProofLine]
