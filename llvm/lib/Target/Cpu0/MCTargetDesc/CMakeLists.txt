add_llvm_component_library(LLVMCpu0Desc
  Cpu0ABIInfo.cpp
  Cpu0MCAsmInfo.cpp
  Cpu0MCTargetDesc.cpp
  Cpu0TargetStreamer.cpp
  Cpu0MCCodeEmitter.cpp
  Cpu0AsmBackend.cpp
  Cpu0ELFObjectWriter.cpp
  Cpu0MCExpr.cpp

  LINK_COMPONENTS
  CodeGenTypes
  MC
  Cpu0Info
  Support
  TargetParser
  Cpu0AsmPrinter

  ADD_TO_COMPONENT
  Cpu0
  )
