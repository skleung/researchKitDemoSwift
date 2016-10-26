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
    
    var store:OCKCarePlanStore?
    var careCardVC:OCKCareCardViewController?
    
    var taskVC:ORKTaskViewController?
    var symptomCardVC:OCKSymptomTrackerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCarePlanStore()
        
        let careCardVC = OCKCareCardViewController(carePlanStore: store!)
        let careCardNavigationVC = UINavigationController(rootViewController: careCardVC)
        careCardVC.navigationController?.title = "My Care Card"
        
        self.symptomCardVC = OCKSymptomTrackerViewController(carePlanStore: store!)
        symptomCardVC?.delegate = tabBarController as! OCKSymptomTrackerViewControllerDelegate?
        let symptomCardNavigationVC = UINavigationController(rootViewController: symptomCardVC!)
        symptomCardNavigationVC.title = "My Symptom Card"
        
        tabBarController?.viewControllers = [careCardNavigationVC, symptomCardNavigationVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpCarePlanStore() {
        store = OCKCarePlanStore.init(persistenceDirectoryURL: storeDirectoryURL())
        store?.delegate = self
        
        // add ibuprofen activity
        let startDate = DateComponents.init(year: 2016, month: 10, day: 01)
        let schedule = OCKCareSchedule.dailySchedule(withStartDate: startDate, occurrencesPerDay: 1)
        let careActivity = OCKCarePlanActivity.intervention(withIdentifier: "Ibuprofen", groupIdentifier: nil, title: "Ibuprofen", text: "200mg", tintColor: nil, instructions: nil, imageURL: nil, schedule: schedule, userInfo: nil)
        store?.add(careActivity, completion: { (success, err) in
            if (!success) {
                print(err?.localizedDescription)
            }
        })
        
        // create assessment activity
        let painAssessment = OCKCarePlanActivity .assessment(withIdentifier: "painAssessment", groupIdentifier: nil, title: "Pain Survey", text: "Lower back", tintColor: UIColor.red, resultResettable: false, schedule: schedule, userInfo: nil)
        store?.add(painAssessment, completion: { (success, err) in
            if (!success) {
                print(err?.localizedDescription)
            }
        })
        
        // create tapping test 
        let tappingAssessment = OCKCarePlanActivity.assessment(withIdentifier: "tappingAssessment", groupIdentifier: nil, title: "Tapping Test", text: "Active Task", tintColor: nil, resultResettable: false, schedule: schedule, userInfo: nil)
        store?.add(tappingAssessment, completion: { (success, err) in
            if (!success) {
                print(err?.localizedDescription)
            }
        })
    }

    private func storeDirectoryURL() -> URL {
        let fileManager = FileManager.default
        
        guard let documentDirectory =   fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("*** Error: Unable to get the document directory! ***")
        }
        
        let storeURL = documentDirectory.appendingPathComponent("MyCareKitStore")
        
        if !fileManager.fileExists(atPath: storeURL.path) {
            try! fileManager.createDirectory(at: storeURL,     withIntermediateDirectories: true, attributes: nil)
        }
        return storeURL
    }
}

