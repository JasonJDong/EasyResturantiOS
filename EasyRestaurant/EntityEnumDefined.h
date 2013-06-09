//
//  EntityEnumDefined.h
//  EasyRestaurant
//
//  Created by JasonDong on 12-11-18.
//  Copyright (c) 2012年 JasonDong. All rights reserved.
//

#ifndef EasyRestaurant_EntityEnumDefined_h
#define EasyRestaurant_EntityEnumDefined_h

typedef enum
{
    AffordStyleAverage, //AA制
    AffordStyleOnlyForMyself, //仅为自己付费
    AffordStyleSomeOnePayForAll, //某人请客
} AffordStyle;

typedef enum
{
    TextDetailViewRemoveStyleNavigateController,
    TextDetailViewRemoveStyleNormalRemove,
}TextDetailViewRemoveStyle;

typedef enum
{
    TeamOperationsJoinTeam,
    TeamOperationsMyTeam,
    TeamOperationsInviteOthers
}TeamOperations;

typedef enum
{
    TeamLifeStatusActived,
    TeamLifeStatusClosed,
}TeamLifeStatus;

typedef enum
{
    TextFieldInputTypeString,
    TextFieldInputTypeNumber
}TextFieldInputType;

typedef enum
{
    CommunicationOperationTypeDelete,
    CommunicationOperationTypeUpdate,
    CommunicationOperationTypeInsert
}CommunicationOperationType;
#endif
