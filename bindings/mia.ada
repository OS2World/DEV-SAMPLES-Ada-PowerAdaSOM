
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:14 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPMediaInterfaceAbstract IS

   
   -- This is the abstract class definition for an interface to
   -- some media.

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
      


   PROCEDURE sompOpen (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Open the media interface.

   PROCEDURE sompClose (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Close the media interface.

END SOMPMediaInterfaceAbstract; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPMediaInterfaceAbstract IS

   
   -- This is the abstract class definition for an interface to
   -- some media.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompOpen : SOM.somMToken;
      sompClose : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPMediaInterfaceAbstractClassData : classData;
   FOR SOMPMediaInterfaceAbstractClassData USE AT standard.system.label("SOMPMediaInterfaceAbstractClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPMediaInterfaceAbstractCClassData : CClassData;
   FOR SOMPMediaInterfaceAbstractCClassData USE AT standard.system.label("SOMPMediaInterfaceAbstractCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPMediaInterfaceAbstractClassData.classObject) 
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
      FUNCTION SOMPMediaInterfaceAbstractNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPMediaInterfaceAbstractNewClass);
      PRAGMA interface_information (SOMPMediaInterfaceAbstractNewClass, ".SOMPMediaInterfaceAbstractNewClass");
   BEGIN
      RETURN SOMPMediaInterfaceAbstractNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPMediaInterfaceAbstractClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPMediaInterfaceAbstractClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompOpen (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Open the media interface.
      PROCEDURE SOMPMediaInterfaceAbstract_sompOpen(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPMediaInterfaceAbstract_sompOpen);
      PRAGMA interface_information (SOMPMediaInterfaceAbstract_sompOpen, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPMediaInterfaceAbstract_sompOpen (
         Self.som_object,
         Ev,
         SOMPMediaInterfaceAbstractClassData.sompOpen);
   END sompOpen;

   PROCEDURE sompClose (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Close the media interface.
      PROCEDURE SOMPMediaInterfaceAbstract_sompClose(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPMediaInterfaceAbstract_sompClose);
      PRAGMA interface_information (SOMPMediaInterfaceAbstract_sompClose, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPMediaInterfaceAbstract_sompClose (
         Self.som_object,
         Ev,
         SOMPMediaInterfaceAbstractClassData.sompClose);
   END sompClose;

END SOMPMediaInterfaceAbstract; 







