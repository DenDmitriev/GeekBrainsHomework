import UIKit

//Домашнее задание
//Дмитриев Денис

//1. Описать несколько структур – любой легковой автомобиль и любой грузовик.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

struct Car {
    var model: String
    var yearRelease: Int
    var volumeTrunk: Int
    var engine: CarAction.Engine = .stop {
        didSet {
            engine == .start ? print(action() + "Двигатель запущен") : print(action() + "Двигатель остановлен")
        }
    }
    var windows: CarAction.Window = .close {
        didSet {
            windows == .close ? print(action() + "Окна закрыты") : print(action() + "Окна открыты")
        }
    }
    var trunk: CarAction.Trunk = .fill(volume: 0) {
        didSet {
            switch trunk {
            case .fill(let volume) where volume <= (volumeTrunk - currentTrunk):
                currentTrunk += volume
                print(action() + "Багажник наполнен на \(volume) литров из возможных \(volumeTrunk), сейчас в багажнике \(currentTrunk) литров")
            case .fill(let volume) where volume > (volumeTrunk - currentTrunk):
                print(action() + "Багажник не может вместить \(volume) литров, есть место только на \(volumeTrunk-currentTrunk) литров")
                trunk = .fill(volume: currentTrunk)
            case .pull(let volume) where volume <= currentTrunk:
                currentTrunk -= volume
                print(action() + "Багажник опусташен на \(volume) литров, осталось \(currentTrunk) литров")
            case .pull(let volume) where volume > currentTrunk:
                print(action() + "В багажнике осталось всего \(currentTrunk) литров")
            default:
                trunk = .fill(volume: currentTrunk)
                print(action() + "Багажник заполнен на \(currentTrunk) из \(volumeTrunk)")
                break
            }
        }
    }
    var currentTrunk: Int = 0
    
    init(model: String, yearRelease: Int, volumeTrunk: Int) {
        self.model = model
        self.yearRelease = yearRelease
        self.volumeTrunk = volumeTrunk
    }
    func discription() {
        print("Машина \(model), года выпуска \(yearRelease), с объемом багажника \(volumeTrunk) литров")
    }
    func action() -> String {
        return model + " -> "
    }
    mutating func engine(work: CarAction.Engine) {
        self.engine = work
        //если машина глушит двигатель, то окна закрываются и наоборот
        if work == .start {
            self.windows = .open
        } else {
            self.windows = .close
        }
    }
}
var opel = Car(model: "Opel Astra", yearRelease: 2008, volumeTrunk: 80)

enum CarAction {
    enum Engine {
        case start
        case stop
    }
    enum Window {
        case open
        case close
    }
    enum Trunk {
        case fill(volume: Int)
        case pull(volume: Int)
    }
    enum Wheels: Int {
        case four = 4
        case six = 6
        case eight = 8
    }
}
opel.discription()
opel.engine = .start
opel.windows = .open
opel.trunk = .fill(volume: 100)
opel.trunk = .fill(volume: 79)
opel.trunk = .pull(volume: 80)
opel.trunk = .pull(volume: 45)
opel.trunk = .pull(volume: 40)



struct Truck {
    var model: String
    var yearRelease: Int
    var tonnage: Int
    var wheels: CarAction.Wheels {
        didSet {
            print(action() + "Колес \(wheels.rawValue)")
        }
    }
    var engine: CarAction.Engine = .stop {
        didSet {
            engine == .start ? print(action() + "Двигатель запущен") : print(action() + "Двигатель остановлен")
        }
    }
    var window: CarAction.Window = .close {
        didSet {
            window == .close ? print(action() + "Окна закрыты") : print(action() + "Окна открыты")
        }
    }
    var trunk: CarAction.Trunk = .fill(volume: 0) {
        didSet {
            switch trunk {
            case .fill(let volume) where volume <= (tonnage - currentTrunk):
                currentTrunk += volume
                print(action() + "Кузов наполнен на \(volume) тон из возможных \(tonnage), сейчас в кузове \(currentTrunk) тон")
            case .fill(let volume) where volume > (tonnage - currentTrunk):
                print(action() + "Кузов не может вместить \(volume) тон, есть место только на \(tonnage-currentTrunk) тон")
                trunk = .fill(volume: currentTrunk)
            case .pull(let volume) where volume <= currentTrunk:
                currentTrunk -= volume
                print(action() + "Кузов опусташен на \(volume) тон, осталось \(currentTrunk) тон")
            case .pull(let volume) where volume > currentTrunk:
                print(action() + "В кузове осталось всего \(currentTrunk) тон")
            default:
                trunk = .fill(volume: currentTrunk)
                print(action() + "Кузов заполнен на \(currentTrunk) из \(tonnage)")
                break
            }
        }
    }
    var currentTrunk: Int = 0
    
    init(model: String, yearRelease: Int, tonnage: Int, wheels: CarAction.Wheels) {
        self.model = model
        self.yearRelease = yearRelease
        self.tonnage = tonnage
        self.wheels = wheels
    }
    func discription() {
        print("Грузовик \(model), года выпуска \(yearRelease), с грузоподъемностью кузова \(tonnage) тонн")
    }
    func action() -> String {
        return model + " -> "
    }
    
    mutating func changeWheels(wheels: CarAction.Wheels) {
        switch wheels {
        case .four:
            self.tonnage = self.tonnage/self.wheels.rawValue * wheels.rawValue
        case .six:
            self.tonnage = self.tonnage/self.wheels.rawValue * wheels.rawValue
        case .eight:
            self.tonnage = self.tonnage/self.wheels.rawValue * wheels.rawValue
        }
        self.engine = .stop
        self.wheels = wheels
    }
}
var kamaz = Truck(model: "Kamaz 6580", yearRelease: 2015, tonnage: 25, wheels: .six)
kamaz.discription()
kamaz.engine = .start
kamaz.window = .open
kamaz.currentTrunk
kamaz.trunk = .fill(volume: 26)
kamaz.trunk = .fill(volume: 15)
kamaz.trunk = .pull(volume: 24)
kamaz.trunk = .pull(volume: 2)
kamaz.trunk = .pull(volume: 13)

var nissan = Car(model: "Nissan Almera", yearRelease: 2007, volumeTrunk: 100)
nissan.discription()
nissan.windows = .close //окна закрыты
nissan.engine(work: .start) //окна открыты
nissan.engine(work: .stop) //снова закрыты

var gazzel = Truck(model: "Газ 3302", yearRelease: 2018, tonnage: 9, wheels: .four)
gazzel.engine = .start
gazzel.window = .open
gazzel.discription() //Грузовик Газ 3302, года выпуска 2018, с грузоподъемностью кузова 9 тонн
gazzel.changeWheels(wheels: .six) //грузоподъемность зависит от кол-ва колес и тоже меняется
gazzel.discription() //Грузовик Газ 3302, года выпуска 2018, с грузоподъемностью кузова 12 тонн

if kamaz.tonnage >= gazzel.tonnage {
    print("\(kamaz.model) имеет большую грузоподъемность")
} else {
    print("\(gazzel.model) большую грузоподъемность")
}

opel.discription()
nissan.discription()
opel.yearRelease >= nissan.yearRelease ? print("\(opel.model) выпущен позже, в \(opel.yearRelease) году") : print("\(nissan.model) выпущен позже, в \(nissan.yearRelease) году")





