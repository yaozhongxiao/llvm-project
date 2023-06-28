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

#include "Cpu0PassConfig.h"

#include "Cpu0SEISelDAGToDAG.h"
#include "Cpu0Subtarget.h"
#include "Cpu0TargetMachine.h"
#include "Cpu0TargetObjectFile.h"

using namespace llvm;

Cpu0PassConfig::Cpu0PassConfig(Cpu0TargetMachine &TM, PassManagerBase &PM)
    : TargetPassConfig(TM, PM) {}

Cpu0TargetMachine &Cpu0PassConfig::getCpu0TargetMachine() const {
  return getTM<Cpu0TargetMachine>();
}

const Cpu0Subtarget &Cpu0PassConfig::getCpu0Subtarget() const {
  return *getCpu0TargetMachine().getSubtargetImpl();
}

// void Cpu0PassConfig::addIRPasses() {
//   TargetPassConfig::addIRPasses();
//   addPass(createAtomicExpandPass());
// }

// Install an instruction selector pass using
// the ISelDag to gen Cpu0 code.
bool Cpu0PassConfig::addInstSelector() {
  addPass(createCpu0SEISelDag(getCpu0TargetMachine(), getOptLevel()));
  return false;
}

// #ifdef ENABLE_GPRESTORE
// void Cpu0PassConfig::addPreRegAlloc() {
//   if (!Cpu0ReserveGP) {
//     // $gp is a caller-saved register.
//     addPass(createCpu0EmitGPRestorePass(getCpu0TargetMachine()));
//   }
//   return;
// }
// #endif

// Implemented by targets that want to run passes immediately before
// machine code is emitted. return true if -print-machineinstrs should
// print out the code after the passes.
// void Cpu0PassConfig::addPreEmitPass() {
//   Cpu0TargetMachine &TM = getCpu0TargetMachine();
//   //@8_2 1{
//   addPass(createCpu0DelJmpPass(TM));
//   //@8_2 1}
//   addPass(createCpu0DelaySlotFillerPass(TM));
//   //@8_2 2}
//   addPass(createCpu0LongBranchPass(TM));
//   return;
// }