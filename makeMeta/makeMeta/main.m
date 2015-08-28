//
//  main.m
//  makeMeta
//
//  Created by Ducky on 2015. 8. 19..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "define.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableDictionary * threadMetaRealation = [[NSMutableDictionary alloc] init];
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSMutableDictionary * threads = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * threadMeta  = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * users  = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * messages  = [[NSMutableDictionary alloc] init];
        
        for(int i = 0 ;i < YTotalThread ; i++){
            
            //thread
            NSString * threadEntityID = [[NSUUID UUID] UUIDString];

            NSString * announcement = @"";
            NSNumber * deleted = @(NO);
            NSString * entityID = [threadEntityID copy];
            NSString * geoFire = @"";
            NSString * master = @"";
            NSMutableDictionary * members = [[NSMutableDictionary alloc] init];
            NSMutableDictionary * notiList = [[NSMutableDictionary alloc] init];
            
            [threads setObject:@{
                                 TP_Announcement:announcement,
                                 TP_Deleted:deleted,
                                 TP_EntityID:entityID,
                                 TP_GeoFire:geoFire,
                                 TP_Master:master,
                                 TP_Members:members,
                                 TP_NotiList:notiList
                                 } forKey:threadEntityID];

            
            
            //meta
            NSString * metaEntityID = [[NSUUID UUID] UUIDString];
//            NSString * metaEntityID = [NSString stringWithFormat:@"a%d",i];
            NSString * RthreadEntityID = [threadEntityID copy];

            NSNumber * creationDate = @(1440063940690);
            NSNumber * memberCount = @(arc4random() % YMaxMembersPerThread);
            NSMutableDictionary * shapeColorDict = [[NSMutableDictionary alloc] init];
            NSMutableDictionary * shapeTypeDict = [[NSMutableDictionary alloc] init];
            NSNumber * type = @(1);
            NSNumber * weight;
            if(ThreadWeigthIncrement == YES)
                weight = @(i);
            else
                weight = @(0);

            NSString * metaName = [NSString stringWithFormat:@"%.3d / %@",i,threadEntityID];
            
            [threadMeta setObject:@{
                                    MP_RThreadEntityID:RthreadEntityID,
                                    MP_CreationDate:creationDate,
                                    MP_MemberCount:memberCount,
                                    MP_Name:metaName,
                                    MP_ShapeColorDict:shapeColorDict,
                                    MP_ShapeTypeDict:shapeTypeDict,
                                    MP_Type:type,
                                    MP_Weight:weight
                                    } forKey:metaEntityID];
            
            [threadMetaRealation setObject:metaEntityID forKey:threadEntityID];
        }
        NSLog(@"Done -  thread and meta");
        
        
        
        for(int i = 0 ; i < YTotalUser ; i++){
            
            NSString * userID = [[NSUUID UUID] UUIDString];
            
            NSString * authenticationID = [userID copy];
            NSString * introduction = [NSString stringWithFormat:@"Hello, Test User %d",i];
            NSMutableDictionary * joinThreads = [[NSMutableDictionary alloc] init];
            NSString * name;
            if(i != 0)
                name = [userID copy];
            else
                name = YName;
            NSNumber * noti = @(YES);
            NSNumber * online = @(YES);
            NSString * profile = [NSString stringWithFormat:@"http://lorempixel.com/640/480/animals/%@",userID];
            NSString * thumbnail = [NSString stringWithFormat:@"http://lorempixel.com/320/240/animals/%@",userID];
            NSNumber * shapeColor = @(arc4random() % 6);
            NSNumber * shapeType = @(arc4random() % 6);
            [users setObject:@{
                               UP_AuthenticationID:authenticationID,
                               UP_Introduction:introduction,
                               UP_JoinThreads:joinThreads,
                               UP_Name:name,
                               UP_Noti:noti,
                               UP_Online:online,
                               UP_ProfileImage0:profile,
                               UP_ProfileImage1:@"",
                               UP_ProfileImage2:@"",
                               UP_ProfileImage3:@"",
                               UP_ProfileImage4:@"",
                               UP_ProfileThumbnail0:thumbnail,
                               UP_ProfileThumbnail1:@"",
                               UP_ProfileThumbnail2:@"",
                               UP_ProfileThumbnail3:@"",
                               UP_ProfileThumbnail4:@"",
                               UP_ShapeColor:shapeColor,
                               UP_ShapeType:shapeType
                               } forKey:userID];
        
        }
        
        NSLog(@"Done -  user");
        
        
        NSArray * threadKeys = [threads allKeys];
        for(NSString * threadKey in threadKeys){
            NSMutableDictionary * threadDict = [threads objectForKey:threadKey];
            NSString * threadID = [threadDict objectForKey:TP_EntityID];
            NSMutableDictionary * members = [threadDict objectForKey:TP_Members];
            NSMutableDictionary * notiList = [threadDict objectForKey:TP_NotiList];

            
            NSInteger userCount = [users count];
            NSArray * userIDs = [users allKeys];

            NSString * metaID_ = [threadMetaRealation objectForKey:threadID];
            NSMutableDictionary * meta_ = [threadMeta objectForKey:metaID_];
            NSNumber * membersInThreadNumber = [meta_ objectForKey:MP_MemberCount];
            NSInteger membersInThread = membersInThreadNumber.integerValue;
            
            for(int i = 0 ;i < membersInThread ; i++){

                NSInteger idx = arc4random()%userCount;
                NSString * selectedUser = userIDs[idx];
                if( i == 0){
                    threadDict = [NSMutableDictionary dictionaryWithDictionary:threadDict];
                    [threadDict setObject:selectedUser forKey:TP_Master];
                }
                //SetRealationship in thread
                [members setObject:@(YES) forKey:selectedUser];
                [notiList setObject:@(YES) forKey:selectedUser];
                
                //Set realationship in user
                NSMutableDictionary * userInfo = [users objectForKey:selectedUser];
                NSMutableDictionary * joinThread = [userInfo objectForKey:UP_JoinThreads];
                [joinThread setObject:@{@"lastReadDate":@""} forKey:threadID];
                
                
                //Add shape info to threadMeta
                NSString * metaID = [threadMetaRealation objectForKey:threadID];
                NSMutableDictionary * meta = [threadMeta objectForKey:metaID];
                NSMutableDictionary * color = [meta objectForKey:MP_ShapeColorDict];
                NSMutableDictionary * type = [meta objectForKey:MP_ShapeTypeDict];
                [color setObject:[userInfo objectForKey:UP_ShapeColor] forKey:selectedUser];
                [type setObject:[userInfo objectForKey:UP_ShapeType] forKey:selectedUser];
            }
        
        }
        NSLog(@"Done - 메타, 스레드, 유저 관계");
        
        NSArray * threadKeys_ = [threads allKeys];
        NSArray * userKeys = [users allKeys];
        
        for(NSString * threadKey in threadKeys_){
            
            NSMutableDictionary * allMessages = [[NSMutableDictionary alloc] init];
            for(int i = 0 ;i < YMessagesPerThread ;i++){
                NSString * messageID = [[NSUUID UUID] UUIDString];
                NSString * entityID = [messageID copy];
                NSNumber * date = @(1440065029175-i);
                NSString * userID = userKeys[(arc4random()%userKeys.count)];
                
                NSString * payload;
                NSNumber * type = @(arc4random()%bMessageTypeCount);
                
                if(type.intValue == bMessageTypeInvalid){
                    type = @(bMessageTypeText);
                }
                
                if(type.intValue == bMessageTypeText){
                    payload = [[NSUUID UUID] UUIDString];
                }
                else if(type.intValue == bMessageTypeLocation){
                    payload = @"37.506159,127.063833";
                }
                else if(type.intValue == bMessageTypeImage){
                    payload = [NSString stringWithFormat:@"http://lorempixel.com/900/600/food/%@,http://lorempixel.com/300/200/food/%@,W900&H600",messageID,messageID];
                }
                else if(type.intValue == bMessageTypeSystemNotification){
                    payload = [NSString stringWithFormat:@"%@,SYSTEM_MESSAGE_LEAVE",userID];
                }
                else if(type.intValue == bMessageTypeEnterSystemNotification){
                    payload = [NSString stringWithFormat:@"%@,SYSTEM_MESSAGE_ENTER",userID];
                }
                else{
                    type = @(bMessageTypeText);
                    payload = [[NSUUID UUID] UUIDString];
                }
                
                [allMessages setObject:@{
                                         MSP_Date:date,
                                         MSP_EntityID:entityID,
                                         MSP_Payload:payload,
                                         MSP_ThreadFirebaseID:threadKey,
                                         MSP_Type:type,
                                         MSP_UserFirebaseID:userID
                                         } forKey:messageID];
            }
            [messages setObject:allMessages forKey:threadKey];
        }
        NSLog(@"Done - 메세지");
        
        NSDate * saveDate = [NSDate date];
        
        
        if(SaveSeparateFile == NO){
            NSDictionary * finalData = @{
                                     RP_Messages:messages,
                                     RP_ThreadMeta:threadMeta,
                                     RP_Threads:threads,
                                     RP_Users:users
                                     };
        
        
        
            NSError * err;
            NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:finalData options:0 error:&err];
            NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [myString writeToFile:[NSString stringWithFormat:@"%@/%@_%@.json",SavePath,YOutputFileName,saveDate] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"done");
        }
        else{
            NSError * err;
            NSData * jsonData;
            NSString * myString;
            
            //save message
            jsonData = [NSJSONSerialization  dataWithJSONObject:messages options:0 error:&err];
            myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [myString writeToFile:[NSString stringWithFormat:@"%@/%@_%@_%@.json",SavePath,YOutputFileName,RP_Messages,saveDate] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            
                        NSLog(@"SaveMessages - done");
            
            //save threadMeta
            jsonData = [NSJSONSerialization  dataWithJSONObject:threadMeta options:0 error:&err];
            myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [myString writeToFile:[NSString stringWithFormat:@"%@/%@_%@_%@.json",SavePath,YOutputFileName,RP_ThreadMeta,saveDate] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            
                                    NSLog(@"SaveThreadMeta - done");
            
            //save thread
            jsonData = [NSJSONSerialization  dataWithJSONObject:threads options:0 error:&err];
            myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [myString writeToFile:[NSString stringWithFormat:@"%@/%@_%@_%@.json",SavePath,YOutputFileName,RP_Threads,saveDate] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            
                                                NSLog(@"SaveThreads - done");
            
            //save users
            jsonData = [NSJSONSerialization  dataWithJSONObject:users options:0 error:&err];
            myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [myString writeToFile:[NSString stringWithFormat:@"%@/%@_%@_%@.json",SavePath,YOutputFileName,RP_Users,saveDate] atomically:NO encoding:NSUTF8StringEncoding error:nil];
            
                                                NSLog(@"SaveUsers - done");
            
                                                NSLog(@"SaveAll - done");

            
        }
        
        
        
//
//        
//       setInterval(function(){
//        location.reload()
//    },170000);
//
//        
//        
//        NSMutableDictionary * meta = [[NSMutableDictionary alloc] init];
//        for(int  i = 0 ; i < 10000 ;i++){
//            NSString * key = [[NSUUID UUID] UUIDString];
//            NSString * name = [[NSUUID UUID] UUIDString];
//            NSNumber * members = [NSNumber numberWithInteger:arc4random()%100];
//            NSMutableDictionary * type = [[NSMutableDictionary alloc] init];
//            NSMutableDictionary * color  = [[NSMutableDictionary alloc] init];
//            for(int i = 0 ;i < members.intValue ;i++){
//                [type setObject:@(arc4random()%6) forKey:[[NSUUID UUID] UUIDString]];
//                [color setObject:@(arc4random()%6) forKey:[[NSUUID UUID] UUIDString]];
//            }
//            
//            NSDictionary * detail =  @{
//                                              @"RThreadEntityID":key,
//                                              @"creationDate": @1439976285130,
//                                              @"memberCount": members,
//                                              @"name": name,
//                                              @"shapeColorDict": color,
//                                              @"shapeTypeDict": type,
//                                              @"type": @1,
//                                              @"weight": @0
//                                        };
//            
//            [meta setObject:detail forKey:key];
//        }
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:meta options:0 error:&err];
//        NSString * myString = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
//        [myString writeToFile:@"%@/meta.json" atomically:NO encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"done");
//        
//    }
    }
    return 0;
}
