//
//  JsonToSQLEngine.m
//  jsonToSQL
//
//  Created by GiPyeong Lee on 2015. 1. 3..
//  Copyright (c) 2015년 com.devsfolder.jsonToSQL. All rights reserved.
//

#import "JsonToSQLEngine.h"

@implementation JsonToSQLEngine
+ (NSString *)returnStringByType:(id)type{
    if([[type className]containsString:@"String"]){
        if([type length]>255){
            return @"text";
        }else{
            return @"varchar(255)";
        }
    }else{
        if(sizeof(type)>255){
            return @"text";
        }else{
            return @"varchar(255)";
        }
    }
    // Numberic Process Need more thinking
    
//    else if([[type className]containsString:@"Number"]){
//        NSLog(@"%s",@encode(short));
//        if((strcmp([type objCType], @encode(int))) == 0) {
//            return @"int";
//        } else if((strcmp([type objCType], @encode(float))) == 0) {
//            return @"float";
//        }
//        else{
//            return [NSString stringWithUTF8String:[type objCType]];
//        }
//    }else {
//        return @"none";
//    }
}
@end
