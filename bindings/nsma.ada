
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:18 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPNameSpaceMgr IS

   
   -- This class is responsible for mapping persistent IDs
   -- to persistent objects and groups of objects.
   --
   -- The NameSpaceMgr maintains a set of IO Group objects.
   --
   -- All objects which have been restored by the Persistent Storage Mgr
   -- can be reached by the single instance of the NameSpaceMgr maintained
   -- for the persistence framework. (See psm.csc)

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
      


   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMPNameSpaceMgr; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPNameSpaceMgr IS

   
   -- This class is responsible for mapping persistent IDs
   -- to persistent objects and groups of objects.
   --
   -- The NameSpaceMgr maintains a set of IO Group objects.
   --
   -- All objects which have been restored by the Persistent Storage Mgr
   -- can be reached by the single instance of the NameSpaceMgr maintained
   -- for the persistence framework. (See psm.csc)

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompFindPersistentObjectById : SOM.somMToken;
      sompFindGroupById : SOM.somMToken;
      sompRegisterGroup : SOM.somMToken;
      sompUnRegisterGroup : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPNameSpaceMgrClassData : classData;
   FOR SOMPNameSpaceMgrClassData USE AT standard.system.label("SOMPNameSpaceMgrClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPNameSpaceMgrCClassData : CClassData;
   FOR SOMPNameSpaceMgrCClassData USE AT standard.system.label("SOMPNameSpaceMgrCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPNameSpaceMgrClassData.classObject) 
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
      FUNCTION SOMPNameSpaceMgrNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPNameSpaceMgrNewClass);
      PRAGMA interface_information (SOMPNameSpaceMgrNewClass, ".SOMPNameSpaceMgrNewClass");
   BEGIN
      RETURN SOMPNameSpaceMgrNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPNameSpaceMgrClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPNameSpaceMgrClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


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

END SOMPNameSpaceMgr; 







