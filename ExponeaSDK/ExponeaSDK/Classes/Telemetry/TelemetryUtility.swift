//
//  TelemetryUtility.swift
//  ExponeaSDK
//
//  Created by Panaxeo on 18/11/2019.
//  Copyright © 2019 Exponea. All rights reserved.
//

final class TelemetryUtility {
    static let telemetryInstallId = "EXPONEA_TELEMETRY_INSTALL_ID"

    static func isSDKRelated(stackTrace: [String]) -> Bool {
        return stackTrace.joined().contains("Exponea") || stackTrace.joined().contains("exponea")
    }

    static func getInstallId(userDefaults: UserDefaults) -> String {
        if let installId = userDefaults.string(forKey: telemetryInstallId) {
            return installId
        }
        let installId = UUID().uuidString
        userDefaults.set(installId, forKey: telemetryInstallId)
        return installId
    }

    static func formatConfigurationForTracking(_ config: Configuration) -> [String: String] {
        let defaultConfig = Configuration()
        return [
            "projectToken":
                config.projectToken != nil && config.projectToken?.isEmpty == false ? "[REDACTED]" : "",
            "projectMapping":
                config.projectMapping != nil && config.projectMapping?.isEmpty == false ? "[REDACTED]" : "",
            "baseUrl":
                "\(config.baseUrl)\(config.baseUrl == defaultConfig.baseUrl ? " [default]" : "")",
            "defaultProperties":
                config.defaultProperties != nil && config.defaultProperties?.isEmpty == false ? "[REDACTED]" : "",
            "sessionTimeout":
                "\(config.sessionTimeout)\(config.sessionTimeout == defaultConfig.sessionTimeout ? " [default]" : "")",
            "automaticSessionTracking":
                String(describing: config.automaticSessionTracking),
            "automaticPushNotificationTracking":
                String(describing: config.automaticPushNotificationTracking),
            "tokenTrackFrequency":
                "\(config.tokenTrackFrequency)"
                    + "\(config.tokenTrackFrequency == defaultConfig.tokenTrackFrequency ? " [default]" : "")",
            "appGroup":
                String(describing: config.appGroup),
            "flushEventMaxRetries":
                "\(config.flushEventMaxRetries)"
                    + "\(config.flushEventMaxRetries == defaultConfig.flushEventMaxRetries ? " [default]" : "")"
        ]
    }
}