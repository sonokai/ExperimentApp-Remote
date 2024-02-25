//
//  NotificationHandler.swift
//  ExperimentApp
//
//  Created by Kai Green on 2/21/24.
//

import Foundation
import UserNotifications

class NotificationHandler {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {success,error in
            if success {
                print("Access Granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    func sendNotifications(hour: Int, minute: Int, duration: Int, title: String, body: String, isSilent: Bool = false) {
        // Content for the notification
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Set sound based on isSilent parameter
        if isSilent {
            content.sound = nil // Setting sound to nil makes it silent
        } else {
            content.sound = UNNotificationSound.default
        }

        // Set up the date components for the trigger
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Starting date for the notifications
        let startDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!

        // Create the repeating trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // Ending date for the notification period
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to: startDate)!

        // Check if the current date is before the end date
        if startDate < endDate {
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error adding notification: \(error.localizedDescription)")
                }
            }
        } else {
            print("Notification period has already passed.")
        }
    }


    
    func checkNotificationAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }
}
