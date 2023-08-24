//
//  NewsModel.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 24.08.2023.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let status: String
    let totalResults: Int
    let results: [News]
    let nextPage: JSONNull?
}

// MARK: - Result
struct News: Codable {
    let title: String
    let link: String
    let description: String
    let content: String?
    let pubDate: String
    let imageURL: String?


    enum CodingKeys: String, CodingKey {
        case title, link
        case description, content, pubDate
        case imageURL = "image_url"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

