//
//  SequenceExtension.swift
//  OMDbApp
//
//  Created by Kian Popat on 23/11/2022.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
