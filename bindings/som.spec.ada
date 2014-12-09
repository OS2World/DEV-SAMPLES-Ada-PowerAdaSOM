------------------------------------------------------------------------------
-- som.ada : SOM -- PACKAGE SPEC
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  SOM
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec06 swn Remove use of System.Subprogram_Value.  (d2123)
-- 95Sep09 kdh Add som3 types
-- 95May15 gvc Replace system.address with local address type (d1286)
-- 95Jan05 swn Add some DSOM flags.
-- 95Jan04 swn Add some DSOM global variables.
-- 94Dec21 swn Upgraded to SOM CSD2.04.
-- 94Dec12 swn Add ContextIdentifier from OperationDef.
--             Add replaceable routines.
-- 94Oct10 swn Created from C header files.
------------------------------------------------------------------------------
--
-- SOM is the Ada binding to the SOM runtime kernel.
--
-- This file contains the Ada version of all the SOM header files.
-- This includes the SOM and DSOM base types, the SOM and DSOM API,
-- and all the global types defined in the SOM IDL files.
--
------------------------------------------------------------------------------

WITH system;
WITH unchecked_conversion;

PACKAGE SOM IS

   PRAGMA comment("@(#) ada/runtime/som/som.spec, ada, power95.3 1.9 12/6/95 13:13:51");

   type address is new integer;
   for address'size use 32;

   null_address:  constant address;

   FUNCTION To_SOM_Address
      is new unchecked_conversion( system.address, address );

   -----------------------------------------------------------------------
   -- Standard C types.
   -----------------------------------------------------------------------

   SUBTYPE char       IS standard.character;
   SUBTYPE charPtr    IS address;                       -- char *
   SUBTYPE long       IS integer;
   SUBTYPE int        IS integer;
   SUBTYPE size_t     IS integer;
   SUBTYPE voidPtr    IS address;                       -- void *
   SUBTYPE voidPtrPtr IS address;                       -- void **
   SUBTYPE va_list    IS address;

   -----------------------------------------------------------------------
   -- somnames.h - SOM runtime names
   -----------------------------------------------------------------------

   -----------------------------------------------------------------------
   -- somltype.h - SOM linkage type
   -----------------------------------------------------------------------

   -----------------------------------------------------------------------
   -- sombtype.h - SOM base types
   -----------------------------------------------------------------------

   TYPE somMethodPtr IS ACCESS
      FUNCTION (
         p      : IN voidPtr)
         RETURN      voidPtr;

   TYPE somTP_somClassInitFuncPtr IS ACCESS
      PROCEDURE (
         somSelf : IN voidPtr);


   SUBTYPE integer1  IS character;
   SUBTYPE integer2  IS short_integer;
   SUBTYPE uinteger2 IS short_integer;
   SUBTYPE integer4  IS integer;
   SUBTYPE uinteger4 IS integer;
   SUBTYPE float4    IS float;
   SUBTYPE float8    IS long_float;
   SUBTYPE zString   IS charPtr;
   SUBTYPE fString   IS charPtr;

   SUBTYPE somId      IS address;    -- char **
   TYPE    somIdPtr   IS ACCESS ALL somId;
   TYPE    somIdArray IS ARRAY (positive RANGE <>) OF ALIASED somId;

   SUBTYPE somToken    IS address;     -- void *
   TYPE    somTokenPtr IS ACCESS ALL somToken;     -- void **

   SOM_DynamicMethod : CONSTANT := 1;
   SOM_StaticMethod  : CONSTANT := 0;

   -----------------------------------------------------------------------
   -- somtypes.h - SOM types
   -----------------------------------------------------------------------

   -- Object Instance Structure

   TYPE    somMethodTabStruct;
   SUBTYPE somMethodTabStructPtr IS address;

   TYPE integer1Array IS ARRAY (1..1) OF integer1;

   TYPE SOMAny_struct IS
   RECORD
      mtab  : somMethodTabStructPtr;
      xbody : integer1Array;
   END RECORD;

   SUBTYPE SOMAny         IS SOMAny_struct;
   SUBTYPE SOMAnyPtr      IS address;

   -- SOM Primitive Classes

-- SUBTYPE SOMObject      IS SOMAny;
   SUBTYPE SOMObjectPtr   IS address;

-- SUBTYPE SOMClass       IS SOMAny;
   SUBTYPE SOMClassPtr    IS address;

