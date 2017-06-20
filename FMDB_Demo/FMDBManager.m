//
//  FMDBManager.m
//  FMDB_Demo
//
//  Created by 田耀琦 on 2017/6/19.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "FMDBManager.h"

#import "FMDatabase.h"

static FMDBManager *manager = nil;

@implementation FMDBManager
{
    FMDatabase *_myDatabase;
}

+ (id)shareInstance {
    /*
    if (manager == nil) {
        manager = [[FMDBManager alloc] init];
    }
    return manager;
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FMDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatDataBase];
    }
    return self;
}

- (void)creatDataBase {
    NSString *docuPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [docuPath stringByAppendingString:@"tableName.sqlite"];
    NSLog(@"path = %@",path);
    _myDatabase = [[FMDatabase alloc] initWithPath:path];
    BOOL ret = [_myDatabase open];
    if (!ret) {
        NSLog(@"数据库打开失败:%@",_myDatabase.lastErrorMessage);
    }
    else {
        //打开成功
        
        //3.创建表格
        //primary key 表示userId是主键,唯一的表示一条记录.
        //autoincrement 表示数据库自己维护主键值的变化.
        //blob是类型,相当于NSData
        NSString *creatsql = @"create table if not exists user (userId integer primary key autoincrement,userName varchar(255),age,integer,headImage blob)";
        BOOL flag = [_myDatabase executeUpdate:creatsql];
        if (!flag) {
            NSLog(@"创建表格失败:%@",_myDatabase.lastErrorMessage);
        }
    }
}

- (void)insertUser:(UserModel *)model {
    NSString *insertSql = @"insert into user (userName,age,headImage) values (?,?,?)";
    NSData *data = UIImagePNGRepresentation(model.image);
    BOOL flag = [_myDatabase executeUpdate:insertSql,model.userName,@(model.age),data];
    if (!flag) {
        NSLog(@"添加用户失败:%@",_myDatabase.lastErrorMessage);
    }
}

- (NSArray *)selectAllUsers {
    NSString *selectSql = @"select * from user";
    FMResultSet *set = [_myDatabase executeQuery:selectSql];
    NSMutableArray *array = [NSMutableArray array];
    while ( [set next]) {
        UserModel *model = [[UserModel alloc] init];
        model.userName = [set stringForColumn:@"userName"];
        model.age = [set intForColumn:@"age"];
        model.image = [UIImage imageWithData:[set dataForColumn:@"headImage"]];
        [array addObject:model];
    }
    return array;
}

- (void)deleteUserWithUserName:(NSString *)userName {
    NSString *deleteSql = @"delete from user where userName=?";
    BOOL flag = [_myDatabase executeUpdate:deleteSql];
    if (!flag) {
        NSLog(@"删除用户失败:%@",_myDatabase.lastErrorMessage);
    }
}

- (void)updateUser:(UserModel *)model userName:(NSString *)userName {
    NSString *updateSql = @"update user set userName=?,age=?,headImage=? Where userName=?";
    BOOL flag = [_myDatabase executeUpdate:updateSql,model.userName,@(model.age), UIImagePNGRepresentation(model.image),userName];
    if (!flag) {
        NSLog(@"修改用户失败:%@",_myDatabase.lastErrorMessage);
    }
    
}







@end
