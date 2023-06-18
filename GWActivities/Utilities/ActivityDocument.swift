//
//  MessageDocument.swift
//  GWActivities
//
//  Created by Ludovic HENRY on 18/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct ActivityDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.commaSeparatedText]

    var message: String = ""

    init(message: String = "") {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            message = String(decoding: data, as: UTF8.self)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(message.utf8)
        return FileWrapper(regularFileWithContents: data)
    }

}
