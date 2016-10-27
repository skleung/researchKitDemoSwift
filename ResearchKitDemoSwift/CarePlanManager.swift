//
//  CarePlanManager.swift
//  ResearchKitDemoSwift
//
//  Created by Sherman Leung on 10/27/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import ResearchKit
import CareKit

public class CarePlanManager:NSObject {
    static let sharedCarePlanStoreManager = CarePlanManager()
    
    var store:OCKCarePlanStore
    
    override init() {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Failed to obtain Documents directory!")
        }
        
        let storeURL = documentDirectory.appendingPathComponent("CarePlanStore")
        
        if !fileManager.fileExists(atPath: storeURL.path) {
            try! fileManager.createDirectory(at: storeURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        store = OCKCarePlanStore(persistenceDirectoryURL: storeURL)
        super.init()
    }

    func addDemoActivities() {
        // create assessment activity
    }
    
    func buildCarePlanResultFrom(taskResult: ORKTaskResult) -> OCKCarePlanEventResult {
        // 1
        guard let firstResult = taskResult.firstResult as? ORKStepResult,
            let stepResult = firstResult.results?.first else {
                fatalError("Unexepected task results")
        }
        
        // 2
        if let numericResult = stepResult as? ORKScaleQuestionResult,
            let answer = numericResult.scaleAnswer {
            return OCKCarePlanEventResult(valueString: answer.stringValue, unitString: "out of 10", userInfo: nil)
        }
        
        // 3
        fatalError("Unexpected task result type")
    }
}
