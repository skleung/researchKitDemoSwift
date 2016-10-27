//
//  TabBarViewController.swift
//  ResearchKitDemoSwift
//
//  Created by Sherman Leung on 10/26/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit

class TabBarViewController: UITabBarController {

}

extension TabBarViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith
        reason: ORKTaskViewControllerFinishReason, error: Error?) {
//        if (reason == ORKTaskViewControllerFinishReason.completed) {
//            let assessment = self.symptomCardVC?.lastSelectedAssessmentEvent
//            let taskResult = taskViewController.result
//            let stepResult = taskResult.stepResult(forStepIdentifier: "painScaleQuestion")
//            
//            let result = OCKCarePlanEventResult(valueString: "5", unitString: "out of 10", userInfo: nil)
//            store?.update(assessment!, with: result, state: .completed, completion: { (success, event, err) in
//                // not implemented
//            })
//        }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
}
