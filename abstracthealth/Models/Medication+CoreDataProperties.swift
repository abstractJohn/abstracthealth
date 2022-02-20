//
//  Medication+CoreDataProperties.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//
//

import Foundation
import CoreData


extension Medication {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Medication> {
        return NSFetchRequest<Medication>(entityName: "Medication")
    }

    @NSManaged public var name: String?
    @NSManaged public var instructions: String?
    @NSManaged public var started: Date?
    @NSManaged public var incidents: NSSet?
    @NSManaged public var prescriber: String?
    @NSManaged public var lastFilled:  Date?
    @NSManaged public var refills: NSNumber?
    @NSManaged public var discontinued: Bool
    @NSManaged public var asNeeded: Bool
    @NSManaged public var prescriptionNumber: String?
    @NSManaged public var priorAuthCode: String?
    public var wrappedName: String {
        name ?? "Unknown Medication"
    }
    public var wrappedPrescriber: String {
        prescriber ?? "Unknown Prescriber"
    }
    public var wrappedInstructions: String {
        instructions ?? "None"
    }
    public var wrappedPrescriptionNumber: String {
        prescriptionNumber ?? "None"
    }
    public var wrappedPriorAuthCode: String {
        priorAuthCode ?? "None"
    }
    public var refillsString: String {
        if refills == nil {
            return "Unknown"
        } else {
            return refills!.stringValue
        }
    }
    public var incidentsArray: [Incident] {
        let set = incidents as? Set<Incident> ?? []
        return set.sorted {
            $0.time! < $1.time!
        }
    }
    public var lastUsed: String {
        guard let maxUsage: Incident = incidentsArray.max(by: {
            (first, second) in
            return first.time! < second.time!
        }) else {
            return "Never"
        }
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        relativeFormatter.dateTimeStyle = .named
        return relativeFormatter.localizedString(for: maxUsage.time!, relativeTo: Date())
    }
    public var lastFilledString: String {
        if lastFilled != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: lastFilled!)
        } else {
            return "Unknown"
        }
    }
    public var startedString: String {
        if started != nil {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: started!)
        } else {
            return "Unknown"
        }
    }
    
    
    struct Data {
        var name: String = "New Medication"
        var prescriber: String = ""
        var lastFilled:  Date = Date()
        var refills: Int = 0
        var discontinued: Bool = false
        var asNeeded: Bool = false
        var prescriptionNumber: String = ""
        var priorAuthCode: String = ""
    }

}

// MARK: Generated accessors for incidents
extension Medication {

    @objc(addIncidentsObject:)
    @NSManaged public func addToIncidents(_ value: Incident)

    @objc(removeIncidentsObject:)
    @NSManaged public func removeFromIncidents(_ value: Incident)

    @objc(addIncidents:)
    @NSManaged public func addToIncidents(_ values: NSSet)

    @objc(removeIncidents:)
    @NSManaged public func removeFromIncidents(_ values: NSSet)

}

extension Medication : Identifiable {

}
