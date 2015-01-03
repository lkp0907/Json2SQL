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
        NSMutableArray *jsonData = [NSJSONSerialization JSONObjectWithData:binaryData options:NSJSONReadingMutableContainers error:&error];
        
        
        // 2. 키값을 통한 테이블 생성 SQL 문 작성
        NSString *tableName = @"exercises";
        NSMutableString *createTableSQL = @"CREATE TABLE ".mutableCopy;
        [createTableSQL appendFormat:@"%@ (",tableName];
        
        [[jsonData objectAtIndex:0]enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if([[obj className]containsString:@"Dictionary"]||[[obj className]containsString:@"Dictionary"]){
                
            }else{
                [createTableSQL appendFormat:@"%@ %@,",key,[JsonToSQLEngine returnStringByType:obj]];
            }

        }];

        [createTableSQL replaceCharactersInRange:NSMakeRange(createTableSQL.length-1, 1) withString:@""];
        [createTableSQL appendString:@");"];
        
        NSLog(@"%@",createTableSQL);
        
        

        // 3. 키-벨류 통한 데이터 삽입 SQL 문 작성
        NSMutableString *insertAllSQL = @"".mutableCopy;
        for (NSDictionary *dic in jsonData) {
            NSMutableString *insertDataSQL = @"INSERT INTO ".mutableCopy;
            [insertDataSQL appendFormat:@"%@ (",tableName];
            NSMutableString *columnString = @"".mutableCopy;
            NSMutableString *valueString = @"".mutableCopy;
            [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                if([[obj className]containsString:@"Dictionary"]||[[obj className]containsString:@"Dictionary"]){
                    
                }else{
                    [columnString appendFormat:@"%@,",key];
                    [valueString appendFormat:@"\"%@\",",obj];
                }
            }];
            [columnString replaceCharactersInRange:NSMakeRange(columnString.length-1, 1) withString:@""];
            [valueString replaceCharactersInRange:NSMakeRange(valueString.length-1, 1) withString:@""];
            [insertDataSQL appendFormat:@"%@) VALUES(%@);",columnString,valueString];
            [insertAllSQL appendString:insertDataSQL];
        }
        
        NSLog(@"%@",insertAllSQL);

        NSString *allString = [NSString stringWithFormat:@"%@\n%@",createTableSQL,insertAllSQL];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
        
        NSError *fileError;
        BOOL succeed = [allString writeToFile:[documentsDirectory stringByAppendingPathComponent:@"sql.txt"]
                                  atomically:YES encoding:NSUTF8StringEncoding error:&fileError];
        if (!succeed){
            // Handle error here

        }else{
            NSLog(@"Success !");
            NSLog(@"%@",[documentsDirectory stringByAppendingPathComponent:@"sql.txt"]);
            // it will be saved in ~/Documents/sql.txt
        }
    }
    return 0;
}