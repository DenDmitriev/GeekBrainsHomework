import UIKit

//Дмитриев Денис
//Домашнее задание

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.

//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

//6. Вывести значения свойств экземпляров в консоль.

class Car: CustomStringConvertible {
    let typeCar: Kind
    
    let model: String
    let yearRelease: Int
    let massTrunk: Int
    
    var work: Engine = .stop {
        didSet {
            work == .start ? print("\(carName())Двигатель заведен") : print("\(carName())Двигатель остановлен")
        }
    }
    var windows: Window = .close {
        didSet {
            windows == .open ? print("\(carName())Окна открыты") : print("\(carName())Окна закрыты")
        }
    }
    var trunkCurrent: Int = 0
    var trunkPut: Trunk = .empty {
        didSet {
            switch trunkPut {
            case .put(let mass) where mass <= (massTrunk - trunkCurrent):
                trunkCurrent += mass
                print("\(String(describing: carName))Погрузка +\(mass), \(trunkCurrent)/\(massTrunk)")
            case .get(let mass) where mass <= trunkCurrent:
                trunkCurrent -= mass
                print("\(String(describing: carName))Разгрузка -\(mass), \(trunkCurrent)/\(massTrunk)")
            case .empty:
                let mass = trunkCurrent
                trunkCurrent = 0
                print("\(String(describing: carName))Пустой -\(mass), \(trunkCurrent)/\(massTrunk)")
            default:
                print("Груз не подходит")
            }
        }
    }
    
    init(type: Kind, model: String, year: Int, trunk: Int) {
        self.model = model
        self.yearRelease = year
        self.typeCar = type
        self.massTrunk = trunk
    }
    
    var description: String {
        return "\(String(describing: carName))Автомобиль типа \(typeCar), модель \(model), \(yearRelease) года"
    }
    
    enum Kind {
        case sedan, cargo
    }
    enum Engine: String {
        case start = "Заведен"
        case stop = "Заглушен"
    }
    enum Window {
        case close, open
    }
    enum Trunk {
        case put(mass: Int)
        case get(mass: Int)
        case empty
    }
    
    func carName() -> String {
        return model + " -> "
    }
    func action() {
        //действия
    }
}

class SportCar: Car {
    var maxSpeed: Int
    var speed: Int = 0 {
        didSet {
            print("\(carName())Скорость \(speed)/\(maxSpeed)")
        }
    }
    var turboBoost: Nitro = .ready {
        didSet {
            if work == .start {
                switch turboBoost {
                case .all where work == .start && nitroBallon >= Baloon.refill.rawValue:
                    nitroBallon += Baloon.full.rawValue
                    print("\(carName())Максимальное ускорение, нитро \(nitroBallon)/100")
                    speed += maxSpeed
                case .half where work == .start && nitroBallon >= Baloon.half.rawValue:
                    nitroBallon += Baloon.half.rawValue
                    print("\(carName())Среднее ускорение, нитро \(nitroBallon)/100")
                    speed += maxSpeed/2
                case .quarter where work == .start && nitroBallon >= Baloon.quarter.rawValue:
                    nitroBallon += Baloon.quarter.rawValue
                    print("\(carName())Ускорение, нитро \(nitroBallon)/100")
                    speed += maxSpeed/4
                case .refill:
                    print("\(carName())Нужно заглушить двигатель")
                default:
                    print("\(carName())Не достаточно газа в балоне")
                }
            } else {
                switch turboBoost {
                case .refill:
                    speed = 0
                    nitroBallon = Baloon.refill.rawValue
                    print("\(carName())Балон нитро заправлен \(nitroBallon)/100")
                default:
                    print("\(carName())Нужно завести двигатель")
                }
            }
        }
    }
    var nitroBallon = 100
    var dateService: Date
    
    init(type: Car.Kind, model: String, year: Int, trunk: Int, maxSpeed: Int, dateService: Date) {
        self.maxSpeed = maxSpeed
        self.dateService = dateService
        super.init(type: type, model: model, year: year, trunk: trunk)
    }
    
    enum Baloon: Int {
        case refill = 100
        case full = -100
        case half = -50
        case quarter = -25
    }
    enum Nitro {
        case ready, all, half, quarter, refill
    }
    enum PitStop: CustomStringConvertible {
        case tire, petrol, oil, repair, fullService
        var description: String {
            switch self {
            case .tire:
                return "Замена шин произведена"
            case .petrol:
                return "Заправлен полный бак"
            case .oil:
                return "Замена масла произведена"
            case .repair:
                return "Ремонт сделан"
            case .fullService:
                return "Полное обслуживание произведено"
            }
        }
    }
    enum Custom: CustomStringConvertible {
        case color(color: UIColor)
        case nitro(N2O: Int)
        var description: String {
            switch self {
            case .color:
                return "Машина перекрашена"
            case .nitro:
                return "Объем N2O увеличен"
            }
        }
    }
    enum Menu {
        case service(PitStop)
        case update(Custom)
        case drive(Engine)
        case wind(Window)
    }
    
