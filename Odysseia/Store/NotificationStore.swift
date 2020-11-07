//
//  NotificationStore.swift
//  Odysseia
//
//  Created by lcr on 2020/11/06.
//

import UIKit

class NotificationStore: NSObject {
    static let newYearRemindNotifyId = "newYearRemindNotifyId"
    static let halfYearRemindNotifyId = "halfYearRemindNotifyId"
    static let monthlyRemindNotifyId = "monthlyRemindNotifyId"

    let notifyMonths = [2, 3, 4, 5, 6, 8, 9, 10, 11, 12]

    func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                UNUserNotificationCenter.current().delegate = self
                self.setNewYearRemindNotify()
                self.setHalfYearRemindNotify()
                self.setMonthlyRemindNotify()
            }
        }
    }

    // 20XX/01/13 12:00 目標設定リマインド
    func setNewYearRemindNotify() {
        let identifier = NotificationStore.newYearRemindNotifyId
        isAlreadySet(identifier: identifier) { isAlreadySet in
            if isAlreadySet {
                return
            }
            let request = self.newYearNotificationRequest()
            UNUserNotificationCenter.current().add(request)
        }
    }

    // 毎月初のリマインド
    func setMonthlyRemindNotify() {
        for month in notifyMonths {
            let identifier = "\(NotificationStore.newYearRemindNotifyId)\(month)"
            isAlreadySet(identifier: identifier) { isAlreadySet in
                if isAlreadySet {
                    return
                }
                let request = self.monthlyNotificationRequest(month: month)
                UNUserNotificationCenter.current().add(request)
            }
        }
    }

    // 20XX/07/01 12:00 半年リマインド
    func setHalfYearRemindNotify() {
        // 権限の確認する
        let identifier = NotificationStore.halfYearRemindNotifyId
        isAlreadySet(identifier: identifier) { isAlreadySet in
            if isAlreadySet {
                return
            }
            let request = self.harfYearNotificationRequest()
            UNUserNotificationCenter.current().add(request)
        }
    }

    private func monthlyNotificationRequest(month: Int) -> UNNotificationRequest {
        let components = DateComponents(month: month, day: 13, hour: 12, minute: 00)
        let content = UNMutableNotificationContent()
        content.title = L10n.Localizable.notificationTitle
        content.body = L10n.Localizable.monthlyRemindNotifyMsg
        content.sound = UNNotificationSound.default
        let identifier = "\(NotificationStore.newYearRemindNotifyId)\(month)"
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        return UNNotificationRequest(identifier: identifier,
                                     content: content,
                                     trigger: trigger)
    }

    private func newYearNotificationRequest() -> UNNotificationRequest {
        let components = DateComponents(month: 1, day: 13, hour: 12, minute: 00)
        let content = UNMutableNotificationContent()
        content.title = L10n.Localizable.notificationTitle
        content.body = L10n.Localizable.newYearRemindNotifyMsg
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        return UNNotificationRequest(identifier: NotificationStore.newYearRemindNotifyId,
                                     content: content,
                                     trigger: trigger)
    }

    private func harfYearNotificationRequest() -> UNNotificationRequest {
        let date = DateComponents(month: 7, day: 1, hour: 12, minute: 00)
        let content = UNMutableNotificationContent()
        content.title = L10n.Localizable.notificationTitle
        content.body = L10n.Localizable.halfYearRemindNotifyMsg
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        return UNNotificationRequest(identifier: NotificationStore.halfYearRemindNotifyId,
                                     content: content,
                                     trigger: trigger)
    }

    private func isAlreadySet(identifier: String, completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests where request.identifier == identifier {
                completion(true)
                return
            }
            completion(false)
        }
    }
}

extension NotificationStore: UNUserNotificationCenterDelegate {
    // フォアグラウンドで通知受信
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
    }
}
