//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Евгения Шевякова on 05.11.2023.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    func registeForLatestUpdatesIfPossible() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .provisional]) { [weak self] granted, error in
            if granted {
                self?.addNotification()
            }
        }
    }
    
    private func addNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["CustomData": "qwerty"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "check_updates_19", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
