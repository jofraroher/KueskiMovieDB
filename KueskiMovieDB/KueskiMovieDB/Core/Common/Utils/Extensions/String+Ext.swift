//
//  String+Ext.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

extension String {
    
    static func getConfigurationValue(key: ConfigurationConstantsKeyProtocol, bundle: StringTable) -> Self {
        return Configuration.getConfigurationValue(valueType: String.self, key: key, bundle: bundle) ?? String()
    }
}
