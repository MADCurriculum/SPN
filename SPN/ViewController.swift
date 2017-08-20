//
//  ViewController.swift
//  SPN
//
//  Created by Bill Skrzypczak on 8/20/17.
//  Copyright © 2017 Bill Skrzypczak. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    // Create a boolean variable to turn notifications on/off
    
    var isGrantedNotificationAccess = false
    
    func makePizzaContent() -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "A Timed Pizza Step"
        content.body = "Making Pizza"
        content.userInfo = ["step":0]
        return content
    }
    
    func addNotification(trigger:UNNotificationTrigger?, content:
        UNMutableNotificationContent, identifier:String){
        let request = UNNotificationRequest(identifier:identifier, content:content, trigger: trigger)
        UNUserNotificationCenter.current().add(request){
            (error) in
            if error != nil {
                print("error adding notification:\(error?.localizedDescription)")
            
            }
        
        }
    
    }
    
    @IBAction func Sched(_ sender: UIButton) {
        if isGrantedNotificationAccess{
            let content = UNMutableNotificationContent()
            content.title = "A scheduled pizza"
            content.body = "Time to make a Pizza !!!"
            let unitFlags:Set<Calendar.Component> = [.minute, .hour, .second]
            var date = Calendar.current.dateComponents(unitFlags, from: Date())
            date.second = date.second! + 15
            
            
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
            addNotification(trigger: trigger, content: content, identifier: "message.scheduled")
            
        
        }
        
    }
    @IBAction func Make(_ sender: UIButton) {
        if isGrantedNotificationAccess{
            let content = makePizzaContent()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
            addNotification(trigger: trigger, content: content, identifier: "message.pizza")
            
        }
    }
    
    @IBAction func Next(_ sender: UIButton) {
    }
    
    @IBAction func Pending(_ sender: UIButton) {
    }
    
    @IBAction func Deliver(_ sender: UIButton) {
    }
    
    @IBAction func Remove(_ sender: UIButton) {
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            self.isGrantedNotificationAccess = granted
            if !granted {
            //add alert to nag user
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Delgates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

}




