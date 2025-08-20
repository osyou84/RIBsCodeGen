//
//  Edge.swift
//  RIBsCodeGen
//
//  Created by 今入　庸介 on 2021/02/08.
//

import Foundation

struct Edge: CustomStringConvertible {
    let parent: String
    let target: String
    let viewCreationOptions: ViewCreationOptions
    let isNeedle: Bool

    var description: String {
        let viewState = viewCreationOptions == .none ? "(noView)" : ""
        return "[child:\(target)\(viewCreationOptions.rawValue) -> parent:\(parent)]"
    }
}
