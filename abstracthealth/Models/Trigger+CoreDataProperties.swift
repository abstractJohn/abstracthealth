//
//  Trigger+CoreDataProperties.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//
//

import Foundation
import CoreData


extension Trigger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trigger> {
        return NSFetchRequest<Trigger>(entityName: "Trigger")
    }

    @NSManaged public var name: String?
    @NSManaged public var incidents: NSSet?
    public var wrappedName: String {
        name ?? "Unknown Trigger"
    }
    public var incidentsArray: [Incident] {
        let set = incidents as? Set<Incident> ?? []
        return set.sorted {
            $0.time! < $1.time!
        }
    }

}

// MARK: Generated accessors for incidents
extension Trigger {

    @objc(addIncidentsObject:)
    @NSManaged public func addToIncidents(_ value: Incident)

    @objc(removeIncidentsObject:)
    @NSManaged public func removeFromIncidents(_ value: Incident)

    @objc(addIncidents:)
    @NSManaged public func addToIncidents(_ values: NSSet)

    @objc(removeIncidents:)
    @NSManaged public func removeFromIncidents(_ values: NSSet)

}

extension Trigger : Identifiable {

}
