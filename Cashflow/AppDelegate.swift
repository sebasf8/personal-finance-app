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

        // Initialize CoreData
        _ = CoreDataStack.shared.context
//        loadData()
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

    private func loadData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"

        let date1 = formatter.date(from: "2021/06/29 22:31")!
        let date2 = formatter.date(from: "2021/06/28 22:31")!
        let date3 = formatter.date(from: "2021/03/29 22:31")!
        let date4 = formatter.date(from: "2021/06/29 22:31")!

        let category1 = Category(name: "Fuel",
                                 assetName: "fuel",
                                 colorName: "category_color_1")

        let category2 = Category(name: "Credit Card",
                                 assetName: "credit_card",
                                 colorName: "category_color_2")

        let category3 = Category(name: "Dinner",
                                 assetName: "dinner",
                                 colorName: "category_color_3")

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

        let expense2 = CashflowItem(uuid: nil,
                                    name: "Food",
                                    amount: 200,
                                    date: date3,
                                    type: .expense,
                                    category: category3)

        let expense3 = CashflowItem(name: "Fuel",
                                    amount: 17.5,
                                    date: date4,
                                    type: .expense,
                                    category: category1)

        let categoryRepository = CategoryCoreDataRepository.shared
        let itemRepository = CashflowItemCoreDataRepository.shared

        categoryRepository.save(category1)
        categoryRepository.save(category2)
        categoryRepository.save(category3)
        categoryRepository.save(category4)

        itemRepository.save(income1)
        itemRepository.save(expense1)
        itemRepository.save(expense2)
        itemRepository.save(expense3)

    }
}
