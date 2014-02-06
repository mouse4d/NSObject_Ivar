//
//  TableViewDataSource.m
//  objctest
//
//  Created by Leonid Popescu on 06/02/2014.
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

#import "RudimentaryDataSource.h"

@implementation Title

+(instancetype)t:(NSString *)title {
    Title *st = [[self alloc] init];
    st.title = title;
    return st;
}

@end


@implementation ObjectWithTitle

+ (instancetype)t:(NSString *)title o:(id)object {
    ObjectWithTitle *obj = [self t:title];
    obj.object = object;
    return obj;
}

@end

@implementation SelectorWithTitle

+(instancetype)t:(NSString *)title s:(SEL)selector {
    SelectorWithTitle *st = [self t:title];
    st.selector = selector;
    return st;
}

@end



@implementation RudimentaryDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_titles count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"theCellIsHere";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    Title *obj = _titles[indexPath.row];

    cell.textLabel.text = obj.title;

    return cell;
}

@end
