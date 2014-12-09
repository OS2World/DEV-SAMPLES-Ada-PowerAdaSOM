
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:17 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMRNameable IS

   
   --Any object derived from this class would have a string name.

   TYPE Ref IS NEW SOMObject.Ref WITH NULL RECORD;

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
      


   PROCEDURE somrSetObjName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String);
     
     -- Sets the internal pointer to "name" .
     --           The OWNERSHIP of the string is transferred to this object.

   FUNCTION somrGetObjName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Returns a pointer to the name string.
     --          The OWNERSHIP of the string stays with this object.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END SOMRNameable; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMRNameable IS

   
   --Any object derived from this class would have a string name.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somrSetObjName : SOM.somMToken;
      somrGetObjName : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMRNameableClassData : classData;
   FOR SOMRNameableClassData USE AT standard.system.label("SOMRNameableClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMRNameableCClassData : CClassData;
   FOR SOMRNameableCClassData USE AT standard.system.label("SOMRNameableCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMRNameableClassData.classObject) 
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
      FUNCTION SOMRNameableNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMRNameableNewClass);
      PRAGMA interface_information (SOMRNameableNewClass, ".SOMRNameableNewClass");
   BEGIN
      RETURN SOMRNameableNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMRNameableClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMRNameableClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somrSetObjName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String)
   IS
     
     -- Sets the internal pointer to "name" .
     --           The OWNERSHIP of the string is transferred to this object.
      PROCEDURE SOMRNameable_somrSetObjName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRNameable_somrSetObjName);
      PRAGMA interface_information (SOMRNameable_somrSetObjName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRNameable_somrSetObjName (
         Self.som_object,
         Ev,
         name,
         SOMRNameableClassData.somrSetObjName);
   END somrSetObjName;

   FUNCTION somrGetObjName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Returns a pointer to the name string.
     --          The OWNERSHIP of the string stays with this object.
      FUNCTION SOMRNameable_somrGetObjName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMRNameable_somrGetObjName);
      PRAGMA interface_information (SOMRNameable_somrGetObjName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMRNameable_somrGetObjName (
            Self.som_object,
            Ev,
            SOMRNameableClassData.somrGetObjName);
      RETURN Result;
   END somrGetObjName; 

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

   PROCEDURE somUninit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somUninit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somUninit;

END SOMRNameable; 







