
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:17 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTEnumNameEntryC IS


   TYPE Ref IS NEW SOMTEntryC.Ref WITH NULL RECORD;

   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref;

   Major_Version : CONSTANT SOM.integer4 := 2;
   Minor_Version : CONSTANT SOM.integer4 := 1;

   FUNCTION New_Class (
      Major_Version : IN SOM.integer4;
      Minor_Version : IN SOM.integer4)
      RETURN             SOM.SOMClassPtr;

   FUNCTION New_Instance
      RETURN Ref;

   PROCEDURE Free_Instance(
      Instance : IN OUT Ref);
      


   FUNCTION get_somtEnumPtr (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- A pointer to the enumerator.

   FUNCTION get_somtEnumVal (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- The value of the enumeration.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTEnumNameEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTEnumNameEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtEnumPtr : SOM.somMToken;
      get_somtEnumVal : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTEnumNameEntryCClassData : classData;
   FOR SOMTEnumNameEntryCClassData USE AT standard.system.label("SOMTEnumNameEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTEnumNameEntryCCClassData : CClassData;
   FOR SOMTEnumNameEntryCCClassData USE AT standard.system.label("SOMTEnumNameEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTEnumNameEntryCClassData.classObject) 
      THEN
         RETURN Ref'(som_object => som_object);
      ELSE
         RAISE program_error;
      END IF;
   END To_Ref;



   FUNCTION New_Class (
      Major_Version : IN SOM.integer4;
      Minor_Version : IN SOM.integer4)
      RETURN             SOM.SOMClassPtr
   IS
      FUNCTION SOMTEnumNameEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTEnumNameEntryCNewClass);
      PRAGMA interface_information (SOMTEnumNameEntryCNewClass, ".SOMTEnumNameEntryCNewClass");
   BEGIN
      RETURN SOMTEnumNameEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTEnumNameEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTEnumNameEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtEnumPtr (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- A pointer to the enumerator.
      FUNCTION SOMTEnumNameEntryC_U_get_somtEnumPtr(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTEnumNameEntryC_U_get_somtEnumPtr);
      PRAGMA interface_information (SOMTEnumNameEntryC_U_get_somtEnumPtr, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEnumNameEntryC_U_get_somtEnumPtr (
            Self.som_object,
            SOMTEnumNameEntryCClassData.get_somtEnumPtr);
      RETURN Result;
   END get_somtEnumPtr; 

   FUNCTION get_somtEnumVal (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- The value of the enumeration.
      FUNCTION SOMTEnumNameEntryC_U_get_somtEnumVal(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMTEnumNameEntryC_U_get_somtEnumVal);
      PRAGMA interface_information (SOMTEnumNameEntryC_U_get_somtEnumVal, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEnumNameEntryC_U_get_somtEnumVal (
            Self.som_object,
            SOMTEnumNameEntryCClassData.get_somtEnumVal);
      RETURN Result;
   END get_somtEnumVal; 

   PROCEDURE somDumpSelfInt (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDumpSelfInt (
         SOMObject.Ref'(som_object=>Self.som_object),
         level);
   END somDumpSelfInt;

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref; 
      emitter : IN SOM.SOMObjectPtr; 
      prefix : IN Corba.String)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMTEntryC.somtSetSymbolsOnEntry (
            SOMTEntryC.Ref'(som_object=>Self.som_object),
            emitter,
            prefix);
   END somtSetSymbolsOnEntry;

END SOMTEnumNameEntryC; 







