
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

clang -target mips-unknown-linux-gnu -c ch3.cpp -emit-llvm -o ch3.bc

xllvm-dis ch3.bc -o ch3.ll

xllc -march=cpu0 -mcpu=help

xllc --debug -march=cpu0 -relocation-model=pic -filetype=asm ch3.bc -o ch3.cpu0.s

xllc --debug -march=cpu0 -relocation-model=pic -filetype=obj ch3.bc -o ch3.cpu0.o
