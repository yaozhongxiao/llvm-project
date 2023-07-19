#!/usr/bin/env bash
#
# Copyright 2023 WorkGroup Participants. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
BUILD_ROOT_DIR=`pwd`

clang -target mips-unknown-linux-gnu -c ch4.cpp -emit-llvm -o ch4.bc
xllvm-dis ch4.bc -o ch4.ll

# dag-gen -v --view-dag-combine1-dags -march cpu0 -filetype asm ch4.bc
dag-gen -march cpu0 -filetype asm ch4.bc
