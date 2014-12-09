
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:12 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPKeyedSet;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPIOGroup IS

   
   -- An IOGroup is a collection of objects which have been grouped
   -- together with the intention that they will be written/read to/from
   -- a storage media at the same time. For example, the group of objects
   -- could be stored in the same file.
   --
   -- Objects are added, located and removed from the group via an integer
   -- key.

   TYPE Ref IS NEW SOMPKeyedSet.Ref WITH NULL RECORD;

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
      

   SUBTYPE SOMPIOGroupKey IS Corba.Long;


   FUNCTION sompCount (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Returns the number of objects in this group

   FUNCTION sompFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first available object in the group. The object returned
     -- is not based on any ordering, it is simply the one closest at hand.

   FUNCTION sompNewIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns a handle which can be used with the sompNextObjectInGroup
     -- method of this class to iterate through all the objects contained
     -- by an instance of this class.

   FUNCTION sompNextObjectInGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      iteratorHandle : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the next object in the group. If there are no more objects left,
     -- it returns NULL.
     --
     -- Example use:
     --
     -- hit = _sompNewIterator(myGroup)
     -- while (obj = _sompNextObjectInGroup(hit)) {
     --    ...
     --    use obj
     --    ...
     --    }
     -- _sompFreeIterator(hit);

   PROCEDURE sompFreeIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      iteratorHandle : IN SOM.SOMObjectPtr);
     
     -- Free the resources used by the given iterator.

   PROCEDURE sompAddToGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      newObject : IN SOM.SOMObjectPtr;
      key : IN SOMPIOGroup.SOMPIOGroupKey);
     
     -- Adds the given object to this group of objects. The given key for
     -- the new object must be unique among all the other objects in
     -- this group.

   FUNCTION sompRemoveFromGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOMPIOGroup.SOMPIOGroupKey)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove from the group and return the object with the given key value.

   FUNCTION sompFindByKey (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOMPIOGroup.SOMPIOGroupKey)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the object with the given key value.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMPIOGroup; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPIOGroup IS

   
   -- An IOGroup is a collection of objects which have been grouped
   -- together with the intention that they will be written/read to/from
   -- a storage media at the same time. For example, the group of objects
   -- could be stored in the same file.
   --
   -- Objects are added, located and removed from the group via an integer
   -- key.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompGetLastOffset : SOM.somMToken;
      sompGetNextAvailableOffset : SOM.somMToken;
      sompSetLastOffset : SOM.somMToken;
      sompFindById : SOM.somMToken;
      sompSetGroupName : SOM.somMToken;
      sompGetGroupName : SOM.somMToken;
      sompCount : SOM.somMToken;
      sompFirst : SOM.somMToken;
      sompNewIterator : SOM.somMToken;
      sompNextObjectInGroup : SOM.somMToken;
      sompFreeIterator : SOM.somMToken;
      sompAddToGroup : SOM.somMToken;
      sompRemoveFromGroup : SOM.somMToken;
      sompFindByKey : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPIOGroupClassData : classData;
   FOR SOMPIOGroupClassData USE AT standard.system.label("SOMPIOGroupClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPIOGroupCClassData : CClassData;
   FOR SOMPIOGroupCClassData USE AT standard.system.label("SOMPIOGroupCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPIOGroupClassData.classObject) 
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
      FUNCTION SOMPIOGroupNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPIOGroupNewClass);
      PRAGMA interface_information (SOMPIOGroupNewClass, ".SOMPIOGroupNewClass");
   BEGIN
      RETURN SOMPIOGroupNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPIOGroupClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPIOGroupClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sompCount (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Returns the number of objects in this group
      FUNCTION SOMPIOGroup_sompCount(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMPIOGroup_sompCount);
      PRAGMA interface_information (SOMPIOGroup_sompCount, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroup_sompCount (
            Self.som_object,
            Ev,
            SOMPIOGroupClassData.sompCount);
      RETURN Result;
   END sompCount; 

   FUNCTION sompFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first available object in the group. The object returned
     -- is not based on any ordering, it is simply the one closest at hand.
      FUNCTION SOMPIOGroup_sompFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroup_sompFirst);
      PRAGMA interface_information (SOMPIOGroup_sompFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroup_sompFirst (
            Self.som_object,
            Ev,
            SOMPIOGroupClassData.sompFirst);
      RETURN Result;
   END sompFirst; 

   FUNCTION sompNewIterator (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns a handle which can be used with the sompNextObjectInGroup
     -- method of this class to iterate through all the objects contained
     -- by an instance of this class.
      FUNCTION SOMPIOGroup_sompNewIterator(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroup_sompNewIterator);
      PRAGMA interface_information (SOMPIOGroup_sompNewIterator, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroup_sompNewIterator (
            Self.som_object,
            Ev,
            SOMPIOGroupClassData.sompNewIterator);
      RETURN Result;
   END sompNewIterator; 

   FUNCTION sompNextObjectInGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      iteratorHandle : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the next object in the group. If there are no more objects left,
     -- it returns NULL.
     --
     -- Example use:
     --
     -- hit = _sompNewIterator(myGroup)
     -- while (obj = _sompNextObjectInGroup(hit)) {
     --    ...
     --    use obj
     --    ...
     --    }
     -- _sompFreeIterator(hit);
      FUNCTION SOMPIOGroup_sompNextObjectInGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         iteratorHandle : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroup_sompNextObjectInGroup);
      PRAGMA interface_information (SOMPIOGroup_sompNextObjectInGroup, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroup_sompNextObjectInGroup (
            Self.som_object,
            Ev,
            iteratorHandle,
            SOMPIOGroupClassData.sompNextObjectInGroup);
      RETURN Result;
   END sompNextObjectInGroup; 

   PROCEDURE sompFreeIterator (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      iteratorHandle : IN SOM.SOMObjectPtr)
   IS
     
     -- Free the resources used by the given iterator.
      PROCEDURE SOMPIOGroup_sompFreeIterator(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         iteratorHandle : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIOGroup_sompFreeIterator);
      PRAGMA interface_information (SOMPIOGroup_sompFreeIterator, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroup_sompFreeIterator (
         Self.som_object,
         Ev,
         iteratorHandle,
         SOMPIOGroupClassData.sompFreeIterator);
   END sompFreeIterator;

   PROCEDURE sompAddToGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      newObject : IN SOM.SOMObjectPtr; 
      key : IN SOMPIOGroup.SOMPIOGroupKey)
   IS
     
     -- Adds the given object to this group of objects. The given key for
     -- the new object must be unique among all the other objects in
     -- this group.
      PROCEDURE SOMPIOGroup_sompAddToGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         newObject : IN SOM.SOMObjectPtr; 
         key : IN SOMPIOGroup.SOMPIOGroupKey;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIOGroup_sompAddToGroup);
      PRAGMA interface_information (SOMPIOGroup_sompAddToGroup, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroup_sompAddToGroup (
         Self.som_object,
         Ev,
         newObject,
         key,
         SOMPIOGroupClassData.sompAddToGroup);
   END sompAddToGroup;

   FUNCTION sompRemoveFromGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOMPIOGroup.SOMPIOGroupKey)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove from the group and return the object with the given key value.
      FUNCTION SOMPIOGroup_sompRemoveFromGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOMPIOGroup.SOMPIOGroupKey;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroup_sompRemoveFromGroup);
      PRAGMA interface_information (SOMPIOGroup_sompRemoveFromGroup, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroup_sompRemoveFromGroup (
            Self.som_object,
            Ev,
            key,
            SOMPIOGroupClassData.sompRemoveFromGroup);
      RETURN Result;
   END sompRemoveFromGroup; 

   FUNCTION sompFindByKey (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOMPIOGroup.SOMPIOGroupKey)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the object with the given key value.
      FUNCTION SOMPIOGroup_sompFindByKey(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOMPIOGroup.SOMPIOGroupKey;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroup_sompFindByKey);
      PRAGMA interface_information (SOMPIOGroup_sompFindByKey, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroup_sompFindByKey (
            Self.som_object,
            Ev,
            key,
            SOMPIOGroupClassData.sompFindByKey);
      RETURN Result;
   END sompFindByKey; 

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

END SOMPIOGroup; 







