//
//  LoadingSpinner.m
//  nav
//
//  Created by ParkJooHyeon on 2016. 12. 2..
//
//

#import "LoadingSpinner.h"


@implementation LoadingSpinner

- (void)pluginInitialize {
    [self initOverlayView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvNoti:) name:CDVPageDidLoadNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recvNoti:) name:CDVPluginResetNotification object:nil];
    
}

- (void) initOverlayView
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    overlay = [[UIView alloc] initWithFrame:rect];
    overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    overlay.clipsToBounds = YES;
    
    UIActivityIndicatorView* iv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [iv startAnimating];
    
    float w_ = iv.bounds.size.width;
    float h_ = iv.bounds.size.height;
    
    iv.frame = CGRectMake(
                          center.x - w_ / 2,
                          center.y - h_ / 2,
                          w_,
                          h_
                          );
    [overlay addSubview:iv];
    
    UILabel* captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                      0,
                                                                      center.y + h_ / 2,
                                                                      rect.size.width,
                                                                      22)];
    captionLabel.backgroundColor = [UIColor clearColor];
    captionLabel.textColor = [UIColor colorWithRed:230 green:230 blue:230 alpha:0.6];
    captionLabel.font=[captionLabel.font fontWithSize:13];
    captionLabel.adjustsFontSizeToFitWidth = YES;
    captionLabel.textAlignment = NSTextAlignmentCenter;
    captionLabel.text = @"Loading...";
    [overlay addSubview:captionLabel];
    
    [self.webView addSubview:overlay];
}

- (void) recvNoti:(NSNotification *) notification
{
    if( notification.name == CDVPluginResetNotification ){
        [UIView transitionWithView:overlay duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            [overlay setHidden:NO];
        } completion:nil];
    }
    else if( notification.name == CDVPageDidLoadNotification ){
        [UIView transitionWithView:overlay duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            [overlay setHidden:YES];
        } completion:nil];
    }
}

@end
