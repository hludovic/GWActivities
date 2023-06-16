//
//  NetworkingMock.swift
//  GWActivitiesTests
//
//  Created by Ludovic HENRY on 15/06/2023.
//

import Foundation
@testable import GWActivities

class NetworkingMock: Networking {
    var result = Result<Data, Error>.success(Data())

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        try (result.get(), URLResponse())
    }
}
