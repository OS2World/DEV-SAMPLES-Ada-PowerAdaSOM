
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:24 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPIdAssignerAbstract;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPIdAssigner IS

   
   -- See poida.csc for the abstract definition of this class.

   TYPE Ref IS NEW SOMPIdAssignerAbstract.Ref WITH NULL RECORD;

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
      


   PROCEDURE sompGetSystemAssignedId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN OUT SOM.SOMObjectPtr);

END SOMPIdAssigner; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPIdAssigner IS

   
   -- See poida.csc for the abstract definition of this class.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPIdAssignerClassData : classData;
   FOR SOMPIdAssignerClassData USE AT standard.system.label("SOMPIdAssignerClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPIdAssignerCClassData : CClassData;
   FOR SOMPIdAssignerCClassData USE AT standard.system.label("SOMPIdAssignerCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPIdAssignerClassData.classObject) 
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
      FUNCTION SOMPIdAssignerNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPIdAssignerNewClass);
      PRAGMA interface_information (SOMPIdAssignerNewClass, ".SOMPIdAssignerNewClass");
   BEGIN
      RETURN SOMPIdAssignerNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPIdAssignerClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPIdAssignerClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompGetSystemAssignedId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN OUT SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIdAssignerAbstract.sompGetSystemAssignedId (
         SOMPIdAssignerAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         id);
   END sompGetSystemAssignedId;

END SOMPIdAssigner; 







