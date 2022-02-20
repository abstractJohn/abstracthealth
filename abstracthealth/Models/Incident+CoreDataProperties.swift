//
//  Incident+CoreDataProperties.swift
//  abstracthealth
//
//  Created by John Nelson on 2/19/22.
//
//

import Foundation
import CoreData


extension Incident {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Incident> {
        return NSFetchRequest<Incident>(entityName: "Incident")
    }

    @NSManaged public var time: Date?
    @NSManaged public var medications: NSSet?
    @NSManaged public var symptoms: NSSet?
    @NSManaged public var triggers: NSSet?
    public var viewName: String {
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .full
        relativeFormatter.dateTimeStyle = .named
        return "Medication Used \(relativeFormatter.localizedString(for: time!, relativeTo: Date()))"
    }
    public var medicationsArray: [Medication] {
        let set = medications as? Set<Medication> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    public var syptomsArray: [Symptom] {
        let set = medications as? Set<Symptom> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    public var triggersArray: [Trigger] {
        let set = medications as? Set<Trigger> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for medications
extension Incident {

    @objc(addMedicationsObject:)
    @NSManaged public func addToMedications(_ value: Medication)

    @objc(removeMedicationsObject:)
    @NSManaged public func removeFromMedications(_ value: Medication)

    @objc(addMedications:)
    @NSManaged public func addToMedications(_ values: NSSet)

    @objc(removeMedications:)
    @NSManaged public func removeFromMedications(_ values: NSSet)

}

// MARK: Generated accessors for symptoms
extension Incident {

    @objc(addSymptomsObject:)
    @NSManaged public func addToSymptoms(_ value: Symptom)

    @objc(removeSymptomsObject:)
    @NSManaged public func removeFromSymptoms(_ value: Symptom)

    @objc(addSymptoms:)
    @NSManaged public func addToSymptoms(_ values: NSSet)

    @objc(removeSymptoms:)
    @NSManaged public func removeFromSymptoms(_ values: NSSet)

}

// MARK: Generated accessors for triggers
extension Incident {

    @objc(addTriggersObject:)
    @NSManaged public func addToTriggers(_ value: Trigger)

    @objc(removeTriggersObject:)
    @NSManaged public func removeFromTriggers(_ value: Trigger)

    @objc(addTriggers:)
    @NSManaged public func addToTriggers(_ values: NSSet)

    @objc(removeTriggers:)
    @NSManaged public func removeFromTriggers(_ values: NSSet)

}

extension Incident : Identifiable {

}
