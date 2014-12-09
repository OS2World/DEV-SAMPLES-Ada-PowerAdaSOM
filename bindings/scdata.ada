
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:15 1997
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

PACKAGE SOMTDataEntryC IS


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
      


   FUNCTION get_somtIsSelfRef (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether a declarator of a struct is self-referential.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTDataEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTDataEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtIsSelfRef : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTDataEntryCClassData : classData;
   FOR SOMTDataEntryCClassData USE AT standard.system.label("SOMTDataEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTDataEntryCCClassData : CClassData;
   FOR SOMTDataEntryCCClassData USE AT standard.system.label("SOMTDataEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTDataEntryCClassData.classObject) 
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
      FUNCTION SOMTDataEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTDataEntryCNewClass);
      PRAGMA interface_information (SOMTDataEntryCNewClass, ".SOMTDataEntryCNewClass");
   BEGIN
      RETURN SOMTDataEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTDataEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTDataEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtIsSelfRef (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether a declarator of a struct is self-referential.
      FUNCTION SOMTDataEntryC_U_get_somtIsSelfRef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTDataEntryC_U_get_somtIsSelfRef);
      PRAGMA interface_information (SOMTDataEntryC_U_get_somtIsSelfRef, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTDataEntryC_U_get_somtIsSelfRef (
            Self.som_object,
            SOMTDataEntryCClassData.get_somtIsSelfRef);
      RETURN Result;
   END get_somtIsSelfRef; 

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

END SOMTDataEntryC; 







