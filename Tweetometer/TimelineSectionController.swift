//
//  TimelineSectionController.swift
//  Tweetometer
//
//  Created by Patrick Balestra on 8/18/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import TweetometerKit
import IGListKit

class TimelineSectionController: ListSectionController {

    var timelineController: TimelineModelController?

    init(timelineController: TimelineModelController? = nil) {
        self.timelineController = timelineController
        super.init()
        setUp()
    }

    private func setUp() {
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }

    override func numberOfItems() -> Int {
        guard let timelineController = timelineController else { return 0 }
        return timelineController.usersTimeline().count
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        let width = context.containerSize.width
        return CGSize(width: width, height: 80)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "TimelineUserCollectionViewCell", bundle: Bundle.main, for: self, at: index) as? TimelineUserCollectionViewCell else { fatalError() }
        
        return cell
    }

    override func didUpdate(to object: Any) {

    }

    override func didSelectItem(at index: Int) {
        
    }
}
