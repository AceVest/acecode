//: [Previous](@previous)

import UIKit

enum CompassPoint {
    case north      // 也可以写在一行上用逗号隔开 north, east, south, west
    case east
    case south
    case west
}

var directionToHead = CompassPoint.north    // 自动推断类型
directionToHead = .east                     // 一旦类型确定，再次赋值时可以省略枚举类型名

switch directionToHead {
    case .north: print("Losts of Plantes Have a North")
    case .east : print("Where the Sun Rises")
    case .south: print("Watch Out for Penguins")
    case .west : print("Where the Skies are Blue")
}


// Associated Values
printLine("Enumeration Associated Values")
enum BarCode {
    case upca(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarCode = BarCode.upca(8, 88488, 66366, 2)
productBarCode = .qrCode("QRCode-123456")

switch productBarCode {
case let .upca(numberSystem, manufacturer, product, check) :
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode) :
    print("QR Code: \(productBarCode)")
}


printLine("RawValues")
// Raw Values
enum ASCIIControlCharacter: Character {
    case tab            = "\t"
    case lineFeed       = "\n"
    case carriageReturn = "\r"
}

// Implicitly Assigned Raw Values
// 整型从0开始自增1，每个项的rawValue不能相同
enum Planet: Int {
    case mercury    // 从0开始，后续自增1，也可以指定值 如 mercury=1
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case netpune
}


print(Planet.mercury, Planet.mercury.rawValue)
print(Planet.mars, Planet.mars.rawValue)

// 使用原始值初始化枚举实例
let possiblePlanet: Planet? = Planet(rawValue: 7)   // 注意是可选类型 Planet?
print(possiblePlanet!, possiblePlanet!.rawValue)
print(Planet(rawValue: 5)!, Planet(rawValue: 5)!.rawValue)


// String型，每项默认为枚举项的字符串值
enum CompassPointString: String {
    case North              // String原始值默认与枚举成员名相同
    case East
    case Sourth
    case West = "WEAST"
}


print(CompassPointString.North, CompassPointString.North.rawValue)
print(CompassPointString.East,  CompassPointString.East.rawValue)
print(CompassPointString.Sourth,CompassPointString.Sourth.rawValue)
print(CompassPointString.West,  CompassPointString.West.rawValue)



// 递归枚举
printLine("Resursive Enumerations")
// 不能忘记 indirect
indirect enum Exp {
    case number(Int)
    case add(Exp, Exp)  // indirect 也可以放在case语句之前
    case mul(Exp, Exp)
}


let exp = Exp.mul(Exp.add(Exp.number(2), Exp.number(5)), Exp.number(7))

func evaluateExp(_ exp: Exp) -> Int {
    switch exp {
    case let .number(n):
        return n
    case let .add(a, b) :
        return evaluateExp(a) + evaluateExp(b)
    case let .mul(a, b):
        return evaluateExp(a) * evaluateExp(b)
    }
}

print(evaluateExp(exp))
