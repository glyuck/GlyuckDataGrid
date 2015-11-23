//
//  UILabel+AppearanceSelectors.h
//  Pods
//
//  Created by Vladimir Lyukov on 23/11/15.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (AppearanceSelectors)

@property(null_resettable, nonatomic, strong) UIFont               *appearanceFont UI_APPEARANCE_SELECTOR;
@property(null_resettable, nonatomic, strong) UIColor              *appearanceTextColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic,strong)         UIColor              *appearanceShadowColor UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          CGSize               appearanceShadowOffset UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          NSTextAlignment      appearanceTextAlignment UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          NSLineBreakMode      appearanceLineBreakMode UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic,strong)         UIColor              *appearanceHighlightedTextColor UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          NSInteger            appearanceNumberOfLines UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          BOOL                 appearanceAdjustsFontSizeToFitWidth UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          UIBaselineAdjustment appearanceBaselineAdjustment UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          CGFloat              appearanceMinimumScaleFactor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic)                          BOOL                 appearanceAllowsDefaultTighteningForTruncation NS_AVAILABLE_IOS(9_0) UI_APPEARANCE_SELECTOR;

- (nullable UIFont *)appearanceFont UNAVAILABLE_ATTRIBUTE;
- (nullable UIColor *)appearanceTextColor UNAVAILABLE_ATTRIBUTE;
- (nullable UIColor *)appearanceShadowColor UNAVAILABLE_ATTRIBUTE;
- (CGSize)appearanceShadowOffset UNAVAILABLE_ATTRIBUTE;
- (NSTextAlignment)appearanceTextAlignment UNAVAILABLE_ATTRIBUTE;
- (NSLineBreakMode)appearanceLineBreakMode UNAVAILABLE_ATTRIBUTE;
- (nullable UIColor *)appearanceHighlightedTextColor UNAVAILABLE_ATTRIBUTE;
- (NSInteger)appearanceNumberOfLines UNAVAILABLE_ATTRIBUTE;
- (BOOL)appearanceAdjustsFontSizeToFitWidth UNAVAILABLE_ATTRIBUTE;
- (UIBaselineAdjustment)appearanceBaselineAdjustment UNAVAILABLE_ATTRIBUTE;
- (CGFloat)appearanceMinimumScaleFactor UNAVAILABLE_ATTRIBUTE;
- (BOOL)appearanceAllowsDefaultTighteningForTruncation UNAVAILABLE_ATTRIBUTE;

@end
