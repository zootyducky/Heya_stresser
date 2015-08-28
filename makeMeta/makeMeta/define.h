//
//  define.h
//  makeMeta
//
//  Created by Ducky on 2015. 8. 23..
//  Copyright (c) 2015년 DuckyCho. All rights reserved.
//

#define YOutputFileName @"HeyaData"
#define SavePath @"/Users/choducky/Desktop"
#define SaveSeparateFile NO
#define ThreadWeigthIncrement YES

#define YTotalThread 100
#define YTotalUser 400
#define YMaxMembersPerThread 160
#define YMessagesPerThread 30

typedef enum {
    bMessageTypeText,
    bMessageTypeLocation,
    bMessageTypeImage,
    bMessageTypeSystemNotification, //leave, public, private
    bMessageTypeInvalid,
    bMessageTypeEnterSystemNotification,//enter
    bMessageTypeCount
} bMessageType;


#define YName @"조영대"
#define YJoinThreadCount 100

//Root Properties
#define RP_Messages @"messages"
#define RP_ThreadMeta @"threadMeta"
#define RP_Threads @"threads"
#define RP_Users @"users"


//ThreadMeta Properties
#define MP_RThreadEntityID @"RThreadEntityID"
#define MP_CreationDate @"creationDate"
#define MP_MemberCount @"memberCount"
#define MP_Name @"name"
#define MP_ShapeColorDict @"shapeColorDict"
#define MP_ShapeTypeDict @"shapeTypeDict"
#define MP_Type @"type"
#define MP_Weight @"weight"


//Thread Properties
#define TP_Announcement @"announcement"
#define TP_Deleted @"deleted"
#define TP_EntityID @"entityID"
#define TP_GeoFire @"geoFire"
#define TP_Master @"master"
#define TP_Members @"members"
#define TP_NotiList @"notiList"


//User Properties
#define UP_AuthenticationID @"authentication-id"
#define UP_Introduction @"introduction"
#define UP_JoinThreads @"join-threads"
#define UP_Name @"name"
#define UP_Noti @"noti"
#define UP_Online @"online"
#define UP_ProfileImage0 @"profileImage0"
#define UP_ProfileImage1 @"profileImage1"
#define UP_ProfileImage2 @"profileImage2"
#define UP_ProfileImage3 @"profileImage3"
#define UP_ProfileImage4 @"profileImage4"
#define UP_ProfileThumbnail0 @"profileThumbnail0"
#define UP_ProfileThumbnail1 @"profileThumbnail1"
#define UP_ProfileThumbnail2 @"profileThumbnail2"
#define UP_ProfileThumbnail3 @"profileThumbnail3"
#define UP_ProfileThumbnail4 @"profileThumbnail4"
#define UP_ShapeColor @"shapeColor"
#define UP_ShapeType @"shapeType"

//Message Properties
#define MSP_Date @"date"
#define MSP_EntityID @"entityID"
#define MSP_Payload @"payload"
#define MSP_Type @"type"
#define MSP_ThreadFirebaseID @"thread-firebase-id"
#define MSP_UserFirebaseID @"user-firebase-id"




