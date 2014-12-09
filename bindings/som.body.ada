------------------------------------------------------------------------------
-- som.body : SOM Interface -- PACKAGE BODY
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  SOM
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec06 swn Remove use of System.Subprogram_Value.  (d2123)
-- 95Aug23 kdh system.subprogram_value is now an access type (f1605)
-- 95May15 gvc address is now a local type, not from System (d1286)
-- 94Dec14 swn Created to handle replaceable routines and SOM_ macros.
------------------------------------------------------------------------------
--
-- SOM is the Ada binding to the SOM runtime kernel.
--
-- This file contains the Ada implementation of the C macros contained
-- in the SOM header files.  Additionally, the implementation of the
-- subprograms provided to access the replaceable routines are here.
--
------------------------------------------------------------------------------

WITH unchecked_conversion;

PACKAGE BODY SOM IS

   PRAGMA comment("@(#) ada/runtime/som/som.body, ada, power95.3 1.5 12/6/95 13:14:10");

   -----------------------------------------------------------------------
   -- SOM Macros

   FUNCTION SOM_CreateLocalEnvironment
      RETURN EnvironmentPtr
   IS
      FUNCTION convert IS
         NEW unchecked_conversion(somToken, EnvironmentPtr);
   BEGIN
      RETURN convert(get_SOMCalloc.all(1, (Environment'size+7)/8));
   END SOM_CreateLocalEnvironment;


   PROCEDURE SOM_DestroyLocalEnvironment (
      ev : IN OUT EnvironmentPtr)
   IS
      FUNCTION convert IS
         NEW unchecked_conversion(EnvironmentPtr, somToken);
      ptr : somToken := convert(ev);
   BEGIN
      somExceptionFree(ev.all);
      IF somGetGlobalEnvironment /= ev THEN
         get_SOMFree.all(ptr);
         ev := null;
      END IF;
   END SOM_DestroyLocalEnvironment;


   PROCEDURE SOM_InitEnvironment (
      ev : IN OUT Environment)
   IS
      FUNCTION convert IS
         NEW unchecked_conversion(system.address, EnvironmentPtr);
   BEGIN
      IF convert(ev'address) /= somGetGlobalEnvironment THEN
         ev := (no_exception, SOM.null_address,
                SOM.null_address, SOM.null_address);
      END IF;
   END SOM_InitEnvironment;


   PROCEDURE SOM_UninitEnvironment (
      ev : IN OUT Environment)
   IS
   BEGIN
      somExceptionFree(ev);
   END SOM_UninitEnvironment;


   -----------------------------------------------------------------------
   -- Replaceable Routines:

   -- These are the subprogram values of the replaceable routines which
   -- are resident in SOM and initalized by SOM.  If they were delcared
   -- as objects of the subprogram access types declared in the spec
   -- (somTD_XXXXX) then Ada elaboration sets them to null.  We can't use
   -- System.Subprogram_Value for the same reason.
   -- Even if we could declare the subprogram access types above, the
   -- compiler does not know that these routines should follow C interface
   -- conventions.

   TYPE subprogram_value IS
   RECORD
      dummy1 : integer;
      dummy2 : integer;
      dummy3 : integer;
   END RECORD;

   TYPE access_subprogram_value IS ACCESS ALL subprogram_value;


   SOMOutCharRoutine : ALIASED subprogram_value;
   --somTD_SOMOutCharRoutinePtr;
   FOR SOMOutCharRoutine USE AT system.label("SOMOutCharRoutine");

   SOMLoadModule : ALIASED subprogram_value;
   --somTD_SOMLoadModulePtr;
   FOR SOMLoadModule USE AT system.label("SOMLoadModule");

   SOMDeleteModule : ALIASED subprogram_value;
   --somTD_SOMDeleteModulePtr;
   FOR SOMDeleteModule USE AT system.label("SOMDeleteModule");

   SOMClassInitFuncName : ALIASED subprogram_value;
   --somTD_SOMClassInitFuncNamePtr;
   FOR SOMClassInitFuncName USE AT system.label("SOMClassInitFuncName");

   SOMCalloc : ALIASED subprogram_value;
   --somTD_SOMCallocPtr;
   FOR SOMCalloc USE AT system.label("SOMCalloc");

   SOMFree : ALIASED subprogram_value;
   --somTD_SOMFreePtr;
   FOR SOMFree USE AT system.label("SOMFree");

   SOMMalloc : ALIASED subprogram_value;
   --somTD_SOMMallocPtr;
   FOR SOMMalloc USE AT system.label("SOMMalloc");

   SOMRealloc : ALIASED subprogram_value;
   --somTD_SOMReallocPtr;
   FOR SOMRealloc USE AT system.label("SOMRealloc");

   SOMError : ALIASED subprogram_value;
   --somTD_SOMErrorPtr;
   FOR SOMError USE AT system.label("SOMError");


   PROCEDURE set_SOMOutCharRoutine (
      subprogram : IN somTD_SOMOutCharRoutinePtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMOutCharRoutinePtr,
                                 access_subprogram_value);
   BEGIN
      SOMOutCharRoutine := convert(subprogram).all;
   END set_SOMOutCharRoutine;


   PROCEDURE set_SOMLoadModule (
      subprogram : IN somTD_SOMLoadModulePtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMLoadModulePtr,
                                 access_subprogram_value);
   BEGIN
      SOMLoadModule := convert(subprogram).all;
   END set_SOMLoadModule;


   PROCEDURE set_SOMDeleteModule (
      subprogram : IN somTD_SOMDeleteModulePtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMDeleteModulePtr,
                                 access_subprogram_value);
   BEGIN
      SOMDeleteModule := convert(subprogram).all;
   END set_SOMDeleteModule;


   PROCEDURE set_SOMClassInitFuncName (
      subprogram : IN somTD_SOMClassInitFuncNamePtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMClassInitFuncNamePtr,
                                 access_subprogram_value);
   BEGIN
      SOMClassInitFuncName := convert(subprogram).all;
   END set_SOMClassInitFuncName;


   PROCEDURE set_SOMMalloc (
      subprogram : IN somTD_SOMMallocPtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMMallocPtr, access_subprogram_value);
   BEGIN
      SOMMalloc := convert(subprogram).all;
   END set_SOMMalloc;


   PROCEDURE set_SOMCalloc (
      subprogram : IN somTD_SOMCallocPtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMCallocPtr, access_subprogram_value);
   BEGIN
      SOMCalloc := convert(subprogram).all;
   END set_SOMCalloc;


   PROCEDURE set_SOMRealloc (
      subprogram : IN somTD_SOMReallocPtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMReallocPtr, access_subprogram_value);
   BEGIN
      SOMRealloc := convert(subprogram).all;
   END set_SOMRealloc;


   PROCEDURE set_SOMFree (
      subprogram : IN somTD_SOMFreePtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMFreePtr, access_subprogram_value);
   BEGIN
      SOMFree := convert(subprogram).all;
   END set_SOMFree;


   PROCEDURE set_SOMError (
      subprogram : IN somTD_SOMErrorPtr)
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(somTD_SOMErrorPtr, access_subprogram_value);
   BEGIN
      SOMError := convert(subprogram).all;
   END set_SOMError;

   ---

   FUNCTION get_SOMOutCharRoutine RETURN somTD_SOMOutCharRoutinePtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value,
                                 somTD_SOMOutCharRoutinePtr);
   BEGIN
      RETURN convert(SOMOutCharRoutine'access);
   END get_SOMOutCharRoutine;


   FUNCTION get_SOMLoadModule RETURN somTD_SOMLoadModulePtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value,
                                 somTD_SOMLoadModulePtr);
   BEGIN
      RETURN convert(SOMLoadModule'access);
   END get_SOMLoadModule;


   FUNCTION get_SOMDeleteModule RETURN somTD_SOMDeleteModulePtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value,
                                 somTD_SOMDeleteModulePtr);
   BEGIN
      RETURN convert(SOMDeleteModule'access);
   END get_SOMDeleteModule;


   FUNCTION get_SOMClassInitFuncName RETURN somTD_SOMClassInitFuncNamePtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value,
                                 somTD_SOMClassInitFuncNamePtr);
   BEGIN
      RETURN convert(SOMClassInitFuncName'access);
   END get_SOMClassInitFuncName;


   FUNCTION get_SOMMalloc RETURN somTD_SOMMallocPtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value, somTD_SOMMallocPtr);
   BEGIN
      RETURN convert(SOMMalloc'access);
   END get_SOMMalloc;


   FUNCTION get_SOMCalloc RETURN somTD_SOMCallocPtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value, somTD_SOMCallocPtr);
   BEGIN
      RETURN convert(SOMCalloc'access);
   END get_SOMCalloc;


   FUNCTION get_SOMRealloc RETURN somTD_SOMReallocPtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value, somTD_SOMReallocPtr);
   BEGIN
      RETURN convert(SOMRealloc'access);
   END get_SOMRealloc;


   FUNCTION get_SOMFree RETURN somTD_SOMFreePtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value, somTD_SOMFreePtr);
   BEGIN
      RETURN convert(SOMFree'access);
   END get_SOMFree;


   FUNCTION get_SOMError RETURN somTD_SOMErrorPtr
   IS
      FUNCTION convert IS
        NEW unchecked_conversion(access_subprogram_value, somTD_SOMErrorPtr);
   BEGIN
      RETURN convert(SOMError'access);
   END get_SOMError;


   -----------------------------------------------------------------------
   -- DSOM Global Variables:

   -- The external references to the global variables are typed as intergers
   -- to prevent intialization during elaboration.  The cover routines
   -- convert them.

   SOMD_ObjectMgr : long;
   FOR SOMD_ObjectMgr USE AT system.label("SOMD_ObjectMgr");

   SOMD_ORBObject : long;
   FOR SOMD_ORBObject USE AT system.label("SOMD_ORBObject");

   SOMD_ImplRepObject : long;
   FOR SOMD_ImplRepObject USE AT system.label("SOMD_ImplRepObject");

   FUNCTION convert IS
     NEW unchecked_conversion(long, SOMObjectPtr);
   FUNCTION convert IS
     NEW unchecked_conversion(SOMObjectPtr, long);


   FUNCTION get_SOMD_ObjectMgr RETURN SOMObjectPtr
   IS
   BEGIN
      RETURN convert(SOMD_ObjectMgr);
   END get_SOMD_ObjectMgr;

   PROCEDURE set_SOMD_ObjectMgr(To : IN SOMObjectPtr)
   IS
   BEGIN
      SOMD_ObjectMgr := convert(to);
   END set_SOMD_ObjectMgr;


   FUNCTION get_SOMD_ORBObject RETURN SOMObjectPtr
   IS
   BEGIN
      RETURN convert(SOMD_ORBObject);
   END get_SOMD_ORBObject;

   PROCEDURE set_SOMD_ORBObject(To : IN SOMObjectPtr)
   IS
   BEGIN
      SOMD_ORBObject := convert(to);
   END set_SOMD_ORBObject;


   FUNCTION get_SOMD_ImplRepObject RETURN SOMObjectPtr
   IS
   BEGIN
      RETURN convert(SOMD_ImplRepObject);
   END get_SOMD_ImplRepObject;

   PROCEDURE set_SOMD_ImplRepObject(To : IN SOMObjectPtr)
   IS
   BEGIN
      SOMD_ImplRepObject := convert(to);
   END set_SOMD_ImplRepObject;

END SOM;



