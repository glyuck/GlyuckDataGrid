//
//  UIView+Appearance_Swift.h
//  Pods
//
//  Created by Vladimir Lyukov on 14/08/15.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Appearance_Swift)

// appearanceWhenContainedIn: is not available in Swift. This fixes that.
+ (instancetype)glyuck_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
+ (instancetype)glyuck_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass class2:(Class<UIAppearanceContainer>)containerClass2;

@end
