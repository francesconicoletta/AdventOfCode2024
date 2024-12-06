import Foundation

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectoryPath)/input.txt"
let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

var map: [Int: [Int]] = [:]
var pageOrders: [[Int]] = []

let lines = fileContents.split(separator: "\n")
for line in lines {
  if line.contains("|") {
    let ordering = line.split(separator: "|")
    let index = Int(ordering[0])!
    let value = Int(ordering[1])!
    map[index, default: []].append(value)
  } else {
    let order = line.components(separatedBy: ",")
    pageOrders.append(order.map { Int($0)! })
  }
}

var correctOrders: [[Int]] = []
for order in pageOrders {
  var correct = true
  order.enumerated().forEach { (index, element) in
    print(map[element]!)
    let constraints = map[element]!
    for i in index + 1..<order.count {
      if !constraints.contains(order[i]) {
        correct = false
        break
      }
    }
  }
  if correct {
    correctOrders.append(order)
  }
}

var result = 0
for correctOrder in correctOrders {
  result += correctOrder[correctOrder.count / 2]
}

print(result)
