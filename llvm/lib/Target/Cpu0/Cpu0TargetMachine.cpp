//===-- Cpu0TargetMachine.cpp - Define TargetMachine for Cpu0 -------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// Implements the info about Cpu0 target spec.
//
//===----------------------------------------------------------------------===//

#include "Cpu0TargetMachine.h"
#include "Cpu0.h"
#include "TargetInfo/Cpu0TargetInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/TargetPassConfig.h"
#include "llvm/IR/Attributes.h"
#include "llvm/IR/Function.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/CodeGen.h"
#include "llvm/Target/TargetOptions.h"

using namespace llvm;

#define DEBUG_TYPE "cpu0"

extern "C" void LLVMInitializeCpu0Target() {
  outs() << __func__ << "\n";
  // Register the target.
  //- Big endian Target Machine
  RegisterTargetMachine<Cpu0ebTargetMachine> X(getTheCpu0Target());
  //- Little endian Target Machine
  RegisterTargetMachine<Cpu0elTargetMachine> Y(getTheCpu0elTarget());
}

static std::string computeDataLayout(const Triple &TT, StringRef CPU,
                                     const TargetOptions &Options,
                                     bool isLittle) {
  std::string Ret = "";
  // There are both little and big endian cpu0.
  if (isLittle)
    Ret += "e";
  else
    Ret += "E";

  Ret += "-m:m";

  // Pointers are 32 bit on some ABIs.
  Ret += "-p:32:32";

  // 8 and 16 bit integers only need to have natural alignment, but try to
  // align them to 32 bits. 64 bit integers have natural alignment.
  Ret += "-i8:8:32-i16:16:32-i64:64";

  // 32 bit registers are always available and the stack is at least 64 bit
  // aligned.
  Ret += "-n32-S64";

  return Ret;
}

static Reloc::Model getEffectiveRelocModel(bool JIT,
                                           std::optional<Reloc::Model> RM) {
  if (!RM || JIT)
    return Reloc::Static;
  return *RM;
}

//===-------------------Cpu0TargetMachine------------------------===//
// DataLayout --> Big-endian, 32-bit pointer/ABI/alignment
// The stack is always 8 byte aligned
// On function prologue, the stack is created by decrementing
// its pointer. Once decremented, all references are done with positive
// offset from the stack/frame pointer, using StackGrowsUp enables
// an easier handling.
// Using CodeModel::Large enables different CALL behavior.
Cpu0TargetMachine::Cpu0TargetMachine(const Target &T, const Triple &TT,
                                     StringRef CPU, StringRef FS,
                                     const TargetOptions &Options,
                                     std::optional<Reloc::Model> RM,
                                     std::optional<CodeModel::Model> CM,
                                     CodeGenOpt::Level OL, bool JIT,
                                     bool isLittle)
    //- Default is big endian
    : LLVMTargetMachine(T, computeDataLayout(TT, CPU, Options, isLittle), TT,
                        CPU, FS, Options, getEffectiveRelocModel(JIT, RM),
                        getEffectiveCodeModel(CM, CodeModel::Small), OL),
      isLittle(isLittle), TLOF(nullptr) {
  // initAsmInfo will display features by llc -march=cpu0 -mcpu=help on 3.7 but
  // not on 3.6
  // initAsmInfo();
}

Cpu0TargetMachine::~Cpu0TargetMachine() {}

TargetPassConfig *Cpu0TargetMachine::createPassConfig(PassManagerBase &PM) {
  return nullptr;
  // return new Cpu0PassConfig(*this, PM);
}

//===-------------------Cpu0ebTargetMachine------------------------===//
void Cpu0ebTargetMachine::anchor() {}

Cpu0ebTargetMachine::Cpu0ebTargetMachine(const Target &T, const Triple &TT,
                                         StringRef CPU, StringRef FS,
                                         const TargetOptions &Options,
                                         std::optional<Reloc::Model> RM,
                                         std::optional<CodeModel::Model> CM,
                                         CodeGenOpt::Level OL, bool JIT)
    : Cpu0TargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, JIT, false) {}

//===-------------------Cpu0elTargetMachine------------------------===//
void Cpu0elTargetMachine::anchor() {}

Cpu0elTargetMachine::Cpu0elTargetMachine(const Target &T, const Triple &TT,
                                         StringRef CPU, StringRef FS,
                                         const TargetOptions &Options,
                                         std::optional<Reloc::Model> RM,
                                         std::optional<CodeModel::Model> CM,
                                         CodeGenOpt::Level OL, bool JIT)
    : Cpu0TargetMachine(T, TT, CPU, FS, Options, RM, CM, OL, JIT, true) {}
