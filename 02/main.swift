import Foundation

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "/Users/nomnp/Developer/AdventOfCode/02/input"

func readFile(filePath: String) -> [[Int]]? {
  guard let content = try? String(contentsOfFile: filePath) else {
    print("Error: Unable to read the file at \(filePath).")
    return nil
  }

  let lines = content.split(separator: "\n")
  var result: [[Int]] = []
  for line in lines {
    let row = line.split(separator: " ").compactMap { Int($0) }
    result.append(row)
  }

  return result
}

//func isRowValid(row: [Int]) -> Bool {
//    var isIncreasing = 0
//    var isDamp = false
//    var skipElem = false
//    var oldElem = 0
//    var swapWithOld = false
//
//    for i in 0..<row.count - 1 {
//        if skipElem {
//            skipElem = false
//            let diff = abs(oldElem - row[i + 1])
//            if diff < 1 || diff > 3 {
//                return false
//            }
//            if oldElem < row[i + 1] {
//                isIncreasing += 1
//            } else if oldElem > row[i + 1] {
//                isIncreasing -= 1
//            }
//            if i == row.count - 2 {
//                swapWithOld = true
//            }
//            continue
//        }
//
//        let diff = abs(row[i] - row[i + 1])
//        if diff < 1 || diff > 3 {
//            if !isDamp {
//                if i != row.count - 2 || i == 0 {
//                    isDamp = true
//                }
//                if i != 0 {
//                    skipElem = true
//                }
//                oldElem = row[i]
//                continue
//            }
//            return false
//        }
//
//        if row[i] < row[i + 1] {
//            isIncreasing += 1
//        } else if row[i] > row[i + 1] {
//            isIncreasing -= 1
//        } else {
//            isDamp = true
//            if i == 0 {
//                skipElem = true
//            }
//            continue
//        }
//    }
//    var diff = 0
//    // check the last element for the increasing.
//    if swapWithOld {
//        diff = abs(row[row.count - 1] - oldElem)
//    } else {
//        diff = abs(row[row.count - 1] - row[row.count - 2])
//    }
//
//    var value = row[row.count - 2]
//    if swapWithOld {
//        value = oldElem
//    }
//    if isIncreasing < 0 {
//        if row[row.count - 1] > value && diff < 1 || diff > 3 {
//            if isDamp {
//                return false
//            }
//            isDamp = true
//            isIncreasing -= 1
//        }
//    } else if isIncreasing > 0 {
//        if row[row.count - 1] < value && diff < 1 || diff > 3 {
//            if isDamp {
//                return false
//            }
//            isDamp = true
//            isIncreasing += 1
//        }
//    }
//    if isDamp && (isIncreasing == row.count - 2 || isIncreasing == -row.count + 2) {
//        return true
//    }
//    if isIncreasing == row.count - 1 || isIncreasing == -row.count + 1 {
//        return true
//    }
//    return false
//}

func isRowValid(_ row: [Int]) -> Bool {
  var increasing = 0
  var decreasing = 0
  var isDamp = false

  for i in 1..<row.count - 1 {
    var elem = row[i]
    let diff = abs(elem - row[i + 1])
    if diff < 1 || diff > 3 {
      if !isDamp {
        isDamp = true
        elem = row[i - 1]
        let diff = abs(elem - row[i + 1])
        if diff < 1 || diff > 3 {
          return false
        }
      } else {
        return false
      }
    }

    if elem > row[i + 1] {
      increasing += 1
    } else if elem < row[i + 1] {
      decreasing += 1
    }
  }

  if isDamp {
    let elem = row[0]
    let diff = abs(elem - row[1])
    if diff < 1 || diff > 3 {
      return false
    }

    if elem > row[1] {
      increasing += 1
    } else if elem < row[1] {
      decreasing += 1
    }
  }

  if increasing == row.count - 2 || decreasing == row.count - 2 {
    return true
  }

  return false
}

var result = 0
if let data = readFile(filePath: filePath) {
  for row in data {
    if isRowValid(row) {
      result += 1
      print(row)
    }
  }
}

print(result)
