//
//  SectionViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/29/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: AnimatableSectionModelType {
    var identity: String { "" }

    typealias Identity = String
    typealias Item = PresentableAnswer
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
