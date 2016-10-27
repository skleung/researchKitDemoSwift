//
//  AssessmentViewController.swift
//  ResearchKitDemoSwift
//
//  Created by Sherman Leung on 10/27/16.
//  Copyright © 2016 Sherman Leung. All rights reserved.
//

import UIKit
import CareKit
import ResearchKit

class AssessmentViewController: UIViewController, OCKSymptomTrackerViewControllerDelegate, ORKTaskViewControllerDelegate {

    let carePlanStoreManager = CarePlanManager.sharedCarePlanStoreManager

    var taskVC:ORKTaskViewController?
    var symptomCardVC:OCKSymptomTrackerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the store
        addActivities()
        
        // create the VC
        symptomCardVC = OCKSymptomTrackerViewController(carePlanStore: carePlanStoreManager.store)
        symptomCardVC?.delegate = self
        
        // display VC
        navigationController?.pushViewController(symptomCardVC!, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addActivities() {
        let startDate = DateComponents.init(year: 2016, month: 10, day: 01)
        let schedule = OCKCareSchedule.dailySchedule(withStartDate: startDate, occurrencesPerDay: 1)
                                                     
        let painAssessment = OCKCarePlanActivity .assessment(withIdentifier: "painAssessment", groupIdentifier: nil, title: "Pain Survey", text: "Lower back", tintColor: UIColor.red, resultResettable: false, schedule: schedule, userInfo: nil)
        carePlanStoreManager.store.add(painAssessment, completion: { (success, err) in
            if (!success) {
                print(err?.localizedDescription)
            }
        })
        
        // create tapping test
        let tappingAssessment = OCKCarePlanActivity.assessment(withIdentifier: "tappingAssessment", groupIdentifier: nil, title: "Tapping Test", text: "Active Task", tintColor: nil, resultResettable: false, schedule: schedule, userInfo: nil)
        carePlanStoreManager.store.add(tappingAssessment, completion: { (success, err) in
            if (!success) {
                print(err?.localizedDescription)
            }
        })
    }
    
    // MARK: OCKSymptomTrackerViewControllerDelegate
    
    func symptomTrackerViewController(_ viewController: OCKSymptomTrackerViewController, didSelectRowWithAssessmentEvent assessmentEvent: OCKCarePlanEvent) {
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
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith
        reason: ORKTaskViewControllerFinishReason, error: Error?) {
                if (reason == ORKTaskViewControllerFinishReason.completed) {
                    let assessment = self.symptomCardVC?.lastSelectedAssessmentEvent
                    let taskResult = taskViewController.result
                    
                    // convert ORKResult to OCKResult
                    let result = carePlanStoreManager.buildCarePlanResultFrom(taskResult: taskResult)
                    
                    // update and save to the store
                    carePlanStoreManager.store.update(assessment!, with: result, state: .completed, completion: { (success, event, err) in
                        // not implemented
                    })
                }
        
        taskViewController.dismiss(animated: true, completion: nil)
    }

    
    

}
