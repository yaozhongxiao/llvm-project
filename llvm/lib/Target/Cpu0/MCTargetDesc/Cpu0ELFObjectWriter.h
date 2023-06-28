//===-- Cpu0ELFObjectWriter.h - Cpu0 ELF Writer ----------------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the declaration of the Cpu0ELFObjectWriter class.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_CPU0_MCTARGETDESC_CPU0ELFOBJECTWRITER_H
#define LLVM_LIB_TARGET_CPU0_MCTARGETDESC_CPU0ELFOBJECTWRITER_H

#include "llvm/MC/MCELFObjectWriter.h"

namespace llvm {

class Cpu0ELFObjectWriter : public MCELFObjectTargetWriter {
public:
  Cpu0ELFObjectWriter(uint8_t OSABI, bool HasRelocationAddend, bool Is64);

  ~Cpu0ELFObjectWriter() = default;

  unsigned getRelocType(MCContext &Ctx, const MCValue &Target,
                        const MCFixup &Fixup, bool IsPCRel) const override;
  bool needsRelocateWithSymbol(const MCSymbol &Sym,
                               unsigned Type) const override;
};

} // namespace llvm
#endif // LLVM_LIB_TARGET_CPU0_MCTARGETDESC_CPU0ELFOBJECTWRITER_H