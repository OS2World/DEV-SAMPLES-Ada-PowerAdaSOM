
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:18 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTMetaClassEntryC IS


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
      


   FUNCTION get_somtMetaFile (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the name of the file containing the definition of the
     -- meta class named in this entry.

   FUNCTION get_somtMetaClassDef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the class definition entry for the meta class named in
     -- this entry.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTMetaClassEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTMetaClassEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtMetaFile : SOM.somMToken;
      get_somtMetaClassDef : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTMetaClassEntryCClassData : classData;
   FOR SOMTMetaClassEntryCClassData USE AT standard.system.label("SOMTMetaClassEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTMetaClassEntryCCClassData : CClassData;
   FOR SOMTMetaClassEntryCCClassData USE AT standard.system.label("SOMTMetaClassEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTMetaClassEntryCClassData.classObject) 
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
      FUNCTION SOMTMetaClassEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTMetaClassEntryCNewClass);
      PRAGMA interface_information (SOMTMetaClassEntryCNewClass, ".SOMTMetaClassEntryCNewClass");
   BEGIN
      RETURN SOMTMetaClassEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTMetaClassEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTMetaClassEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtMetaFile (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the name of the file containing the definition of the
     -- meta class named in this entry.
      FUNCTION SOMTMetaClassEntryC_U_get_somtMetaFile(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMetaClassEntryC_U_get_somtMetaFile);
      PRAGMA interface_information (SOMTMetaClassEntryC_U_get_somtMetaFile, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMetaClassEntryC_U_get_somtMetaFile (
            Self.som_object,
            SOMTMetaClassEntryCClassData.get_somtMetaFile);
      RETURN Result;
   END get_somtMetaFile; 

   FUNCTION get_somtMetaClassDef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the class definition entry for the meta class named in
     -- this entry.
      FUNCTION SOMTMetaClassEntryC_U_get_somtMetaClassDef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMetaClassEntryC_U_get_somtMetaClassDef);
      PRAGMA interface_information (SOMTMetaClassEntryC_U_get_somtMetaClassDef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMetaClassEntryC_U_get_somtMetaClassDef (
            Self.som_object,
            SOMTMetaClassEntryCClassData.get_somtMetaClassDef);
      RETURN Result;
   END get_somtMetaClassDef; 

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

END SOMTMetaClassEntryC; 







