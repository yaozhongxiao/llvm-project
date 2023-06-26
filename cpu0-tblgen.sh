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

# llvm-builder --force --target Cpu0 ${SCRIPT_DIR}
cd ${SCRIPT_DIR}/llvm-build
ninja  -j2 lib/Target/Cpu0/Cpu0CommonTableGen