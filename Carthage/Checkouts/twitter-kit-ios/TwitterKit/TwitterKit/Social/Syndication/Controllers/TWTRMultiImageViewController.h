/*
 * Copyright (C) 2017 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

/**
 This header is private to the Twitter Kit SDK and not exposed for public SDK consumption
 */

#import <UIKit/UIKit.h>
#import "TWTRMediaContainerViewController.h"

@class TWTRTweetMediaEntity;

NS_ASSUME_NONNULL_BEGIN

@interface TWTRImagePresentationContext : NSObject

/**
 * The image to display.
 */
@property (nonatomic, readonly, nullable) UIImage *image;

/**
 * The media entity to display
 */
@property (nonatomic, readonly) TWTRTweetMediaEntity *mediaEntity;

/**
 * The Tweet ID for the owner of the image.
 */
@property (nonatomic, copy, readonly) NSString *parentTweetID;

/**
 * Initializes the receiver with the given image and URL.
 */
+ (instancetype)contextWithImage:(nullable UIImage *)image mediaEntity:(TWTRTweetMediaEntity *)mediaEntity parentTweetID:(NSString *)parentTweetID;
- (instancetype)initWithImage:(nullable UIImage *)image mediaEntity:(TWTRTweetMediaEntity *)mediaEntity parentTweetID:(NSString *)parentTweetID;

@end

@interface TWTRMultiImageViewController : UIPageViewController <TWTRMediaContainerPresentable>

@property (nonatomic, copy, readonly) NSArray<TWTRImagePresentationContext *> *contexts;

- (instancetype)initWithImagePresentationContexts:(NSArray<TWTRImagePresentationContext *> *)contexts initialContextIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
