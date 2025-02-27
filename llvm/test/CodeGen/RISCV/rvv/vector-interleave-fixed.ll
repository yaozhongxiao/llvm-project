; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+v,+zfh,+experimental-zvfh | FileCheck -check-prefixes=CHECK,RV32 %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zfh,+experimental-zvfh | FileCheck -check-prefixes=CHECK,RV64 %s

; Integers

define <32 x i1> @vector_interleave_v32i1_v16i1(<16 x i1> %a, <16 x i1> %b) {
; CHECK-LABEL: vector_interleave_v32i1_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmclr.m v9
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, tu, ma
; CHECK-NEXT:    vmv.v.v v9, v0
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 2
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmerge.vim v8, v10, 1, v0
; CHECK-NEXT:    vsetivli zero, 16, e8, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v10, v8, 16
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vwaddu.vv v12, v8, v10
; CHECK-NEXT:    li a1, -1
; CHECK-NEXT:    vwmaccu.vx v12, a1, v10
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    ret
	   %res = call <32 x i1> @llvm.experimental.vector.interleave2.v32i1(<16 x i1> %a, <16 x i1> %b)
	   ret <32 x i1> %res
}

define <16 x i16> @vector_interleave_v16i16_v8i16(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LABEL: vector_interleave_v16i16_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <16 x i16> @llvm.experimental.vector.interleave2.v16i16(<8 x i16> %a, <8 x i16> %b)
	   ret <16 x i16> %res
}

define <8 x i32> @vector_interleave_v8i32_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LABEL: vector_interleave_v8i32_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <8 x i32> @llvm.experimental.vector.interleave2.v8i32(<4 x i32> %a, <4 x i32> %b)
	   ret <8 x i32> %res
}

define <4 x i64> @vector_interleave_v4i64_v2i64(<2 x i64> %a, <2 x i64> %b) {
; RV32-LABEL: vector_interleave_v4i64_v2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; RV32-NEXT:    vmv.v.i v10, 0
; RV32-NEXT:    vsetivli zero, 2, e64, m2, tu, ma
; RV32-NEXT:    vmv.v.v v10, v8
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    lui a0, %hi(.LCPI3_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI3_0)
; RV32-NEXT:    vle16.v v12, (a0)
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    vslideup.vi v10, v8, 2
; RV32-NEXT:    vrgatherei16.vv v8, v10, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: vector_interleave_v4i64_v2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vmv.v.i v10, 0
; RV64-NEXT:    vsetivli zero, 2, e64, m2, tu, ma
; RV64-NEXT:    vmv.v.v v10, v8
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    lui a0, %hi(.LCPI3_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI3_0)
; RV64-NEXT:    vle64.v v12, (a0)
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    vslideup.vi v10, v8, 2
; RV64-NEXT:    vrgather.vv v8, v10, v12
; RV64-NEXT:    ret
	   %res = call <4 x i64> @llvm.experimental.vector.interleave2.v4i64(<2 x i64> %a, <2 x i64> %b)
	   ret <4 x i64> %res
}

declare <32 x i1> @llvm.experimental.vector.interleave2.v32i1(<16 x i1>, <16 x i1>)
declare <16 x i16> @llvm.experimental.vector.interleave2.v16i16(<8 x i16>, <8 x i16>)
declare <8 x i32> @llvm.experimental.vector.interleave2.v8i32(<4 x i32>, <4 x i32>)
declare <4 x i64> @llvm.experimental.vector.interleave2.v4i64(<2 x i64>, <2 x i64>)

; Floats

define <4 x half> @vector_interleave_v4f16_v2f16(<2 x half> %a, <2 x half> %b) {
; CHECK-LABEL: vector_interleave_v4f16_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <4 x half> @llvm.experimental.vector.interleave2.v4f16(<2 x half> %a, <2 x half> %b)
	   ret <4 x half> %res
}

define <8 x half> @vector_interleave_v8f16_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: vector_interleave_v8f16_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <8 x half> @llvm.experimental.vector.interleave2.v8f16(<4 x half> %a, <4 x half> %b)
	   ret <8 x half> %res
}

define <4 x float> @vector_interleave_v4f32_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: vector_interleave_v4f32_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv1r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <4 x float> @llvm.experimental.vector.interleave2.v4f32(<2 x float> %a, <2 x float> %b)
	   ret <4 x float> %res
}

define <16 x half> @vector_interleave_v16f16_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: vector_interleave_v16f16_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <16 x half> @llvm.experimental.vector.interleave2.v16f16(<8 x half> %a, <8 x half> %b)
	   ret <16 x half> %res
}

define <8 x float> @vector_interleave_v8f32_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: vector_interleave_v8f32_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vwaddu.vv v10, v8, v9
; CHECK-NEXT:    li a0, -1
; CHECK-NEXT:    vwmaccu.vx v10, a0, v9
; CHECK-NEXT:    vmv2r.v v8, v10
; CHECK-NEXT:    ret
	   %res = call <8 x float> @llvm.experimental.vector.interleave2.v8f32(<4 x float> %a, <4 x float> %b)
	   ret <8 x float> %res
}

define <4 x double> @vector_interleave_v4f64_v2f64(<2 x double> %a, <2 x double> %b) {
; RV32-LABEL: vector_interleave_v4f64_v2f64:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    vmv.v.i v10, 0
; RV32-NEXT:    vsetivli zero, 2, e64, m2, tu, ma
; RV32-NEXT:    vmv.v.v v10, v8
; RV32-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV32-NEXT:    lui a0, %hi(.LCPI9_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; RV32-NEXT:    vle16.v v12, (a0)
; RV32-NEXT:    vmv1r.v v8, v9
; RV32-NEXT:    vslideup.vi v10, v8, 2
; RV32-NEXT:    vrgatherei16.vv v8, v10, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: vector_interleave_v4f64_v2f64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vmv.v.i v10, 0
; RV64-NEXT:    vsetivli zero, 2, e64, m2, tu, ma
; RV64-NEXT:    vmv.v.v v10, v8
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    lui a0, %hi(.LCPI9_0)
; RV64-NEXT:    addi a0, a0, %lo(.LCPI9_0)
; RV64-NEXT:    vle64.v v12, (a0)
; RV64-NEXT:    vmv1r.v v8, v9
; RV64-NEXT:    vslideup.vi v10, v8, 2
; RV64-NEXT:    vrgather.vv v8, v10, v12
; RV64-NEXT:    ret
	   %res = call <4 x double> @llvm.experimental.vector.interleave2.v4f64(<2 x double> %a, <2 x double> %b)
	   ret <4 x double> %res
}


declare <4 x half> @llvm.experimental.vector.interleave2.v4f16(<2 x half>, <2 x half>)
declare <8 x half> @llvm.experimental.vector.interleave2.v8f16(<4 x half>, <4 x half>)
declare <4 x float> @llvm.experimental.vector.interleave2.v4f32(<2 x float>, <2 x float>)
declare <16 x half> @llvm.experimental.vector.interleave2.v16f16(<8 x half>, <8 x half>)
declare <8 x float> @llvm.experimental.vector.interleave2.v8f32(<4 x float>, <4 x float>)
declare <4 x double> @llvm.experimental.vector.interleave2.v4f64(<2 x double>, <2 x double>)
