//
//  ViewController.m
//  objctest
//
//  Created by Leonid Popescu on 31/01/2014.
//  Copyright (c) 2014 becauseTuesday. All rights reserved.
//
/*
	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "ViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "NSObject+IvarPrint.h"

#import "ObjectWithStructs.h"
#import "ObjectWithPointers.h"
#import "ObjectWithArrays.h"
#import "ObjectWithPrimitiveValues.h"

#import "RudimentaryDataSource.h"


@interface ObjectWithCString : NSObject
@end

@implementation ObjectWithCString {

    char * cString;
}

- (id)init
{
    self = [super init];
    if (self) {

        cString = "this is a new \n thing";
    }
    return self;
}
@end





@interface ViewController () {}
@end



@implementation ViewController {

    RudimentaryDataSource *_objectsDataSource;
    RudimentaryDataSource *_selectorsDataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    _objectsDataSource = [[RudimentaryDataSource alloc] init];
    _objectsDataSource.titles = @[[ObjectWithTitle t:@"object with structs"  o:[ObjectWithStructs obj]],
                                 [ObjectWithTitle t:@"object with pointers" o:[ObjectWithPointers obj]],
                                 [ObjectWithTitle t:@"object with arrays"   o:[ObjectWithArrays obj]],
                                  [ObjectWithTitle t:@"object with arrays"   o:[ObjectWithPrimitiveValues obj]]];

    _objectsTableView.dataSource = _objectsDataSource;

    NSIndexPath *idx = [NSIndexPath indexPathForRow:0 inSection:0];

    [_objectsTableView selectRowAtIndexPath:idx animated:NO scrollPosition:UITableViewScrollPositionTop];

    
    _selectorsDataSource = [[RudimentaryDataSource alloc] init];
    _selectorsDataSource.titles = @[[SelectorWithTitle t:@"ivar descriptions" s:@selector(ivarDescriptions)],
                                    [SelectorWithTitle t:@"ivar names" s:@selector(ivarNames)],
                                    [SelectorWithTitle t:@"ivar names and types" s:@selector(ivarNamesAndTypes)]];
    _commandsTableView.dataSource = _selectorsDataSource;
}


#pragma tableView delegate protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == _commandsTableView) {

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        ObjectWithTitle *objWithTitle = _objectsDataSource.titles[_objectsTableView.indexPathForSelectedRow.row];
        id obj = objWithTitle.object;

        SelectorWithTitle *selWithTitle = _selectorsDataSource.titles[indexPath.row];
        SEL selector = selWithTitle.selector;

        id result = objc_msgSend(obj, selector);

        NSLog(@"%@", result);
    }
}


@end
