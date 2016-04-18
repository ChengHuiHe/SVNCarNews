//
//  Address.h
//  CarNews
//
//  Created by Chenghui on 16/3/3.
//  Copyright © 2016年 Chenghui. All rights reserved.
//

#ifndef Address_h
#define Address_h

/********************首页************************/

// 首页的广告 --- POST
// http://123.57.66.127/qctt-api/5.1/index.php/Adverqctt/getFocus?region=%E5%8C%97%E4%BA%AC&classId=0
//拼接参数： region=%E5%8C%97%E4%BA%AC&classId=0
#define KADV_TouTiao_URL @"http://123.57.66.127/qctt-api/5.1/index.php/Adverqctt/getFocus?"

//================ 头条 POST =================

// 1首页 --- 头条 --- 到时拼接id
// —- POST —-(page=0)
//http://123.57.66.127/qctt-api/5.1/index.php/News/getNewsList?page=0&classId=0

#define KTouTiao_URL @"http://123.57.66.127/qctt-api/5.1/index.php/News/getNewsList"

// 1.1详情 ——（传值） resourceLoc: “90055”,,到时拼接：90070.html
//http://m.qctt.cn/html/mobile/news_new/showapi5-98619.html
#define KDetail_URL @"http://m.qctt.cn/html/mobile/news_new/showapi5-"

//================ 新车 POST=================
// http://123.57.66.127/qctt-api/5.1/index.php/Adverqctt/getFocus 汽车头条

// http://api.app.yiche.com/webapi/newslist.ashx?categoryid=3&pageindex=1&pagesize=20&productid=17&v=1  易车
//#define KNewCar_URL @"http://123.57.66.127/qctt-api/5.1/index.php/News/getNewsList"

#define KNewCar_URL @"http://api.app.yiche.com/webapi/newslist.ashx"


//新车
//#define KNewCar_URL @"http://mrobot.pcauto.com.cn/v2/cms/channels/2"
// ?pageNo=%ld&pageSize=20&v=4.0.0

// http://mrobot.pcauto.com.cn/v2/cms/channels/2?pageNo=%ld&pageSize=20&v=4.0.0

// 测评
#define KIndustr_URL @"http://api.app.yiche.com/webapi/newslist.ashx"
// pageNo=%ld&pageSize=20&v=4.0.0


// 导购
//http://mrobot.pcauto.com.cn/v2/cms/channels/15?pageNo=%ld&pageSize=20&v=4.0.0

#define KDaoGou_URL @"http://mrobot.pcauto.com.cn/v2/cms/channels/15"
// pageNo=%ld&pageSize=20&v=4.0.0"


// 说车
//http://api.app.yiche.com/webapi/newslistzi.ashx?pageindex=1&pagesize=20&productid=17&v=1
#define KSayCar_URL @"http://api.app.yiche.com/webapi/newslistzi.ashx"

/********************车视界************************/



/********************二手车************************/

// 3.——-二手车*（汽车报价大全）—cid、pindex、psize
//http://taoche.app.yiche.com/CarList.ashx?cid=201&pindex=1&psize=20&sign=43fc6265d3d0f8973464c8f5e4624383%20 (北京)

// http://taoche.app.yiche.com/CarList.ashx?cid=501&pindex=1&psize=20&sign=16ccc1a946512873f908236ab302a690 (广州)


#define KErshou_URL @"http://taoche.app.yiche.com/CarList.ashx"

// 3.1汽车详情（）--- 传值ucarid和城市名称
// GET http://taoche.app.yiche.com/CarDetail.ashx?ucarid=8765452&sign=ed20f60accc8f5c42c31a4c769b13a49 （北京）
// http://taoche.app.yiche.com/CarDetail.ashx?ucarid=9221542&sign=47a33752728d538ade43dda05d73dd67 (广州)

#define KCarDetail_URL @"http://taoche.app.yiche.com/CarDetail.ashx"


// 3.精彩视频 —-  汽车报价大全
//http://api.app.yiche.com/webapi/api.ashx?method=bit.videocatlist&catids=1%2C6%2C7&sign=22fdf38331d801f19015e09f5f6a0b83

// 转码后
//#define KVideo_URL @"http://api.app.yiche.com/webapi/api.ashx?method=bit.videocatlist&catids=1,6,7&sign=22fdf38331d801f19015e09f5f6a0b83"

#define KVideo_URL @"http://api.app.yiche.com/webapi/api.ashx?method=bit.videocatlist&catids=1%2C6%2C7&sign=22fdf38331d801f19015e09f5f6a0b83"


// 1.1 视频评论
//http://api.app.yiche.com/webapi/api.ashx?method=bit.videocommentlist&videoid=414644&ishot=1&pageindex=1&pagesize=3&sign=ccf598aa379a3f24d2b98117fcbcb104
#define KVideo_Conment_URL @"http://api.app.yiche.com/webapi/api.ashx?method=bit.videocommentlist&videoid=414644&ishot=1&pageindex=1&pagesize=3&sign=ccf598aa379a3f24d2b98117fcbcb104"


//网易汽车分类Car，参数: cid
#define kURLCategoryCar @"http://product.auto.163.com/mobile/serieslist/2000-1-1-1:00:00/%@_e96a831c41f635bc06af01ee01162ba3.html"


/********************我的************************/

//===== 注册 ---- 3步骤---
//post

//1.注册
//http://123.57.66.127/qctt-api/5.1/index.php/Users/isAvalible
//username=13610142351

#define kRegisterURL @"http://123.57.66.127/qctt-api/5.1/index.php/Users/isAvalible"

//2.验证码
//http://123.57.66.127/qctt-api/5.1/index.php/Smsqctt/sendSmsCode
// verifycode=738569&telephone=13610142351

//3.成功 ；密码123456
//http://123.57.66.127/qctt-api/5.1/index.php/Users/getRegMessage

// passwd=e10adc3949ba59abbe56e057f20f883e&username=13610142351&deviceid=90187CFC8915


#endif /* Address_h */
