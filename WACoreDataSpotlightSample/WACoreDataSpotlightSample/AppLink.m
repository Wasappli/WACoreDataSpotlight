//
//  AppLink.m
//  WACoreDataSpotlightSample
//
//  Created by Marian Paul on 25/09/2015.
//  Copyright © 2015 Wasappli. All rights reserved.
//

#import "AppLink.h"

@implementation AppLink

+ (void)goTo:(NSString *)route, ... {
    va_list args;
    va_start(args, route);
    NSString *finalRoute = [[NSString alloc] initWithFormat:route arguments:args];
    va_end(args);
    
    UIApplication *application = [UIApplication sharedApplication];
    [[application delegate] application:application
                                openURL:[NSURL URLWithString:finalRoute]
                      sourceApplication:nil
                             annotation:nil];
}

@end
