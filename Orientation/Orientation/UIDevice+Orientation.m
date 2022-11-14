//
//  UIDevice+Orientation.m
//  Orientation
//
//  Created by 王亮 on 2022/11/14.
//

#import "UIDevice+Orientation.h"

@implementation UIDevice (Orientation)
- (void)changeInterfaceOrientationTo:(UIInterfaceOrientation)orientation
{
   if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
       SEL selector             = NSSelectorFromString(@"setOrientation:");
       NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
       [invocation setSelector:selector];
       [invocation setTarget:[UIDevice currentDevice]];
       int val                  = orientation;
       [invocation setArgument:&val atIndex:2];
       [invocation invoke];
   }
}
@end
