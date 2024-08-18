//
//  Configuration.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import Foundation

enum Configuration {
    
    static func getConfigurationValue<T>(valueType _: T.Type, key: ConfigurationConstantsKeyProtocol, bundle: StringTable) -> T? {
        if let configuration = getConfigurationDictionary(bundle: bundle) {
            return configuration.object(forKey: key.constantKey) as? T
        }
        return nil
    }
    
    static func getConfigurationDictionary(bundle: StringTable) -> NSDictionary? {
        let path = getConfigurationPath(bundle: bundle)
        let resource = Bundle.main.path(forResource: path, ofType: FileType.plist.rawValue)
        do {
            let data = NSData(contentsOfFile: resource ?? String()) as? Data ?? Data()
            let propertyList = try PropertyListSerialization.propertyList(
                from: data,
                options: .mutableContainersAndLeaves,
                format: nil
            )
            return propertyList as? NSDictionary
        } catch {
            return nil
        }
    }
    
    static func getConfigurationPath(bundle: StringTable) -> String {
        bundle.rawValue + ResourceType.Configuration.rawValue
    }
}
