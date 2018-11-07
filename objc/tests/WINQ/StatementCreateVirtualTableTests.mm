/*
 * Tencent is pleased to support the open source community by making
 * WCDB available.
 *
 * Copyright (C) 2017 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use
 * this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 *       https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "WINQTestCase.h"

@interface StatementCreateVirtualTableTests : WINQTestCase

@end

@implementation StatementCreateVirtualTableTests {
    WCDB::Schema schema;
    NSString* table;
    NSString* module;
    WCDB::ModuleArgument moduleArgument1;
    WCDB::ModuleArgument moduleArgument2;
    WCDB::ModuleArguments moduleArguments;
}

- (void)setUp
{
    [super setUp];
    schema = @"testSchema";
    table = @"testTable";
    module = @"testModule";
    moduleArgument1 = WCDB::ModuleArgument(1, 1);
    moduleArgument2 = WCDB::ModuleArgument(2, 2);
    moduleArguments = {
        moduleArgument1,
        moduleArgument2,
    };
}

- (void)test_default_constructible
{
    WCDB::StatementCreateVirtualTable constructible __attribute((unused));
}

- (void)test_get_type
{
    XCTAssertEqual(WCDB::StatementCreateVirtualTable().getType(), WCDB::SQL::Type::CreateVirtualTableSTMT);
    XCTAssertEqual(WCDB::StatementCreateVirtualTable::type, WCDB::SQL::Type::CreateVirtualTableSTMT);
}

- (void)test_create_virtual_table
{
    auto testingSQL = WCDB::StatementCreateVirtualTable().createVirtualTable(table).schema(schema).usingModule(module).argument(moduleArgument1);

    auto testingTypes = { WCDB::SQL::Type::CreateVirtualTableSTMT, WCDB::SQL::Type::Schema, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"CREATE VIRTUAL TABLE testSchema.testTable USING testModule(1 = 1)");
}

- (void)test_create_virtual_table_if_not_exists
{
    auto testingSQL = WCDB::StatementCreateVirtualTable().createVirtualTable(table).schema(schema).ifNotExists().usingModule(module).argument(moduleArgument1);

    auto testingTypes = { WCDB::SQL::Type::CreateVirtualTableSTMT, WCDB::SQL::Type::Schema, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"CREATE VIRTUAL TABLE IF NOT EXISTS testSchema.testTable USING testModule(1 = 1)");
}

- (void)test_create_virtual_table_without_schema
{
    auto testingSQL = WCDB::StatementCreateVirtualTable().createVirtualTable(table).usingModule(module).argument(moduleArgument1);

    auto testingTypes = { WCDB::SQL::Type::CreateVirtualTableSTMT, WCDB::SQL::Type::Schema, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"CREATE VIRTUAL TABLE main.testTable USING testModule(1 = 1)");
}

- (void)test_create_virtual_table_with_arguments
{
    auto testingSQL = WCDB::StatementCreateVirtualTable().createVirtualTable(table).schema(schema).usingModule(module).arguments(moduleArguments);

    auto testingTypes = { WCDB::SQL::Type::CreateVirtualTableSTMT, WCDB::SQL::Type::Schema, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"CREATE VIRTUAL TABLE testSchema.testTable USING testModule(1 = 1, 2 = 2)");
}

- (void)test_create_virtual_table_with_seperated_arguments
{
    auto testingSQL = WCDB::StatementCreateVirtualTable().createVirtualTable(table).schema(schema).usingModule(module).argument(moduleArgument1).argument(moduleArgument2);

    auto testingTypes = { WCDB::SQL::Type::CreateVirtualTableSTMT, WCDB::SQL::Type::Schema, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::ModuleArgument, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue, WCDB::SQL::Type::Expression, WCDB::SQL::Type::LiteralValue };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"CREATE VIRTUAL TABLE testSchema.testTable USING testModule(1 = 1, 2 = 2)");
}

- (void)test_create_virtual_table_without_argument
{
    auto testingSQL = WCDB::StatementCreateVirtualTable().createVirtualTable(table).schema(schema).usingModule(module);

    auto testingTypes = { WCDB::SQL::Type::CreateVirtualTableSTMT, WCDB::SQL::Type::Schema };
    IterateAssertEqual(testingSQL, testingTypes);
    WINQAssertEqual(testingSQL, @"CREATE VIRTUAL TABLE testSchema.testTable USING testModule");
}

@end
