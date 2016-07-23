//
//  AGAlertViewWithProgressbar.m
//  iPadToiPad
//
//  Created by gold on 8/7/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import "public.h"
#import "AGAlertViewWithProgressbar.h"

@interface AGAlertViewWithProgressbar()

@end

@implementation AGAlertViewWithProgressbar

#pragma mark - Properties
@synthesize progress, title, message, delegate, cancelBtnTitle, otherBtnTitles;

- (BOOL)isVisible{
    return self.alertView.visible;
}

- (void)setProgress:(NSUInteger)theProgress withRange:(NSUInteger)range{
    if (progress != theProgress) {
        if (theProgress > range) {
            return;
        }
        
        progress = theProgress;
        
        self.progressView.progress = (float)(progress/(float)range);
        self.progressLbl.text = [NSString stringWithFormat:@"%d%%", (int)(self.progressView.progress*100)];
    }
}

- (void)setTitle:(NSString *)theTitle{
    if (title != theTitle) {
        title = theTitle;
        
        self.alertView.title = title;
    }
}

- (void)setMessage:(NSString *)theMessage{
    if (message != theMessage) {
        message = theMessage;
        self.alertView.message = message;
    }
}

- (void)setDelegate:(id<UIAlertViewDelegate>)theDelegate{
    if (delegate != theDelegate) {
        delegate = theDelegate;
        
        supportedDelegateMethods.delegateClickedBtnAtIndex = ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]);
        supportedDelegateMethods.delegateCancel = ([self.delegate respondsToSelector:@selector(alertViewCancel:)]);
        supportedDelegateMethods.delegateWillPresentAlertView = ([self.delegate respondsToSelector:@selector(willPresentAlertView:)]);
        supportedDelegateMethods.delegateDidPresentAlertView = ([self.delegate respondsToSelector:@selector(didPresentAlertView:)]);
        supportedDelegateMethods.delegateWillDismissWithBtnIndex = ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]);
        supportedDelegateMethods.delegateDidDismissWithBtnIndex = ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]);
        supportedDelegateMethods.delegateShouldEnableFirstOtherBtn = ([self.delegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]);
    }
}

- (void)setCancelBtnTitle:(NSString *)theCancelBtnTitle{
    if (cancelBtnTitle != theCancelBtnTitle) {
        cancelBtnTitle = theCancelBtnTitle;
        
        [self hide];
        self.alertView = nil;
    }
}

- (void)setOtherBtnTitles:(NSArray *)theOtherBtnTitles{
    if (otherBtnTitles != theOtherBtnTitles) {
        otherBtnTitles = theOtherBtnTitles;
        
        [self hide];
        self.alertView = nil;
    }
}

@synthesize alertView, progressView, progressLbl;

- (UIAlertView *)alertView{
    if (alertView == nil) {
        alertView = [[UIAlertView alloc]initWithTitle:self.title message:self.message delegate:self cancelButtonTitle:self.cancelBtnTitle otherButtonTitles:nil];
        
        for (NSString *arg in self.otherBtnTitles) {
            [alertView addButtonWithTitle:arg];
        }
        
        [self setupAlertView];
    }
    
    return alertView;
}

#pragma mark - Object Lifecycle

- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage andDelegate:(id<UIAlertViewDelegate>)theDelegate{
    return [self initWithTitle:theTitle message:theMessage delegate:theDelegate cancelButtonTitle:nil otherButtonTitles:nil];
}

- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage delegate:(id)theDelegate cancelButtonTitle:(NSString *)titleForTheCancelButton otherButtonTitles:(NSString *)titleForTheFirstButton, ... NS_REQUIRES_NIL_TERMINATION{
    
    self = [super init];
    if (self){
        NSMutableArray *otherButtonTitlesArray = [[NSMutableArray alloc]init];
        
        va_list args;
        va_start(args, titleForTheFirstButton);
        for (NSString *arg = titleForTheFirstButton; arg != nil; arg = va_arg(args, NSString *)){
            [otherButtonTitlesArray addObject:arg];
        }
        va_end(args);
        
        self.progress = 0;
        self.message = theMessage;
        self.title = theTitle;
        self.delegate = theDelegate;
        self.cancelBtnTitle = titleForTheCancelButton;
        self.otherBtnTitles = otherButtonTitlesArray;
    }
    return self;
}

