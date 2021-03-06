//: [Previous](@previous)

import UIKit

printLine("Properies")

printLine("Stored Properties")

//Instances of FixedLengthRange have a variable stored property called firstValue and a constant stored property called length.
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 7


printLine("Stored Properties of Constant Structure Instances")

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//以下这句是不行的，因为rangeOfFourItems是常量FixedLengthRange的struct类型，是值类型，其值不能修改。而类因为是引用类型则可以。
//rangeOfFourItems.firstValue = 9

printLine("Lazy Stored Properties")
// lazy property must always be variable
// lazy 属性在声明前加上 lazy 关键字
// 如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次

class DataImporter {
    var name: String = ""
    init() {
        self.name = "DataImporter"
        print("...\(self.name)...")
    }
}

class DataManager {
    lazy var importer = DataImporter()
    var data: Array<String> = []
}

let dataManager = DataManager()
dataManager.data.append("Data_0")
dataManager.data.append("Data_1")
dataManager.data.append("Data_2")
// lazy 变量还未初始化
print("the DataImporter instance for the importer property has not yet been created")

// 主动调用才初始化
dataManager.importer


printLine("Computed Properties")

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width  = 0.0
    var height = 0.0
}

struct Rect {
    var origin = Point()
    var size   = Size()
    
    // 必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的
    var center: Point {
        get {
            var p = Point()
            p.x = origin.x + size.width/2
            p.y = origin.y + size.width/2
            return p
        }
        
        set(p) {
            origin.x = p.x - size.width/2
            origin.y = p.y - size.height/2
        }
        
        /*
        //set 有更简洁的写法，set重命名参数的话默认参数名为newValue
         
        set {
            origin.x = newValue.x - size.width/2
            origin.y = newValue.y - size.height/2
        }
        */
    }
}



var square = Rect(origin: Point(x:0.0, y:0.0), size: Size(width: 10.0, height: 10.0))
let squareCenter = square.center
print("square center is (\(squareCenter.x), \(squareCenter.y))")

square.center = Point(x: 15.0, y: 15.0)
print("square new origin is (\(square.origin.x), \(square.origin.y))")



class Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    
    // 更简单的getter的写法
    var volume: Double {
        return width*height*depth
    }
    
    init(width: Double, height: Double, depth: Double) {
        self.width  = width
        self.height = height
        self.depth  = depth
    }
}

let fourByFiveByTwo = Cuboid(width:4.0, height:5.0, depth:2.0)
print(fourByFiveByTwo.volume)


// 属性观察器
class StepCounter
{
    var totalSteps: Int = 0 {
        // 默认的分别是newValue & oldValue
        willSet(newValue) {
            print("About to set totalSteps to \(newValue)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps-oldValue) steps")
            }
        }
    }
    
    var serialNumber: String = "0000-00000-0000000-000" {
        // 不想用newValue & oldValue 可以命名为别的方法
        willSet(newSerialNumber) {
            print("New serial number \(newSerialNumber)")
        }
        
        didSet(oldSerialNumber) {
            print("Old serial number \(oldSerialNumber)")
        }
    }
}


let stepCounter = StepCounter()

stepCounter.totalSteps = 100
stepCounter.totalSteps = 300
stepCounter.totalSteps = 657
stepCounter.totalSteps = 257
stepCounter.serialNumber = "0010-23873-83F123A-ECA"
stepCounter.serialNumber = "10A0-8376C-247232E-EST"


// 类型属性
struct SomeStructure {
    static var storedType = "Structure"
    static var computedType: Int {
        return 1;
    }
}

enum SomeEnumeration {
    static var v: String = "ComputedEnumeration"
    static var storedType = "Enumeration"
    static var computedType: String {
        get {
            return "get" + v
        }
        
        set(v) {
            self.v = v
        }
    }
}

class SomeClass {
    static var storedType = "Class"
    static var computedType: String {
        return "ComputedClass"
    }
}

print(SomeStructure.storedType)
print(SomeEnumeration.storedType)
print(SomeClass.storedType)

print(SomeStructure.computedType)
print(SomeEnumeration.computedType)
SomeEnumeration.computedType = "ComputedEnumerationV2"
print(SomeEnumeration.computedType)
print(SomeClass.computedType)

