//
//  AnimationDetailViewController.m
//  iOSUIViewAnimation
//
//  Created by minggo on 16/7/8.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "AnimationDetailViewController.h"

@interface AnimationDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *anView;
@end

@implementation AnimationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)changeFrame{
    
    CGRect originalRect = self.anView.frame;
    CGRect rect = CGRectMake(self.anView.frame.origin.x-20, self.anView.frame.origin.y-120, 120, 80);
    
    [UIView animateWithDuration:2 animations:^{
        self.anView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.anView.frame = originalRect;
        }];
        
    }];
    
}

-(void)changeBounds{
    
    CGRect originalBounds = self.anView.bounds;
    //尽管这个rect的x，y跟原始的不同，动画也只是改变了宽高
    CGRect rect = CGRectMake(0, 0, 120, 80);
    
    [UIView animateWithDuration:1 animations:^{
        self.anView.bounds = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            self.anView.bounds = originalBounds;
        }];
        
    }];
}

-(void)changeCenter{
    
    CGPoint originalPoint = self.anView.center;
    CGPoint point = CGPointMake(self.anView.center.x, self.anView.center.y+80);
    
    [UIView animateWithDuration:2 animations:^{
        self.anView.center = point;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.anView.center = originalPoint;
        }];
        
    }]; 
}

-(void)transform{
    CGAffineTransform originalTransform = self.anView.transform;
    [UIView animateWithDuration:2 animations:^{
        //self.anView.transform = CGAffineTransformMakeScale(0.6, 0.6);//缩放
        //self.anView.transform = CGAffineTransformMakeTranslation(60, -60);
        self.anView.transform = CGAffineTransformMakeRotation(4.0f);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.anView.transform = originalTransform;
            
        }];
    }];
}

-(void)alpha{
    [UIView animateWithDuration:2 animations:^{
        self.anView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 animations:^{
            self.anView.alpha = 1;
        }];

    }];
}

-(void)changeBackground{
    
    [UIView animateKeyframesWithDuration:9.0 delay:0.f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0 / 4 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.9475 green:0.1921 blue:0.1746 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:1.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.1064 green:0.6052 blue:0.0334 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.1366 green:0.3017 blue:0.8411 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            self.anView.backgroundColor = [UIColor colorWithRed:0.619 green:0.037 blue:0.6719 alpha:1.0];
        }];
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}

-(void)springAnimation{
    CGRect originalRect = self.anView.frame;
    CGRect rect = CGRectMake(self.anView.frame.origin.x-20, self.anView.frame.origin.y-120, 120, 80);
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        self.anView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
           self.anView.frame = originalRect;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
}

-(void)transitionAnimation{
    [UIView transitionWithView:self.anView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        //self.anView.backgroundColor = [UIColor blueColor];
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self.anView duration:2.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            //self.anView.backgroundColor = [UIColor greenColor];
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)click:(id)sender {
    if (self.type==0) {
        [self changeFrame];
    }else if (self.type==1){
        [self changeBounds];
    }else if (self.type==2){
        [self changeCenter];
    }else if (self.type==3){
        [self transform];
    }else if (self.type==4){
        [self alpha];
    }else if (self.type==5){
        [self changeBackground];
    }else if (self.type==6){
        [self springAnimation];
    }else if (self.type==7){
        [self transitionAnimation];
    }
}



@end
