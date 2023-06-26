//===-- Cpu0MCTargetDesc.h - CPU0 Target Descriptions -----------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file provides CPU0 specific target descriptions.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_CPU0_MCTARGETDESC_CPU0MCTARGETDESC_H
#define LLVM_LIB_TARGET_CPU0_MCTARGETDESC_CPU0MCTARGETDESC_H

#include "llvm/Support/DataTypes.h"

#include <memory>

namespace llvm {
class MCAsmBackend;
class MCCodeEmitter;
class MCContext;
class MCInstrInfo;
class MCObjectTargetWriter;
class MCRegisterInfo;
class MCSubtargetInfo;
class MCTargetOptions;
class StringRef;
class Target;
class Triple;
class raw_ostream;
class raw_pwrite_stream;

// MCCodeEmitter *createCpu0MCCodeEmitterEB(const MCInstrInfo &MCII,
//                                          const MCRegisterInfo &MRI,
//                                          MCContext &Ctx);
// MCCodeEmitter *createCpu0MCCodeEmitterEL(const MCInstrInfo &MCII,
//                                          const MCRegisterInfo &MRI,
//                                          MCContext &Ctx);

// MCAsmBackend *createCpu0AsmBackend(const Target &T,
//                                    const MCSubtargetInfo &STI,
//                                    const MCRegisterInfo &MRI,
//                                    const MCTargetOptions &Options);

// std::unique_ptr<MCObjectTargetWriter> createCpu0ELFObjectWriter(const Triple
// &TT);

} // namespace llvm

// Define Cpu0 register info by include the tblgen'erated inc
#define GET_REGINFO_ENUM
#include "Cpu0GenRegisterInfo.inc"

// Define Cpu0 Instrs info by include the tblgen'erated inc
#define GET_INSTRINFO_ENUM
#include "Cpu0GenInstrInfo.inc"

// Define Cpu0 subtarget info by include the tblgen'erated inc
#define GET_SUBTARGETINFO_ENUM
#include "Cpu0GenSubtargetInfo.inc"

#endif // LLVM_LIB_TARGET_CPU0_MCTARGETDESC_CPU0MCTARGETDESC_H
