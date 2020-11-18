//
//  TestHelper.swift
//  OdysseiaTests
//
//  Created by lcr on 2020/11/14.
//

import UIKit

extension UIApplication {
    var windowScene: UIWindowScene? {
        connectedScenes
            .first {
                $0.activationState == .foregroundActive
            } as? UIWindowScene
    }

    // keyWindowは以下のように取得できます。
    var keyWindow: UIWindow? {
        windowScene?.windows
            .first { $0.isKeyWindow }
    }
}

var mainWindow: UIWindow? {
    if #available(iOS 13.0, *) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first
        }
    }
    return UIApplication.shared.keyWindow
}
