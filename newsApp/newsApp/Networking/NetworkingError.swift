//
//  NetworkingError.swift
//  newsApp
//
//  Created by User on 02.12.2023.
//

import UIKit

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
