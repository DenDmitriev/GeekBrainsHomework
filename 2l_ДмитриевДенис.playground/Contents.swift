import UIKit

//Домашнее задание
//Дмитриев Денис

// MARK: - Задание 1
//Написать функцию, которая определяет, четное число или нет

func even(number someNumber: Int) -> Bool {
    (someNumber % 2) == 0 ? true : false
}

even(number: 2) //true
even(number: 1) //false


// MARK: - Задание 2
//Написать функцию, которая определяет, делится ли число без остатка на 3

func divideByNumber(number someNumber: Int,_ divider: Int) -> Bool {
    (someNumber % divider) == 0 ? true : false
}

divideByNumber(number: 9, 3)
divideByNumber(number: 7, 3)


// MARK: - Задание 3
//Создать возрастающий массив из 100 чисел

//Способ 1
var oneArray = Array(0...99)
oneArray.last //99

//Способ 2
var twoArray: Array<Int> = []
for i in 0...99 {
    twoArray.append(i)
}
twoArray.last //99

//Способ 3
var threeArray: [Int] = []
var index = 0
repeat {
    threeArray.append(index)
    index = threeArray.count
} while threeArray.count < 100
threeArray.last //99

//Способ 4
var fourArray: [Int] = []
while fourArray.count < 100 {
    fourArray.append(fourArray.count)
}
fourArray.last //99


// MARK: - Задание 4
//Удалить из этого массива все четные числа и все числа, которые не делятся на 3

//Способ 1
for (_, value) in oneArray.enumerated() {
    if even(number: value) || !divideByNumber(number: value, 3) {
        oneArray.remove(at: oneArray.firstIndex(of: value)!)
    }
}
oneArray //[3, 9, 15, 21, 27, 33, 39 ...


//Способ 2
index = 0
while index < twoArray.count {
    if even(number: twoArray[index]) || !divideByNumber(number: twoArray[index], 3) {
        twoArray.remove(at: index)
        index -= 1
    }
    index += 1
}
twoArray //[3, 9, 15, 21, 27, 33, 39 ...


//Способ 3
func cleanArray(array: [Int]) -> [Int] {
    var exportArray: [Int] = array
    for item in array {
        if divideByNumber(number: item, 2) || !divideByNumber(number: item, 3) {
            let index = exportArray.firstIndex(of: item)
            exportArray.remove(at: index!)
        }
    }
    return exportArray
}
threeArray = cleanArray(array: threeArray) //[3, 9, 15, 21, 27, 33, 39 ...


// MARK: - Задание 5
//Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов

func fibonacciSequence(count: Int) -> [Double] {
    var newArray: [Double] = [0,1]
    while newArray.count < count {
        let last = newArray.last!
        let beforeLast = newArray[newArray.count - 2]
        let newValue = beforeLast + last
        newArray.append(newValue)
    }
    return newArray
}

let fibonacciArray = fibonacciSequence(count: 100)
fibonacciArray.last //2.189229958345552e+20
fibonacciArray.count //100


// MARK: - Задание 6
//Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги

func simpleSequence(length: Int) -> [Int] {
    var array = [2]
    for simple in array.last!... {
        for value in array {
            if divideByNumber(number: simple, value) {
                break
            }
            if value == array.last {
                array.append(simple)
            }
        }
        if array.count == 100 {
            break
        }
    }
    return array
}

let simpleSeq = simpleSequence(length: 10) //[2, 3, 5, 7, 11, 13, 17, 19, 23, 29
simpleSeq.last //541
simpleSeq.count //100






