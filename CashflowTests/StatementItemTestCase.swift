//
//  StatementItemTestCase.swift
//  CashflowTests
//
//  Created by Sebastian Fernandez on 23/04/2021.
//

import XCTest
import CoreData
@testable import Cashflow

class StatementItemTestCase: XCTestCase {
    var coreDataStack: TestCoreDataStack!
    var sut: StatementItem!

    override func setUpWithError() throws {
        coreDataStack = TestCoreDataStack()
        sut = StatementItem(context: coreDataStack.container.viewContext)
    }

    override func tearDownWithError() throws {
        sut = nil
        coreDataStack = nil
    }

    func testGetFilteredHistory() throws {
        let date = Date()
        let date2 = date.addingTimeInterval(200000)
        let date3 = date.addingTimeInterval(-200000)

        sut.addHistoryEntry(amount: 2000, date: date)
        sut.addHistoryEntry(amount: 2500, date: date2)
        sut.addHistoryEntry(amount: 2500, date: date3)

        print("date1: \(date) date2: \(date2) date3 \(date3)")

        let filteredHistory = sut.getHistory(since: date, until: date2)

        XCTAssertTrue(filteredHistory.count == 2, "The filtered history is not correct")
    }

}
