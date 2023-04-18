//
//  Alerts.swift
//  DessertApp
//
//  Created by Elise on 4/16/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidData = AlertItem(title: Text("Server Error"),
                                       message: Text("Invalid data received from server. Please contact support."),
                                       dismissButton: .default(Text("Dismiss")))
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                           message: Text("Invalid response from server. Please try again later or contact support."),
                                           dismissButton: .default(Text("Dismiss")))
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("There was an issue connecting to the server. Please contact support."),
                                      dismissButton: .default(Text("Dismiss")))
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            message: Text("Unable to complete your request. Please check your internet connection."),
                                            dismissButton: .default(Text("Dismiss")))
}
