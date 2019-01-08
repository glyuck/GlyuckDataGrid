//
//  UIView+Appearance_Swift.m
//  Pods
//
//  Created by Vladimir Lyukov on 14/08/15.
//
//

#import "UIView+Appearance_Swift.h"

@implementation UIView (Appearance_Swift)

+ (instancetype)glyuck_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}

+ (instancetype)glyuck_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass class2:(Class<UIAppearanceContainer>)containerClass2 {
    return [self appearanceWhenContainedIn:containerClass, containerClass2, nil];
}

@end
