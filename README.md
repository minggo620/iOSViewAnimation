
# 谈UIView Animation编程艺术
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSViewAnimation/master.zip)   
“Action！”，欢迎收看这期大型扯谈实用类技术节目，《小明讲故事》，大家好我是小明！  

有人会这么问，“小明，no zuo no die，你觉得哪个城市的人最作？”。“我觉得~伦敦的人比较作，相当作，作得有风格，作得有国际范！因为~有一个伦敦人叫Charlie Chaplin，中文名叫查理 卓别林，小名叫作不停，作界的佛爷啊，嘻嘻~”。    
  
“幼稚！！” ，“美国新墨西哥州的人也挺作的，你看《猫和老鼠》中的Tom捉了140集，Jerry还是没有被捉住，作界的二爷呢。” ，“滚！！”。  
 
**得动画者得天下啊**，有请我们今天的嘉宾哑剧之王--卓别林先生和深爱Jerry的Tom先生。  
![文章结构图](http://upload-images.jianshu.io/upload_images/1252638-e34dbfae11866a13.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
卓先生，您也做过电影后期剪切工作，电影的动画是如何形成的呢？
>在英国把动画叫Animation，它的动词形式是Animate，你们中文意思是“赋予生命”。对于人类来说，眼睛看到一幅画或一个物体后，在0.34秒内不会消失。利用这一原理，在一幅画还没有消失前播放下一幅画，就会给人造成一种流畅的视觉变化效果。对于苍蝇，那就不一样，那叫反应迟钝。    

![chaplin.gif](http://upload-images.jianshu.io/upload_images/1252638-b4400573ed42866e.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)


哦~卓先生说的应该就是**逐帧动画**，每一个画面就是一帧，逐一播放形成连续的动画效果。那么，Tom先生，您那个时代动画又有什么变化吗？
>我是看卓先生的电影长大的，1940我才出现在荧屏上。不过有些不一样了，不仅仅单一画面逐一播放，你们可以在《猫和老鼠》中，看到我的胡子被Jerry拉得夸张长，追起Jerry来，身体那些夸张的伸缩，人无法做到的，这也是动漫的魅力。这些动画变化，是可以通过计算机计算每一个时间变化的信息集合成每一帧的画面。  

![tom.gif](http://upload-images.jianshu.io/upload_images/1252638-2bfdc6e531105220.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)  

哦~Tom先生说的应该是**关键帧动画**，这个在现代技术比较常见的动画制作方式。比如现在大家用的苹果产品，按钮的大小变化，图片的移动，旋转等等这些都是关键帧动画。作为iOS开发者的话，UIView Animation就是属于关键帧动画这一类。  
  
现代的技术是很先进，挺有味道的，我们一起来领略一下，还得请Tom示范一下。
###一.大小动画（改变frame）  
####1.展示效果
![fram大小变化](http://upload-images.jianshu.io/upload_images/1252638-e55121cc90b124cc.gif?imageMogr2/auto-orient/strip)  
####2.Show Code  
	-(void)changeFrame{
    
    	CGRect originalRect = self.anView.frame;
    	CGRect rect = CGRectMake(self.anView.frame.origin.x-20, self.anView.frame.origin.y-120, 160, 80);
    
    	[UIView animateWithDuration:1 animations:^{
        	self.anView.frame = rect;
    	} completion:^(BOOL finished) {
        	[UIView animateWithDuration:1 animations:^{
            	self.anView.frame = originalRect;
        	}];
        
    	}];
	}   

###二.拉伸动画（改变bounds）    
####1.展示效果
![bounds变化](http://upload-images.jianshu.io/upload_images/1252638-c537a67a110fed09.gif?imageMogr2/auto-orient/strip)  
####2.Show Code
	-(void)changeBounds{
    
    	CGRect originalBounds = self.anView.bounds;
    	//尽管这个rect的x，y跟原始的不同，动画也只是改变了宽高
    	CGRect rect = CGRectMake(0, 0, 300, 120);
    
    	[UIView animateWithDuration:1 animations:^{
        self.anView.bounds = rect;
    	} completion:^(BOOL finished) {
        	[UIView animateWithDuration:1 animations:^{
            	self.anView.bounds = originalBounds;
        	}];
        
    	}];
	}

###三.转移动画（改变center）
####1.展示效果
![animation3.gif](http://upload-images.jianshu.io/upload_images/1252638-982b6c7a810f4ed1.gif?imageMogr2/auto-orient/strip)  
####2.Show Code  
  
	-(void)changeCenter{
    
    	CGPoint originalPoint = self.anView.center;
    	CGPoint point = CGPointMake(self.anView.center.x, self.anView.center.y-170);
    
    	[UIView animateWithDuration:0.3 animations:^{
        	self.anView.center = point;
    	} completion:^(BOOL finished) {
        	[UIView animateWithDuration:1 animations:^{
            	self.anView.center = originalPoint;
        	}];
        
    	}]; 
	}
	  

谢谢二爷的示范，经典的表情也勾起很多人的回忆。好，我们回到现实，以上的3个例子，大家不难发现共同的特点和重复性。  
>**1.都是改变UIView的属性就可以产生动画。**  
**2.都是带有block做结束回调，对结束监控**  
**3.动画大小和位置变化可以通过多种方式实现**  

“佛爷，是不是很好奇我们并没有使用Tom先生很多图片组逐一显示？来，也请您下矿一走！”。“哈哈，好！不过那碗河水我还是要倒的”，“行，随你翻腾~”。  
  
###四.旋转动画(改变transform)  
####1.展示效果  
![animation4.gif](http://upload-images.jianshu.io/upload_images/1252638-21b81e01aeffae75.gif?imageMogr2/auto-orient/strip)  
####2.Show Code   
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
  
###五.透明度动画(改变alpha)      
####1.展示效果  
![animation5.gif](http://upload-images.jianshu.io/upload_images/1252638-8413629d4f3ffe79.gif?imageMogr2/auto-orient/strip)  
####2.Show Code   
	-(void)alpha{
    	[UIView animateWithDuration:2 animations:^{
        	self.anView.alpha = 0.3;
    	} completion:^(BOOL finished) {
        	[UIView animateWithDuration:2 animations:^{
            	self.anView.alpha = 1;
        	}];

    	}];
	}  

卓先生，停停停，来，回到我们舞台中间来。就以上6中都能让您玩的这么愉快，以上都是仅仅修改本身的属性值，我再介绍剩下三种基于UIView特别的动画，一个是Keyframe，一个Spring和transition动画。一人一个轮着来，卓先生先生你先。

###六.背景颜色Keyframes动画（改变background）    
####1.展示效果 
![animation6.gif](http://upload-images.jianshu.io/upload_images/1252638-1bd8f41adab762f0.gif?imageMogr2/auto-orient/strip)  
####2.Show Code   
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
        	[UIView addKeyframeWithRelativeStartTime:3.0 / 4 relativeDuration:1.0 / 4 animations:^{
            	self.anView.backgroundColor = [UIColor whiteColor];
        	}];
    	} completion:^(BOOL finished) {
        	NSLog(@"动画结束");
    	}];
	}

###七.Spring动画（iOS7.0起）    
####1.展示效果
![animation7.gif](http://upload-images.jianshu.io/upload_images/1252638-be761fff07d7abe1.gif?imageMogr2/auto-orient/strip)  
####2.Show Code   
	-(void)springAnimation{
    	CGRect originalRect = self.anView.frame;
    	CGRect rect = CGRectMake(self.anView.frame.origin.x-80, self.anView.frame.origin.y, 120, 120);
    
    	[UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
        	self.anView.frame = rect;
    		} completion:^(BOOL finished) {
        		[UIView animateWithDuration:1 delay:1 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveLinear animations:^{
           			self.anView.frame = originalRect;
        		} completion:^(BOOL finished) {
            
        	}];
    	}];
	}
	
	
###八.transition动画    
####1.展示效果
![animation8.gif](http://upload-images.jianshu.io/upload_images/1252638-a10f214c11af5c57.gif?imageMogr2/auto-orient/strip)  
####2.Show Code   
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
	
###九.关于参数option选择说明
####1.UIViewAnimationOptions
	
	UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
	UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
	UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
	UIViewAnimationOptionRepeat                    //无限重复执行动画
	UIViewAnimationOptionAutoreverse               //执行动画回路
	UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
	UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
	UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
	UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
	UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置

	UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
	UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
	UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
	UIViewAnimationOptionCurveLinear               //时间曲线，匀速

	UIViewAnimationOptionTransitionNone            //转场，不使用动画
	UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
	UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
	UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
	UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
	UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
	UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
	UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页

###2.UIViewKeyframeAnimationOptions
	UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
	UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
	UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
	UIViewAnimationOptionRepeat                   //无限重复执行动画
	UIViewAnimationOptionAutoreverse              //执行动画回路
	UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
	UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置

	UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
	UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
	UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
	UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
	UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀

就UIView的动画而言，UIViewKeyframeAnimationOptions紧在Keyframes，其余的都是UIViewAnimationOptions。  

###十.总结和扩展  
**1.UIView动画主要是变化UIView的自带属性**  
**2.UIView动画可以有很多种方式实现同一效果**  
**3.Spring动画iOS7.0以上才有**  
**4.UIViewKeyframeAnimationOptions用着Keyframes动画，其余都用UIViewAnimationOptions枚举**  
这就以上UIView Animation的动画的基础内容了，节目到了尾声。嘿，卓先生，Tom先生停下来，给大家说byebye啦。谢谢大家，让我们再次以热烈的掌声感谢卓先生和Tom先生。谢谢~~ 
###十一.源码地址
#####*[https://github.com/minggo620/iOSViewAnimation](https://github.com/minggo620/iOSViewAnimation)*
######谢谢收看这期大型扯淡实用技术类节目，《小明讲故事》。"Tom老师，你对我眨眼什么意思？"，“你们中国的《喜洋洋和灰太狼》捉了多少集？” 
***
**【原创出品 未经授权 禁止转载】**  
**【欢迎微友分享转发 禁止公号等未经授权的转载】**
