//
//  AGAlertViewWithProgressbar.h
//  iPadToiPad
//
//  Created by gold on 8/7/15.
//  Copyright (c) 2015 gold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AGAlertViewWithProgressbar : NSObject<UIAlertViewDelegate>{
    NSUInteger progress;
    NSString *title;
    NSString *message;
    NSString *cancelBtnTitle;
    NSArray *otherBtnTitles;
    UIAlertView *alertView;
    UIProgressView *progressView;
    UILabel *progressLbl;
    
    struct {
        unsigned int delegateClickedBtnAtIndex:1;
        unsigned int delegateCancel:1;
        unsigned int delegateWillPresentAlertView:1;
        unsigned int delegateDidPresentAlertView:1;
        unsigned int delegateWillDismissWithBtnIndex:1;
        unsigned int delegateDidDismissWithBtnIndex:1;
        unsigned int delegateShouldEnableFirstOtherBtn:1;
    }supportedDelegateMethods;
}

@property (nonatomic, assign) NSUInteger progress;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *cancelBtnTitle;
@property (nonatomic, retain) NSArray *otherBtnTitles;
@property (nonatomic, assign) id<UIAlertViewDelegate> delegate;
@property (nonatomic, readonly, getter=isVisible) BOOL visible;
@property (nonatomic, retain) UIAlertView *alertView;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) UILabel *progressLbl;

- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage andDelegate:(id<UIAlertViewDelegate>)theDelegate;
- (id)initWithTitle:(NSString *)theTitle message:(NSString *)theMessage delegate:(id)theDelegate cancelButtonTitle:(NSString *)titleForTheCancelButton otherButtonTitles:(NSString *)titleForTheFirstButton, ... NS_REQUIRES_NIL_TERMINATION;

- (void)show;
- (void)hide;

- (void)repositionControls;
- (void)setAutoresizingMask;
- (void)setupAlertView;
- (void)setProgress:(NSUInteger)theProgress withRange:(NSUInteger)range;

@end
