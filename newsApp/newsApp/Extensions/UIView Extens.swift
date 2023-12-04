//
//  UIView Extens.swift
//  newsApp
//
//  Created by User on 29.11.2023.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
