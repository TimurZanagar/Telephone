//
//  BackgroundActivityUserAgentEventTarget.swift
//  Telephone
//
//  Copyright © 2008-2016 Alexey Kuznetsov
//  Copyright © 2016-2022 64 Characters
//
//  Telephone is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Telephone is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

import Foundation
import UseCases

final class BackgroundActivityUserAgentEventTarget {
    private var activity: NSObjectProtocol?

    private let process: ProcessInfo

    init(process: ProcessInfo) {
        self.process = process
    }
}

extension BackgroundActivityUserAgentEventTarget: UserAgentEventTarget {
    func didFinishStarting(_ agent: UserAgent) {
        activity = process.beginActivity(options: .userInitiatedAllowingIdleSystemSleep, reason: "SIP User Agent")
    }

    func didFinishStopping(_ agent: UserAgent) {
        if let activity = activity {
            process.endActivity(activity)
        }
        activity = nil
    }

    func didDetectNAT(_ agent: UserAgent) {}
    func didMakeCall(_ agent: UserAgent) {}
    func didReceiveCall(_ agent: UserAgent) {}
}
