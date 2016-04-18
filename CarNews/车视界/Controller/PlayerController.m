//
//  PlayerController.m
//  CarNews
//
//  Created by Chenghui on 16/4/8.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#import "PlayerController.h"
#import <AVFoundation/AVFoundation.h>

#define  WEAKSELF   __weak typeof (self) weakSelf = self;

@interface PlayerController ()

/** 进度条*/
@property (strong, nonatomic) UISlider *progressSlider;

@property (nonatomic,strong)AVPlayer * avplayer;//播放器

@property (nonatomic,strong)AVPlayerItem * item;
@end

@implementation PlayerController

#pragma mark --- 在最后的话，返回
- (void)viewDidAppear:(BOOL)animated
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    // 初始化 播放器
    [self createPlarerUI];
        
}

#pragma mark -- 播放器
- (void)createPlarerUI
{
    //1.创建播放器类，并且加载视频资源
     self.item  = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.URLString]];
    self.avplayer = [[AVPlayer alloc] initWithPlayerItem:self.item];
    
    //2.将播放器和图层关联起来
    //2.1 创建播放器图层，传入播放器作为参数
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    //2.2 设置图层frame
    playerLayer.frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    //2.3 设置播放图层的填充模式，类似于 contentMode
    //    UIImageView * imageView;
    //    imageView.contentMode
    
    //按比例放置，有黑边
    //AVLayerVideoGravityResizeAspect
    //按比例填充，不留黑边，但是会裁剪视频内容
    //AVLayerVideoGravityResizeAspectFill
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //CALayer 图层类，为UIView提供显示内容的。
    //3.将视频播放图层添加到当前屏幕上
    [self.view.layer addSublayer:playerLayer];
    
#pragma mark --- 播放按钮
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setTitle:@"播放" forState:UIControlStateNormal];
//    [playButton setTitle:@"暂停" forState:UIControlStateSelected];
    playButton.backgroundColor = [UIColor redColor];
    playButton.frame = CGRectMake(10, CGRectGetMaxY(playerLayer.frame)+10, 60, 40);
    playButton.tag = 1006;
    [playButton addTarget:self action:@selector(playerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(playButton.frame)+10,CGRectGetMaxY(playerLayer.frame)+playButton.frame.size.height*0.5+10 , screen_width-(playButton.frame.size.width+10*2), 2)];
    _progressSlider.value = 0;

    //    设置左边轨道的颜色
    self.progressSlider.minimumTrackTintColor = [UIColor redColor];
    //    右边的轨道颜色
    self.progressSlider.maximumTrackTintColor = [UIColor brownColor];

    //    给滑块添加一个监听事件,当滑块的Value 发生变化的时候就执行sliderAction
    [self.progressSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
//    获取总时长
//    CMTime totalCMTime = item.asset.duration;
//    CGFloat totalTime = CMTimeGetSeconds(totalCMTime);
    // slider 的最大值
    //    _progressSlider.maximumValue = totalTime;
//    CHLog(@"总时长:%f",localtime);
    [self.view addSubview:self.progressSlider];

    
    //CALayer 图层类，为UIView提供显示内容的。
    //3.将视频播放图层添加到当前屏幕上
    [self.view.layer addSublayer:playerLayer];
    
#pragma mark --- 计算时间 滑动效果
    // 回到主线程 刷新！！！
    WEAKSELF
    [self.avplayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        CGFloat tt = self.avplayer.currentItem.duration.value * 1.0/self.avplayer.currentItem.duration.timescale;
        
        CGFloat ct = self.avplayer.currentItem.currentTime.value * 1.0/self.avplayer.currentItem.currentTime.timescale;
        
        weakSelf.progressSlider.value = ct/tt;
        
    }];

    
}


/** 播放/暂停按钮*/
- (void)playerAction:(UIButton*)button
{
    
    //创建关键帧动画对象
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    NSValue * value0 = [NSNumber numberWithFloat:1];
    NSValue * value1 = [NSNumber numberWithFloat:1.5];
    NSValue * value2 = [NSNumber numberWithFloat:0.75];
    NSValue * value3 = [NSNumber numberWithFloat:1];
    
    //修改动画时间
    animation.duration = 0.5;
    
    //设置重复次数
    animation.repeatCount = 1;
    
    
    animation.values = @[value0,value1,value2,value3];
    
    [button.layer addAnimation:animation forKey:@"123413"];
    
    
    
    
    
   UIButton *playButton = [button viewWithTag:1006];
   
    button.selected = !(playButton.selected);
    
    [button setTitle:@"暂停" forState:UIControlStateSelected];

    
    if (self.avplayer.rate == 0) { // 暂停
        [self.avplayer play];

        [self reloadInputViews];
        
    }else{
        [self.avplayer pause];
    }

}

-(void)sliderAction:(UISlider *)slider{
    
    // 拖动改变 值
    [self.avplayer seekToTime:CMTimeMake(self.progressSlider.value * self.avplayer.currentItem.duration.value, self.avplayer.currentItem.duration.timescale)];

}

/** 全屏按钮处理方法*/
//- (IBAction)fullScreenButtonClick:(UIButton *)sender {
//    // 转屏
//    NSNumber *number = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//    [[UIDevice currentDevice] setValue:number forKey:@"Orientation"];
//}

#pragma mark -- 移除对象
- (void)viewWillDisappear:(BOOL)animated
{
    self.avplayer = nil;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
}


@end
