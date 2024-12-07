import Foundation

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectoryPath)/input.txt"
let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

let lines = fileContent.split(separator: "\n")

let addition: (Int, Int) -> Int = { $0 + $1 }
let multiplication: (Int, Int) -> Int = { $0 * $1 }
let concatenation: (Int, Int) -> Int = { Int(String($0) + String($1))! }
let operators: [(Int, Int) -> Int] = [addition, multiplication, concatenation]

func evaluate(values: [Int], testValue: Int) -> Bool {
  if values.count == 1 {
    return values[0] == testValue
  }
  for op in operators {
    let value = op(values[0], values[1])
    var newValues = values
    newValues.removeFirst()
    newValues[0] = value
    if evaluate(values: newValues, testValue: testValue) {
      return true
    }
  }
  return false
}

var result = 0

for line in lines {
  let parts = line.split(separator: ":")
  guard parts.count == 2,
    let testValue = Int(parts[0]),
    let values = parts[1]
      .split(separator: " ")
      .compactMap({ Int($0) }) as [Int]?
  else {
    continue
  }

  if evaluate(values: values, testValue: testValue) {
    result += testValue
  }
}

print(result)
