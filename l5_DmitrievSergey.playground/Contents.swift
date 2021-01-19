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




