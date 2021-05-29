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
        sut = Cashflow()
        coreDataStack = TestCoreDataStack()

    }

    override func tearDownWithError() throws {
        sut = nil
        coreDataStack = nil
    }

    func testAddExpense() throws {
        let expense = CashflowItem(context: coreDataStack.container.viewContext)
        expense.amount = 250
        expense.category = "Groseries"
        expense.type = .expense

        sut.registerExpense(expense)

        XCTAssertNotNil(sut.movements.first)
    }

    func testAddIncome() throws {
        let income = CashflowItem(context: coreDataStack.container.viewContext)
        income.amount = 250
        income.category = "Salary"
        income.type = .expense

        sut.registerIncome(income)

        XCTAssertNotNil(sut.movements.first)
    }

    func testGetCashflowForMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let date1 = formatter.date(from: "2021/05/29 22:31")
        let date2 = formatter.date(from: "2021/05/28 22:31")
        let date3 = formatter.date(from: "2021/03/29 22:31")
        let date4 = formatter.date(from: "2021/05/29 22:31")

        let income1 = CashflowItem(context: coreDataStack.container.viewContext)
        income1.amount = 1200
        income1.category = "Salary"
        income1.type = .income
        income1.date = date1

        let expense1 = CashflowItem(context: coreDataStack.container.viewContext)
        expense1.amount = 900
        expense1.category = "Rent"
        expense1.type = .expense
        expense1.date = date2

        let expense2 = CashflowItem(context: coreDataStack.container.viewContext)
        expense2.amount = 200
        expense2.category = "Groseries"
        expense2.type = .expense
        expense2.date = date3

        let expense3 = CashflowItem(context: coreDataStack.container.viewContext)
        expense3.amount = 17.5
        expense3.category = "Delivery"
        expense3.type = .expense
        expense3.date = date4

        sut.registerIncome(income1)
        sut.registerExpense(expense1)
        sut.registerExpense(expense2)
        sut.registerExpense(expense3)

        let movements = sut.getCashflowFor(month: 5)

        let total = movements.totalIncomes - movements.totalExpenses

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
