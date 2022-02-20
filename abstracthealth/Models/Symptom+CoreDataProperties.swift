//
//  Symptom+CoreDataProperties.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//
//

import Foundation
import CoreData
import HealthKit


extension Symptom {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Symptom> {
        return NSFetchRequest<Symptom>(entityName: "Symptom")
    }

    @NSManaged public var name: String?
    @NSManaged public var incidents: NSSet?
    public var wrappedName: String {
        name ?? "Unknown Symptom"
    }
    public var incidentsArray: [Incident] {
        let set = incidents as? Set<Incident> ?? []
        return set.sorted {
            $0.time! < $1.time!
        }
    }

}

// MARK: Generated accessors for incidents
extension Symptom {

    @objc(addIncidentsObject:)
    @NSManaged public func addToIncidents(_ value: Incident)

    @objc(removeIncidentsObject:)
    @NSManaged public func removeFromIncidents(_ value: Incident)

    @objc(addIncidents:)
    @NSManaged public func addToIncidents(_ values: NSSet)

    @objc(removeIncidents:)
    @NSManaged public func removeFromIncidents(_ values: NSSet)

}

extension Symptom : Identifiable {

}
