
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:23 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTCommonEntryC;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTUserDefinedTypeEntryC IS


   TYPE Ref IS NEW SOMTCommonEntryC.Ref WITH NULL RECORD;

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
      


   FUNCTION get_somtOriginalTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The typedef that defined the user-defined type.

   FUNCTION get_somtBaseTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The object representing the base type
     -- (eg. short, float, unsigned long) of a user-defined type,
     -- skipping over any intermediate user-defined types.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION get_somtTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

END SOMTUserDefinedTypeEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTUserDefinedTypeEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtOriginalTypedef : SOM.somMToken;
      get_somtBaseTypeObj : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTUserDefinedTypeEntryCClassData : classData;
   FOR SOMTUserDefinedTypeEntryCClassData USE AT standard.system.label("SOMTUserDefinedTypeEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTUserDefinedTypeEntryCCClassData : CClassData;
   FOR SOMTUserDefinedTypeEntryCCClassData USE AT standard.system.label("SOMTUserDefinedTypeEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTUserDefinedTypeEntryCClassData.classObject) 
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
      FUNCTION SOMTUserDefinedTypeEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTUserDefinedTypeEntryCNewClass);
      PRAGMA interface_information (SOMTUserDefinedTypeEntryCNewClass, ".SOMTUserDefinedTypeEntryCNewClass");
   BEGIN
      RETURN SOMTUserDefinedTypeEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTUserDefinedTypeEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTUserDefinedTypeEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtOriginalTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The typedef that defined the user-defined type.
      FUNCTION SOMTUserDefinedTypeEntryC_U_get_somtOriginalTypedef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTUserDefinedTypeEntryC_U_get_somtOriginalTypedef);
      PRAGMA interface_information (SOMTUserDefinedTypeEntryC_U_get_somtOriginalTypedef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTUserDefinedTypeEntryC_U_get_somtOriginalTypedef (
            Self.som_object,
            SOMTUserDefinedTypeEntryCClassData.get_somtOriginalTypedef);
      RETURN Result;
   END get_somtOriginalTypedef; 

   FUNCTION get_somtBaseTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The object representing the base type
     -- (eg. short, float, unsigned long) of a user-defined type,
     -- skipping over any intermediate user-defined types.
      FUNCTION SOMTUserDefinedTypeEntryC_U_get_somtBaseTypeObj(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTUserDefinedTypeEntryC_U_get_somtBaseTypeObj);
      PRAGMA interface_information (SOMTUserDefinedTypeEntryC_U_get_somtBaseTypeObj, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTUserDefinedTypeEntryC_U_get_somtBaseTypeObj (
            Self.som_object,
            SOMTUserDefinedTypeEntryCClassData.get_somtBaseTypeObj);
      RETURN Result;
   END get_somtBaseTypeObj; 

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

   FUNCTION get_somtTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMTCommonEntryC.get_somtTypeObj (
            SOMTCommonEntryC.Ref'(som_object=>Self.som_object));
   END get_somtTypeObj;

END SOMTUserDefinedTypeEntryC; 







