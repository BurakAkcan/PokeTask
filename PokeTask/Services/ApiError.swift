//
//  AppError.swift
//  PokeTask
//
//  Created by Burak AKCAN on 23.09.2022.
//

import Foundation

enum APIError:LocalizedError{
    case invalidUrl
    case taskError
    case invalidResponse
    case invalidStatusCode(Int)
    case noData
    case invalidJson
    
    var errorDescription: String?{
        switch self {
        case .invalidUrl:
            return "Inavlid Url error"
        case .taskError:
            return "Task error"
        case .invalidResponse:
            return "Invalid response error"
        case .invalidStatusCode(let statusCode):
            return "Error status code \(statusCode)"
        case .noData:
            return "Error no data"
        case .invalidJson:
            return "The data could not decode"
        }
    }
}
