import Foundation

extension String {
  func character(at position: Int) -> String {
    guard position >= 0 && position < self.count else {
      return ""
    }
    let index = self.index(self.startIndex, offsetBy: position)
    return String(self[index])
  }
}

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectoryPath)/input.txt"
let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

var length = 0
if let firstLine = fileContents.split(
  separator: "\n", maxSplits: 1, omittingEmptySubsequences: true
).first {
  length = firstLine.count + 1
}

let hr = [1, 2, 3]
let hl = [-1, -2, -3]
let vd = [length, length * 2, length * 3]
let vu = [-length, -length * 2, -length * 3]
let dru = [-length + 1, -length * 2 + 2, -length * 3 + 3]
let drd = [length + 1, length * 2 + 2, length * 3 + 3]
let dlu = [-length - 1, -length * 2 - 2, -length * 3 - 3]
let dld = [length - 1, length * 2 - 2, length * 3 - 3]

var positions = [hr, hl, vd, vu, dru, drd, dlu, dld]
var result = 0

for i in fileContents.indices {
  if fileContents[i] != "X" {
    continue
  }

  let index = fileContents.distance(from: fileContents.startIndex, to: i)
  for position in positions {
    if fileContents.character(at: index + position[0]) == "M"
      && fileContents.character(at: index + position[1]) == "A"
      && fileContents.character(at: index + position[2]) == "S"
    {
      result += 1
    }
  }
}

print("Part 1: \(result)")

// Part 2
let mlu = [-length - 1, length + 1]
let mld = [length - 1, -length + 1]
let mru = [-length + 1, length - 1]
let mrd = [length + 1, -length - 1]
positions = [mlu, mld, mru, mrd]
result = 0

for i in fileContents.indices {
  if fileContents[i] != "A" {
    continue
  }

  let index = fileContents.distance(from: fileContents.startIndex, to: i)
  var foundOne = false
  for position in positions {
    if fileContents.character(at: index + position[0]) == "M"
      && fileContents.character(at: index + position[1]) == "S"
    {
      foundOne ? (result += 1) : (foundOne = true)
    }
  }
}

print("Part 2: \(result)")
