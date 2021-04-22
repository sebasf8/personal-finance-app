//
//  CashflowTests.swift
//  CashflowTests
//
//  Created by Sebastian Fernandez on 03/04/2021.
//

import XCTest
import CoreData

@testable import Cashflow

class NetworthCaseTest: XCTestCase {
    var coreDataStack: TestCoreDataStack!
    var sut: Networth!
        
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        sut = Networth(repository: StatementItemCoreDataRepository(context: coreDataStack.container.viewContext))
    }

    override func tearDown() {
        coreDataStack = nil
    }

    func testResultAtNoStatements() {
        sut.assets = []
        sut.liabilities = []
        
        let result = sut.getResult()
        XCTAssertEqual(result, 0.00, "The NW not was zero for empties collections")
    }
    
    func testResultPositive() {
        // Assets
        
        let cash = StatementItem(context: coreDataStack.container.viewContext)
        let bank = StatementItem(context: coreDataStack.container.viewContext)
        let portfolio = StatementItem(context: coreDataStack.container.viewContext)
        cash.ammount = 2000.0
        bank.ammount = 3000.0
        portfolio.ammount = 4000.0
        
        // Liabilities
        
        let creditCard = StatementItem(context: coreDataStack.container.viewContext)
        creditCard.ammount = 2000.0
        
        sut.assets = [cash, bank, portfolio]
        sut.liabilities = [creditCard]
        
        XCTAssertEqual(7000.00, sut.getResult(), "NW is not corresponding at assets and liabilities")
    }
    
    func testAddAsset() {
        let cash = StatementItem(context: coreDataStack.container.viewContext)
        cash.ammount = 4000
        cash.name = "Santander"
        cash.category = "Bank"
        cash.type = .asset
        
        try! sut.addAsset(asset: cash)
        
        XCTAssertTrue(sut.assets.count == 1, "Asset was not added")
        XCTAssertEqual(sut.assets[0], cash, "Cash was not in asset list")
    }
    
    func testAddLiability() {
        let creditCard = StatementItem(context: coreDataStack.container.viewContext)
        creditCard.ammount = 2000.0
        creditCard.name = "Visa"
        creditCard.category = "Credit Card"
        creditCard.type = .liability
        
        try! sut.addLiability(liability: creditCard)
    }

}
