import UIKit

//Дмитриев Денис
//Домашнее задание к уроку 1

// MARK: - Задание 1
//Решить квадратное уравнение ax2 + bx + c = 0
print("Задание 1")
//Модель уравнения
struct QuadraticEquation {
    var a: Double
    var b: Double
    var c: Double
}
//Расчет корней квадратного уравнения
func quadraticEquationSolve(_ equation: QuadraticEquation) -> (Double?, Double?) {
    
    print("Уравнение \(equation.a)x2 + \(equation.b)x + \(equation.c) = 0")

    func discrimenant(a: Double, b: Double, c: Double) -> Double {
        return pow(b, 2) - 4*a*c
    }

    let dis = discrimenant(a: equation.a, b: equation.b, c: equation.c)
    print("Дискрименант = \(dis)")
    
    var x1: Double?
    var x2: Double?
    
    if dis == 0 {
        x1 = -equation.b / 2 * equation.a
        x2 = x1
        print("Корень x = \(x1!)")
    } else if dis > 0 {
        x1 = (-equation.b + pow(dis, 0.5)) / 2 * equation.a
        x2 = (-equation.b - pow(dis, 0.5)) / 2 * equation.a
        print("Корень x1 = \(x1!)")
        print("Корень x2 = \(x2!)")
    } else if dis < 0 {
        print("Корней нет")
    }
    return (x1, x2)
}

//Примеры уравнений
let oneQuEq = QuadraticEquation(a: 1, b: 5, c: -6)
let solveOne = quadraticEquationSolve(oneQuEq) // (1, 6)

let twoQuEq = QuadraticEquation(a: 1, b: 2, c: 1)
let solveTwo = quadraticEquationSolve(twoQuEq) // (-1, -1)

let threeQuEq = QuadraticEquation(a: 1, b: 1, c: 1)
let solveThree = quadraticEquationSolve(threeQuEq) // (nil, nil)



// MARK: - Задание 2
//Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника
print("Задание 2")
//Модель прямоугольного треугольника
struct RightTriangle {
    let catetA: Double
    let catetB: Double
}
//Расчет площади треугольника
func areaRightTriangle(triangel: RightTriangle) -> Double {
    let area = 1/2 * triangel.catetA * triangel.catetB
    print("Площадь пр. треугольника с катетами \(triangel.catetA) и \(triangel.catetB) = \(area)")
    return area
}
//Расчет гипотенузы треугольника
func hypotenuseRightTriangle(triangel: RightTriangle) -> Double {
    let hyp = pow(pow(triangel.catetA, 2) + pow(triangel.catetB, 2), 1/2)
    print("Гипотенуза пр. треугольника с катетами \(triangel.catetA) и \(triangel.catetB) = \(hyp)")
    return hyp
}
//Расчет периметра треугольника
func perimetrRightTriangle(triangel: RightTriangle) -> Double {
    let hyp = pow(pow(triangel.catetA, 2) + pow(triangel.catetB, 2), 1/2)
    let per = triangel.catetA + triangel.catetB + hyp
    print("Периметр пр. треугольника с катетами \(triangel.catetA) и \(triangel.catetB) = \(per)")
    return per
}

let someRightTriangle = RightTriangle(catetA: 3, catetB: 4)

let area = areaRightTriangle(triangel: someRightTriangle) //6
let hyp = hypotenuseRightTriangle(triangel: someRightTriangle) //5
let per = perimetrRightTriangle(triangel: someRightTriangle) //12


// MARK: - Задание 3
//Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
print("Задание 3")
//Модель вклада
struct Vklad {
    let summa: Double
    let procent: Double
}
//Функция подсчета процентов
func vkladCalc(years: Int, vklad: Vklad) -> Double {
    var itog = vklad.summa
    for _ in 1...years {
        itog += itog * vklad.procent/100
    }
    let roundItog = round(itog)
    print("Итого за \(years) лет, на вкладе с \(vklad.summa) будет \(roundItog)")
    return roundItog
}

let someVklad = Vklad(summa: 1000, procent: 10)
let vklad = vkladCalc(years: 5, vklad: someVklad) //1611
