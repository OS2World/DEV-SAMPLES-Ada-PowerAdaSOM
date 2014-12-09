
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:21 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTStructEntryC IS


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
      


   FUNCTION somtGetFirstMember (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The first member of the struct.

   FUNCTION somtGetNextMember (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The next member of the struct, relative to the previous call
     -- to this method or somtGetFirstMember.

   FUNCTION get_somtStructClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The class in which the structure was defined.

   FUNCTION get_somtIsException (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether the structure is really an exception.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTStructEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTStructEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtStructClass : SOM.somMToken;
      get_somtIsException : SOM.somMToken;
      somtGetFirstMember : SOM.somMToken;
      somtGetNextMember : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTStructEntryCClassData : classData;
   FOR SOMTStructEntryCClassData USE AT standard.system.label("SOMTStructEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTStructEntryCCClassData : CClassData;
   FOR SOMTStructEntryCCClassData USE AT standard.system.label("SOMTStructEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTStructEntryCClassData.classObject) 
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
      FUNCTION SOMTStructEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTStructEntryCNewClass);
      PRAGMA interface_information (SOMTStructEntryCNewClass, ".SOMTStructEntryCNewClass");
   BEGIN
      RETURN SOMTStructEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTStructEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTStructEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somtGetFirstMember (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The first member of the struct.
      FUNCTION SOMTStructEntryC_somtGetFirstMember(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTStructEntryC_somtGetFirstMember);
      PRAGMA interface_information (SOMTStructEntryC_somtGetFirstMember, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTStructEntryC_somtGetFirstMember (
            Self.som_object,
            SOMTStructEntryCClassData.somtGetFirstMember);
      RETURN Result;
   END somtGetFirstMember; 

   FUNCTION somtGetNextMember (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The next member of the struct, relative to the previous call
     -- to this method or somtGetFirstMember.
      FUNCTION SOMTStructEntryC_somtGetNextMember(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTStructEntryC_somtGetNextMember);
      PRAGMA interface_information (SOMTStructEntryC_somtGetNextMember, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTStructEntryC_somtGetNextMember (
            Self.som_object,
            SOMTStructEntryCClassData.somtGetNextMember);
      RETURN Result;
   END somtGetNextMember; 

   FUNCTION get_somtStructClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The class in which the structure was defined.
      FUNCTION SOMTStructEntryC_U_get_somtStructClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTStructEntryC_U_get_somtStructClass);
      PRAGMA interface_information (SOMTStructEntryC_U_get_somtStructClass, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTStructEntryC_U_get_somtStructClass (
            Self.som_object,
            SOMTStructEntryCClassData.get_somtStructClass);
      RETURN Result;
   END get_somtStructClass; 

   FUNCTION get_somtIsException (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether the structure is really an exception.
      FUNCTION SOMTStructEntryC_U_get_somtIsException(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTStructEntryC_U_get_somtIsException);
      PRAGMA interface_information (SOMTStructEntryC_U_get_somtIsException, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTStructEntryC_U_get_somtIsException (
            Self.som_object,
            SOMTStructEntryCClassData.get_somtIsException);
      RETURN Result;
   END get_somtIsException; 

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

END SOMTStructEntryC; 







