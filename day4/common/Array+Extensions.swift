//
//  Array+Extensions.swift
//
//  Created by Kacper Raczy on 06.12.2018.
//

extension Array where Element: Comparable {
  func argmax() -> Index? {
        guard self.count > 0 else {
            return nil
        }

        let result = self.reduce((startIndex, startIndex, nil)) { (result ,next) -> (Index, Index, Element?) in
            let (idx, maxIdx, maxVal) = result
            if maxVal == nil || next > maxVal! {
                return (idx + 1, idx, next)
            } else {
                return (idx + 1, maxIdx, maxVal)
            }
        }

        return result.1
    }
}
