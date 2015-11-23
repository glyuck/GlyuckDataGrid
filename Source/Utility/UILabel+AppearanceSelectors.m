//
//  UILabel+AppearanceSelectors.m
//  Pods
//
//  Created by Vladimir Lyukov on 23/11/15.
//
//

#import "UILabel+AppearanceSelectors.h"

@implementation UILabel (AppearanceSelectors)

- (void)setAppearanceFont:(UIFont *)font {
    self.font = font;
}

- (void)setAppearanceTextColor:(UIColor *)textColor {
    self.textColor = textColor;
}

- (void)setAppearanceShadowColor:(UIColor *)shadowColor {
    self.shadowColor = shadowColor;
}

- (void)setAppearanceShadowOffset:(CGSize)shadowOffset {
    self.shadowOffset = shadowOffset;
}

- (void)setAppearanceTextAlignment:(NSTextAlignment)textAlignment {
    self.textAlignment = textAlignment;
}

- (void)setAppearanceLineBreakMode:(NSLineBreakMode)lineBreakMode {
    self.lineBreakMode = lineBreakMode;
}

- (void)setAppearanceHighlightedTextColor:(UIColor *)highlightedTextColor {
    self.highlightedTextColor = highlightedTextColor;
}

- (void)setAppearanceNumberOfLines:(NSInteger)numberOfLines {
    self.numberOfLines = numberOfLines;
}

- (void)setAppearanceAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth {
    self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
}

- (void)setAppearanceBaselineAdjustment:(UIBaselineAdjustment)baselineAdjustment {
    self.baselineAdjustment = baselineAdjustment;
}

- (void)setAppearanceMinimumScaleFactor:(CGFloat)minimumScaleFactor {
    self.minimumScaleFactor = minimumScaleFactor;
}

- (void)setAppearanceAllowsDefaultTighteningForTruncation:(BOOL)allowsDefaultTighteningForTruncation {
    self.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation;
}

@end
