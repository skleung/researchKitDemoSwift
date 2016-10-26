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
// MARK: - OCKSymptomTrackerViewControllerDelegate
extension TabBarViewController: OCKSymptomTrackerViewControllerDelegate {
    func symptomTrackerViewController(_ viewController: OCKSymptomTrackerViewController,
                                      didSelectRowWithAssessmentEvent assessmentEvent: OCKCarePlanEvent) {
        let identifier = assessmentEvent.activity.identifier
        if (identifier == "painAssessment") {
            let answerFormat = ORKValuePickerAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: .max, step: 1, vertical: false, maximumValueDescription: "High", minimumValueDescription: "Low")
            let step = ORKQuestionStep.init(identifier: "painScaleQuestion", title: "How would you rate your pain?", answer: answerFormat)
            let task = ORKOrderedTask.init(identifier: "painScaleTask", steps: [step])
            let taskVC = ORKTaskViewController(task: task, taskRun: nil)
            taskVC.delegate = self
            present(taskVC, animated: true, completion: nil)
        } else if (identifier == "tappingAssessment") {
            
        }
    }
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
