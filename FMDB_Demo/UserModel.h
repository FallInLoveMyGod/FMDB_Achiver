//
//  UserModel.h
//  FMDB_Demo
//
//  Created by 田耀琦 on 2017/6/19.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject <NSCoding,NSCopying>

@property (nonatomic,strong)UIImage *image;

@property (nonatomic,assign)NSInteger age;

@property (nonatomic,strong)NSString *userName;

@end
