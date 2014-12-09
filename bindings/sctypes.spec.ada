------------------------------------------------------------------------------
-- sctypes.ada : SOM Compiler Types -- PACKAGE SPEC
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  SCTypes
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 94Dec12 swn Created from C header files.
------------------------------------------------------------------------------
--
-- SCTypes is the Ada binding to the SOM Compiler Emitter Framework types.
--
-- This file contains the Ada version of all the SOM compiler Emitter
-- Framework header files.
-- This includes the all the global types defined in the SOM IDL files.
--
------------------------------------------------------------------------------

WITH SOM;

PACKAGE SCTypes IS

    --------------------------------------------------------------------------
    -- sm.h
    --------------------------------------------------------------------------

    SUBTYPE Stab IS SOM.voidPtr;

    TYPE SOMTTypes IS
       (SOMTAnyBE,
        SOMTArgumentE,
        SOMTAttE,
        SOMTBadEntryE,
        SOMTBaseE,
        SOMTBooleanBE,
        SOMTCaseEntryE,
        SOMTCaseListE,
        SOMTCaseSTME,
        SOMTCharBE,
        SOMTClassE,
        SOMTConstE,
        SOMTCopyrightE,
        SOMTDataE,
        SOMTDclListE,
        SOMTDefaultE,
        SOMTDoubleBE,
        SOMTEBaseE,
        SOMTEEnumE,
        SOMTEnumBE,
        SOMTEnumE,
        SOMTEnumPE,
        SOMTFloatBE,
        SOMTGroupE,
        SOMTLongBE,
        SOMTMetaE,
        SOMTModuleE,
        SOMTNegativeBE,
        SOMTNewMethodE,
        SOMTOctetBE,
        SOMTOverriddenMethodE,
        SOMTOverrideMethodE,
        SOMTPassthruE,
        SOMTSequenceE,
        SOMTSequenceTDE,
        SOMTShortBE,
        SOMTStringBE,
        SOMTStringE,
        SOMTStructE,
        SOMTStructPE,
        SOMTStructSE,
        SOMTTyDclE,
        SOMTTypeCodeBE,
        SOMTTypedefBE,
        SOMTTypedefE,
        SOMTUnionE,
        SOMTUnionPE,
        SOMTUnionSE,
        SOMTUnsignedLongBE,
        SOMTUnsignedShortBE,
        SOMTVoidBE,
        SOMTVoidPtrBE);

    TYPE IDL_Entry IS
    RECORD
        name     : SOM.charPtr;
        IDL_type : SOMTTypes;
    END RECORD;

    --------------------------------------------------------------------------
    -- sctypes.h
    --------------------------------------------------------------------------

    SOMT_MAX_STRING_LENGTH : CONSTANT := 10000;
    SOMT_MAX_SMALL_STRING  : CONSTANT := 1000;

    TYPE SOMTTargetTypeT IS
       (somtPrivateE,
        somtPublicE,
        somtImplementationE,
        somtAllE);


--#ifdef SOM_STRICT_IDL
--SOMEXTERN SOMTEntryC somtGetObjectWrapper(Entry *ep);
--SOMEXTERN void printEntry(SOMTEntryC entry, int level);
--SOMEXTERN void dumpEntry(SOMTEntryC entry, int level);
--#else
--SOMEXTERN SOMTEntryC *somtGetObjectWrapper(Entry * ep);
--SOMEXTERN void printEntry(SOMTEntryC * entry, int level);
--SOMEXTERN void dumpEntry(SOMTEntryC * entry, int level);
--#endif
--SOMEXTERN void somtShowEntry(Entry * ep);
--SOMEXTERN char *somtStrDup(char *str);
--SOMEXTERN char *somtStrCat(int count,...);
--SOMEXTERN char *somtMakeIncludeStr(boolean local, char *stem, char *suffix);
--SOMEXTERN char *somtNewSymbol(char *prefix, char *stem);
--SOMEXTERN char *somtGetFileStem(char *fullName);
--SOMEXTERN char *somtEntryTypeName(SOMTTypes type);

    --------------------------------------------------------------------------
    -- sccommon.idl
    --------------------------------------------------------------------------

    TYPE somtVisibilityT IS
       (somtInternalVE, somtPublicVE, somtPrivateVE);

    --------------------------------------------------------------------------
    -- scparm.idl
    --------------------------------------------------------------------------

    TYPE somtParameterDirectionT IS
       (somtInE, somtOutE, somtInOutE);

    --------------------------------------------------------------------------
    -- scemit.idl
    --------------------------------------------------------------------------

    SUBTYPE FILE IS SOM.voidPtr;

    --------------------------------------------------------------------------
    -- sctmplt.idl
    --------------------------------------------------------------------------

    TYPE somtCommentStyleT IS
       (somtDashesE, somtCPPE, somtCSimpleE, somtCBlockE);

END SCTypes;
