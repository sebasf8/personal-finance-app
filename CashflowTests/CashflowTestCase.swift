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
    var sut: CashflowModel!

    override func setUpWithError() throws {
        sut = CashflowModel(movements: [])
        coreDataStack = TestCoreDataStack()
    }

    override func tearDownWithError() throws {
        sut = nil
        coreDataStack = nil
    }

    func testGetCashflowForMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let date1 = formatter.date(from: "2021/06/29 22:31")!
        let date2 = formatter.date(from: "2021/06/28 22:31")!
        let date3 = formatter.date(from: "2021/06/29 22:31")!

        let movementFactory = MovementMockFactory()
        let salary = movementFactory.make(.salary, date: date1)
        let rent = movementFactory.make(.rent, date: date2)
        let fuel = movementFactory.make(.fuel, date: date3)

        let movements = [salary, rent, fuel]
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
