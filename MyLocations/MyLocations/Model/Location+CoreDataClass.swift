//
//  Location+CoreDataClass.swift
//  MyLocations
//
//  Created by Александр Воробьев on 28.04.2021.
//

import Foundation
import MapKit
import CoreData

@objc(Location)
public class Location: NSManagedObject {
    
}

//MARK: - Photo Stack

extension Location {
    
    static func nextPhotoID() -> Int {
        let userDefaults = UserDefaults.standard
        let currentID = userDefaults.integer(forKey: "PhotoID") + 1
        userDefaults.set(currentID, forKey: "PhotoID")
        return currentID
    }
    
    var hasPhoto: Bool {
        photoID != nil
    }
    
    var photoURL: URL {
        assert(photoID != nil, "No photo ID set")
        let filename = "Photo-\(photoID!.intValue).jpg"
        return applicationDocumentsDirectory.appendingPathComponent(filename)
    }
    
    var photoImage: UIImage? {
        UIImage(contentsOfFile: photoURL.path)
    }
    
    func removePhotoFile() {
        if hasPhoto {
            do {
                try FileManager.default.removeItem(at: photoURL)
            } catch {
                print("Error removing file: \(error)")
            }
        }
    }
}

//MARK: - MKAnnotation

extension Location: MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    public var title: String? {
        if locationDescription.isEmpty {
            return "No Description"
        } else {
            return locationDescription
        }
    }
    
    public var subtitle: String? {
        category
    }
}
