//
//  TypeExtensions.swift
//  WorldTrotter
//
//  Created by Giovanni Catania on 22/04/16.
//  Copyright © 2016 Giovanni Catania. All rights reserved.
//

import Foundation

//MARK: - NSDate
extension NSDate
{
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
}
