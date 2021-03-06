-----------------------------------------------------------------------------------------
-- |
-- Module      :  FRP.Yampa.Forceable
-- Copyright   :  (c) Zhanyong Wan, Yale University, 2003
-- License     :  BSD-style (see the LICENSE file in the distribution)
--
-- Maintainer  :  nilsson@cs.yale.edu
-- Stability   :  provisional
-- Portability :  portable
--
-- Hyperstrict evaluation.
-----------------------------------------------------------------------------------------

module FRP.Yampa.Forceable
 {-# DEPRECATED "Use DeepSeq instead" #-}
 where

-- | A deep strict evalaution class.
class Forceable a where
    -- | Evaluate completely.
    force :: a -> a

-- | Deep strict evaluation for 'Int'.
instance Forceable Int where
  force = id

-- | Deep strict evaluation for 'Integer'.
instance Forceable Integer where
  force = id

-- | Deep strict evaluation for 'Double'.
instance Forceable Double where
  force = id

-- | Deep strict evaluation for 'Float'.
instance Forceable Float where
  force = id

-- | Deep strict evaluation for 'Bool'.
instance Forceable Bool where
  force = id

-- | Deep strict evaluation for 'Char'.
instance Forceable Char where
  force = id

-- | Deep strict evaluation for '()'.
instance Forceable () where
  force = id

-- | Deep strict evaluation for pairs.
instance (Forceable a, Forceable b) => Forceable (a, b) where
  force p@(a, b) = force a `seq` force b `seq` p

-- | Deep strict evaluation for triples.
instance (Forceable a, Forceable b, Forceable c) => Forceable (a, b, c) where
  force p@(a, b, c) = force a `seq` force b `seq` force c `seq` p

-- | Deep strict evaluation for tuples of four elements.
instance (Forceable a, Forceable b, Forceable c, Forceable d) =>
         Forceable (a, b, c, d) where
  force p@(a, b, c, d) =
      force a `seq` force b `seq` force c `seq` force d `seq` p

-- | Deep strict evaluation for tuples of five elements.
instance (Forceable a, Forceable b, Forceable c, Forceable d, Forceable e) =>
         Forceable (a, b, c, d, e) where
  force p@(a, b, c, d, e) =
      force a `seq` force b `seq` force c `seq` force d `seq` force e `seq` p

-- | Deep strict evaluation for lists.
instance (Forceable a) => Forceable [a] where
  force nil@[] = nil
  force xs@(x:xs') = force x `seq` force xs' `seq` xs

-- | Deep strict evaluation for 'Maybe'.
instance (Forceable a) => Forceable (Maybe a) where
  force mx@Nothing  = mx
  force mx@(Just x) = force x `seq` mx
