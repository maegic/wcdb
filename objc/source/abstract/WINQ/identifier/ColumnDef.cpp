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

#include <WCDB/WINQ.h>

namespace WCDB {

ColumnDef::ColumnDef(const Column& column)
{
    syntax().column = column;
}

ColumnDef::ColumnDef(const Column& column, const ColumnType& type)
{
    syntax().column = column;
    syntax().typed = true;
    syntax().columnType = type;
}

ColumnDef& ColumnDef::constraint(const ColumnConstraint& constraint)
{
    syntax().constraints.push_back(constraint);
    return *this;
}

} // namespace WCDB
