
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:24 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPIdAssignerAbstract IS

   
   -- This is the abstract contract for an ID Assigner. The ID in
   -- this case is an ID for a persistent object. An ID Assigner is
   -- used at the time a persistent object is initialized.

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
      


   PROCEDURE sompGetSystemAssignedId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN OUT SOM.SOMObjectPtr);
     
     --
     -- Assign a system ID.
     -- Input: Pointer to persistent ID object
     -- Output: Returns nonzero error if ID could not be assigned,
     --         otherwise, returns 0.
     --         This method allocates the ID object.
     --         Freeing the storage space is the
     --         responsibility of the persistent object (po.c) at uninit.

END SOMPIdAssignerAbstract; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPIdAssignerAbstract IS

   
   -- This is the abstract contract for an ID Assigner. The ID in
   -- this case is an ID for a persistent object. An ID Assigner is
   -- used at the time a persistent object is initialized.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompGetSystemAssignedId : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPIdAssignerAbstractClassData : classData;
   FOR SOMPIdAssignerAbstractClassData USE AT standard.system.label("SOMPIdAssignerAbstractClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPIdAssignerAbstractCClassData : CClassData;
   FOR SOMPIdAssignerAbstractCClassData USE AT standard.system.label("SOMPIdAssignerAbstractCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPIdAssignerAbstractClassData.classObject) 
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
      FUNCTION SOMPIdAssignerAbstractNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPIdAssignerAbstractNewClass);
      PRAGMA interface_information (SOMPIdAssignerAbstractNewClass, ".SOMPIdAssignerAbstractNewClass");
   BEGIN
      RETURN SOMPIdAssignerAbstractNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPIdAssignerAbstractClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPIdAssignerAbstractClassData.classObject));
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
     
     --
     -- Assign a system ID.
     -- Input: Pointer to persistent ID object
     -- Output: Returns nonzero error if ID could not be assigned,
     --         otherwise, returns 0.
     --         This method allocates the ID object.
     --         Freeing the storage space is the
     --         responsibility of the persistent object (po.c) at uninit.
      PROCEDURE SOMPIdAssignerAbstract_sompGetSystemAssignedId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         id : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIdAssignerAbstract_sompGetSystemAssignedId);
      PRAGMA interface_information (SOMPIdAssignerAbstract_sompGetSystemAssignedId, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIdAssignerAbstract_sompGetSystemAssignedId (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(id'address),
         SOMPIdAssignerAbstractClassData.sompGetSystemAssignedId);
   END sompGetSystemAssignedId;

END SOMPIdAssignerAbstract; 







