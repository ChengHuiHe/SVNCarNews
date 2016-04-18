# SVNCarNews
# 这个是 《车-资讯》个人项目，喜欢的话给个星，谢谢！
![image](https://github.com/ChengHuiHe/SVNCarNews/blob/master/123.gif ) 
- 首页是常规的新闻类展示。
- 广告的实现：第一种是使用通知，当点击了某张图片时，发送一个通知，这个通知有个notice 属性，（它可以带参数），把值传道下一个界面。
第二种是block，事实上原理也一样。这里我采用block。

- 视频：由于没有使用第三方组件，使用常规的AVPlayer 类，然后，创建一个播放层AVPlayerLayer，
    //1.创建播放器类，并且加载视频资源
     self.item  = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.URLString]];
    self.avplayer = [[AVPlayer alloc] initWithPlayerItem:self.item];
    
    //2.将播放器和图层关联起来
    //2.1 创建播放器图层，传入播放器作为参数
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    设置 playerLayer 的frame 就可以，实现简单的播放了。
# 多表嵌套：本项目中使用到一个 表视图里面嵌套一个 collectionView。
 ![image](https://github.com/SVNCarNews/1.png)

 - 实现思路是，先创建一张表，设置数据源和代理，把cell的图片 和 标题设置在一个合理的范围内：例如100的宽。然后，在这张表上，添加一个子控制器。该
 子控制器是 collectionView，然后，实现子控制器的代理和数据源，就可以了。
 
 # 注意：这里的数据解析，有点不一样：
 - 因为,主要是服务器，那边的返回不太符合常规写法，所以，我根据实际情况这样写：
      /**
     *  GBK2312中文编码
     *  @param kCFStringEncodingGB_18030_2000
     */
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];// 服务器，那边的问题，具体设置，看请求体
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSString * retStr = [[NSString alloc] initWithData:responseObject encoding:enc];
        
        NSData * data = [retStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError * error = [[NSError alloc] init];
        
        //json解析
        NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        
        [self parserArray:array];//解析数据
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
        
    }];
