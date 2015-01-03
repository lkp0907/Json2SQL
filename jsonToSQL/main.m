//
//  main.m
//  jsonToSQL
//
//  Created by GiPyeong Lee on 2015. 1. 3..
//  Copyright (c) 2015년 com.devsfolder.jsonToSQL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonToSQLEngine.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        // Only MySQL NOW

        // 1. json 데이터 로드 객체화
        NSData *binaryData = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] bundlePath]stringByAppendingPathComponent:@"testAPI.json"]];
        
        NSError *error;
        NSMutableArray *data = [NSJSONSerialization JSONObjectWithData:binaryData options:NSJSONReadingMutableContainers error:&error];
        
        
        // 2. 키값을 통한 테이블 생성 SQL 문 작성
        NSString *tableName = @"exercises";
        NSMutableString *createTableSQL = @"CREATE TABLE ".mutableCopy;
        [createTableSQL appendFormat:@"%@ (",tableName];
        
        [[data objectAtIndex:0]enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [createTableSQL appendFormat:@"%@ %@,",key,[JsonToSQLEngine returnStringByType:obj]];
        }];

        [createTableSQL replaceCharactersInRange:NSMakeRange(createTableSQL.length-1, 1) withString:@""];
        [createTableSQL appendString:@");"];
        
        NSLog(@"%@",createTableSQL);
        
        // 3. 키-벨류 통한 데이터 삽입 SQL 문 작성
        
        

    }
    return 0;
}