//
//  TrackingItem.swift
//  Laundry
//
//  Created by Eric Johnson  on 8/11/15.
//  Copyright (c) 2015 Eric Johnson . All rights reserved.
//

import Foundation

struct TrackingItem {
    var label: String // Washer or Dryer and #
    var state: String // Available, time left, Unknown, etc
    var id: String // Site Code Id
    var position: Int // Index of position in array in table view
    var alert: Bool // Alerts on (true) or off (false)
    var UUID: String // unique identifier
    
    init(label: String, state: String, id: String, position: Int, alert: Bool, UUID: String) {
        self.label = label
        self.state = state
        self.id = id
        self.position = position
        self.alert = alert
        self.UUID = UUID
    }
    
    var isDone: Bool {
        // track whether or not a laundry machines status has changed, return done when it is changed
        return alert
    }
}