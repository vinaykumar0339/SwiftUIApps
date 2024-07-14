//
//  UIApplication+Extensions.swift
//  WeatherApp
//
//  Created by vinay kumar on 14/07/24.
//

import UIKit
import Foundation

extension UIApplication {
    func dismissKeyBoard() {
        sendAction(#selector(UITextField.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
