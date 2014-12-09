#- Copyright (C) 1994 OC Systems, Inc.
#- licensed material, program property of OC Systems
#:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
#  Assembler support for SOM method "thunk" calls.
#
#  This module provides entry points used to make indirect calls
#  to SOM method thunks.  There is a separate entry point, named
#  "xsomcall#", that depends on the number of parameters being
#  passed, in addition to the subprogram value parameter.  The
#  subprogram value parameter is always the last parameter so that
#  it can be moved to R11 (leaving the other parameters in place)
#  to make an indirect call.
#
#  97Apr24  swn  d3681 Added entrypoints to support up to 50 parameters.
#  95Apr24  swn  Added ESVs for all entry points, langid = asm.  (d1177)
#  94Dec20  swn  Compacted call sequence and added more parameters.
#  94Oct18  swn  Created.
#  
#-----------------------------------------------------------------
#-----------------------------------------------------------------
.set R0,0
.set SP,1
.set RTOC,2
.set R3,3
.set R4,4
.set R5,5
.set R6,6
.set R7,7
.set R8,8
.set R9,9
.set R10,10
.set R11,11
.set R12,12
.set R13,13
.set R14,14
.set R15,15
.set R16,16
.set R17,17
.set R18,18
.set R19,19
.set ST,20
.set R21,21
.set R22,22
.set R23,23
.set R24,24
.set R25,25
.set R26,26
.set R27,27
.set R28,28
.set SB,29
.set RA,30
.set FP,31
.set FP0,0
.set FP1,1
.set FP2,2
.set FP3,3
.set FP4,4
.set FP5,5
.set FP6,6
.set FP7,7
.set FP8,8
.set FP9,9
.set FP10,10
.set FP11,11
.set FP12,12
.set FP13,13
.set FP14,14
.set FP15,15
.set FP16,16
.set FP17,17
.set FP18,18
.set FP19,19
.set FP20,20
.set FP21,21
.set FP22,22
.set FP23,23
.set FP24,24
.set FP25,25
.set FP26,26
.set FP27,27
.set FP28,28
.set FP29,29
.set FP30,30
.set FP31,31
.set cs0,0
.set cs1,1
.set cs2,2
.set cs3,3
.set cs4,4
.set cs5,5
.set cs6,6
.set cs7,7
.set LR,8
.set XER,1
#
######################################################################
#   Offsets into the subprogram value record
#
#  TYPE Subprogram_Value is
#    Record
#     Entry_Point   : Address;
#     Static_Base   : Address;
#     TOC           : Address;
#  End Record;
#
.dsect      SPV
spv_ep:     .long 0
spv_toc:    .long 0
spv_sb:     .long 0
#
#
#
#-----------------------------------------------------------------
#
#  xsomcall
#     Make indirect function call.  Assume subprogram value in R11
#     and all other parameters ar where they should be.
#     Copy C function return reg to Ada function return reg.
#
	 .csect    .xsomcall{pr},3
	 .globl    .xsomcall{pr}

         mflr      RA                  # save caller return address
         stm       SB,-12(SP)          # save registers
         cal       FP,0(SP)            # setup frame pointer
         cal       SP,-160(SP)         # push some space on the stack

	 st        RTOC,20(SP)         # save current TOC address.
	 bl        ._ptrgl{pr}	       # Go to "callee"
         l         RTOC,20(SP)         # Restore TOC
         cal       R19,0(R3)           # Move function return value

         l         RA,-8(FP)           # Restore link register
         cal       SP, 0(FP)           # Restore stack pointer
         mtlr      RA                  # Restore link register
         lm        SB,-12(SP)          # Restore saved registers
         br                            # Return to caller
xsomcall_prop:
         l         R4,-8(FP)           # Get link register
         cal       R3, 0(R4)           # 
         cal       SP, 0(FP)           # Restore stack pointer
         mtlr      R4                  # Restore link register
         lm        SB,-12(SP)          # Restore saved registers
         b         xreraise{pr}        # Reraise
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall1
#     Indirect call with one parameter.
#
	 .csect    .xsomcall1{pr},3
	 .globl    .xsomcall1{pr}

	 cal       R11,0(R4)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall2
#     Indirect call with two parameters.
#
	 .csect    .xsomcall2{pr},3
	 .globl    .xsomcall2{pr}

	 cal  	   R11,0(R5)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall3