#pragma mark - Public Methods

- (void)show{
    if (!self.visible) {
        [self.alertView show];
    }
}

- (void)hide{
    if (self.visible) {
        [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)thisAlertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (supportedDelegateMethods.delegateClickedBtnAtIndex) {
        [self.delegate alertView:thisAlertView clickedButtonAtIndex:buttonIndex];
    }
}

- (void)alertViewCancel:(UIAlertView *)thisAlertView{
    if (supportedDelegateMethods.delegateCancel) {
        [self.delegate alertViewCancel:thisAlertView];
    }
}

- (void)willPresentAlertView:(UIAlertView *)thisAlertView{
    [self repositionControls];
    
    if (supportedDelegateMethods.delegateWillPresentAlertView) {
        [self.delegate willPresentAlertView:thisAlertView];
    }
}

- (void)didPresentAlertView:(UIAlertView *)thisAlertView{
    if (supportedDelegateMethods.delegateDidPresentAlertView) {
        [self.delegate didPresentAlertView:thisAlertView];
    }
}

- (void)alertView:(UIAlertView *)thisAlertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (supportedDelegateMethods.delegateWillDismissWithBtnIndex) {
        [self.delegate alertView:thisAlertView willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)thisAlertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    self.alertView = nil;
    
    if (supportedDelegateMethods.delegateDidDismissWithBtnIndex) {
        [self.delegate alertView:thisAlertView didDismissWithButtonIndex:buttonIndex];
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)thisAlertView{
    if (supportedDelegateMethods.delegateShouldEnableFirstOtherBtn) {
        return [self.delegate alertViewShouldEnableFirstOtherButton:thisAlertView];
    }else{
        return NO;
    }
}

#pragma mark - Private Methods

- (void)repositionControls{
    UILabel *messageLabel = nil;
    
    NSInteger idx = 0;
    for (UIView *subview in self.alertView.subviews) {
        if (([subview isKindOfClass:[UILabel class]]) && subview != self.progressLbl) {
            idx ++;
            
            if (idx == 2) {
                messageLabel = (UILabel *)subview;
                break;
            }
        }
    }
    
    CGFloat y = messageLabel.top + messageLabel.height + 20.0f;
    
    self.progressView.frame = CGRectMake(30.0f, y + 3.f, 170.0f, 90.0f);
    self.progressLbl.frame = CGRectMake(215.0f, y, 40.0f, 14.0f);
    
    if (alertView.numberOfButtons > 0) {
        [self setAutoresizingMask];
        
        self.alertView.frame = (CGRect){self.alertView.frame.origin, {self.alertView.width, self.alertView.height + 40.f}};
    }
}

- (void)setAutoresizingMask{
    for (UIView *subview in self.alertView.subviews) {
        if (([subview isKindOfClass:[UIButton class]])) {
            subview.autoresizingMask = subview.autoresizingMask ^ UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        }
    }
}

- (void)setupAlertView{
    self.alertView.autoresizesSubviews = YES;
    
    progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.progress = (float)(self.progress/100.f);
    [self.alertView addSubview:self.progressView];
    
    progressLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    self.progressLbl.backgroundColor = [UIColor clearColor];
    self.progressLbl.textColor = [UIColor whiteColor];
    self.progressLbl.font = [UIFont systemFontOfSize:14.f];
    self.progressLbl.text = [NSString stringWithFormat:@"%d%%", (int)self.progress];
    self.progressLbl.tag = 1;
    self.progressLbl.textAlignment = NSTextAlignmentCenter;
    [self.alertView addSubview:self.progressLbl];
}

@end
