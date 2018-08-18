//
//  TimelineDownloaderOperation.swift
//  TweetometerKit
//
//  Created by Patrick Balestra on 8/17/18.
//  Copyright © 2018 Patrick Balestra. All rights reserved.
//

import Foundation
import TwitterKit

class TimelineDownloaderOperation: Operation {

    let client: TWTRAPIClient
    let semaphore = DispatchSemaphore(value: 0)
    let maxId: String?

    var result: Result<Timeline>?

    init(client: TWTRAPIClient, maxId: String? = nil) {
        self.client = client
        self.maxId = maxId
    }

    override func main() {
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"

        var parameters = ["count": "200", "exclude_replies": "false"]
        if let maxId = maxId {
            parameters["max_id"] = maxId
        }
        let request = client.urlRequest(withMethod: "GET", urlString: url, parameters: parameters, error: nil)
        client.sendTwitterRequest(request) { [unowned self] response, data, error in
            if let error = error {
                return self.result = .error(TweetometerError.from(error))
            }
            guard let data = data else {
                return self.result = .error(TweetometerError.invalidResponse)
            }

            do {
                let tweets = try JSONDecoder.twitter.decode([Tweet].self, from: data)
                self.result = .success(Timeline(tweets: tweets))
            } catch {
                return self.result = .error(TweetometerError.invalidResponse)
            }
            self.semaphore.signal()
        }
        self.semaphore.wait()
    }
}
