
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:19 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTModuleEntryC IS


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
      


   FUNCTION get_somtOuterModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The module enclosing this module, or NULL if there is none.

   FUNCTION get_somtModuleFile (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The name of the file in which the module appears.

   FUNCTION somtGetFirstModuleStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModuleTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModuleUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModuleEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModuleConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModuleSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstInterface (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextInterface (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstModuleDef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextModuleDef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTModuleEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTModuleEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtOuterModule : SOM.somMToken;
      somtGetFirstModuleStruct : SOM.somMToken;
      somtGetNextModuleStruct : SOM.somMToken;
      somtGetFirstModuleTypedef : SOM.somMToken;
      somtGetNextModuleTypedef : SOM.somMToken;
      somtGetFirstModuleUnion : SOM.somMToken;
      somtGetNextModuleUnion : SOM.somMToken;
      somtGetFirstModuleEnum : SOM.somMToken;
      somtGetNextModuleEnum : SOM.somMToken;
      somtGetFirstModuleConstant : SOM.somMToken;
      somtGetNextModuleConstant : SOM.somMToken;
      somtGetFirstModuleSequence : SOM.somMToken;
      somtGetNextModuleSequence : SOM.somMToken;
      somtGetFirstInterface : SOM.somMToken;
      somtGetNextInterface : SOM.somMToken;
      somtGetFirstModule : SOM.somMToken;
      somtGetNextModule : SOM.somMToken;
      somtGetFirstModuleDef : SOM.somMToken;
      somtGetNextModuleDef : SOM.somMToken;
      get_somtModuleFile : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTModuleEntryCClassData : classData;
   FOR SOMTModuleEntryCClassData USE AT standard.system.label("SOMTModuleEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTModuleEntryCCClassData : CClassData;
   FOR SOMTModuleEntryCCClassData USE AT standard.system.label("SOMTModuleEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTModuleEntryCClassData.classObject) 
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
      FUNCTION SOMTModuleEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTModuleEntryCNewClass);
      PRAGMA interface_information (SOMTModuleEntryCNewClass, ".SOMTModuleEntryCNewClass");
   BEGIN
      RETURN SOMTModuleEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTModuleEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTModuleEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtOuterModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The module enclosing this module, or NULL if there is none.
      FUNCTION SOMTModuleEntryC_U_get_somtOuterModule(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_U_get_somtOuterModule);
      PRAGMA interface_information (SOMTModuleEntryC_U_get_somtOuterModule, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_U_get_somtOuterModule (
            Self.som_object,
            SOMTModuleEntryCClassData.get_somtOuterModule);
      RETURN Result;
   END get_somtOuterModule; 

   FUNCTION get_somtModuleFile (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The name of the file in which the module appears.
      FUNCTION SOMTModuleEntryC_U_get_somtModuleFile(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTModuleEntryC_U_get_somtModuleFile);
      PRAGMA interface_information (SOMTModuleEntryC_U_get_somtModuleFile, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_U_get_somtModuleFile (
            Self.som_object,
            SOMTModuleEntryCClassData.get_somtModuleFile);
      RETURN Result;
   END get_somtModuleFile; 

   FUNCTION somtGetFirstModuleStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleStruct(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleStruct);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleStruct, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleStruct (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleStruct);
      RETURN Result;
   END somtGetFirstModuleStruct; 

   FUNCTION somtGetNextModuleStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleStruct(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleStruct);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleStruct, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleStruct (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleStruct);
      RETURN Result;
   END somtGetNextModuleStruct; 

   FUNCTION somtGetFirstModuleTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleTypedef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleTypedef);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleTypedef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleTypedef (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleTypedef);
      RETURN Result;
   END somtGetFirstModuleTypedef; 

   FUNCTION somtGetNextModuleTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleTypedef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleTypedef);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleTypedef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleTypedef (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleTypedef);
      RETURN Result;
   END somtGetNextModuleTypedef; 

   FUNCTION somtGetFirstModuleUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleUnion(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleUnion);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleUnion, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleUnion (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleUnion);
      RETURN Result;
   END somtGetFirstModuleUnion; 

   FUNCTION somtGetNextModuleUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleUnion(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleUnion);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleUnion, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleUnion (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleUnion);
      RETURN Result;
   END somtGetNextModuleUnion; 

   FUNCTION somtGetFirstModuleEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleEnum(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleEnum);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleEnum, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleEnum (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleEnum);
      RETURN Result;
   END somtGetFirstModuleEnum; 

   FUNCTION somtGetNextModuleEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleEnum(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleEnum);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleEnum, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleEnum (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleEnum);
      RETURN Result;
   END somtGetNextModuleEnum; 

   FUNCTION somtGetFirstModuleConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleConstant(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleConstant);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleConstant, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleConstant (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleConstant);
      RETURN Result;
   END somtGetFirstModuleConstant; 

   FUNCTION somtGetNextModuleConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleConstant(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleConstant);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleConstant, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleConstant (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleConstant);
      RETURN Result;
   END somtGetNextModuleConstant; 

   FUNCTION somtGetFirstModuleSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleSequence(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleSequence);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleSequence, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleSequence (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleSequence);
      RETURN Result;
   END somtGetFirstModuleSequence; 

   FUNCTION somtGetNextModuleSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleSequence(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleSequence);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleSequence, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleSequence (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleSequence);
      RETURN Result;
   END somtGetNextModuleSequence; 

   FUNCTION somtGetFirstInterface (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstInterface(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstInterface);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstInterface, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstInterface (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstInterface);
      RETURN Result;
   END somtGetFirstInterface; 

   FUNCTION somtGetNextInterface (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextInterface(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextInterface);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextInterface, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextInterface (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextInterface);
      RETURN Result;
   END somtGetNextInterface; 

   FUNCTION somtGetFirstModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModule(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModule);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModule, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModule (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModule);
      RETURN Result;
   END somtGetFirstModule; 

   FUNCTION somtGetNextModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModule(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModule);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModule, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModule (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModule);
      RETURN Result;
   END somtGetNextModule; 

   FUNCTION somtGetFirstModuleDef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetFirstModuleDef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetFirstModuleDef);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetFirstModuleDef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetFirstModuleDef (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetFirstModuleDef);
      RETURN Result;
   END somtGetFirstModuleDef; 

   FUNCTION somtGetNextModuleDef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTModuleEntryC_somtGetNextModuleDef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTModuleEntryC_somtGetNextModuleDef);
      PRAGMA interface_information (SOMTModuleEntryC_somtGetNextModuleDef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTModuleEntryC_somtGetNextModuleDef (
            Self.som_object,
            SOMTModuleEntryCClassData.somtGetNextModuleDef);
      RETURN Result;
   END somtGetNextModuleDef; 

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

END SOMTModuleEntryC; 







