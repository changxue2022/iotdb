@REM
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements.  See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership.  The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License.  You may obtain a copy of the License at
@REM
@REM     http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied.  See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM

@echo off

pushd %~dp0..\..
if NOT DEFINED IOTDB_HOME set IOTDB_HOME=%cd%
popd

IF EXIST "%IOTDB_HOME%\conf\iotdb-system.properties" (
  set config_file="%IOTDB_HOME%\conf\iotdb-system.properties"
) ELSE (
  IF EXIST "%IOTDB_HOME%\conf\iotdb-datanode.properties" (
    set config_file=%IOTDB_HOME%\conf\iotdb-datanode.properties
  ) ELSE (
    echo No configuration file found. Exiting.
    exit /b 1
  )
)

if not defined config_file (
  echo No configuration file found. Exiting.
  exit /b 1
)

for /f  "eol=# tokens=2 delims==" %%i in ('findstr /i "^dn_rpc_port"
"%config_file%"') do (
  set dn_rpc_port=%%i
)
@REM trim the port
:delLeft1
if "%dn_rpc_port:~0,1%"==" " (
    set "dn_rpc_port=%dn_rpc_port:~1%"
    goto delLeft1
)
:delRight1
if "%dn_rpc_port:~-1%"==" " (
    set "dn_rpc_port=%dn_rpc_port:~0,-1%"
    goto delRight1
)

if not defined dn_rpc_port (
  echo "WARNING: dn_rpc_port not found in the configuration file. Using default value dn_rpc_port = 6667"
  set dn_rpc_port=6667
)

echo Check whether the rpc_port is used..., port is %dn_rpc_port%

for /f "tokens=5" %%a in ('netstat /ano ^| findstr :%dn_rpc_port% ') do (
  taskkill /f /pid %%a
  echo Close DataNode, PID: %%a
)
rem ps ax | grep -i 'iotdb.DataNode' | grep -v grep | awk '{print $1}' | xargs kill -SIGTERM
