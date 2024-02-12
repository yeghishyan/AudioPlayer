//
//  NotificationVM.swift
//  AudioPlayer
//
//  Created by miqo on 27.12.23.
//

import UserNotifications
import Combine
import SwiftUI

final class NotificationService: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationService()
         
    @Published private(set) var latestNotification: UNNotificationResponse? = .none
    @Published var badgeNumber: Int = 0
    @Published var showSettingsPage: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
        
        $badgeNumber
            .drop(while: {$0 < 1})
            .sink { badgeNumber in
                UNUserNotificationCenter.current().setBadgeCount(badgeNumber, withCompletionHandler: { error in
                    print(error ?? "")
                })
            }.store(in: &cancellables)
    }
    
    func handle(notification: UNNotificationResponse?) {
        latestNotification = notification
    }
    
    func requestPushNotificationAuthorization() async {
        do {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [
                .alert, .sound, .badge, .provisional, .criticalAlert, .providesAppNotificationSettings
            ])
            
        } catch {
            print(error)
        }
    }
    
    func scheduleNotification(title: String, subtitle: String, secondsLater: TimeInterval = 1, isRepeating: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsLater, repeats: isRepeating)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        showSettingsPage = true
    }
}

