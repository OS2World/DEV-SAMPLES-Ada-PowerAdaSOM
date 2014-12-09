
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:52 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMMBeforeAfter;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMRReplicable IS

   
   --
   --

   TYPE Ref IS NEW SOMMBeforeAfter.Ref WITH NULL RECORD;

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
      


   FUNCTION sommBeforeMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      object : IN SOM.SOMObjectPtr;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Boolean;

   PROCEDURE sommAfterMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      object : IN SOM.SOMObjectPtr;
      methodId : IN SOM.somId;
      returnedvalue : IN SOM.somToken;
      ap : IN SOM.va_list);

END SOMRReplicable; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMRReplicable IS

   
   --
   --

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMRReplicableClassData : classData;
   FOR SOMRReplicableClassData USE AT standard.system.label("SOMRReplicableClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMRReplicableCClassData : CClassData;
   FOR SOMRReplicableCClassData USE AT standard.system.label("SOMRReplicableCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMRReplicableClassData.classObject) 
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
      FUNCTION SOMRReplicableNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMRReplicableNewClass);
      PRAGMA interface_information (SOMRReplicableNewClass, ".SOMRReplicableNewClass");
   BEGIN
      RETURN SOMRReplicableNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMRReplicableClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMRReplicableClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sommBeforeMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      object : IN SOM.SOMObjectPtr; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMMBeforeAfter.sommBeforeMethod (
            SOMMBeforeAfter.Ref'(som_object=>Self.som_object),
            Ev,
            object,
            methodId,
            ap);
   END sommBeforeMethod;

   PROCEDURE sommAfterMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      object : IN SOM.SOMObjectPtr; 
      methodId : IN SOM.somId; 
      returnedvalue : IN SOM.somToken; 
      ap : IN SOM.va_list)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMMBeforeAfter.sommAfterMethod (
         SOMMBeforeAfter.Ref'(som_object=>Self.som_object),
         Ev,
         object,
         methodId,
         returnedvalue,
         ap);
   END sommAfterMethod;

END SOMRReplicable; 







