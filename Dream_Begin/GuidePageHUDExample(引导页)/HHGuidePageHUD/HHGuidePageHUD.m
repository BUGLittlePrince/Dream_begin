//
//  HHGuidePageHUD.m
//  Dream_Begin
//
//  Created by hanhong on 2018/5/10.
//  Copyright © 2018年 hanhong. All rights reserved.
//

#import "HHGuidePageHUD.h"
#import "HHGifImageOperation.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#import "HHCustomPageControl.h"

#define HHHidden_TIME 3.0

@interface HHGuidePageHUD ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) HHCustomPageControl *imagePageControl;
@property (nonatomic, assign) NSInteger slideIntoNumber;
@property (nonatomic, strong) MPMoviePlayerController *playerController;

@end

@implementation HHGuidePageHUD

- (instancetype)hh_initWithFrame:(CGRect)frame imageNameArray:(NSArray<NSString *> *)imageNameArray buttonIsHidden:(BOOL)isHidden
{
    if (self == [super initWithFrame:frame]) {
        self.slideInto = NO;
        if (isHidden == YES) {
            self.imageArray = imageNameArray;
        }
        
        //设置引导视图的scrollView
        UIScrollView *guidePageView = [[UIScrollView alloc] initWithFrame:frame];
        [guidePageView setBackgroundColor:[UIColor lightGrayColor]];
        [guidePageView setContentSize:CGSizeMake(KScreenWidth * imageNameArray.count, KScreenHeight)];
        [guidePageView setBounces:NO];
        [guidePageView setPagingEnabled:YES];
        [guidePageView setShowsHorizontalScrollIndicator:NO];
        [guidePageView setDelegate:self];
        [self addSubview:guidePageView];
        
        //设置引导页上的跳过按钮
        UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth * 0.8, KScreenWidth * 0.1, 50, 25)];
        [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
        [skipButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [skipButton setBackgroundColor:[UIColor grayColor]];
        [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [skipButton.layer setCornerRadius:(skipButton.frame.size.height * 0.5)];
        [skipButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:skipButton];
        
        
        //添加在引导页上多张引导图片
        for (int i = 0; i < imageNameArray.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth * i, 0, KScreenWidth, KScreenHeight)];
            if ([[HHGifImageOperation hh_contentTypeForImageData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameArray[i] ofType:nil]]] isEqualToString:@"gif"]) {
                NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameArray[i] ofType:nil]];
                imageView = (UIImageView *)[[HHGifImageOperation alloc] initWithFrame:frame gifImageData:localData];
                [guidePageView addSubview:imageView];
            } else {
                imageView.image = [UIImage imageNamed:imageNameArray[i]];
                [guidePageView addSubview:imageView];
            }
            
            //设置在最后一张图片上显示进入体验按钮
            if (i == imageNameArray.count - 1 && isHidden == NO) {
                [imageView setUserInteractionEnabled:YES];
                UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
                startButton.frame = CGRectMake(KScreenWidth * 0.3, KScreenHeight * 0.8, KScreenWidth * 0.4, KScreenHeight * 0.08);
                [startButton setTitle:@"开始体验" forState:UIControlStateNormal];
                [startButton setTitleColor:[UIColor colorWithRed:164 / 255.0 green:201 / 255.0 blue:67 / 255.0 alpha:1.0] forState:UIControlStateNormal];
                [startButton.titleLabel setFont:[UIFont systemFontOfSize:21.0]];
                [startButton setBackgroundImage:[UIImage imageNamed:@"GuideImage.bundle/guideImage_button_backgound"] forState:UIControlStateNormal];
                [startButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:startButton];
            }
        }
        
        //设置引导页上的页面控制器
//        self.imagePageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.9, KScreenWidth, KScreenHeight * 0.1)];
//        self.imagePageControl.currentPage = 0;
//        self.imagePageControl.numberOfPages = imageNameArray.count;
//        self.imagePageControl.pageIndicatorTintColor = [UIColor grayColor];
//        self.imagePageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        [self addSubview:self.imagePageControl];

        HHCustomPageControl *pageControl = [[HHCustomPageControl alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.9, KScreenWidth, KScreenHeight * 0.1)];
        [self addSubview:pageControl];
        pageControl.layer.cornerRadius = 2;
        pageControl.layer.masksToBounds = YES;
        pageControl.tag = 10000;
        pageControl.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0];
        pageControl.numberOfPages = imageNameArray.count;
        pageControl.currentPage = 0;
        pageControl.pageControlType = HHPageControlTypeLine;
        pageControl.pageControlAlignment = HHPageControlAlignmentCenter;
        pageControl.pageMargin = 15;
        pageControl.pageSizeWidth = 18.0;
        pageControl.pageSizeHeight = 6.0;
        pageControl.pageIndicatorColor = [UIColor yellowColor];
        pageControl.currentPageIndicatorColor = [UIColor redColor];
        pageControl.transformScale = 1.5;
        pageControl.showPageNumber = NO;
        self.imagePageControl = pageControl;

        //展示出来
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.imagePageControl setCurrentPage:page];
    
    if (self.imageArray && page == self.imageArray.count - 1 && self.slideInto == NO) {
        [self buttonClick:nil];
    }
    if (self.imageArray && page < self.imageArray.count - 1 && self.slideInto == YES) {
        self.slideIntoNumber = 1;
    }
    if (self.imageArray && page == self.imageArray.count - 1 && self.slideInto == YES) {
        UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:nil action:nil];
        if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight) {
            self.slideIntoNumber ++;
            if (self.slideIntoNumber == 3) {
                [self buttonClick:nil];
            }
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    [UIView animateWithDuration:HHHidden_TIME animations:^{
        self.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HHHidden_TIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSelector:@selector(removeGuidePageHUD) withObject:nil afterDelay:0];
        });
    }];
}

- (void)removeGuidePageHUD
{
    [self removeFromSuperview];
    
}

//APP视频新特性页面（新增测试模块内容）
- (instancetype)hh_initWithFrame:(CGRect)frame videoURL:(NSURL *)videoURL
{
    if ([super initWithFrame:frame]) {
        self.playerController = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        [self.playerController.view setFrame:frame];
        [self.playerController.view setAlpha:1.0];
        [self.playerController setControlStyle:MPMovieControlStyleNone];
        [self.playerController setRepeatMode:MPMovieRepeatModeOne];
        //自动播放
        [self.playerController setShouldAutoplay:YES];
        //缓存
        [self.playerController prepareToPlay];
        [self addSubview:self.playerController.view];
        
        //视频引导页进入按钮
        UIButton *movieStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        movieStartButton.frame = CGRectMake(20, KScreenHeight - 30 - 40, KScreenWidth - 40, 40);
        [movieStartButton.layer setBorderWidth:1.0];
        [movieStartButton.layer setCornerRadius:20.0];
        [movieStartButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [movieStartButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [movieStartButton setAlpha:0.0];
        [self.playerController.view addSubview:movieStartButton];
        [movieStartButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [UIView animateWithDuration:HHHidden_TIME animations:^{
            [movieStartButton setAlpha:1.0];
        }];
    }
    return self;
}

@end
