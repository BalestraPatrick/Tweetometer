//
//  MPRewardedVideoAdManager.h
//  MoPubSDK
//
//  Copyright (c) 2015 MoPub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MPRewardedVideoReward;
@class CLLocation;
@protocol MPRewardedVideoAdManagerDelegate;

/**
 * `MPRewardedVideoAdManager` represents a rewarded video for a single ad unit ID. This is the object that
 * `MPRewardedVideo` uses to load and present the ad.
 */
@interface MPRewardedVideoAdManager : NSObject

@property (nonatomic, weak) id<MPRewardedVideoAdManagerDelegate> delegate;
@property (nonatomic, readonly) NSString *adUnitID;
@property (nonatomic, strong) NSArray *mediationSettings;
@property (nonatomic, copy) NSString *customerId;

- (instancetype)initWithAdUnitID:(NSString *)adUnitID delegate:(id<MPRewardedVideoAdManagerDelegate>)delegate;

/**
 * Returns the custom event class type.
 */
- (Class)customEventClass;

/**
 * Loads a rewarded video ad with the ad manager's ad unit ID.
 *
 * @param keywords A string representing a set of keywords that should be passed to the MoPub ad server to receive
 * more relevant advertising.
 *
 * @param location Latitude/Longitude that are passed to the MoPub ad server
 * If this method is called when an ad is already available and we haven't already played a video for the last time we loaded an ad,
 * the object will simply notify the delegate that an ad loaded.
 *
 * @param customerId The user's id within the app.
 *
 * However, if an ad has been played for the last time a load was issued and load is called again, the method will request a new ad.
 */
- (void)loadRewardedVideoAdWithKeywords:(NSString *)keywords location:(CLLocation *)location customerId:(NSString *)customerId;

/**
 * Tells the caller whether the underlying ad network currently has an ad available for presentation.
 */
- (BOOL)hasAdAvailable;

/**
 * Plays a rewarded video ad.
 *
 * @param viewController Presents the rewarded video ad from viewController.
 */
- (void)presentRewardedVideoAdFromViewController:(UIViewController *)viewController;

/**
 * This method is called when another ad unit has played a rewarded video from the same network this ad manager's custom event
 * represents.
 */
- (void)handleAdPlayedForCustomEventNetwork;

@end

@protocol MPRewardedVideoAdManagerDelegate <NSObject>

- (void)rewardedVideoDidLoadForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoDidFailToLoadForAdManager:(MPRewardedVideoAdManager *)manager error:(NSError *)error;
- (void)rewardedVideoDidExpireForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoDidFailToPlayForAdManager:(MPRewardedVideoAdManager *)manager error:(NSError *)error;
- (void)rewardedVideoWillAppearForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoDidAppearForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoWillDisappearForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoDidDisappearForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoDidReceiveTapEventForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoWillLeaveApplicationForAdManager:(MPRewardedVideoAdManager *)manager;
- (void)rewardedVideoShouldRewardUserForAdManager:(MPRewardedVideoAdManager *)manager reward:(MPRewardedVideoReward *)reward;

@end
