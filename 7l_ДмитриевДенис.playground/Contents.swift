import UIKit

//Дмитриев Денис
//Домашнее задание


//1. Придумать класс, методы которого могут создавать непоправимые ошибки. Реализовать их с помощью try/catch.
class DownlodsTask {
    var data: Data = Data()
    func getData() {
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: "path"))
        } catch let error {
            print(error)
        }
    }
}
let someDownloadsTask = DownlodsTask()
someDownloadsTask.getData()


//2. Придумать класс, методы которого могут завершаться неудачей. Реализовать их с использованием Error.

struct Candy {
    var count: Int
    var price: Int
}

enum CandyMachineError: Error {
    case notAvailable(name: String)
    case notEnough(coinsNedded: Int)
    case outOfStock(name: String)
}

class CandyMachine {
    
    var candyBank = [
        "M&M": Candy(count: 1, price: 3),
        "Skittles": Candy(count: 0, price: 2),
        "Gummy": Candy(count: 2, price: 5),
    ]
    var coins: Int = 0
    
    func give(_ candy: String) {
        print("Заберите \(candy)")
    }
    
    func buy(candyName: String) throws {
        guard var candy = candyBank[candyName] else {
            throw CandyMachineError.notAvailable(name: candyName)
        }
        guard candy.count > 0 else {
            throw CandyMachineError.outOfStock(name: candyName)
        }
        guard coins >= candy.price else {
            throw CandyMachineError.notEnough(coinsNedded: candy.price - coins)
        }
        coins -= candy.price
        candy.count -= 1
        candyBank[candyName] = candy
        give(candyName)
    }
}

var candyMachine = CandyMachine()
candyMachine.coins = 3
do {
    try candyMachine.buy(candyName: "Meller")
} catch CandyMachineError.notAvailable(let name) {
    print("Конфет \(name) нет в аппарате")
} catch CandyMachineError.outOfStock(let name) {
    print("Конфеты \(name) закончились")
} catch CandyMachineError.notEnough(let coinsNedded) {
    print("Не достаточно внесенных денег, нужно еще \(coinsNedded)")
}
//Конфет Meller нет в аппарате

func buyCandy(name: String, coins: Int, machine: CandyMachine) throws {
    machine.coins = coins
    do {
        try candyMachine.buy(candyName: name)
    } catch CandyMachineError.notAvailable(let name) {
        print("Конфет \(name) нет в аппарате")
    } catch CandyMachineError.outOfStock(let name) {
        print("Конфеты \(name) закончились")
    } catch CandyMachineError.notEnough(let coinsNedded) {
        print("Не достаточно внесенных денег, нужно еще \(coinsNedded)")
    }
}

try! buyCandy(name: "Skittles", coins: 3, machine: candyMachine)
//Конфеты Skittles закончились
try! buyCandy(name: "Gummy", coins: 3, machine: candyMachine)
//Не достаточно внесенных денег, нужно еще 2
try! buyCandy(name: "Meller", coins: 5, machine: candyMachine)
//Конфет Meller нет в аппарате
try! buyCandy(name: "Gummy", coins: 5, machine: candyMachine)
//Заберите Gummy

