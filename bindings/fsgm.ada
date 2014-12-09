
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:09 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPAscii;
WITH SOMPIOGroupMgrAbstract;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPBinary IS

   
   -- This is an IO Group Manager class which writes groups of objects
   -- in a format similar to class SOMPAscii execept that this
   -- class stores numeric data in binary.

   TYPE Ref IS NEW SOMPAscii.Ref WITH NULL RECORD;

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
      


   FUNCTION sompInstantiateMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

END SOMPBinary; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPBinary IS

   
   -- This is an IO Group Manager class which writes groups of objects
   -- in a format similar to class SOMPAscii execept that this
   -- class stores numeric data in binary.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPBinaryClassData : classData;
   FOR SOMPBinaryClassData USE AT standard.system.label("SOMPBinaryClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPBinaryCClassData : CClassData;
   FOR SOMPBinaryCClassData USE AT standard.system.label("SOMPBinaryCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPBinaryClassData.classObject) 
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
      FUNCTION SOMPBinaryNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPBinaryNewClass);
      PRAGMA interface_information (SOMPBinaryNewClass, ".SOMPBinaryNewClass");
   BEGIN
      RETURN SOMPBinaryNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPBinaryClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPBinaryClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sompInstantiateMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompInstantiateMediaInterface (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev);
   END sompInstantiateMediaInterface;

END SOMPBinary; 







