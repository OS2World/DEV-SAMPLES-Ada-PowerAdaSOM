
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:23 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTUnionEntryC IS


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
      

   TYPE somtLabelList IS
   RECORD
      label : Corba.String;
      nextLabel : SOM.voidPtr;
   END RECORD;
   PRAGMA Preserve_Layout( somtLabelList );
     
     -- Linked list of case labels.

   TYPE somtCaseEntry IS
   RECORD
      caseLabels : SOM.voidPtr;
        
        -- The labels for this case.
      memberType : SOM.SOMObjectPtr;
        
        -- The type of the member.
      memberDeclarator : SOM.SOMObjectPtr;
        
        -- The declarator for the member.
   END RECORD;
   PRAGMA Preserve_Layout( somtCaseEntry );
     
     -- A case for the union.


   FUNCTION get_somtSwitchType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The switch type of the union.

   FUNCTION somtGetFirstCaseEntry (
      Self : IN Ref)
      RETURN SOMTUnionEntryC.somtCaseEntry;
     
     -- The first case for the union.

   FUNCTION somtGetNextCaseEntry (
      Self : IN Ref)
      RETURN SOMTUnionEntryC.somtCaseEntry;
     
     -- The next case for the union, relative to the previous
     -- call to this method or to somtGetFirstCaseEntry.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTUnionEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTUnionEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtSwitchType : SOM.somMToken;
      somtGetFirstCaseEntry : SOM.somMToken;
      somtGetNextCaseEntry : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTUnionEntryCClassData : classData;
   FOR SOMTUnionEntryCClassData USE AT standard.system.label("SOMTUnionEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTUnionEntryCCClassData : CClassData;
   FOR SOMTUnionEntryCCClassData USE AT standard.system.label("SOMTUnionEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTUnionEntryCClassData.classObject) 
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
      FUNCTION SOMTUnionEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTUnionEntryCNewClass);
      PRAGMA interface_information (SOMTUnionEntryCNewClass, ".SOMTUnionEntryCNewClass");
   BEGIN
      RETURN SOMTUnionEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTUnionEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTUnionEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtSwitchType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The switch type of the union.
      FUNCTION SOMTUnionEntryC_U_get_somtSwitchType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTUnionEntryC_U_get_somtSwitchType);
      PRAGMA interface_information (SOMTUnionEntryC_U_get_somtSwitchType, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTUnionEntryC_U_get_somtSwitchType (
            Self.som_object,
            SOMTUnionEntryCClassData.get_somtSwitchType);
      RETURN Result;
   END get_somtSwitchType; 

   FUNCTION somtGetFirstCaseEntry (
      Self : IN Ref)
      RETURN SOMTUnionEntryC.somtCaseEntry
   IS
     
     -- The first case for the union.
      FUNCTION SOMTUnionEntryC_somtGetFirstCaseEntry(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOMTUnionEntryC.somtCaseEntry; 
      PRAGMA interface (assembly, SOMTUnionEntryC_somtGetFirstCaseEntry);
      PRAGMA interface_information (SOMTUnionEntryC_somtGetFirstCaseEntry, ".xsomcall1");
      Result : ALIASED SOMTUnionEntryC.somtCaseEntry;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTUnionEntryC_somtGetFirstCaseEntry (
            Self.som_object,
            SOMTUnionEntryCClassData.somtGetFirstCaseEntry);
      RETURN Result;
   END somtGetFirstCaseEntry; 

   FUNCTION somtGetNextCaseEntry (
      Self : IN Ref)
      RETURN SOMTUnionEntryC.somtCaseEntry
   IS
     
     -- The next case for the union, relative to the previous
     -- call to this method or to somtGetFirstCaseEntry.
      FUNCTION SOMTUnionEntryC_somtGetNextCaseEntry(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOMTUnionEntryC.somtCaseEntry; 
      PRAGMA interface (assembly, SOMTUnionEntryC_somtGetNextCaseEntry);
      PRAGMA interface_information (SOMTUnionEntryC_somtGetNextCaseEntry, ".xsomcall1");
      Result : ALIASED SOMTUnionEntryC.somtCaseEntry;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTUnionEntryC_somtGetNextCaseEntry (
            Self.som_object,
            SOMTUnionEntryCClassData.somtGetNextCaseEntry);
      RETURN Result;
   END somtGetNextCaseEntry; 

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

END SOMTUnionEntryC; 