    func make(menu: Menu) {
        if work == .start {
            work = .stop
        }
        switch menu {
        case .service(let operation):
            dateService = Date()
            let time = dateService.description
            print("\(operation ) в \(time)")
        case .update(let custom):
            print(custom)
            switch custom {
            case .color(let color):
                print("Новый цвет машины \(color)")
            case .nitro(let void):
                nitroBallon = void
                print("Объем балона N2O \(nitroBallon)")
            }
        case .drive(let status):
            work = status
        case .wind(let status):
            windows = status
        }
    }
    override var description: String {
        return super.description + " ,сервис \(dateService), балон N2O \(nitroBallon)"
    }
    
    override func action() {
        print(description)
    }
}

var shelby = SportCar(type: .sedan, model: "Ford Shelby", year: 2015, trunk: 50, maxSpeed: 300, dateService: Date())
print(shelby.description)
shelby.turboBoost = .quarter
shelby.make(menu: .drive(.start))
shelby.turboBoost = .half
shelby.turboBoost = .quarter
shelby.turboBoost = .refill
shelby.work = .stop
shelby.turboBoost = .refill
shelby.work = .start
shelby.turboBoost = .all
shelby.make(menu: .wind(.open))
shelby.make(menu: .service(.oil))
shelby.make(menu: .service(.petrol))
shelby.make(menu: .update(.nitro(N2O: 200)))
shelby.make(menu: .update(.color(color: .cyan)))
shelby.make(menu: .service(.fullService))
shelby.action()

print("____________________")

class TrunkCar: Car {
    
    var driver: Driver
    var fuel: Tank
    
    var status: Mode = .free
    var mass: Int = 0
    
    enum Mode: String {
        case free = "Свободен"
        case hold = "Занят заказом"
    }

    enum Tank: String {
        case full = "полный бак"
        case half = "пол бака"
        case quater = "мало"
        case empty = "нужна заправка"
    }
    
    enum Rate: Int {
        case express = 2
        case ordinary = 1
    }

    enum Cargo {
        case mass(kg: Int)
        case type(Rate)
        case distance(km: Int)
        case driver(Driver)
    }
    enum Driver: String {
        case one = "Алексей"
        case two = "Владимир"
        case three = "Ярослав"
    }
    enum Drive {
        case order(Cargo)
        case refill(Tank)
        case load(Trunk)
        case work(Engine)
        case status(Mode)
    }

    init(type: Car.Kind, model: String, year: Int, trunk: Int, driver: String, fuel: Tank) {
        self.driver = .one
        self.fuel = fuel
        super.init(type: type, model: model, year: year, trunk: trunk)
    }
    override var description: String {
        return super.description + ", Водитель \(driver), Топливо \(fuel.rawValue)"
    }
    
    
    func order(trunk: TrunkCar, mass: Int, type: Rate, distance: Int, money: Int) -> () {
        guard trunk.status == .free else { return console(text: trunk.status.rawValue) }
        guard trunk.fuel == .full || trunk.fuel == .half else { return console(text: "Грузовик тербуется заправить") }
        guard mass <= trunk.massTrunk else { return console(text: "\(trunk.model) вмещает только \(trunk.massTrunk)")}
        let cost = type.rawValue * distance + mass
        guard money >= cost else { return console(text: "Для выполнения заказа необходимо \(cost) рублей") }
        let message = "Заказ на доставку для \(trunk.model) груза весом \(mass) принят и его будет выполнять \(trunk.driver.rawValue). Стоимость доставки \(cost)"
        trunk.mass = mass
        return console(text: message)
    }
    func console(text: String) {
        print("\(carName())\(text)")
    }
    func prepareToOrder(trunk: Drive) {
        print("\(carName())с водителем \(self.driver.rawValue) принял заказ и начинает подготовку")
        switch trunk {
        case .load(let cargo):
            switch cargo {
            case .put(mass: mass):
                trunkPut = .put(mass: mass)
            default:
                return
            }
            fallthrough
        case .refill:
            fuel = .full
            print("\(carName())Статус бака - \(fuel.rawValue)")
            fallthrough
        case .work:
            work = .start
            fallthrough
        case .status:
            status = .hold
            print("\(carName())\(status.rawValue)")
        default:
            return
        }
    }
    
    override func action() {
        print(description)
    }
}

let gasel = TrunkCar(type: .cargo, model: "Газ 2020", year: 2020, trunk: 500, driver: "Алексей", fuel: .full)
print(gasel.description)
gasel.order(trunk: gasel, mass: 100, type: .express, distance: 500, money: 1000)
gasel.order(trunk: gasel, mass: 1000, type: .express, distance: 500, money: 1000)
gasel.order(trunk: gasel, mass: 500, type: .express, distance: 500, money: 2000)
gasel.prepareToOrder(trunk: .load(.put(mass: 500)))

