//
//  UIFont+Ext.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

import UIKit

extension UIFont {
    
    class func preferredFont(forTextStyle style: UIFont.TextStyle, weight: UIFont.Weight = .regular, size: CGFloat? = nil) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        
        let defaultFont = UIFont.preferredFont(forTextStyle: style)
        let fontSize = size ?? defaultFont.pointSize
        
        let fontToScale = UIFont.systemFont(ofSize: fontSize, weight: weight)
        
        return metrics.scaledFont(for: fontToScale)
    }
}
