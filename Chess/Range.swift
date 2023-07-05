//
//  Range.swift
//  Chess
//
//  Created by Raymond Vleeshouwer on 04/07/23.
//

import Foundation

func range(_ start: Int = 0, _ step: Int = 1, _ end: Int) -> [Int] {
    var result: [Int] = []
    var current = start

    if step > 0 {
        while current < end {
            result.append(current)
            current += step
        }
    } else if step < 0 {
        while current > end {
            result.append(current)
            current += step
        }
    }

    return result
}

func range2(_ start: Int = 0, _ step: Int = 1, _ end: Int) -> [Int] {
    var result: [Int] = []
    var current = start + step

    if step > 0 {
        while current < end {
            result.append(current)
            current += step
        }
    } else if step < 0 {
        while current > end {
            result.append(current)
            current += step
        }
    }

    return result
}
