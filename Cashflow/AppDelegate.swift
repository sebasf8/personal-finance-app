//
//  AppDelegate.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 03/04/2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let context = CoreDataStack.shared.context
//        loadData(context)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    private func loadData(_ context: NSManagedObjectContext) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let date1 = formatter.date(from: "2021/07/29 22:31")!
        let date2 = formatter.date(from: "2021/07/28 22:31")!
        let date4 = formatter.date(from: "2021/07/29 22:31")!

        let category1 = CategoryMO(context: context)
        category1.name = "Fuel"
        category1.imageName = .fuel
        category1.colorName = .purple

        let category2 = CategoryMO(context: context)
        category2.name = "Credit Card"
        category2.imageName = .creditCard
        category2.colorName = .red

        let category3 = CategoryMO(context: context)
        category3.name = "Dinner"
        category3.imageName = .dinner
        category3.colorName = .gray

        let category4 = CategoryMO(context: context)
        category4.name = "Salary"
        category4.imageName = .creditCard
        category4.colorName = .green

        let income1 = CashflowItemMO(context: context)
        income1.name = "Salary"
        income1.amount = 1200
        income1.date = date1
        income1.type = .income
        income1.category = category4

        let expense1 = CashflowItemMO(context: context)
        expense1.name = "Rent"
        expense1.amount = 900
        expense1.date = date2
        expense1.type = .expense
        expense1.category = category2

        let expense2 = CashflowItemMO(context: context)
        expense2.name = "Food"
        expense2.amount = 200
        expense2.date = date2
        expense2.type = .expense
        expense2.category = category3

        let expense3 = CashflowItemMO(context: context)
        expense3.name = "Fuel"
        expense3.amount = 17.5
        expense3.date = date4
        expense3.type = .expense
        expense3.category = category1

        let itemRepository = CashflowItemCoreDataRepository.shared

        itemRepository.save(income1)
        itemRepository.save(expense1)
        itemRepository.save(expense2)
        itemRepository.save(expense3)

    }
}