#     Indirect call with three parameters.
#
	 .csect    .xsomcall3{pr},4
	 .globl    .xsomcall3{pr}

	 cal   	   R11,0(R6)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall4
#     Indirect call with four parameters.
#
	 .csect    .xsomcall4{pr},4
	 .globl    .xsomcall4{pr}

	 cal  	   R11,0(R7)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall5
#     Indirect call with five parameters.
#
	 .csect    .xsomcall5{pr},4
	 .globl    .xsomcall5{pr}

	 cal  	   R11,0(R8)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall6
#     Indirect call with six parameters.
#
	 .csect    .xsomcall6{pr},4
	 .globl    .xsomcall6{pr}

	 cal  	   R11,0(R9)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall7
#     Indirect call with seven parameters.
#
	 .csect    .xsomcall7{pr},4
	 .globl    .xsomcall7{pr}

	 cal  	   R11,0(R10)           # Move pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall8
#     Indirect call with eight parameters.
#
	 .csect    .xsomcall8{pr},4
	 .globl    .xsomcall8{pr}

	 l  	   R11,56(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall9
#     Indirect call with nine parameters.
#
	 .csect    .xsomcall9{pr},4
	 .globl    .xsomcall9{pr}

         l         R11,60(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall10
#     Indirect call with ten parameters.
#
	 .csect    .xsomcall10{pr},4
	 .globl    .xsomcall10{pr}

         l         R11,64(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall11
#     Indirect call with eleven parameters.
#
	 .csect    .xsomcall11{pr},4
	 .globl    .xsomcall11{pr}

         l         R11,68(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall12
#     Indirect call with twelve parameters.
#
	 .csect    .xsomcall12{pr},4
	 .globl    .xsomcall12{pr}

         l         R11,72(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall13
#     Indirect call with thirteen parameters.
#
	 .csect    .xsomcall13{pr},4
	 .globl    .xsomcall13{pr}

         l         R11,76(SP)          # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall14
#     Indirect call with fourteen parameters.
#
	 .csect    .xsomcall14{pr},4
	 .globl    .xsomcall14{pr}

         l         R11,80(SP)          # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall15
#     Indirect call with fifteen parameters.
#
	 .csect    .xsomcall15{pr},4
	 .globl    .xsomcall15{pr}

         l         R11,84(SP)          # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#
#-----------------------------------------------------------------
#
#  xsomcall16
#     Indirect call with sixteen parameters.
#
	 .csect    .xsomcall16{pr},4
	 .globl    .xsomcall16{pr}

	 cal  	   R11,88(SP)          # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall17
#     Indirect call with seventeen parameters.
#
	 .csect    .xsomcall17{pr},4
	 .globl    .xsomcall17{pr}

	 cal  	   R11,92(SP)          # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall18
#     Indirect call with eighteen parameters.
#
	 .csect    .xsomcall18{pr},4
	 .globl    .xsomcall18{pr}

	 l  	   R11,96(SP)          # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall19
#     Indirect call with nineteen parameters.
#
	 .csect    .xsomcall19{pr},4
	 .globl    .xsomcall19{pr}

         l         R11,100(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall20
#     Indirect call with twenty parameters.
#
	 .csect    .xsomcall20{pr},4
	 .globl    .xsomcall20{pr}

         l         R11,104(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall21
#     Indirect call with twenty-one parameters.
#
	 .csect    .xsomcall21{pr},4
	 .globl    .xsomcall21{pr}

         l         R11,108(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall22
#     Indirect call with twenty-two parameters.
#
	 .csect    .xsomcall22{pr},4
	 .globl    .xsomcall22{pr}

         l         R11,112(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall23
#     Indirect call with twenty-three parameters.
#
	 .csect    .xsomcall23{pr},4
	 .globl    .xsomcall23{pr}

         l         R11,116(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall24
#     Indirect call with twenty-four parameters.
#
	 .csect    .xsomcall24{pr},4
	 .globl    .xsomcall24{pr}

         l         R11,120(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall25
#     Indirect call with twenty-five parameters.
#
	 .csect    .xsomcall25{pr},4
	 .globl    .xsomcall25{pr}

         l         R11,124(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall26
#     Indirect call with twenty-six parameters.
#
	 .csect    .xsomcall26{pr},4
	 .globl    .xsomcall26{pr}

         l         R11,128(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall27
#     Indirect call with twenty-seven parameters.
#
	 .csect    .xsomcall27{pr},4
	 .globl    .xsomcall27{pr}

         l         R11,132(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall28
#     Indirect call with twenty-eight parameters.
#
	 .csect    .xsomcall28{pr},4
	 .globl    .xsomcall28{pr}

         l         R11,136(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall29
#     Indirect call with twenty-nine parameters.
#
	 .csect    .xsomcall29{pr},4
	 .globl    .xsomcall29{pr}

         l         R11,140(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall30
#     Indirect call with thirty parameters.
#
	 .csect    .xsomcall30{pr},4
	 .globl    .xsomcall30{pr}

         l         R11,144(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall31
#     Indirect call with thirty-one parameters.
#
	 .csect    .xsomcall31{pr},4
	 .globl    .xsomcall31{pr}

         l         R11,148(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall32
#     Indirect call with thirty-two parameters.
#
	 .csect    .xsomcall32{pr},4
	 .globl    .xsomcall32{pr}

         l         R11,152(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall33
#     Indirect call with thirty-three parameters.
#
	 .csect    .xsomcall33{pr},4
	 .globl    .xsomcall33{pr}

         l         R11,156(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall34
#     Indirect call with thirty-four parameters.
#
	 .csect    .xsomcall34{pr},4
	 .globl    .xsomcall34{pr}

         l         R11,160(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall35
#     Indirect call with thirty-five parameters.
#
	 .csect    .xsomcall35{pr},4
	 .globl    .xsomcall35{pr}

         l         R11,164(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall36
#     Indirect call with thirty-six parameters.
#
	 .csect    .xsomcall36{pr},4
	 .globl    .xsomcall36{pr}

         l         R11,168(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall37
#     Indirect call with thirty-seven parameters.
#
	 .csect    .xsomcall37{pr},4
	 .globl    .xsomcall37{pr}

         l         R11,172(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall38
#     Indirect call with thirty-eight parameters.
#
	 .csect    .xsomcall38{pr},4
	 .globl    .xsomcall38{pr}

         l         R11,176(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall39
#     Indirect call with thirty-nine parameters.
#
	 .csect    .xsomcall39{pr},4
	 .globl    .xsomcall39{pr}

         l         R11,180(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall40
#     Indirect call with forty parameters.
#
	 .csect    .xsomcall40{pr},4
	 .globl    .xsomcall40{pr}

         l         R11,184(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall41
#     Indirect call with forty-one parameters.
#
	 .csect    .xsomcall41{pr},4
	 .globl    .xsomcall41{pr}

         l         R11,188(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall42
#     Indirect call with forty-two parameters.
#
	 .csect    .xsomcall42{pr},4
	 .globl    .xsomcall42{pr}

         l         R11,192(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall43
#     Indirect call with forty-three parameters.
#
	 .csect    .xsomcall43{pr},4
	 .globl    .xsomcall43{pr}

         l         R11,196(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall44
#     Indirect call with forty-four parameters.
#
	 .csect    .xsomcall44{pr},4
	 .globl    .xsomcall44{pr}

         l         R11,200(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall45
#     Indirect call with forty-five parameters.
#
	 .csect    .xsomcall45{pr},4
	 .globl    .xsomcall45{pr}

         l         R11,204(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall46
#     Indirect call with forty-six parameters.
#
	 .csect    .xsomcall46{pr},4
	 .globl    .xsomcall46{pr}

         l         R11,208(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall47
#     Indirect call with forty-seven parameters.
#
	 .csect    .xsomcall47{pr},4
	 .globl    .xsomcall47{pr}

         l         R11,212(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall48
#     Indirect call with forty-eight parameters.
#
	 .csect    .xsomcall48{pr},4
	 .globl    .xsomcall48{pr}

         l         R11,216(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall49
#     Indirect call with forty-nine parameters.
#
	 .csect    .xsomcall49{pr},4
	 .globl    .xsomcall49{pr}

         l         R11,220(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#-----------------------------------------------------------------
#
#  xsomcall50
#     Indirect call with fifty parameters.
#
	 .csect    .xsomcall50{pr},4
	 .globl    .xsomcall50{pr}

         l         R11,224(SP)         # Get pointer to func descr..
         b         .xsomcall{pr}
         .long      0                  # END_OF_CODE
         .short     12                 # language id (Assembly)
         .short     0                  # other flags.
#
#-----------------------------------------------------------------
         .string    "%Z %W %I %G %U"
#-----------------------------------------------------------------
#
	 .extern    xreraise{pr}
         .extern    ._ptrgl{pr}
