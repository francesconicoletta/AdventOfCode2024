import Foundation

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectoryPath)/input"

let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

var col1: [Int] = []
var col2: [Int] = []
let lines = fileContents.split(separator: "\n")

for line in lines {
  let col = line.split(separator: " ")
  col1.append(Int(col[0])!)
  col2.append(Int(col[1])!)
}

col1.sort()
col2.sort()

var distance: Int = 0

for (firstValue, secondValue) in zip(col1, col2) {
  if firstValue > secondValue {
    distance += firstValue - secondValue
  } else {
    distance += secondValue - firstValue
  }
}

print(distance)

let dictionary = col2.reduce(into: [:]) { counts, item in
  counts[item, default: 0] += 1
}

var similarity = 0
for elem in col1 {
  similarity += elem * dictionary[elem, default: 0]
}

print(similarity)
