import Foundation

let currentDirectoryPath = FileManager.default.currentDirectoryPath
let filePath = "\(currentDirectoryPath)/input.txt"
let fileContents = try! String(contentsOfFile: filePath, encoding: .utf8)

enum Cell {
  case obstacle, void, visited
}

enum Direction {
  case up, down, left, right
}

struct Player {
  var x = 0
  var y = 0
  var direction: Direction = Direction.up
}

struct Map {
  var grid: [[Cell]]
  let width: Int
  let height: Int
  var player: Player = Player()

  init(from rawGrid: String) {
    let lines = rawGrid.split(separator: "\n")
    self.grid = lines.map { line in
      line.map { char -> Cell in
        switch char {
        case "#": return .obstacle
        case ".": return .void
        case "^": return .visited
        default: fatalError("Unexpected character in grid: \(char)")
        }
      }
    }
    self.height = lines.count
    self.width = lines.first?.count ?? 0

    for (y, line) in lines.enumerated() {
      if let xIndex = line.firstIndex(of: "^") {
        let x = line.distance(from: line.startIndex, to: xIndex)
        self.player = Player(x: x, y: y, direction: .up)
        break
      }
    }
  }

  func isInBounds(x: Int, y: Int) -> Bool {
    print(width, height)
    return x >= 0 && x < width && y >= 0 && y < height
  }

  func cellAt(x: Int, y: Int) -> Cell? {
    guard isInBounds(x: x, y: y) else { return nil }
    return grid[y][x]
  }

  mutating func setCellAt(x: Int, y: Int, to newCell: Cell) {
    guard isInBounds(x: x, y: y) else { return }
    grid[y][x] = newCell
  }
}

let turnOrder: [Direction: Direction] = [
  .up: .right,
  .right: .down,
  .down: .left,
  .left: .up,
]

let directionOffsets: [Direction: (dx: Int, dy: Int)] = [
  .up: (0, -1),
  .down: (0, 1),
  .left: (-1, 0),
  .right: (1, 0),
]

var map = Map(from: fileContents)
var player = map.player

while true {
  let offset = directionOffsets[player.direction]!
  let newX = player.x + offset.dx
  let newY = player.y + offset.dy

  if !map.isInBounds(x: newX, y: newY) {
    break
  } else if map.cellAt(x: newX, y: newY) == .obstacle {
    player.direction = turnOrder[player.direction]!
  } else if map.cellAt(x: newX, y: newY) == .void {
    map.setCellAt(x: newX, y: newY, to: .visited)
    player.x = newX
    player.y = newY
  } else if map.cellAt(x: newX, y: newY) == .visited {
    player.x = newX
    player.y = newY
  }
}

var result = 0
map.grid.forEach {
  $0.forEach {
    if $0 == .visited {
      result += 1
    }
  }
}

print(result)
