//
//  EmotionModel.m
//  CoreEmotionView
//
//  Created by 成林 on 15/4/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "EmotionModel.h"
#import "NSObject+MJKeyValue.h"
#import "NSArray+SubArray.h"
#import "EmotionPageView.h"
#import "EmotionViewConst.h"
#import "NSObject+MJCoding.h"
#import "CoreArchive.h"
#import "NSMutableArray+EmotionExtend.h"






static NSArray *_emotions_recent,*_emotions_recent_subArray,*_emotions_default,*_emotions_default_subArray,*_emotions_emoji,*_emotions_emoji_subArray,*_emotions_lxh,*_emotions_lxh_subArray;

static NSUInteger _pageNum;

static NSString *_path;

static NSArray *_emotionsFromArc;


@implementation EmotionModel
MJCodingImplementation





/*
 *  最近
 */
+(NSArray *)emotions_recent{
    return [self read];
}

+(NSArray *)emotions_recent_subArray{
    
    if(_emotions_recent_subArray==nil){
        
        _emotions_recent_subArray = [[self emotions_recent] subArrayWithLength:[self pageNum]];
    }
    
    return _emotions_recent_subArray;
}



/*
 *  默认
 */
+(NSArray *)emotions_default{
    
    if(_emotions_default==nil){
        _emotions_default=[self arrayWithFolderName:@"default"];
    }
    
    return _emotions_default;
}
+(NSArray *)emotions_default_subArray{
    
    if(_emotions_default_subArray==nil){
        _emotions_default_subArray =[[self emotions_default] subArrayWithLength:[self pageNum]];
    }
    
    return _emotions_default_subArray;
}


/*
 *  Emoji
 */
+(NSArray *)emotions_emoji{
    
    if(_emotions_emoji==nil){
        _emotions_emoji=[self arrayWithFolderName:@"emoji"];
    }
    
    return _emotions_emoji;
}
+(NSArray *)emotions_emoji_subArray{
    
    if(_emotions_emoji_subArray==nil){
        _emotions_emoji_subArray = [[self emotions_emoji] subArrayWithLength:[self pageNum]];
    }
    
    return _emotions_emoji_subArray;
}



/*
 *  浪小花
 */
+(NSArray *)emotions_lxh{
    
    if(_emotions_lxh==nil){
        _emotions_lxh=[self arrayWithFolderName:@"lxh"];
    }
    
    return _emotions_lxh;
}
+(NSArray *)emotions_lxh_subArray{
    
    if(_emotions_lxh_subArray==nil){
        _emotions_lxh_subArray = [[self emotions_lxh] subArrayWithLength:[self pageNum]];
    }
    
    return _emotions_lxh_subArray;
}



+(NSArray *)arrayWithFolderName:(NSString *)folderName{
    
    //获取路径
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@/info",EmotionBundelName,folderName] ofType:@"plist"];
    
    //字典数组
    NSArray *dictA = [[NSArray alloc] initWithContentsOfFile:path];
    
    //模型数组
    NSArray *modelA = [self objectArrayWithKeyValuesArray:dictA];
    
    return modelA;
}




/*
 *  处理过的多维表情数组
 *  EmotionPageView可根据此多维数组创建对应的一组pageView
 */
+(NSArray *)emotionsPageArray{
    
    NSArray *emotionsPageArray = @[
                                   
               //最近，默认为空，暂不处理
               [self emotions_recent_subArray],
           
               //默认
               [self emotions_default_subArray],
               
               //Emoji
               [self emotions_emoji_subArray],
               
               //浪小花
               [self emotions_lxh_subArray],
             ];
    
    return emotionsPageArray;
}



+(NSUInteger)pageNum{
    
    if(_pageNum==0){
        
        _pageNum = [EmotionPageView pageNum];
    }
    
    return _pageNum;
}



/**
 *  计算range
 *
 *  @param type 类型
 *
 *  @return range
 */
+(NSRange)rangeForEmotionWithType:(EmotionModelType)type{
    
    NSRange range = NSMakeRange(0, 0);
    
    if(EmotionModelTypeRecent == type){//最近
        
        range = NSMakeRange(0, 1);
        
    }else if(EmotionModelTypeDefault == type){ //默认
        
        NSRange oldRange = [self rangeForEmotionWithType:EmotionModelTypeRecent];
        
        NSUInteger loc = oldRange.location + oldRange.length;
        
        NSUInteger len = [self emotions_default_subArray].count;
        
        range = NSMakeRange(loc, len);
        
    }else if (EmotionModelTypeEmoji == type){//Emoji
        
        NSRange oldRange = [self rangeForEmotionWithType:EmotionModelTypeDefault];
        
        NSUInteger loc = oldRange.location + oldRange.length;
        
        NSUInteger len = [self emotions_emoji_subArray].count;
        
        range = NSMakeRange(loc, len);
        
    }else{//浪小花
        
        NSRange oldRange = [self rangeForEmotionWithType:EmotionModelTypeEmoji];
        
        NSUInteger loc = oldRange.location + oldRange.length;
        
        NSUInteger len = [self emotions_lxh_subArray].count;
        
        range = NSMakeRange(loc, len);

    }
    
    return range;
}


/**
 *  对应page页码是否处于对应的range中
 *
 *  @param page 页码
 *  @param type 类型
 *
 *  @return 结果
 */
+(BOOL)page:(NSUInteger)page InRange:(EmotionModelType)type{
    
    NSRange range = [self rangeForEmotionWithType:type];
    
    return ((page>=range.location) && (page<range.location+range.length));
}






/*
 *  文件IO操作
 */

/**
 *  保存
 *
 *  @param emotionModel 模型
 *
 *  @return 保存结果
 */
+(void)save:(EmotionModel *)emotionModel{
    
    NSArray *oldEmotions =_emotions_default;
    
    NSMutableArray *emotionsArrayM=[NSMutableArray arrayWithArray:oldEmotions];
    
    //添加最新的表情模型
    NSUInteger maxCount = [self pageNum];
    
    [emotionsArrayM addRecentEmotionObj:emotionModel maxCount:maxCount];
    
    //得到新数组
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:emotionsArrayM maxCount:maxCount];
    
    //更新
    _emotionsFromArc = arrM;
    
    [CoreArchive archiveRootObject:_emotionsFromArc toFile:[self path]];
}


/*
 *  读取
 */
+(NSArray *)read{
    
    return [self emotions];
}



+(NSString *)path{
    
    if(_path==nil){
        
        NSString *cachesPath = [NSString cachesFolder];
        
        //创建caches下面的子文件夹
        NSString *subPath = [cachesPath createSubFolder:@"emotion"];
        
        //得到路径
        _path = [NSString stringWithFormat:@"%@%@",subPath,@"emotion.arc"];
    }
    
    return _path;
}





+(NSArray *)emotions{
    
    if(_emotionsFromArc==nil){
       
        NSArray *emotions = [CoreArchive unarchiveObjectWithFile:[self path]];
        
        if(emotions==nil) emotions =@[];
        
        emotions = [NSMutableArray arrayWithArray:emotions maxCount:[self pageNum]];
        
        _emotionsFromArc = emotions;
    }
    
    return _emotionsFromArc;
}


-(BOOL)isEqual:(EmotionModel *)other{
    
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.png];
}

@end
