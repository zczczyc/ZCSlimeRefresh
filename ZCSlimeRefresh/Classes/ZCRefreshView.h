//
//  ZCRefreshView.h
//  ZCSlimeRefresh
//
//  A refresh view looks like UIRefreshControl
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCSlimeView.h"

@class ZCRefreshView;

typedef void (^ZCRefreshBlock)(ZCRefreshView* sender);

@protocol ZCRefreshDelegate;

@interface ZCRefreshView : UIView{
    UIImageView     *_refreshView;
    ZCSlimeView     *_slime;
}

//set the state loading or not.
@property (nonatomic, assign)   BOOL    loading;
- (void)setLoadingWithexpansion;

//set the slime's style by this property.
@property (nonatomic, strong, readonly) ZCSlimeView *slime;
//set your refresh icon.
@property (nonatomic, strong, readonly) UIImageView *refreshView;
//select one to receive the refreshing message.
@property (nonatomic, copy)     ZCRefreshBlock      block;
@property (nonatomic, weak)   id<ZCRefreshDelegate>   delegate;
@property (nonatomic, readonly) UIActivityIndicatorView *activityIndicationView;

//default is false, if true when slime go back it will have a alpha effect 
//to go to miss.
@property (nonatomic, assign)   BOOL    slimeMissWhenGoingBack;

// not need
@property (nonatomic, assign)   CGFloat upInset;

//
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDraging;

//as the name, called when loading over.
- (void)endRefresh;

// init default is 32
- (id)initWithHeight:(CGFloat)height;
// call update when the scrollView size changed.
-(void)update:(CGFloat)upInset;

@end

@protocol ZCRefreshDelegate <NSObject>

@optional
//start refresh.
- (void)slimeRefreshStartRefresh:(ZCRefreshView*)refreshView;

@end
