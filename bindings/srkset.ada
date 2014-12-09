
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:55 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPKeyedSet IS

   
   -- A set of objects identified by a key.

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
      


   FUNCTION sompGetFirstObject (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Get first object in this set.
     -- If set is empty, returns NULL.

END SOMPKeyedSet; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPKeyedSet IS

   
   -- A set of objects identified by a key.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompGetFirstObject : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPKeyedSetClassData : classData;
   FOR SOMPKeyedSetClassData USE AT standard.system.label("SOMPKeyedSetClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPKeyedSetCClassData : CClassData;
   FOR SOMPKeyedSetCClassData USE AT standard.system.label("SOMPKeyedSetCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPKeyedSetClassData.classObject) 
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
      FUNCTION SOMPKeyedSetNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPKeyedSetNewClass);
      PRAGMA interface_information (SOMPKeyedSetNewClass, ".SOMPKeyedSetNewClass");
   BEGIN
      RETURN SOMPKeyedSetNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPKeyedSetClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPKeyedSetClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sompGetFirstObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Get first object in this set.
     -- If set is empty, returns NULL.
      FUNCTION SOMPKeyedSet_sompGetFirstObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPKeyedSet_sompGetFirstObject);
      PRAGMA interface_information (SOMPKeyedSet_sompGetFirstObject, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPKeyedSet_sompGetFirstObject (
            Self.som_object,
            Ev,
            SOMPKeyedSetClassData.sompGetFirstObject);
      RETURN Result;
   END sompGetFirstObject; 

END SOMPKeyedSet; 







