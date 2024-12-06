import Foundation

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectoryPath)/input.txt"
let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

var result = 0
let pattern = /mul\((\d{1,3}),(\d{1,3})\)/

for match in fileContents.matches(of: pattern) {
  result += Int(match.1)! * Int(match.2)!
}

print(result)
