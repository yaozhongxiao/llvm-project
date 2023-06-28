add_llvm_component_group(Cpu0 HAS_JIT)

# LLVM_TARGET_DEFINITIONS must contain the name of the .td file to process
set(LLVM_TARGET_DEFINITIONS Cpu0.td)

# Generate Cpu0GenRegisterInfo.inc which included by hand code C++ files.
# Cpu0GenRegisterInfo.inc came from Cpu0RegisterInfo.td
tablegen(LLVM Cpu0GenRegisterInfo.inc -gen-register-info)
# Generate Cpu0GenInstrInfo.inc which included by hand code C++ files.
# Cpu0GenInstrInfo.inc came from Cpu0InstrInfo.td.
tablegen(LLVM Cpu0GenInstrInfo.inc -gen-instr-info)
tablegen(LLVM Cpu0GenSubtargetInfo.inc -gen-subtarget)
tablegen(LLVM Cpu0GenMCPseudoLowering.inc -gen-pseudo-lowering)

tablegen(LLVM Cpu0GenDAGISel.inc -gen-dag-isel)
tablegen(LLVM Cpu0GenCallingConv.inc -gen-callingconv)

# tablegen(LLVM Cpu0GenCodeEmitter.inc -gen-emitter)
tablegen(LLVM Cpu0GenMCCodeEmitter.inc -gen-emitter)
tablegen(LLVM Cpu0GenAsmWriter.inc -gen-asm-writer)

add_public_tablegen_target(Cpu0CommonTableGen)

add_llvm_target(Cpu0CodeGen
  Cpu0MachineFunction.cpp
  Cpu0PassConfig.cpp
  Cpu0Subtarget.cpp
  Cpu0TargetMachine.cpp
  Cpu0TargetObjectFile.cpp

  Cpu0AsmPrinter.cpp
  Cpu0RegisterInfo.cpp
  Cpu0InstrInfo.cpp
  Cpu0FrameLowering.cpp
  Cpu0ISelDAGToDAG.cpp
  Cpu0ISelLowering.cpp

  Cpu0SEInstrInfo.cpp
  Cpu0SERegisterInfo.cpp
  Cpu0SEFrameLowering.cpp
  Cpu0SEISelDAGToDAG.cpp
  Cpu0SEISelLowering.cpp
  Cpu0MCInstLower.cpp

  LINK_COMPONENTS
  Analysis
  AsmPrinter
  CodeGen
  CodeGenTypes
  Core
  GlobalISel
  MC
  SelectionDAG
  Support
  Target
  TargetParser
  Cpu0Desc
  Cpu0Info
  Cpu0AsmPrinter

  ADD_TO_COMPONENT
  Cpu0
  )

add_subdirectory(InstPrinter)
add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
