//
//  YourData.swift
//  passTheData
//
//  Created by Jason Yang on 1/25/24.
//

import Foundation

// 예시 데이터 모델
struct YourData: Codable {
    let name: String
    let age: Int
    // 다른 속성들 추가 가능

    // JSON 형태로 변환
    func toJSONString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(self)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Error encoding data: \(error.localizedDescription)")
            return nil
        }
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    // JSON 데이터로 초기화
    init?(jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()

        do {
            self = try decoder.decode(YourData.self, from: data)
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            return nil
        }
    }
}
