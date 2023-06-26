//===-- Cpu0TargetMachine.h - Define TargetMachine for Cpu0 -----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the Cpu0 specific subclass of TargetMachine.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_CPU0_CPU0PASSCONFIG_H
#define LLVM_LIB_TARGET_CPU0_CPU0PASSCONFIG_H

#include "llvm/CodeGen/TargetPassConfig.h"

namespace llvm {

class Cpu0TargetMachine;
class Cpu0Subtarget;

//@Cpu0PassConfig {
/// Cpu0 Code Generator Pass Configuration Options.
class Cpu0PassConfig : public TargetPassConfig {
public:
  Cpu0PassConfig(Cpu0TargetMachine &TM, PassManagerBase &PM);

  Cpu0TargetMachine &getCpu0TargetMachine() const;
  const Cpu0Subtarget &getCpu0Subtarget() const;

  // void addIRPasses() override;
  // bool addInstSelector() override;
  // void addPreEmitPass() override;

#ifdef ENABLE_GPRESTORE
  void addPreRegAlloc() override;
#endif
};

} // namespace llvm
#endif // LLVM_LIB_TARGET_CPU0_CPU0PASSCONFIG_H
