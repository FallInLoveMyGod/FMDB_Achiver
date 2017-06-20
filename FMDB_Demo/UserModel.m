//
//  UserModel.m
//  FMDB_Demo
//
//  Created by 田耀琦 on 2017/6/19.
//  Copyright © 2017年 田耀琦. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _userName = [aDecoder decodeObjectForKey:@"userName"];
        _age = [aDecoder decodeIntegerForKey:@"age"];
        NSData *iamgeData = [aDecoder decodeObjectForKey:@"image"];
        _image = [UIImage imageWithData:iamgeData];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeInteger:self.age forKey:@"age"];
    NSData *imageData = UIImagePNGRepresentation(self.image);
    [aCoder encodeObject:imageData forKey:@"image"];
}

- (id)copyWithZone:(NSZone *)zone {
    UserModel *model = [[[self class] allocWithZone:zone] init];
    model.userName = [self.userName copyWithZone:zone];
    model.age = self.age;
    model.image = self.image;
    return model;
}


@end
