/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package org.apache.iotdb.commons.schema.table;

public enum TableType {
  BASE_TABLE("BASE TABLE"),
  TREE_TO_TABLE_VIEW("TREE_TO_TABLE VIEW"),
  VIEW("VIEW"),
  SYSTEM_VIEW("SYSTEM VIEW"),
  ;

  private final String name;

  TableType(final String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }
}
