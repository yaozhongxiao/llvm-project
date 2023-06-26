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

add_public_tablegen_target(Cpu0CommonTableGen)

add_llvm_target(Cpu0CodeGen
  Cpu0FrameLowering.cpp
  Cpu0MachineFunction.cpp
  Cpu0PassConfig.cpp
  Cpu0RegisterInfo.cpp
  Cpu0Subtarget.cpp
  Cpu0TargetMachine.cpp
  Cpu0TargetObjectFile.cpp

  LINK_COMPONENTS
  Analysis
  AsmPrinter
  CodeGen
  CodeGenTypes
  Core
  GlobalISel
  MC
  Cpu0Desc
  Cpu0Info
  SelectionDAG
  Support
  Target
  TargetParser

  ADD_TO_COMPONENT
  Cpu0
  )

add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
