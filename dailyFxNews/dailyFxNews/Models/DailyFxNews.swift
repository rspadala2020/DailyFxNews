//
//  DailyFxNews.swift
//  dailyFxNews
//
//  Created by raja padala on 06/11/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DailyFxNews: Codable {
    let breakingNews: JSONNull?
    let topNews: [SpecialReport]?
    let dailyBriefings: DailyBriefings?
    let technicalAnalysis, specialReport: [SpecialReport]?
}

// MARK: - DailyBriefings
struct DailyBriefings: Codable {
    let eu, asia, us: [SpecialReport]?
}

// MARK: - SpecialReport
struct SpecialReport: Codable {
    let title: String?
    let url: String?
    let specialReportDescription: String?
    let content, firstImageURL: String?
    let headlineImageURL: String?
    let articleImageURL, backgroundImageURL: String?
    let videoType, videoID: String?
    let videoURL: String?
    let videoThumbnail: String?
    let newsKeywords: String?
    let authors: [Author]?
    let instruments: [String]?
    let tags, categories: [String]?
    let displayTimestamp, lastUpdatedTimestamp: Int?

    enum CodingKeys: String, CodingKey {
        case title, url
        case specialReportDescription = "description"
        case content
        case firstImageURL = "firstImageUrl"
        case headlineImageURL = "headlineImageUrl"
        case articleImageURL = "articleImageUrl"
        case backgroundImageURL = "backgroundImageUrl"
        case videoType
        case videoID = "videoId"
        case videoURL = "videoUrl"
        case videoThumbnail, newsKeywords, authors, instruments, tags, categories, displayTimestamp, lastUpdatedTimestamp
    }
}
// MARK: - Authors
struct Author: Codable {
    let name, title: String?
    let bio: String?
    let email, phone: String?
    let facebook: String?
    let twitter, googleplus: String?
    let subscription: String?
    let rss: String?
    let descriptionLong, descriptionShort: String?
    let photo: String?
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
        return hasher.combine(0)
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
