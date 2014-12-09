
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:22 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMTCommonEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTTypedefEntryC IS


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
      


   FUNCTION get_somtTypedefType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The type of the typedef. This does not include pointer stars or
     -- array declarators.   These must be obtained by examining each
     -- of the declarators.

   FUNCTION somtGetFirstDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The first declarator for this typedef.
     -- Declarators of struct members will be instances of SOMTDataEntryC,
     -- while declarators of typedefs will be instances of SOMTUserDefinedTypeEntryC.

   FUNCTION somtGetNextDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The next declarator for this typedef, relative to the previous
     -- call to this method or somtGetFirstDeclarator.
     -- Declarators of struct members will be instances of SOMTDataEntryC,
     -- while declarators of typedefs will be instances of SOMTUserDefinedTypeEntryC.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTTypedefEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTTypedefEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtTypedefType : SOM.somMToken;
      somtGetFirstDeclarator : SOM.somMToken;
      somtGetNextDeclarator : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTTypedefEntryCClassData : classData;
   FOR SOMTTypedefEntryCClassData USE AT standard.system.label("SOMTTypedefEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTTypedefEntryCCClassData : CClassData;
   FOR SOMTTypedefEntryCCClassData USE AT standard.system.label("SOMTTypedefEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTTypedefEntryCClassData.classObject) 
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
      FUNCTION SOMTTypedefEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTTypedefEntryCNewClass);
      PRAGMA interface_information (SOMTTypedefEntryCNewClass, ".SOMTTypedefEntryCNewClass");
   BEGIN
      RETURN SOMTTypedefEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTTypedefEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTTypedefEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtTypedefType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The type of the typedef. This does not include pointer stars or
     -- array declarators.   These must be obtained by examining each
     -- of the declarators.
      FUNCTION SOMTTypedefEntryC_U_get_somtTypedefType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTTypedefEntryC_U_get_somtTypedefType);
      PRAGMA interface_information (SOMTTypedefEntryC_U_get_somtTypedefType, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTypedefEntryC_U_get_somtTypedefType (
            Self.som_object,
            SOMTTypedefEntryCClassData.get_somtTypedefType);
      RETURN Result;
   END get_somtTypedefType; 

   FUNCTION somtGetFirstDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The first declarator for this typedef.
     -- Declarators of struct members will be instances of SOMTDataEntryC,
     -- while declarators of typedefs will be instances of SOMTUserDefinedTypeEntryC.
      FUNCTION SOMTTypedefEntryC_somtGetFirstDeclarator(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTTypedefEntryC_somtGetFirstDeclarator);
      PRAGMA interface_information (SOMTTypedefEntryC_somtGetFirstDeclarator, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTypedefEntryC_somtGetFirstDeclarator (
            Self.som_object,
            SOMTTypedefEntryCClassData.somtGetFirstDeclarator);
      RETURN Result;
   END somtGetFirstDeclarator; 

   FUNCTION somtGetNextDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The next declarator for this typedef, relative to the previous
     -- call to this method or somtGetFirstDeclarator.
     -- Declarators of struct members will be instances of SOMTDataEntryC,
     -- while declarators of typedefs will be instances of SOMTUserDefinedTypeEntryC.
      FUNCTION SOMTTypedefEntryC_somtGetNextDeclarator(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTTypedefEntryC_somtGetNextDeclarator);
      PRAGMA interface_information (SOMTTypedefEntryC_somtGetNextDeclarator, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTypedefEntryC_somtGetNextDeclarator (
            Self.som_object,
            SOMTTypedefEntryCClassData.somtGetNextDeclarator);
      RETURN Result;
   END somtGetNextDeclarator; 

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

END SOMTTypedefEntryC; 







