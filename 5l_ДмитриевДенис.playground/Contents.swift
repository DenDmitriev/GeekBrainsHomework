import UIKit

//Дмитриев Денис
//Домашнее задание 5

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.

//5. Создать несколько объектов каждого класса. Применить к ним различные действия.

//6. Вывести сами объекты в консоль.

enum Condition: Double {
    case new = 1
    case used = 0.7
    case broken = 0.3
}

protocol Car {
    var model: String { get }
    var year: Int { get }
    var mileage: Int { get set }
    var price: Int { get set }
    var status: Condition { get set }
    
    func custom(value: Int) -> (Bool, String)
}

extension Car {
    
    func nameCar() -> String {
        return "Автомобиль \(self.model), \(self.year) года, пробег \(self.mileage) км"
    }
    
    func service(mileage: Int, status: Condition) -> String {
        switch status {
        case .new:
            return "Сервис не требуется"
        case .used:
            if mileage >= 80000 {
                let answer = "Требуется обслуживание для \(self.model) в сервисе"
                print(answer)
                return answer
            } else {
                let answer = "Сервис для \(self.model) потребуется после \(80000 - mileage) км"
                print(answer)
                return answer
            }
        case .broken:
            let answer = "Необходим ремонт для \(self.model)"
            print(answer)
            return "Необходим ремонт для \(self.model)"
        }
    }
    
    mutating func sale(money: Int) -> (Bool, String) {
        self.price = price(newmileage: self.mileage)
        let deal = money >= self.price ? true : false
        if deal {
            let answer = "\(nameCar()) продана за \(money) рублей"
            print(answer)
            return ( deal, answer )
        } else {
            let answer = "Продажа \(nameCar()) не удалась, стоисмоть = \(self.price) рублей"
            print(answer)
            return ( deal,  answer)
        }
    }
    
    mutating func price(newmileage: Int) -> Int {
        self.mileage = newmileage
        self.price = Int(self.status.rawValue * 1/Double(newmileage)*1000000000)
        return self.price
    }
}

class SportCar: Car, CustomStringConvertible {
    
    var description: String {
        return "Автомобиль \(self.model), \(self.year) года, пробег \(self.mileage) км, оценка стоимости \(price), состояние \(status)"
    }
    
    var model: String
    
    var year: Int
    
    var mileage: Int {
        didSet {
            print("\(nameCar()) имеет пробег \(mileage) км")
        }
    }
    
    var price: Int {
        didSet {
            print("\(nameCar()) оценен в \(price) рублей")
        }
    }
    
    var status: Condition = .new
    
    init(model: String, year: Int, mileage: Int) {
        self.model = model
        self.year = year
        self.mileage = mileage
        if mileage <= 5000 {
            self.status = .new
        } else {
            self.status = .used
        }
        self.price = Int(self.status.rawValue * 1/Double(self.mileage)*1000000000)
    }
    
    func custom(value: Int) -> (Bool, String) {
        let deal = value >= self.price ? true : false
        if deal {
            let answer = "\(nameCar()) куплен за \(value) рублей"
            print(answer)
            return ( deal, answer )
        } else {
            let answer = "Купить \(nameCar()) не удалось, стоисмоть = \(self.price) рублей"
            print(answer)
            return ( deal, answer)
        }
    }
    
    
}

var subaru = SportCar(model: "Subaru WRX STI 2.5T", year: 2019, mileage: 1000)
print(subaru.description)
subaru.service(mileage: 20000, status: .used)
subaru.service(mileage: 80000, status: .used)
subaru.custom(value: 99999)
subaru.custom(value: 1000000)
subaru.price(newmileage: 80000)
subaru.custom(value: 12500)
subaru.sale(money: 1250)


class TrunkCar: Car, CustomStringConvertible {
    
    var description: String {
        return "Грузовик \(self.model), \(self.year) года, пробег \(self.mileage) км, оценка стоимости \(price), состояние \(status), сейчас \(self.custom(value: self.track))"
    }
    
    var model: String
    
    var year: Int
    
    var mileage: Int
    
    var status: Condition
    
    var price: Int
    
    var track: Int
    
    var order: Track
    
    enum Track {
        case park
        case sort
        case drive
        case delivered
    }
    
    init(model: String, year: Int, mileage: Int, track: Int) {
        self.model = model
        self.year = year
        self.mileage = mileage
        self.track = track
        if mileage <= 5000 {
            self.status = .new
        } else {
            self.status = .used
        }
        self.price = Int(self.status.rawValue * 80000/Double(self.mileage))
        self.order = .park
    }
    
    func custom(value: Int) -> (Bool, String) {
        track = value
        switch order {
        case .park:
            let answer = "\(nameCar()) ожидает заказа"
            print(answer)
            return (true, answer)
        case .sort:
            let answer = "\(nameCar()) на погрузке \(self.track)"
            print(answer)
            return (false, answer)
        case .drive:
            let answer = "\(nameCar()) в пути по заказу \(self.track)"
            print(answer)
            return (false, answer)
        case .delivered:
            let answer = "\(nameCar()) доставил заказ \(self.track)"
            print(answer)
            return (true, answer)
        }
    }
}

var maz = TrunkCar(model: "МАЗ 975830-3061", year: 2015, mileage: 120000, track: 545)
print(maz.description)
maz.order = .sort
maz.order = .drive
maz.order = .delivered
maz.order = .park
