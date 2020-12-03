//
//  NotificationStoreTests.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/06.
//

@testable import Odysseia
import XCTest

// シュミレータにあらかじめ通知権限を与える方法が見つかるまでSkip
class NotificationStoreTests: XCTestCase {
    var notificationStore: NotificationStore!

    override func setUp() {
        super.setUp()
        notificationStore = NotificationStore()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    override func tearDown() {
        super.tearDown()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func testSetMonthlyRemindNotify() throws {
        throw XCTSkip("Skip")
        // setup
        let exp = expectation(description: "testSetMonthlyRemindNotify")

        // execute
        notificationStore.setMonthlyRemindNotify()
        sleep(2)

        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            XCTAssertEqual(requests.count, self.notificationStore.notifyMonths.count)
            for request in requests {
                // verify
                XCTAssertEqual(request.content.title, L10n.Localizable.notificationTitle)
                XCTAssertEqual(request.content.body, L10n.Localizable.monthlyRemindNotifyMsg)
                XCTAssertEqual(request.trigger?.repeats, true)
            }
            XCTAssertEqual(requests.count, self.notificationStore.notifyMonths.count)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
    }

    func testHarfYearRemindNotify() throws {
        throw XCTSkip("Skip")
        // setup
        let expectIdentifier = NotificationStore.halfYearRemindNotifyId
        let exp = expectation(description: "testSetHalfYearRemindNotify")

        // execute
        notificationStore.setHalfYearRemindNotify()
        sleep(2)

        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests where request.identifier == expectIdentifier {
                // verify
                XCTAssertEqual(request.identifier, expectIdentifier)
                XCTAssertEqual(request.content.title, L10n.Localizable.notificationTitle)
                XCTAssertEqual(request.content.body, L10n.Localizable.halfYearRemindNotifyMsg)
                XCTAssertEqual(request.trigger?.repeats, true)
                exp.fulfill()
            }
            XCTAssertEqual(requests.count, 1)
        }
        wait(for: [exp], timeout: 5.0)
    }

    func testNewYearRemindNotify() throws {
        throw XCTSkip("Skip")
        // setup
        let expectIdentifier = NotificationStore.newYearRemindNotifyId
        let exp = expectation(description: "testSetNewYearRemindNotify")

        // execute
        notificationStore.setNewYearRemindNotify()

        sleep(2)
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            for request in requests where request.identifier == expectIdentifier {
                // verify
                XCTAssertEqual(request.identifier, expectIdentifier)
                XCTAssertEqual(request.content.title, L10n.Localizable.notificationTitle)
                XCTAssertEqual(request.content.body, L10n.Localizable.newYearRemindNotifyMsg)
                XCTAssertEqual(request.trigger?.repeats, true)
                exp.fulfill()
            }
            XCTAssertEqual(requests.count, 1)
        }
        wait(for: [exp], timeout: 5.0)
    }

    private func getThisYear() -> Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let thisYearString = formatter.string(from: now as Date)
        guard  let thisYear = Int(thisYearString) else {
            return 2020
        }
        return thisYear
    }
}
