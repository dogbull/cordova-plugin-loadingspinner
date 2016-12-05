//
//  LoadingSpinner.h
//  nav
//
//  Created by ParkJooHyeon on 2016. 12. 2..
//
//

#import <Cordova/CDVPlugin.h>


@interface LoadingSpinner : CDVPlugin
{
    UIView* overlay;
}

- (void)pluginInitialize;

@end
