//
//  Question.swift
//  tapandtap
//
//  Copyright (c) 2023 Minii All rights reserved.

struct Question: Decodable, Equatable, Identifiable {
    let id: Int
    let question1: String
    let question2: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case question1
        case question2
    }
}
