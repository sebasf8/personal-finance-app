//
//  CashflowTestCase.swift
//  CashflowTests
//
//  Created by Sebastian Fernandez on 29/05/2021.
//

import XCTest

@testable import Cashflow

class CashflowTestCase: XCTestCase {
    var coreDataStack: TestCoreDataStack!
    var sut: Cashflow!

    override func setUpWithError() throws {
        sut = Cashflow(movements: [])
        coreDataStack = TestCoreDataStack()
    }

    override func tearDownWithError() throws {
        sut = nil
        coreDataStack = nil
    }

//    func testAddExpense() throws {
//        let category1 = Category(name: "Fuel",
//                                 assetName: "Fuel",
//                                 colorName: "category_color_1")
//
//        let expense = CashflowItem(name: "Fuel",
//                                    amount: 17.5,
//                                    date: Date(),
//                                    type: .expense,
//                                    category: category1)
//
//
//        sut.registerExpense(expense)
//
//        XCTAssertNotNil(sut.movements.first)
//    }

//    func testAddIncome() throws {
//        let salary = Category()
//        salary.assetName = "credit_card"
//        salary.name = "Salary"
//        salary.color = "category_color_1"
//
//        let income = CashflowItem()
//        income.amount = 250
//        income.category = salary
//        income.type = .expense
//
//        sut.registerIncome(income)
//
//        XCTAssertNotNil(sut.movements.first)
//    }

    func testGetCashflowForMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let date1 = formatter.date(from: "2021/06/29 22:31")!
        let date2 = formatter.date(from: "2021/06/28 22:31")!
        let date4 = formatter.date(from: "2021/06/29 22:31")!

        let category1 = Category(name: "Fuel",
                                 assetName: "Fuel",
                                 colorName: "category_color_1")

        let category2 = Category(name: "Credit Card",
                                 assetName: "credit_card",
                                 colorName: "category_color_2")

        let category4 = Category(name: "Salary",
                                 assetName: "credit_card",
                                 colorName: "category_color_1")

        let income1 = CashflowItem(uuid: nil,
                                   name: "Salary",
                                   amount: 1200,
                                   date: date1,
                                   type: .income,
                                   category: category4)

        let expense1 = CashflowItem(uuid: nil,
                                    name: "Rent",
                                    amount: 900,
                                    date: date2,
                                    type: .expense,
                                    category: category2)

        let expense3 = CashflowItem(name: "Fuel",
                                    amount: 17.5,
                                    date: date4,
                                    type: .expense,
                                    category: category1)

        let movements = [income1, expense1, expense3]
        sut.movements = movements

        let total = sut.totalIncomes - sut.totalExpenses

        XCTAssertEqual(total, 282.5)
    }

    func testGetLastMovements() {

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
