import UIKit

//Домашняя работа
//Дмитриев Денис

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)

//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.



struct Queue<T: Comparable>: CountQueue {

    var persons: [T] = []
    
    var count: Int {
        get {
            print("Сейчас длина в очереди = \(persons.count)")
            return persons.count
        }
    }
    var target: String
    
    init(persons: [T], target: String) {
        self.persons = persons
        self.target = target
        print("Создана очеред из \(persons) к \(target)")
    }
    
    mutating func push(_ person: T) {
        print("Новый член очереди \(person) к \(target)")
        persons.append(person)
    }
    mutating func move() -> T {
        print("\(persons.first!) зашел к \(target), теперь первый \(persons[1])")
        return persons.removeFirst()
    }
    
    func findQueue(_ person: T) -> Int? {
        var index: Int?
        index = persons.firstIndex { (member) -> Bool in
            member == person
        }
        guard index != nil else {
            print("\(person) не обнаружен в очереди к \(target)")
            return nil
        }
        print("\(person) имеет номер \(index!+1) в очереди к \(target)")
        return index
    }
    
    func filter(_ condition: (T) -> Bool ) -> [T] {
        var newArray = [T]()
        for person in persons {
            if condition(person) {
                newArray.append(person)
            }
        }
        print("Массив \(persons) отфильтрован до \(newArray)")
        return newArray
    }
    
    func sorted(_ condition: (T, T) -> Bool) -> [T] {
        return persons.sorted { (personA, personB) -> Bool in
            return condition(personA, personB) ? true : false
        }
    }
    
    //Для удобства мой сабскрипт начинается с 1 а не с 0, для отличия с класическим
    subscript(index: Int) -> T? {
        guard index <= persons.count && index != 0 else {
            print("Очередь имеет длину \(persons.count) и начинается с 1")
            return nil
        }
        let person: T = persons[index-1]
        print("Под номером \(index) в очереди \(person)")
        return person
    }
}

protocol CountQueue {
    var count: Int { get }
    var target: String { get }
}


var zooQueue = Queue(persons: ["🦊", "🐼", "🐷"], target: "Ветеринару")
zooQueue.push("🐵")
zooQueue.move()
print(zooQueue)
zooQueue.findQueue("🐷")
zooQueue.findQueue("🦊")
zooQueue.count
var sortedZooQueue = zooQueue.sorted { $0 < $1 }
print(sortedZooQueue)
print(zooQueue)
zooQueue[1]
zooQueue[5]

print("_____")


var intQueue = Queue(persons: [12,46,31,4,59], target: "Задаче")
intQueue.push(61)
intQueue.move()
print(intQueue)
intQueue.findQueue(43)
intQueue.findQueue(99)
intQueue.count

var newQueue = intQueue.filter { (person) -> Bool in
    person % 2 == 0
}
print(newQueue)

newQueue = intQueue.filter { $0 % 2 == 1 }
print(newQueue)

newQueue = intQueue.sorted { $0 > $1 }
print(newQueue)

intQueue[2]
intQueue[0]
print("_____")


enum Sport: String {
    case Football = "⚽️"
    case Basketball = "🏀"
    case Rugby = "🏈"
    case Baseball = "⚾️"
    case Volleyball = "🏐"
}

var sportQueue = Queue(persons: [Sport.Football.rawValue, Sport.Baseball.rawValue, Sport.Rugby.rawValue], target: "Игре")
sportQueue.push(Sport.Volleyball.rawValue)
sportQueue.move()
sportQueue.findQueue(Sport.Rugby.rawValue)
sportQueue.findQueue(Sport.Football.rawValue)
sportQueue.count
print(sportQueue)
var newSportQueue = Queue(persons: sportQueue.sorted { $0 > $1 }, target: "Игре")
print(newSportQueue)
sportQueue[3]
newSportQueue[3]
print("_____")

