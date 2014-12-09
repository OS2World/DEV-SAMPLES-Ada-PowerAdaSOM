
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:12 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTAttributeEntryC IS


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
      


   FUNCTION get_somtIsReadonly (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether the attribute is readonly.

   FUNCTION get_somtAttribType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The type of the attribute.  This does not include pointer stars
     -- or array declarators.  To get the "full" type, get each attribute
     -- declarator and get the somtType attribute.

   FUNCTION somtGetFirstAttributeDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The first attribute declarator for this attribute declaration.

   FUNCTION somtGetNextAttributeDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The next attribute declarator for this attribute declaration,
     -- relative to the previous call to this method or
     -- somtGetFirstAttributeDeclarator.

   FUNCTION somtGetFirstGetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The first get method for this attribute declaration.

   FUNCTION somtGetNextGetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The next get method for this attribute declaration,
     -- relative to the previous call to this method or
     -- somtGetFirstGetMethod.

   FUNCTION somtGetFirstSetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The first set method for this attribute declaration.

   FUNCTION somtGetNextSetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The next set method for this attribute declaration,
     -- relative to the previous call to this method or
     -- somtGetFirstSetMethod.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTAttributeEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTAttributeEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtIsReadonly : SOM.somMToken;
      get_somtAttribType : SOM.somMToken;
      somtGetFirstAttributeDeclarator : SOM.somMToken;
      somtGetNextAttributeDeclarator : SOM.somMToken;
      somtGetFirstGetMethod : SOM.somMToken;
      somtGetNextGetMethod : SOM.somMToken;
      somtGetFirstSetMethod : SOM.somMToken;
      somtGetNextSetMethod : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTAttributeEntryCClassData : classData;
   FOR SOMTAttributeEntryCClassData USE AT standard.system.label("SOMTAttributeEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTAttributeEntryCCClassData : CClassData;
   FOR SOMTAttributeEntryCCClassData USE AT standard.system.label("SOMTAttributeEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTAttributeEntryCClassData.classObject) 
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
      FUNCTION SOMTAttributeEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTAttributeEntryCNewClass);
      PRAGMA interface_information (SOMTAttributeEntryCNewClass, ".SOMTAttributeEntryCNewClass");
   BEGIN
      RETURN SOMTAttributeEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTAttributeEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTAttributeEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtIsReadonly (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether the attribute is readonly.
      FUNCTION SOMTAttributeEntryC_U_get_somtIsReadonly(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_U_get_somtIsReadonly);
      PRAGMA interface_information (SOMTAttributeEntryC_U_get_somtIsReadonly, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_U_get_somtIsReadonly (
            Self.som_object,
            SOMTAttributeEntryCClassData.get_somtIsReadonly);
      RETURN Result;
   END get_somtIsReadonly; 

   FUNCTION get_somtAttribType (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The type of the attribute.  This does not include pointer stars
     -- or array declarators.  To get the "full" type, get each attribute
     -- declarator and get the somtType attribute.
      FUNCTION SOMTAttributeEntryC_U_get_somtAttribType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_U_get_somtAttribType);
      PRAGMA interface_information (SOMTAttributeEntryC_U_get_somtAttribType, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_U_get_somtAttribType (
            Self.som_object,
            SOMTAttributeEntryCClassData.get_somtAttribType);
      RETURN Result;
   END get_somtAttribType; 

   FUNCTION somtGetFirstAttributeDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The first attribute declarator for this attribute declaration.
      FUNCTION SOMTAttributeEntryC_somtGetFirstAttributeDeclarator(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_somtGetFirstAttributeDeclarator);
      PRAGMA interface_information (SOMTAttributeEntryC_somtGetFirstAttributeDeclarator, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_somtGetFirstAttributeDeclarator (
            Self.som_object,
            SOMTAttributeEntryCClassData.somtGetFirstAttributeDeclarator);
      RETURN Result;
   END somtGetFirstAttributeDeclarator; 

   FUNCTION somtGetNextAttributeDeclarator (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The next attribute declarator for this attribute declaration,
     -- relative to the previous call to this method or
     -- somtGetFirstAttributeDeclarator.
      FUNCTION SOMTAttributeEntryC_somtGetNextAttributeDeclarator(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_somtGetNextAttributeDeclarator);
      PRAGMA interface_information (SOMTAttributeEntryC_somtGetNextAttributeDeclarator, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_somtGetNextAttributeDeclarator (
            Self.som_object,
            SOMTAttributeEntryCClassData.somtGetNextAttributeDeclarator);
      RETURN Result;
   END somtGetNextAttributeDeclarator; 

   FUNCTION somtGetFirstGetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The first get method for this attribute declaration.
      FUNCTION SOMTAttributeEntryC_somtGetFirstGetMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_somtGetFirstGetMethod);
      PRAGMA interface_information (SOMTAttributeEntryC_somtGetFirstGetMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_somtGetFirstGetMethod (
            Self.som_object,
            SOMTAttributeEntryCClassData.somtGetFirstGetMethod);
      RETURN Result;
   END somtGetFirstGetMethod; 

   FUNCTION somtGetNextGetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The next get method for this attribute declaration,
     -- relative to the previous call to this method or
     -- somtGetFirstGetMethod.
      FUNCTION SOMTAttributeEntryC_somtGetNextGetMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_somtGetNextGetMethod);
      PRAGMA interface_information (SOMTAttributeEntryC_somtGetNextGetMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_somtGetNextGetMethod (
            Self.som_object,
            SOMTAttributeEntryCClassData.somtGetNextGetMethod);
      RETURN Result;
   END somtGetNextGetMethod; 

   FUNCTION somtGetFirstSetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The first set method for this attribute declaration.
      FUNCTION SOMTAttributeEntryC_somtGetFirstSetMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_somtGetFirstSetMethod);
      PRAGMA interface_information (SOMTAttributeEntryC_somtGetFirstSetMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_somtGetFirstSetMethod (
            Self.som_object,
            SOMTAttributeEntryCClassData.somtGetFirstSetMethod);
      RETURN Result;
   END somtGetFirstSetMethod; 

   FUNCTION somtGetNextSetMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The next set method for this attribute declaration,
     -- relative to the previous call to this method or
     -- somtGetFirstSetMethod.
      FUNCTION SOMTAttributeEntryC_somtGetNextSetMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTAttributeEntryC_somtGetNextSetMethod);
      PRAGMA interface_information (SOMTAttributeEntryC_somtGetNextSetMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTAttributeEntryC_somtGetNextSetMethod (
            Self.som_object,
            SOMTAttributeEntryCClassData.somtGetNextSetMethod);
      RETURN Result;
   END somtGetNextSetMethod; 

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

END SOMTAttributeEntryC; 







