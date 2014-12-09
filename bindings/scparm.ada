
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:20 1997
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

PACKAGE SOMTParameterEntryC IS


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
      


   FUNCTION get_somtParameterDirection (
      Self : IN Ref)
      RETURN SCTypes.somtParameterDirectionT;
     
     -- The direction for this parameter. (somtInE, somtOutE, or somtInOutE).

   FUNCTION get_somtIDLParameterDeclaration (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The IDL declaration of the parameter, including the type and name.

   FUNCTION get_somtCParameterDeclaration (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The declaration for the parameter within a C method procedure prototype.
     -- It includes the parameter's type and name.
     -- This may differ from the parameter's IDL declaration.
     -- In particular, pointer stars may be added.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTParameterEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTParameterEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtParameterDirection : SOM.somMToken;
      get_somtCParameterDeclaration : SOM.somMToken;
      get_somtIDLParameterDeclaration : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTParameterEntryCClassData : classData;
   FOR SOMTParameterEntryCClassData USE AT standard.system.label("SOMTParameterEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTParameterEntryCCClassData : CClassData;
   FOR SOMTParameterEntryCCClassData USE AT standard.system.label("SOMTParameterEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTParameterEntryCClassData.classObject) 
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
      FUNCTION SOMTParameterEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTParameterEntryCNewClass);
      PRAGMA interface_information (SOMTParameterEntryCNewClass, ".SOMTParameterEntryCNewClass");
   BEGIN
      RETURN SOMTParameterEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTParameterEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTParameterEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtParameterDirection (
      Self : IN Ref)
      RETURN SCTypes.somtParameterDirectionT
   IS
     
     -- The direction for this parameter. (somtInE, somtOutE, or somtInOutE).
      FUNCTION SOMTParameterEntryC_U_get_somtParameterDirection(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.somtParameterDirectionT; 
      PRAGMA interface (assembly, SOMTParameterEntryC_U_get_somtParameterDirection);
      PRAGMA interface_information (SOMTParameterEntryC_U_get_somtParameterDirection, ".xsomcall1");
      Result : ALIASED SCTypes.somtParameterDirectionT;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTParameterEntryC_U_get_somtParameterDirection (
            Self.som_object,
            SOMTParameterEntryCClassData.get_somtParameterDirection);
      RETURN Result;
   END get_somtParameterDirection; 

   FUNCTION get_somtIDLParameterDeclaration (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The IDL declaration of the parameter, including the type and name.
      FUNCTION SOMTParameterEntryC_U_get_somtIDLParameterDeclaration(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTParameterEntryC_U_get_somtIDLParameterDeclaration);
      PRAGMA interface_information (SOMTParameterEntryC_U_get_somtIDLParameterDeclaration, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTParameterEntryC_U_get_somtIDLParameterDeclaration (
            Self.som_object,
            SOMTParameterEntryCClassData.get_somtIDLParameterDeclaration);
      RETURN Result;
   END get_somtIDLParameterDeclaration; 

   FUNCTION get_somtCParameterDeclaration (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The declaration for the parameter within a C method procedure prototype.
     -- It includes the parameter's type and name.
     -- This may differ from the parameter's IDL declaration.
     -- In particular, pointer stars may be added.
      FUNCTION SOMTParameterEntryC_U_get_somtCParameterDeclaration(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTParameterEntryC_U_get_somtCParameterDeclaration);
      PRAGMA interface_information (SOMTParameterEntryC_U_get_somtCParameterDeclaration, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTParameterEntryC_U_get_somtCParameterDeclaration (
            Self.som_object,
            SOMTParameterEntryCClassData.get_somtCParameterDeclaration);
      RETURN Result;
   END get_somtCParameterDeclaration; 

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

END SOMTParameterEntryC; 







