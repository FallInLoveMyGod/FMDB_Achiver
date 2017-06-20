//
//  FMDBManager.h
//  FMDB_Demo
//
//  Created by 田耀琦 on 2017/6/19.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <FMDB/FMDB.h>
#import "UserModel.h"

@interface FMDBManager : NSObject

+ (id)shareInstance;

- (void)insertUser:(UserModel *)model;

- (NSArray *)selectAllUsers;

- (void)deleteUserWithUserName:(NSString *)userName;

- (void)updateUser:(UserModel *)model userName:(NSString *)userName;

@end
