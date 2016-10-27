//
//  ViewController.swift
//  ResearchKitDemoSwift
//
//  Created by Sherman Leung on 10/26/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit

class ViewController: UIViewController, OCKCarePlanStoreDelegate {
    
    let carePlanStoreManager = CarePlanManager.sharedCarePlanStoreManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addActivity()
        
        let careCardVC = OCKCareCardViewController(carePlanStore: carePlanStoreManager.store)
        
        // adding it to the navigation controller
        navigationController?.title = "My Care Card"
        navigationController?.pushViewController(careCardVC, animated: false)
    }
    
    func addActivity() {
        // create schedule
        let startDate = DateComponents.init(year: 2016, month: 10, day: 01)
        let schedule = OCKCareSchedule.dailySchedule(withStartDate: startDate, occurrencesPerDay: 1)
        
        // create and add activity
        let careActivity = OCKCarePlanActivity.intervention(withIdentifier: "Ibuprofen", groupIdentifier: nil, title: "Ibuprofen", text: "200mg", tintColor: nil, instructions: nil, imageURL: nil, schedule: schedule, userInfo: nil)
        carePlanStoreManager.store.add(careActivity, completion: { (success, err) in
            if (!success) {
                print(err?.localizedDescription)
            }
        })
    }
}

