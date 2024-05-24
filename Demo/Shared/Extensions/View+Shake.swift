//
//  View+Shake.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-24.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

#if os(iOS)
extension NSNotification.Name {
    static let deviceDidShakeNotification = NSNotification.Name("MyDeviceDidShakeNotification")
}

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .deviceDidShakeNotification, object: event)
    }
}

extension View {

    var deviceDidShakeNotification: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: .deviceDidShakeNotification)
    }
}
#endif

extension View {

    /// Perform an action when the device receives a shake.
    @ViewBuilder
    func onReceiveShake(
        action: @escaping () -> Void
    ) -> some View {
        #if os(iOS)
        self.onReceive(deviceDidShakeNotification) { _ in
            action()
        }
        #else
        self
        #endif
    }
}