-- SUBTYPE SOMClassMgr    IS SOMAny;
   SUBTYPE SOMClassMgrPtr IS address;

   -----------------------------------------------------------------------
   -- somitype.h -- SOM Implementation Types
   -----------------------------------------------------------------------

   -----------------------------------------------------------------------
   -- somcdev.h
   -----------------------------------------------------------------------

   SOM_TraceLevel  : int;
   FOR SOM_TraceLevel USE AT system.label("SOM_TraceLevel");

   SOM_WarnLevel   : int;
   FOR SOM_WarnLevel USE AT system.label("SOM_WarnLevel");

   SOM_AssertLevel : int;
   FOR SOM_AssertLevel USE AT system.label("SOM_AssertLevel");


   -----------------------------------------------------------------------
   -- somapi.h -- SOM Application Program Interface
   -----------------------------------------------------------------------

   -----------------------------------------------------------------------
   -- SOM version numbers.
   SOM_MajorVersion : long;
      FOR SOM_MajorVersion USE AT system.label("SOM_MajorVersion");
   SOM_MinorVersion : long;
      FOR SOM_MinorVersion USE AT system.label("SOM_MinorVersion");

   -----------------------------------------------------------------------
   -- Pointers to functions.

   TYPE somTD_classInitRoutinePtr     IS ACCESS
      PROCEDURE (
         c1 : IN SOMClassPtr;
         c2 : IN SOMClassPtr);

   TYPE somTD_SOMOutCharRoutinePtr    IS ACCESS
      FUNCTION (
         c      : IN char)
         RETURN      int;

   TYPE somTD_SOMLoadModulePtr        IS ACCESS
      FUNCTION (
         className    : IN zString;
         fileName     : IN zString;
         functionName : IN zString;
         majorVersion : IN integer4;
         minorVersion : IN integer4;
         modHandle    : IN somTokenPtr)
         RETURN            int;

   TYPE somTD_SOMDeleteModulePtr      IS ACCESS
      FUNCTION (
         modHandle : IN somToken)
         RETURN         int;

   TYPE somTD_SOMClassInitFuncNamePtr IS ACCESS
      FUNCTION RETURN zString;

   TYPE somTD_SOMMallocPtr            IS ACCESS
      FUNCTION (
         size   : IN size_t)
         RETURN      somToken;

   TYPE somTD_SOMCallocPtr            IS ACCESS
      FUNCTION (
         num    : IN size_t;
         size   : IN size_t)
         RETURN      somToken;

   TYPE somTD_SOMReallocPtr           IS ACCESS
      FUNCTION (
         ptr    : IN somToken;
         size   : IN size_t)
         RETURN      somToken;

   TYPE somTD_SOMFreePtr              IS ACCESS
      PROCEDURE (
         ptr : IN somToken);

   TYPE somTD_SOMErrorPtr             IS ACCESS
      PROCEDURE (
         errorCode : IN int;
         fileName  : IN zString;
         lineNum   : IN int);


   -----------------------------------------------------------------------
   -- Public Method and Data Tokens.
   SUBTYPE somMToken    IS somToken;
   SUBTYPE somMTokenPtr IS address;

   SUBTYPE somDToken    IS somToken;
   SUBTYPE somDTokenPtr IS address;


   -----------------------------------------------------------------------
   -- The Method Table Structure

   -- To specify an embedded object
   TYPE somEmbeddedObjStruct IS
   RECORD
      copp   : address;
      cnt    : long;
      offset : long;
   END RECORD;
   TYPE somEmbeddedObjStructPtr IS ACCESS ALL somEmbeddedObjStruct;

   SUBTYPE somClassInfo IS somToken;

   -- Generic procedure pointer types.
   SUBTYPE somMethodProc         IS address;
   SUBTYPE somMethodProcPtr      IS address;
   TYPE    somMethodProcPtrPtr   IS ACCESS ALL somMethodProcPtr;
   TYPE    somMethodProcPtrArray IS ARRAY (1..1) OF somMethodProcPtr;

   -- Public Method Table Structure
   TYPE somMethodTabStruct IS
   RECORD
      classObject         : SOMClassPtr;
      classInfo           : address;
      clannName           : charPtr;
      instanceSize        : long;
      dataAlignment       : long;
      mtabSize            : long;
      protectedDataOffset : somDToken;
      embeddedObjs        : somEmbeddedObjStructPtr;
      entries             : somMethodProcPtrArray;
   END RECORD;
   SUBTYPE somMethodTab    IS somMethodTabStruct;
   SUBTYPE somMethodTabPtr IS address;

   -- For building lists of method tables.
   SUBTYPE somMethodTabListPtr IS address;
   TYPE somMethodTabList IS
   RECORD
      mtab   : somMethodTabPtr;
      next   : somMethodTabListPtr;
   END RECORD;
   SUBTYPE somMethodTabs IS somMethodTabListPtr;

   -- For building lists of class objects
   SUBTYPE somClassListPtr IS address;
   TYPE somClassList IS
   RECORD
      cls  : SOMClassPtr;
      next : somClassListPtr;
   END RECORD;
   SUBTYPE somClasses IS somClassListPtr;

   -----------------------------------------------------------------------
   -- SOM Initializers, Destructors, Assigners

   TYPE somInitInfo IS
   RECORD
      cls                  : SOMClassPtr;
      defaultInit          : somMethodProcPtr;
      defaultCopyInit      : somMethodProcPtr;
      defaultConstCopyInit : somMethodProcPtr;
      defaultNCArgCopyInit : somMethodProcPtr;
      dataOffset           : long;
      legacyInit           : somMethodProcPtr;
   END RECORD;
   TYPE somInitInfoPtr IS ACCESS ALL somInitInfo;

   TYPE somDestructInfo IS
   RECORD
      cls                  : SOMClassPtr;
      defaultDestruct      : somMethodProcPtr;
      dataOffset           : long;
      legacyUninit         : somMethodProcPtr;
   END RECORD;
   TYPE somDestructInfoPtr IS ACCESS ALL somDestructInfo;

   TYPE somAssignInfo IS
   RECORD
      cls                  : SOMClassPtr;
      defaultAssign        : somMethodProcPtr;
      defaultConstAssign   : somMethodProcPtr;
      defaultNCArgAssign   : somMethodProcPtr;
      udaAssign            : somMethodProcPtr;
      udaConstAssign       : somMethodProcPtr;
      dataOffset           : long;
   END RECORD;
   TYPE somAssignInfoPtr IS ACCESS ALL somAssignInfo;

   TYPE somBooleanVector IS ACCESS ALL char;     --octet
   SUBTYPE somCtrlInfo IS somToken;

   TYPE somInitCtrl IS
   RECORD
      mask     : somBooleanVector;
      info     : somInitInfoPtr;
      infoSize : int;
      ctrlinfo : somCtrlInfo;
   END RECORD;

   TYPE somDestructCtrl IS
   RECORD
      mask     : somBooleanVector;
      info     : somDestructInfoPtr;
      infoSize : int;
      ctrlinfo : somCtrlInfo;
   END RECORD;

   TYPE somAssignCtrl IS
   RECORD
      mask     : somBooleanVector;
      info     : somAssignInfoPtr;
      infoSize : int;
      ctrlinfo : somCtrlInfo;
   END RECORD;

   SUBTYPE som3InitCtrl     IS somInitCtrl;
   SUBTYPE som3DestructCtrl IS somDestructCtrl;
   SUBTYPE som3AssignCtrl   IS somAssignCtrl;

   -----------------------------------------------------------------------
   -- The Class Data Structures

   -- Generic ClassData structure.
   TYPE somClassDataStructure IS
   RECORD
      classObject : SOMClassPtr;
      tokens      : somToken;
   END RECORD;
   SUBTYPE somClassDataStructurePtr IS address;

   -- Special info access structure.
   TYPE somTP_somRenewNoInitNoZeroThunk IS ACCESS
      PROCEDURE (
         p : IN voidPtr);

   TYPE somParentMtabStruct IS
   RECORD
      mtab       : somMethodTabPtr;
      next       : somMethodTabs;
      classObject : SOMClassPtr;
      somRenewNonInitNoZeroThunk : somTP_somRenewNoInitNoZeroThunk;
      instanceSize               : long;
      initializers               : somMethodProcPtrPtr;
      resolvedMTokens            : somMethodProcPtrPtr;
      initCtrl                   : somInitCtrl;
      destructCtrl               : somDestructCtrl;
      assignCtrl                 : somAssignCtrl;
      embeddedTotalCount         : long;
      hierarchyTotalCount        : long;
      unused                     : long;
   END RECORD;
   TYPE somParentMtabStructPtr IS ACCESS ALL somParentMtabStruct;

   -- Generic auxiliary class data structure.
   TYPE somCClassDataStructure IS
   RECORD
      parentMtab        : somParentMTabStructPtr;
      instanceDataToken : somDToken;
      wrappers          : somMethodProcPtrArray;
   END RECORD;
   TYPE somCClassDataStructurePtr IS ACCESS ALL somCClassDataStructure;

   -----------------------------------------------------------------------
   -- Offset-based method resolution.

   FUNCTION somResolve (
      obj    : IN SOMObjectPtr;
      mdata  : IN somMToken)
      RETURN      somMethodProcPtr;
      PRAGMA interface(c, somResolve);
      PRAGMA interface_information(somResolve, ".somResolve");

   FUNCTION somParentResolve (
      parentMtabs : IN SOMMethodTabs;
      mToken      : IN somMToken)
      RETURN           somMethodProcPtr;
      PRAGMA interface(c, somParentResolve);
      PRAGMA interface_information(somParentResolve, ".somParentResolve");

   FUNCTION somParentNumResolve (
      parentMtabs : IN SOMMethodTabs;
      parentNum   : IN int;
      mToken      : IN somMToken)
      RETURN           somMethodProcPtr;
      PRAGMA interface(c, somParentNumResolve);
      PRAGMA interface_information(somParentNumResolve, ".somParentNumResolve");

   FUNCTION somClassResolve (
      class  : IN SOMClassPtr;
      mdata  : IN somMToken)
      RETURN      somMethodProcPtr;
      PRAGMA interface(c, somClassResolve);
      PRAGMA interface_information(somClassResolve, ".somClassResolve");

   FUNCTION somAncestorResolve (
      obj    : IN SOMObjectPtr;
      ccds   : IN somCClassDataStructurePtr;
      mToken : IN somMToken)
      RETURN      somMethodProcPtr;
      PRAGMA interface(c, somAncestorResolve);
      PRAGMA interface_information(somAncestorResolve, ".somAncestorResolve");

   FUNCTION somResolveByName (
      obj        : IN SOMObjectPtr;
      methodName : IN charPtr)
      RETURN          somMethodProcPtr;
      PRAGMA interface(c, somResolveByName);
      PRAGMA interface_information(somResolveByName, ".somResolveByName");

   -----------------------------------------------------------------------
   -- Offset-based data resolution.

   FUNCTION somDataResolve (
      obj    : IN SOMObjectPtr;
      dataId : IN somDToken)
      RETURN      somMethodProcPtr;
      PRAGMA interface(c, somDataResolve);
      PRAGMA interface_information(somDataResolve, ".somDataResolve");

   FUNCTION somDataResolveChk (
      obj    : IN SOMObjectPtr;
      dataId : IN somDToken)
      RETURN      somMethodProcPtr;
      PRAGMA interface(c, somDataResolveChk);
      PRAGMA interface_information(somDataResolveChk, ".somDataResolveChk");

   -----------------------------------------------------------------------
   -- Miscellaneous procedures:

   -- Create and initialize the SOM environment.
   FUNCTION somEnvironmentNew
      RETURN SOMClassMgrPtr;
      PRAGMA interface(c, somEnvironmentNew);
      PRAGMA interface_information(somEnvironmentNew, ".somEnvironmentNew");

   FUNCTION somIsObj (
      obj    : IN SOMToken)
      RETURN      boolean;
      PRAGMA interface(c, somIsObj);
      PRAGMA interface_information(somIsObj, ".somIsObj");

   FUNCTION somClassOfNewClassWithParents (
      newClassName : IN charPtr;
      parents      : IN somClasses;
      explicitMeta : IN SOMClassPtr)
      RETURN            SOMClassPtr;
      PRAGMA interface(c, somClassOfNewClassWithParents);
      PRAGMA interface_information(somClassOfNewClassWithParents, ".somClassOfNewClassWithParents");

   FUNCTION somGetClassFromToken (
      mToken : IN somMToken)
      RETURN      SOMClassPtr;
      PRAGMA interface(c, somGetClassFromToken);
      PRAGMA interface_information(somGetClassFromToken, ".somGetClassFromToken");

   -----------------------------------------------------------------------
   -- String Manager:

   FUNCTION somCheckId (
      id     : IN somId)
      RETURN      somId;
      PRAGMA interface(c, somCheckId);
      PRAGMA interface_information(somCheckId, ".somCheckId");

   FUNCTION somRegisterId (
      id     : IN somId)
      RETURN      int;
      PRAGMA interface(c, somRegisterId);
      PRAGMA interface_information(somRegisterId, ".somRegisterId");

   FUNCTION somIdFromString (
      aString : IN zString)
      RETURN       somId;
      PRAGMA interface(c, somIdFromString);
      PRAGMA interface_information(somIdFromString, ".somIdFromString");

   FUNCTION somStringFromId (
      id     : IN somId)
      RETURN      zString;
      PRAGMA interface(c, somStringFromId);
      PRAGMA interface_information(somStringFromId, ".somStringFromId");

   FUNCTION somCompareIds (
      id1    : IN somId;
      id2    : IN somId)
      RETURN      int;
      PRAGMA interface(c, somCompareIds);
      PRAGMA interface_information(somCompareIds, ".somCompareIds");

   FUNCTION somTotalRegIds
      RETURN long;
      PRAGMA interface(c, somTotalRegIds);
      PRAGMA interface_information(somTotalRegIds, ".somTotalRegIds");

   PROCEDURE somSetExpectedIds (
      numIds : IN long);
      PRAGMA interface(c, somSetExpectedIds);
      PRAGMA interface_information(somSetExpectedIds, ".somSetExpectedIds");

   FUNCTION somUniqueKey (
      id     : IN somId)
      RETURN      long;
      PRAGMA interface(c, somUniqueKey);
      PRAGMA interface_information(somUniqueKey, ".somUniqueKey");

   PROCEDURE somBeginPersistentIds;
      PRAGMA interface(c, somBeginPersistentIds);
      PRAGMA interface_information(somBeginPersistentIds, ".somBeginPersistentIds");

   PROCEDURE somEndPersistentIds;
      PRAGMA interface(c, somEndPersistentIds);
      PRAGMA interface_information(somEndPersistentIds, ".somEndPersistentIds");


   -----------------------------------------------------------------------
   -- Class Manager:

   SOMClassMgrObject : SOMClassMgrPtr;
   FOR SOMClassMgrObject USE AT system.label("SOMClassMgrObject");
      -- This is the global Class Manager object.

   PROCEDURE somRegisterClassLibrary (
      libraryName    : IN zString;
      libraryInitRtn : IN somMethodProcPtr);
      PRAGMA interface(c, somRegisterClassLibrary);
      PRAGMA interface_information(somRegisterClassLibrary, ".somRegisterClassLibrary");

   -----------------------------------------------------------------------
   -- Method Stubs -- Signature Support:

   SUBTYPE somRdAppType IS uinteger4;

   TYPE somFloatMap    IS ARRAY (0..12) OF uinteger4;
   TYPE somFloatMapPtr IS ACCESS ALL somFloatMap;

   TYPE somMethodInfoStruct IS
   RECORD
      callType    : somRdAppType;
      va_listSize : long;
      float_map   : somFloatMapPtr;
   END RECORD;
   SUBTYPE somMethodInfo    IS somMethodInfoStruct;
   TYPE    somMethodInfoPtr IS ACCESS ALL somMethodInfo;

   TYPE somApRdInfoStruct IS
   RECORD
      rdStub   : somMethodProcPtr;
      apStub   : somMethodProcPtr;
      stubInfo : somMethodInfoPtr;
   END RECORD;
   SUBTYPE somApRdInfo    IS somApRdInfoStruct;
   TYPE    somApRdInfoPtr IS ACCESS ALL somApRdInfo;

   -- somRdAppType values.
   -- Return types:
   SOMRdRetSimple     : CONSTANT :=  0;         -- Non-float fullword.
   SOMRdRetFloat      : CONSTANT :=  2;         -- Fullword float.
   SOMRdRetDouble     : CONSTANT :=  4;         -- Doubleword float.
   SOMRdRetlongdouble : CONSTANT :=  6;         -- Long double.
   SOMRdRetaggregate  : CONSTANT :=  8;         -- Struct or union.
   SOMRdRetbyte       : CONSTANT := 10;         -- Byte.
   SOMRdRethalf       : CONSTANT := 12;         -- Halfword.

   -- Floating-point scalar indicators.
   SOMRdNoFloatArgs   : CONSTANT := 0;
   SOMRdFloatArgs     : CONSTANT := 1;

   -- Float map modifiers.
   SOMFMSingle : CONSTANT := 1;        -- Indicates single precision.
   SOMFMLast   : CONSTANT := 2;        -- Indicates last float arg.

   -----------------------------------------------------------------------
   -- somApply

   SUBTYPE somSharedMethodData    IS somToken;
   SUBTYPE somSharedMethodDataPtr IS address;

   TYPE somMethodDataStruct IS
   RECORD
      id         : somId;
      xtype      : uinteger4;
      descriptor : somId;
      mToken     : somMToken;
      method     : somMethodProcPtr;
      shared     : somSharedMethodDataPtr;
   END RECORD;
   SUBTYPE somMethodData    IS somMethodDataStruct;
   TYPE    somMethodDataPtr IS ACCESS ALL somMethodData;

   FUNCTION somApply (
      somSelf : IN SOMObjectPtr;
      retVal  : IN voidPtrPtr;
      mdPtr   : IN somMethodDataPtr;
      ap      : IN va_list)
      RETURN       boolean;
      PRAGMA interface (C, somApply);
      PRAGMA interface_information(somApply, ".somApply");

   -----------------------------------------------------------------------
   -- somMakeUserRdStub

   TYPE somDispatchInfo IS
   RECORD
      methodId    : somId;
      dispatchFcn : somMethodProcPtr;
   END RECORD;
   TYPE somDispatchInfoPtr IS ACCESS ALL somDispatchInfo;

   FUNCTION somMakeUserRdStub (
      cls          : IN SOMClassPtr;
      dispatchInfo : IN somDispatchInfoPtr)
      RETURN            somMethodProcPtr;
      PRAGMA interface (C, somMakeUserRdStub);
      PRAGMA interface_information(somMakeUserRdStub, ".somMakeUserRdStub");

   -----------------------------------------------------------------------
   -- Class building:

   -- To specify new static methods.
   TYPE somStaticMethodStruct IS
   RECORD
      classData        : somMTokenPtr;
      methodId         : somIdPtr;
      methodDescriptor : somIdPtr;
      method           : somMethodProcPtr;
      redispatchStub   : somApRdInfoPtr;    --somMethodProcPtr;
      applyStub        : somApRdInfoPtr;    --somMethodProcPtr;
   END RECORD;
   SUBTYPE somStaticMethod_t      IS somStaticMethodStruct;
   TYPE    somStaticMethod_tPtr   IS ACCESS ALL somStaticMethod_t;
   TYPE    somStaticMethod_tArray IS
           ARRAY (positive RANGE <>) OF ALIASED somStaticMethod_t;

   -- To specify an override method.
   TYPE somOverrideMethodStruct IS
   RECORD
      methodId : somIdPtr;
      method   : somMethodProcPtr;
   END RECORD;
   SUBTYPE somOverrideMethod_t      IS somOverrideMethodStruct;
   TYPE    somOverrideMethod_tPtr   IS ACCESS ALL somOverrideMethod_t;
   TYPE    somOverrideMethod_tArray IS
           ARRAY (positive RANGE <>) OF ALIASED somOverrideMethod_t;

   -- To inherit a specific parent's method implementation.
   TYPE somInheritedMethodStruct IS
   RECORD
      methodId  : somIdPtr;
      parentNum : long;
      mToken    : somMTokenPtr;
   END RECORD;
   SUBTYPE somInheritedMethod_t      IS somInheritedMethodStruct;
   TYPE    somInheritedMethod_tPtr   IS ACCESS ALL somInheritedMethod_t;
   TYPE    somInheritedMethod_tArray IS
           ARRAY (positive RANGE <>) OF ALIASED somInheritedMethod_t;


   -- To register a method that has moved upwards in the class hierarchy.
   TYPE somMigratedMethodStruct IS
   RECORD
      clsMToken  : somMTokenPtr;
      destMToken : somMTokenPtr;
   END RECORD;
   SUBTYPE somMigratedMethod_t      IS somMigratedMethodStruct;
   TYPE    somMigratedMethod_tPtr   IS ACCESS ALL somMigratedMethod_t;
   TYPE    somMigratedMethod_tArray IS
           ARRAY (positive RANGE <>) OF ALIASED somMigratedMethod_t;


   -- To specify non-internal data.
   TYPE somNonInternalDataStruct IS
   RECORD
      classData          : somDTokenPtr;
      basisForDataOffset : charPtr;
   END RECORD;
   SUBTYPE somNonInternalData_t IS somNonInternalDataStruct;
   TYPE somNonInternalData_tPtr IS ACCESS ALL somNonInternalDataStruct;

   -- To specify a procedure method.
   TYPE somProcMethodsStruct IS
   RECORD
      classData : somMethodProcPtrPtr;
      pEntry    : somMethodProcPtr;
   END RECORD;
   SUBTYPE somProcMethods_t      IS somProcMethodsStruct;
   TYPE    somProcMethods_tPtr   IS ACCESS ALL somProcMethods_t;
   TYPE    somProcMethods_tArray IS
           ARRAY (positive RANGE <>) OF ALIASED somProcMethods_t;

   -- To specify a general method action.
   TYPE somMethodStruct IS
   RECORD
      typex            : long;
      classData        : somMTokenPtr;
      methodId         : somIdPtr;
      methodDescriptor : somIdPtr;
      method           : somMethodProcPtr;
      redispatchStub   : somMethodProcPtr;
      applyStub        : somMethodProcPtr;
   END RECORD;
   SUBTYPE somMethods_t    IS somMethodStruct;
   TYPE    somMethods_tPtr IS ACCESS ALL somMethods_t;

   -- To specify a varargs function.
   TYPE somVarargsFuncsStruct IS
   RECORD
      classData : somMethodProcPtrPtr;
      vEntry    : somMethodProcPtr;
   END RECORD;
   SUBTYPE somVarargsFuncs_t      IS somVarargsFuncsStruct;
   TYPE    somVarargsFuncs_tPtr   IS ACCESS ALL somVarargsFuncs_t;
   TYPE    somVarargsFuncs_tArray IS
           ARRAY (positive RANGE <>) OF ALIASED somVarargsFuncs_t;

   -- To specify dynamically computed information.
   TYPE somDynamicSCI IS
   RECORD
      version          : int;
      instanceDataSize : long;
      dataAlignment    : long;
      embeddedObjs     : somEmbeddedObjStructPtr;
   END RECORD;
   TYPE somDynamicSCIPtr IS ACCESS ALL somDynamicSCI;

   -- To build a new class.
   TYPE somStaticClassInfoStruct IS
   RECORD
      layoutVersion         : integer4;
      numStaticMethods      : integer4;
      numStaticOverrides    : integer4;
      numNonInternalData    : integer4;
      numProcMethods        : integer4;
      numVarargsFuncs       : integer4;
      majorVersion          : integer4;
      minorVersion          : integer4;
      instanceDataSize      : integer4;
      maxMethods            : integer4;
      numParents            : integer4;
      classId               : somId;
      explicitMetaId        : somId;
      implicitParentMeta    : integer4;
      parents               : somIdPtr;
      cds                   : somClassDataStructurePtr;
      ccds                  : somCClassDataStructurePtr;
      smt                   : somStaticMethod_tPtr;
      omt                   : somOverrideMethod_tPtr;
      nitReferenceBase      : charPtr;
      nit                   : somNonInternalData_tPtr;
      pmt                   : somProcMethods_tPtr;
      vft                   : somVarargsFuncs_tPtr;
      cif                   : somMethodProcPtr;   --somTP_somClassInitFuncPtr;
      -- start v2
      dataAlignment         : integer4;
      -- start v3
      numDirectInitClasses  : long;
      directInitClasses     : somIdPtr;
      numMethods            : long;
      mt                    : somMethods_tPtr;
      protectedDataOffset   : long;
      somSCIVersion         : long;
      numInheritedMethods   : long;
      imt                   : somInheritedMethod_tPtr;
      numClassDataEntries   : long;
      classDataEntryNames   : somIdPtr;
      numMigratedMethods    : long;
      mmt                   : somMigratedMethod_tPtr;
      numInitializers       : long;
      initializers          : somIdPtr;
      somDTSClass           : long;
      dsci                  : somDynamicSCIPtr;
   END RECORD;
   SUBTYPE somStaticClassInfo    IS somStaticClassInfoStruct;
   SUBTYPE somStaticClassInfoPtr IS address;

   FUNCTION somBuildClass (
      inherit_vars : IN long;
      sci          : IN somStaticClassInfo;
      majorVersion : IN long;
      minorVersion : IN long)
      RETURN            SOMClassPtr;
   PRAGMA interface(C, somBuildClass);
   PRAGMA interface_information(somBuildClass, ".somBuildClass");

   -----------------------------------------------------------------------

   FUNCTION somConstructClass (
      classInitRoutine : IN somTD_classInitRoutinePtr;
      parentClass      : IN SOMClassPtr;
      metaClass        : IN SOMClassPtr;
      cds              : IN somClassDataStructurePtr)
      RETURN                SOMClassPtr;
   PRAGMA interface(C, somConstructClass);
   PRAGMA interface_information(somConstructClass, ".somConstructClass");

   -----------------------------------------------------------------------

   -- somPrintf

   FUNCTION somVprintf (
      fmt    : IN zString;
      ap     : IN va_list)
      RETURN      integer4;
      PRAGMA interface (C, somVprintf);
      PRAGMA interface_information(somVprintf, ".somVprintf");

   PROCEDURE somPrefixLevel (
      level : IN long);
      PRAGMA interface (C, somPrefixLevel);
      PRAGMA interface_information(somPrefixLevel, ".somPrefixLevel");

   -- somLPrintf

   -----------------------------------------------------------------------
   -- Replaceable Routines:
   -- For a number of reasons direct access to the subprogram access
   -- values is not provided.  These cover subprograms are provided
   -- instead.

   -- Call these entry points to set the access values.

   PROCEDURE set_SOMOutCharRoutine (
      subprogram : IN somTD_SOMOutCharRoutinePtr);

   PROCEDURE set_SOMLoadModule (
      subprogram : IN somTD_SOMLoadModulePtr);

   PROCEDURE set_SOMDeleteModule (
      subprogram : IN somTD_SOMDeleteModulePtr);

   PROCEDURE set_SOMClassInitFuncName (
      subprogram : IN somTD_SOMClassInitFuncNamePtr);

   PROCEDURE set_SOMMalloc (
      subprogram : IN somTD_SOMMallocPtr);

   PROCEDURE set_SOMCalloc (
      subprogram : IN somTD_SOMCallocPtr);

   PROCEDURE set_SOMRealloc (
      subprogram : IN somTD_SOMReallocPtr);

   PROCEDURE set_SOMFree (
      subprogram : IN somTD_SOMFreePtr);

   PROCEDURE set_SOMError (
      subprogram : IN somTD_SOMErrorPtr);

   -- Call these entry points to get the access values.

   FUNCTION get_SOMOutCharRoutine RETURN somTD_SOMOutCharRoutinePtr;

   FUNCTION get_SOMLoadModule RETURN somTD_SOMLoadModulePtr;

   FUNCTION get_SOMDeleteModule RETURN somTD_SOMDeleteModulePtr;

   FUNCTION get_SOMClassInitFuncName RETURN somTD_SOMClassInitFuncNamePtr;

   FUNCTION get_SOMMalloc RETURN somTD_SOMMallocPtr;

   FUNCTION get_SOMCalloc RETURN somTD_SOMCallocPtr;

   FUNCTION get_SOMRealloc RETURN somTD_SOMReallocPtr;

   FUNCTION get_SOMFree RETURN somTD_SOMFreePtr;

   FUNCTION get_SOMError RETURN somTD_SOMErrorPtr;


   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
   -- The following declarations are types that are declared either in
   -- somcorba.h or in SOM IDL files as global types.  Global types are
   -- included because they are not emitted by the Ada emitter.
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------

   SUBTYPE SOMFOREIGN IS voidPtr;

   --------------------------------------------------------------------------
   -- Exceptions
   --------------------------------------------------------------------------

   -- CORBA 4.13,  p. 79

   TYPE completion_status IS
      (completed_yes, completed_no, completed_maybe);
   FOR completion_status USE
      (completed_yes => 0, completed_no => 1, completed_maybe => 2);

   TYPE exception_type IS
      (no_exception, user_exception, system_exception);
   FOR exception_type USE
      (no_exception => 0, user_exception => 1, system_exception => 2);


   --------------------------------------------------------------------------
   -- Environment.
   --------------------------------------------------------------------------

   -- CORBA 5.19, p.99

   TYPE Environment IS
   RECORD
      major          : exception_type := no_exception;
      exception_name : charPtr;
      params         : voidPtr;
      somdAnchor     : voidPtr;
   END RECORD;

   FOR Environment USE
   RECORD
      major          AT  0 RANGE 0..31;
      exception_name AT  4 RANGE 0..31;
      params         AT  8 RANGE 0..31;
      somdAnchor     AT 12 RANGE 0..31;
   END RECORD;

   TYPE EnvironmentPtr IS ACCESS ALL Environment;

   FUNCTION somExceptionId (
      ev     : IN Environment)
      RETURN      charPtr;
      PRAGMA interface (C, somExceptionId);
      PRAGMA interface_information (somExceptionId, ".somExceptionId");

   FUNCTION exception_id (
      ev     : IN Environment)
      RETURN      charPtr
      RENAMES somExceptionId;

   FUNCTION somExceptionValue (
      ev     : IN Environment)
      RETURN      voidPtr;
      PRAGMA interface (C, somExceptionValue);
      PRAGMA interface_information (somExceptionValue, ".somExceptionValue");

   FUNCTION exception_value (
      ev     : IN Environment)
      RETURN      voidPtr
      RENAMES somExceptionValue;

   PROCEDURE somExceptionFree (
      ev     : IN Environment);
      PRAGMA interface (C, somExceptionFree);
      PRAGMA interface_information (somExceptionFree, ".somExceptionFree");

   PROCEDURE exception_free (
      ev     : IN Environment)
      RENAMES somExceptionFree;

   PROCEDURE somSetException (
      ev             : IN Environment;
      major          : IN exception_type;
      exception_name : IN charPtr;
      params         : IN voidPtr);
      PRAGMA interface (C, somSetException);
      PRAGMA interface_information (somSetException, ".somSetException");

   FUNCTION somGetGlobalEnvironment
      RETURN EnvironmentPtr;
      PRAGMA interface (C, somGetGlobalEnvironment);
      PRAGMA interface_information (somGetGlobalEnvironment, ".somGetGlobalEnvironment");

   -- SOM Macros

   FUNCTION SOM_CreateLocalEnvironment
      RETURN EnvironmentPtr;

   PROCEDURE SOM_DestroyLocalEnvironment (
      ev : IN OUT EnvironmentPtr);

   PROCEDURE SOM_InitEnvironment (
      ev : IN OUT Environment);

   PROCEDURE SOM_UninitEnvironment (
      ev : IN OUT Environment);


   --------------------------------------------------------------------------
   -- Interface Repository
   --------------------------------------------------------------------------

   -- CORBA 7.5.1, p.129

   SUBTYPE Identifier    IS charPtr;
   SUBTYPE RepositoryId  IS charPtr;
   SUBTYPE InterfaceName IS Identifier;

   -- CORBA 7.5.6, p.135

   SUBTYPE ContextIdentifier IS charPtr;

   -- CORBA 7.6, p.141

   TYPE TCKind IS
         (TypeCode_tk_null,
          TypeCode_tk_void,
          TypeCode_tk_short,
          TypeCode_tk_long,
          TypeCode_tk_ushort,
          TypeCode_tk_ulong,
          TypeCode_tk_float,
          TypeCode_tk_double,
          TypeCode_tk_boolean,
          TypeCode_tk_char,
          TypeCode_tk_octet,
          TypeCode_tk_any,
          TypeCode_tk_TypeCode,
          TypeCode_tk_Principal,
          TypeCode_tk_objref,
          TypeCode_tk_struct,
          TypeCode_tk_union,
          TypeCode_tk_enum,
          TypeCode_tk_string,
          TypeCode_tk_sequence,
          TypeCode_tk_array,
          TypeCode_tk_pointer,
          TypeCode_tk_self,
          TypeCode_tk_foreign);

  FOR TCKind USE
        ( TypeCode_tk_null      => 1,
          TypeCode_tk_void      => 2,
          TypeCode_tk_short     => 3,
          TypeCode_tk_long      => 4,
          TypeCode_tk_ushort    => 5,
          TypeCode_tk_ulong     => 6,
          TypeCode_tk_float     => 7,
          TypeCode_tk_double    => 8,
          TypeCode_tk_boolean   => 9,
          TypeCode_tk_char      => 10,
          TypeCode_tk_octet     => 11,
          TypeCode_tk_any       => 12,
          TypeCode_tk_TypeCode  => 13,
          TypeCode_tk_Principal => 14,
          TypeCode_tk_objref    => 15,
          TypeCode_tk_struct    => 16,
          TypeCode_tk_union     => 17,
          TypeCode_tk_enum      => 18,
          TypeCode_tk_string    => 19,
          TypeCode_tk_sequence  => 20,
          TypeCode_tk_array     => 21,

          TypeCode_tk_pointer   => 101,
          TypeCode_tk_self      => 102,
          TypeCode_tk_foreign   => 103);

   SUBTYPE TypeCode IS Address;

   --------------------------------------------------------------------------
   -- Basic Types mapping.
   --------------------------------------------------------------------------

   -- CORBA 5.7, p.89

   TYPE any IS
   RECORD
      typex : TypeCode;
      value : Address;
   END RECORD;

   --------------------------------------------------------------------------
   -- Dynamic Invocation Interface
   --------------------------------------------------------------------------

   -- CORBA 6.1.1,   p. 106

   SUBTYPE Flags IS long;

   TYPE NamedValue IS
   RECORD
      name      : Identifier;
      argument  : Any;
      len       : long;
      arg_modes : Flags;
   END RECORD;


   -- CORBA 6.1.3,   p. 108

   SUBTYPE ORBStatus IS long;


   --------------------------------------------------------------------------
   -- Basic Object Adapter
   --------------------------------------------------------------------------

   -- CORBA 9.2, p.150

   TYPE IDL_SEQUENCE_octet IS
   RECORD
      maximum : long;
      length  : long;
      buffer  : Address;
   END RECORD;
   SUBTYPE ReferenceData IS IDL_SEQUENCE_octet;

   --------------------------------------------------------------------------
   -- Implementation Repository
   --------------------------------------------------------------------------

   SUBTYPE ImplId IS charPtr;

   -----------------------------------------------------------------------
   -- somir.idl
   -----------------------------------------------------------------------

   -- SOM-unique extension to the CORBA Interface Repository.

   TYPE somModifier IS
   RECORD
      name  : charPtr;
      value : charPtr;
   END RECORD;

   -- Miscellaneous "ir" helper functions

   FUNCTION irGetFileNames RETURN charPtr;
   PRAGMA interface (C, irGetFileNames);
   PRAGMA interface_information (irGetFileNames, ".irGetFileNames");

   FUNCTION irGetLastFileName RETURN charPtr;
   PRAGMA interface (C, irGetLastFileName);
   PRAGMA interface_information (irGetLastFileName, ".irGetLastFileName");


   -----------------------------------------------------------------------
   -- eman.idl
   -----------------------------------------------------------------------
   -- Event Manager types.

   SUBTYPE EMRegProc      IS somToken;
   SUBTYPE EMMethodProc   IS somToken;
   SUBTYPE EMMethodProcEv IS somToken;

   -------------------------------------------------------------------------
   -- somdtype.idl
   -------------------------------------------------------------------------

    SOMD_Version : CONSTANT string := "1.0";

   -------------------------------------------------------------------------
   -- somderr.h
   -------------------------------------------------------------------------

   SOMD_ERR_BASE                  : CONSTANT := 30000;

   SOMDERROR_NoMemory              : CONSTANT := 1;
   SOMDERROR_NotImplemented        : CONSTANT := 2;
   SOMDERROR_UnexpectedNULL        : CONSTANT := 3;
   SOMDERROR_IO                    : CONSTANT := 4;
   SOMDERROR_BadVersion            : CONSTANT := 5;
   SOMDERROR_ParmSize              : CONSTANT := 6;
   SOMDERROR_HostName              : CONSTANT := 7;
   SOMDERROR_HostAddress           : CONSTANT := 8;
   SOMDERROR_SocketCreate          : CONSTANT := 9;
   SOMDERROR_SocketBind            : CONSTANT := 10;
   SOMDERROR_SocketName            : CONSTANT := 11;
   SOMDERROR_SocketReceive         : CONSTANT := 12;
   SOMDERROR_SocketSend            : CONSTANT := 13;
   SOMDERROR_SocketIoctl           : CONSTANT := 14;
   SOMDERROR_SocketSelect          : CONSTANT := 15;
   SOMDERROR_PacketSequence        : CONSTANT := 16;
   SOMDERROR_PacketTooBig          : CONSTANT := 17;
   SOMDERROR_AddressNotFound       : CONSTANT := 18;
   SOMDERROR_NoMessages            : CONSTANT := 19;
   SOMDERROR_UnknownAddress        : CONSTANT := 20;
   SOMDERROR_RecvError             : CONSTANT := 21;
   SOMDERROR_SendError             : CONSTANT := 22;
   SOMDERROR_CommTimeOut           : CONSTANT := 23;
   SOMDERROR_CannotConnect         : CONSTANT := 24;
   SOMDERROR_BadConnection         : CONSTANT := 25;
   SOMDERROR_NoHostName            : CONSTANT := 26;
   SOMDERROR_BadBinding            : CONSTANT := 27;
   SOMDERROR_BadMethodName         : CONSTANT := 28;
   SOMDERROR_BadEnvironment        : CONSTANT := 29;
   SOMDERROR_BadContext            : CONSTANT := 30;
   SOMDERROR_BadNVList             : CONSTANT := 31;
   SOMDERROR_BadFlag               : CONSTANT := 32;
   SOMDERROR_BadLength             : CONSTANT := 33;
   SOMDERROR_BadObjref             : CONSTANT := 34;
   SOMDERROR_NullField             : CONSTANT := 35;
   SOMDERROR_UnknownReposId        : CONSTANT := 36;
   SOMDERROR_NVListAccess          : CONSTANT := 37;
   SOMDERROR_NVIndexError          : CONSTANT := 38;
   SOMDERROR_SysTime               : CONSTANT := 39;
   SOMDERROR_SystemCallFailed      : CONSTANT := 40;
   SOMDERROR_CouldNotStartProcess  : CONSTANT := 41;
   SOMDERROR_NoServerClass         : CONSTANT := 42;
   SOMDERROR_NoSOMDInit            : CONSTANT := 43;
   SOMDERROR_SOMDDIRNotSet         : CONSTANT := 44;
   SOMDERROR_NoImplDatabase        : CONSTANT := 45;
   SOMDERROR_ImplNotFound          : CONSTANT := 46;
   SOMDERROR_ClassNotFound         : CONSTANT := 47;
   SOMDERROR_ServerNotFound        : CONSTANT := 48;
   SOMDERROR_ServerAlreadyExists   : CONSTANT := 49;
   SOMDERROR_ServerNotActive       : CONSTANT := 50;
   SOMDERROR_CouldNotStartSOM      : CONSTANT := 51;
   SOMDERROR_ObjectNotFound        : CONSTANT := 52;
   SOMDERROR_NoParentClass         : CONSTANT := 53;
   SOMDERROR_DispatchError         : CONSTANT := 54;
   SOMDERROR_BadTypeCode           : CONSTANT := 55;
   SOMDERROR_BadDescriptor         : CONSTANT := 56;
   SOMDERROR_BadResultType         : CONSTANT := 57;
   SOMDERROR_KeyInUse              : CONSTANT := 58;
   SOMDERROR_KeyNotFound           : CONSTANT := 59;
   SOMDERROR_CtxInvalidPropName    : CONSTANT := 60;
   SOMDERROR_CtxNoPropFound        : CONSTANT := 61;
   SOMDERROR_CtxStartScopeNotFound : CONSTANT := 62;
   SOMDERROR_CtxAccess             : CONSTANT := 63;
   SOMDERROR_CouldNotStartThread   : CONSTANT := 64;
   SOMDERROR_AccessDenied          : CONSTANT := 65;
   SOMDERROR_BadParm               : CONSTANT := 66;
   SOMDERROR_Interrupt             : CONSTANT := 67;
   SOMDERROR_Locked                : CONSTANT := 68;
   SOMDERROR_Pointer               : CONSTANT := 69;
   SOMDERROR_Boundary              : CONSTANT := 70;
   SOMDERROR_UnknownError          : CONSTANT := 71;
   SOMDERROR_NoSpace               : CONSTANT := 72;
   SOMDERROR_DuplicateQueue        : CONSTANT := 73;
   SOMDERROR_BadQueueName          : CONSTANT := 74;
   SOMDERROR_DuplicateSem          : CONSTANT := 75;
   SOMDERROR_BadSemName            : CONSTANT := 76;
   SOMDERROR_TooManyHandles        : CONSTANT := 77;
   SOMDERROR_BadAddrFamily         : CONSTANT := 78;
   SOMDERROR_BadFormat             : CONSTANT := 79;
   SOMDERROR_BadDrive              : CONSTANT := 80;
   SOMDERROR_SharingViolation      : CONSTANT := 81;
   SOMDERROR_BadExeSignature       : CONSTANT := 82;
   SOMDERROR_BadExe                : CONSTANT := 83;
   SOMDERROR_Busy                  : CONSTANT := 84;
   SOMDERROR_BadThread             : CONSTANT := 85;
   SOMDERROR_SOMDPORTNotDefined    : CONSTANT := 86;
   SOMDERROR_ResourceExists        : CONSTANT := 87;
   SOMDERROR_UserName              : CONSTANT := 88;
   SOMDERROR_WrongRefType          : CONSTANT := 89;
   SOMDERROR_MustOverride          : CONSTANT := 90;
   SOMDERROR_NoSocketsClass        : CONSTANT := 91;
   SOMDERROR_EManRegData           : CONSTANT := 92;
   SOMDERROR_NoRemoteComm          : CONSTANT := 93;

   -------------------------------------------------------------------------
   -- somdext.h
   -------------------------------------------------------------------------

   PROCEDURE SOMD_Init(Env : IN Environment);
   PRAGMA interface (C, SOMD_Init);
   PRAGMA interface_information (SOMD_Init, ".SOMD_Init");

   PROCEDURE SOMD_Uninit(Env : IN Environment);
   PRAGMA interface (C, SOMD_Uninit);
   PRAGMA interface_information (SOMD_Uninit, ".SOMD_Uninit");

   PROCEDURE SOMInitsomd;
   PRAGMA interface (C, SOMInitsomd);
   PRAGMA interface_information (SOMInitsomd, ".SOMInitsomd");

   PROCEDURE ORBfree(obj : IN OUT voidPtr);
   PRAGMA interface (C, ORBFree);
   PRAGMA interface_information (ORBFree, ".ORBFree");

   -- DSOM global variables

   SOMD_TraceLevel : long;
   FOR SOMD_TraceLevel USE AT system.label("SOMD_TraceLevel");

   SOMD_DebugFlag  : long;
   FOR SOMD_DebugFlag USE AT system.label("SOMD_DebugFlag");

   SOMD_ImplDefObject : SOMObjectPtr;
   FOR SOMD_ImplDefObject USE AT system.label("SOMD_ImplDefObject");

   SOMD_SOMOAObject : SOMObjectPtr;
   FOR SOMD_SOMOAObject USE AT system.label("SOMD_SOMOAObject");

   -- These globals are accessible through cover subprograms to prevent
   -- elaboration problems.

   FUNCTION get_SOMD_ObjectMgr RETURN SOMObjectPtr;
   PROCEDURE set_SOMD_ObjectMgr(To : IN SOMObjectPtr);

   FUNCTION get_SOMD_ORBObject RETURN SOMObjectPtr;
   PROCEDURE set_SOMD_ORBObject(To : IN SOMObjectPtr);

   FUNCTION get_SOMD_ImplRepObject RETURN SOMObjectPtr;
   PROCEDURE set_SOMD_ImplRepObject(To : IN SOMObjectPtr);

   -- DSOM flags from SOMOA.

   SOMD_WAIT    : CONSTANT := 1;
   SOMD_NO_WAIT : CONSTANT := 0;

   SOMD_IMPL_NOT_INITIALIZED : CONSTANT := 0;
   SOMD_IMPL_NOT_ACTIVE      : CONSTANT := 1;
   SOMD_IMPL_ACTIVE          : CONSTANT := 2;

private
   null_address:  constant address := 0;
END SOM;


