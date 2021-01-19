import UIKit

enum DoorsState: String {
    case isOpen = "Открыты", isClose = "Закрыты"
}

enum DoorsActions {
    case open, close
}

protocol DoorsP {
    var doorsState: DoorsState {get set}
    mutating func doActionWithDoors(_ action: DoorsActions)
}

extension DoorsP {
    var doorsState: DoorsState{
        get{return self.doorsState}
        set{self.doorsState = newValue}
    }
    mutating func doActionWithDoors(_ action: DoorsActions) {
        switch action {
        case .open:
            doorsState = .isOpen
        case .close:
            doorsState = .isClose
            
        }
    }
}


enum WindowState: String {
    case isOpen = "Открыты", isClose = "Закрыты"
}

enum WindowsActions{
    case open, close
}

protocol WindowsP {
    var windowsState: WindowState {get set}
    mutating func doActionWithWindows(_ action: WindowsActions)
}

extension WindowsP {
    var windowsState: WindowState{
        get{return self.windowsState}
        set{self.windowsState = newValue}
    }
    mutating func doActionWithWindows(_ action: WindowsActions) {
        switch action {
        case .open:
            windowsState = .isOpen
        case .close:
            windowsState = .isClose
            
        }
    }
}

enum EngineState: String {
    case on = "Включен", off = "Выключен"
}

enum EngineActions {
    case turnOff, turnOn
}

protocol EngineP {
    var engineState: EngineState {get set}
    mutating func doActionWithEngine(_ action: EngineActions)
}

extension EngineP {
    var engineState: EngineState{
        get{return self.engineState}
        set{self.engineState = newValue}
    }
    mutating func doActionWithEngine(_ action: EngineActions) {
        switch action {
        case .turnOn:
            print("Extension EngineP: включаюсь из расширения. Состояние двигателя - \(engineState)")
            engineState = .on
            print("Extension EngineP: Двигатель запущен. Состояние двигателя - \(engineState)")
        case .turnOff:
            engineState = .off
            
        }
    }
}

enum TrunkState: String {
    case isOpen = "Открыт", isClose = "Закрыт"
}

enum TrunkActions {
    case put(value: Double), take(value: Double)
    case open, close
}

protocol TrunkP {
    var trunkState: TrunkState {get set}
    var maxTrunkVolume: Double {get}
    var currentTrunkVolume: Double {get set}
    mutating func doActionWithTrunk(_ action: TrunkActions)
}

extension TrunkP {
    var trunkState: TrunkState{
        get{return self.trunkState}
        set{self.trunkState = newValue}
    }
    var maxTrunkVolume: Double {
        get{return self.maxTrunkVolume}
    }
    var currentTrunkVolume: Double {
        get{return self.currentTrunkVolume}
        set{ self.currentTrunkVolume = newValue}
    }
    mutating func doActionWithTrunk(_ action: TrunkActions) {
        switch action {
        case .open:
            print("Extension TrunkP: открываюсь из расширения. Состояние багажника - \(trunkState)")
            trunkState = .isOpen
            print("Extension TrunkP: Багажник открыт. Состояние багажника - \(trunkState)")
        case .close:
            trunkState = .isClose
        case let .put(value: value):
            guard (currentTrunkVolume + value) <= maxTrunkVolume else {
                print("Указанный объем превышает максимальный объем багажника")
                return
            }
            currentTrunkVolume += value
            print("Extension TrunkP: в багажник положили \(value). Заполненный объем багажника \(currentTrunkVolume) из \(maxTrunkVolume)")
        case let .take(value: value):
            guard  (currentTrunkVolume - value) >= 0 else {
                print("В багажнике \(currentTrunkVolume), вы пытаетесь забрать \(value). Операция недоступна")
                return
            }
            print("Extension TrunkP: Из багажника забрали \(value).")
            
        }
    }
}

protocol CarP: WindowsP, DoorsP, EngineP{
    var brand:String { get set}
    var year: Int { get }
}

extension CarP {
    var brand: String {
        get{ return self.brand}
        set{self.brand = newValue}
    }
}

class TrunkCar: CarP, TrunkP {
    var brand:String
    let year: Int
    let maxTrunkVolume: Double
    var currentTrunkVolume: Double
    var doorsState: DoorsState
    var windowsState: WindowState
    var engineState: EngineState
    var trunkState: TrunkState
    
    init(brand: String, year: Int, maxTrunkVolume: Double, currentTrunkVolume: Double, doorsState: DoorsState, windowsState: WindowState, engineState: EngineState, trunkState: TrunkState){
        self.brand = brand
        self.year = year
        self.maxTrunkVolume = maxTrunkVolume
        self.currentTrunkVolume = currentTrunkVolume
        self.doorsState = doorsState
        self.windowsState = windowsState
        self.engineState = engineState
        self.trunkState = trunkState
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Марка - \(brand). Год выпуска - \(year). Вместимость багажника - \(maxTrunkVolume). Заполненность багажника - \(currentTrunkVolume).Двери -  \(doorsState.rawValue). Окна - \(windowsState.rawValue). Двигатель - \(engineState.rawValue). Багажник - \(trunkState.rawValue)"
    }
}

class CarWDE: CarP {
    var brand:String
    let year: Int
    var doorsState: DoorsState
    var windowsState: WindowState
    var engineState: EngineState
    
    init(brand: String, year: Int, doorsState: DoorsState, windowsState: WindowState, engineState: EngineState) {
        self.brand = brand
        self.year = year
        self.doorsState = doorsState
        self.windowsState = windowsState
        self.engineState = engineState
    }
}

extension CarWDE: CustomStringConvertible {
    var description: String {
        return "Марка - \(brand). Год выпуска - \(year). Двери -  \(doorsState.rawValue). Окна - \(windowsState.rawValue). Двигатель - \(engineState.rawValue)."
    }
}

var car1 = CarWDE(brand: "Volvo", year: 2020, doorsState: .isClose, windowsState: .isClose, engineState: .off)

print(car1)

print("\(car1.doorsState)")
print("\(car1.windowsState)")
print("\(car1.engineState)")
print("\(car1.brand)")
print("\(car1.year)")
car1.doActionWithDoors(.open)
car1.doActionWithWindows(.open)
car1.doActionWithEngine(.turnOn)
print("\(car1.doorsState)")
print("\(car1.windowsState)")
print("\(car1.engineState)")
car1.brand = "Opel"
print("\(car1.brand)")

var car2 = TrunkCar(brand: "Volvo", year: 2021, maxTrunkVolume: 500, currentTrunkVolume: 0, doorsState: .isClose, windowsState: .isClose, engineState: .off, trunkState: .isClose)

car2.doActionWithDoors(.open)
print("\(car2.doorsState)")
print("\(car2.currentTrunkVolume)")
car2.doActionWithTrunk(.put(value: 100))
print(car2)
car2.doActionWithTrunk(.put(value:500))



