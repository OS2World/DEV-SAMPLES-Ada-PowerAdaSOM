
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:20 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTSequenceEntryC IS


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
      


   FUNCTION get_somtSeqLength (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The length of the sequence.

   FUNCTION get_somtSeqType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The type of the sequence.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTSequenceEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTSequenceEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtSeqLength : SOM.somMToken;
      get_somtSeqType : SOM.somMToken;
      get_somtSeqTypedef : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTSequenceEntryCClassData : classData;
   FOR SOMTSequenceEntryCClassData USE AT standard.system.label("SOMTSequenceEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTSequenceEntryCCClassData : CClassData;
   FOR SOMTSequenceEntryCCClassData USE AT standard.system.label("SOMTSequenceEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTSequenceEntryCClassData.classObject) 
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
      FUNCTION SOMTSequenceEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTSequenceEntryCNewClass);
      PRAGMA interface_information (SOMTSequenceEntryCNewClass, ".SOMTSequenceEntryCNewClass");
   BEGIN
      RETURN SOMTSequenceEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTSequenceEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTSequenceEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtSeqLength (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The length of the sequence.
      FUNCTION SOMTSequenceEntryC_U_get_somtSeqLength(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTSequenceEntryC_U_get_somtSeqLength);
      PRAGMA interface_information (SOMTSequenceEntryC_U_get_somtSeqLength, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTSequenceEntryC_U_get_somtSeqLength (
            Self.som_object,
            SOMTSequenceEntryCClassData.get_somtSeqLength);
      RETURN Result;
   END get_somtSeqLength; 

   FUNCTION get_somtSeqType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The type of the sequence.
      FUNCTION SOMTSequenceEntryC_U_get_somtSeqType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTSequenceEntryC_U_get_somtSeqType);
      PRAGMA interface_information (SOMTSequenceEntryC_U_get_somtSeqType, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTSequenceEntryC_U_get_somtSeqType (
            Self.som_object,
            SOMTSequenceEntryCClassData.get_somtSeqType);
      RETURN Result;
   END get_somtSeqType; 

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

END SOMTSequenceEntryC; 







