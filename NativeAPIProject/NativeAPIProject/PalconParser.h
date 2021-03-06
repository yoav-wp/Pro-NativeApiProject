//
//  PalconParser.h
//  NativeAPIProject
//
//  Created by Nir Gaiger on 8/15/16.
//  Copyright © 2016 Domain Planet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PalconParser : NSObject
@property (nonatomic, strong) NSString *urlWithQueryString;
@property (nonatomic, strong) NSString *pageURL;
@property (nonatomic, strong) NSDictionary *pageDataDictionary;

-(void) initWithFullURL:(NSString *)fullURL;
-(NSString *)homepageGetFirstWysiwyg;
-(NSString *)homepageGetSecondWysiwyg;
-(NSArray *)categoryGetCarousel;
-(NSDictionary *)homepageGetBannerDataDict;
-(NSString *)homepageGetAppTitle;
-(NSString *)getPageType;
-(NSMutableArray *)getTabBarElements;
-(NSString *)brandReviewGetWysiwyg;
-(NSString *)brandReviewGetBrandName;
-(NSString *)brandReviewGetBonusText;
-(NSString *)brandNameGetClaimButtonText;
-(NSString *)brandReviewGetBrandLogo;
-(NSString *)brandReviewGetBrandRating;
-(NSString *)brandReviewGetSecondTabWysiwyg;
-(NSMutableArray *)getBrandReviewScreenshots;
-(NSArray *)brandReviewGetPaymentMethods;
-(NSString *)brandReviewGetAffiliateURL;
-(NSArray *)brandReviewGetSoftwareProviders;
-(NSString *)brandReviewGetTOSWysiwyg;
-(NSString *)homePageGetTableTitle;
-(NSArray *)brandReviewGetRatingDetails;
-(NSString *)getIsPageNative;
-(NSDictionary *)homepageGetTableWidget;
-(NSDictionary *)brandReviewGetBasicBrandInfoDict;
-(NSArray *)brandReviewGetSegmentText;


@end
