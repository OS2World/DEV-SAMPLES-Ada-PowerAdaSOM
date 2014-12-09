
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:25 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPPersistentStorageMgr IS

   
   -- The Persistent Storage Manager is the primary interface for clients
   -- of the Persistence Framework to read and write persistent objects
   -- to/from storage.
   --
   -- Only a single instance of this class exists in the Persistence Framework
   -- by virtue of the metaclass SOMMSingleInstance.

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
      

   SOMP_STORING_ON : CONSTANT Corba.Unsigned_Short := 3;

   SOMP_STORING_OFF : CONSTANT Corba.Unsigned_Short := 4;

   SOMP_RESTORING_ON : CONSTANT Corba.Unsigned_Short := 5;

   SOMP_RESTORING_OFF : CONSTANT Corba.Unsigned_Short := 6;


   PROCEDURE sompStoreObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisObject : IN SOM.SOMObjectPtr);
     
     -- Stores a persistent object and all its persistent children.

   FUNCTION sompRestoreObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Restores an object and its children.
     -- If error, returns NULL.

   PROCEDURE sompStoreObjectWithoutChildren (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisObject : IN SOM.SOMObjectPtr);
     
     -- Stores a persistent object.

   FUNCTION sompRestoreObjectWithoutChildren (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Restores an object to a stable state.
     -- If error, returns NULL.

   PROCEDURE sompDeleteObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr);
     
     -- Delete the given persistent object.
     --
     -- If the object is an in-memory object only, it is removed from the Name
     -- Space Mgr and its in-memory IO Group object and then freed.  If the
     -- object also previously existed in a stored IO Group, then the stored
     -- IO Group is modified to indicate that the object has been removed.

   FUNCTION sompObjectExists (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Checks to see if object exists.  If so, returns TRUE otherwise
     -- returns FALSE.

   PROCEDURE sompAddObjectToWriteSet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisObject : IN SOM.SOMObjectPtr);
     
     -- Adds the given object to the set of objects being written by
     -- sompStoreObject. An error occurs if this method is called
     -- before sompStoreObject is called.
     --
     -- This method provides a way for an object's encoder/decoder to add
     -- a persistent object to the set to be written. This is useful for saving
     -- persistent child objects which were not "registered" with their
     -- parent object.

   PROCEDURE sompAddIdToReadSet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr);
     
     -- This method adds the given persistent ID to the set of ID's which
     -- represent the persistent object's to be restored by
     -- sompRestoreObject.  If an error occurs the ID is not added to the read set.
     --
     -- ID's can only be added to the read set following a call to
     -- sompRestoreObject. It is expected that encoder/decoder
     -- writers will make use of this method when restoring child objects.
     -- For example:
     --    1) decoder reads object ID in string form
     --    2) decoder creates persistent ID object based on string
     --    3) decoder calls sompAddIdToReadSet with the persistent ID.

   FUNCTION sompRestoreObjectFromIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      idString : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Instantiate a persistent ID from the given string and then restore
     -- the object and its children.
     -- If error, returns NULL.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END SOMPPersistentStorageMgr; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPPersistentStorageMgr IS

   
   -- The Persistent Storage Manager is the primary interface for clients
   -- of the Persistence Framework to read and write persistent objects
   -- to/from storage.
   --
   -- Only a single instance of this class exists in the Persistence Framework
   -- by virtue of the metaclass SOMMSingleInstance.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompStoreObject : SOM.somMToken;
      sompRestoreObject : SOM.somMToken;
      sompStoreObjectWithoutChildren : SOM.somMToken;
      sompRestoreObjectWithoutChildren : SOM.somMToken;
      sompDeleteObject : SOM.somMToken;
      sompObjectExists : SOM.somMToken;
      sompAddObjectToWriteSet : SOM.somMToken;
      sompRestoreObjectToNameSpace : SOM.somMToken;
      sompAddIdToReadSet : SOM.somMToken;
      sompRestoreStableObject : SOM.somMToken;
      sompAddRegisteredChildrenToReadSet : SOM.somMToken;
      sompPrepareWriteSet : SOM.somMToken;
      sompStoreWriteSet : SOM.somMToken;
      sompAddChildIfNecessary : SOM.somMToken;
      sompRemoveIOGroupFromSet : SOM.somMToken;
      sompRestoreObjectFromIdString : SOM.somMToken;
      sompSetPSMFlags : SOM.somMToken;
      sompRemoveObjectFromSet : SOM.somMToken;
      sompNewGroupMgr : SOM.somMToken;
      sompPSMInitThreadData : SOM.somMToken;
      sompPSMUninitThreadData : SOM.somMToken;
      sompPSMGetThreadData : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPPersistentStorageMgrClassData : classData;
   FOR SOMPPersistentStorageMgrClassData USE AT standard.system.label("SOMPPersistentStorageMgrClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPPersistentStorageMgrCClassData : CClassData;
   FOR SOMPPersistentStorageMgrCClassData USE AT standard.system.label("SOMPPersistentStorageMgrCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPPersistentStorageMgrClassData.classObject) 
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
      FUNCTION SOMPPersistentStorageMgrNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPPersistentStorageMgrNewClass);
      PRAGMA interface_information (SOMPPersistentStorageMgrNewClass, ".SOMPPersistentStorageMgrNewClass");
   BEGIN
      RETURN SOMPPersistentStorageMgrNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPPersistentStorageMgrClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPPersistentStorageMgrClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompStoreObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
     
     -- Stores a persistent object and all its persistent children.
      PROCEDURE SOMPPersistentStorageMgr_sompStoreObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompStoreObject);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompStoreObject, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentStorageMgr_sompStoreObject (
         Self.som_object,
         Ev,
         thisObject,
         SOMPPersistentStorageMgrClassData.sompStoreObject);
   END sompStoreObject;

   FUNCTION sompRestoreObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Restores an object and its children.
     -- If error, returns NULL.
      FUNCTION SOMPPersistentStorageMgr_sompRestoreObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompRestoreObject);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompRestoreObject, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentStorageMgr_sompRestoreObject (
            Self.som_object,
            Ev,
            objectID,
            SOMPPersistentStorageMgrClassData.sompRestoreObject);
      RETURN Result;
   END sompRestoreObject; 

   PROCEDURE sompStoreObjectWithoutChildren (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
     
     -- Stores a persistent object.
      PROCEDURE SOMPPersistentStorageMgr_sompStoreObjectWithoutChildren(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompStoreObjectWithoutChildren);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompStoreObjectWithoutChildren, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentStorageMgr_sompStoreObjectWithoutChildren (
         Self.som_object,
         Ev,
         thisObject,
         SOMPPersistentStorageMgrClassData.sompStoreObjectWithoutChildren);
   END sompStoreObjectWithoutChildren;

   FUNCTION sompRestoreObjectWithoutChildren (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Restores an object to a stable state.
     -- If error, returns NULL.
      FUNCTION SOMPPersistentStorageMgr_sompRestoreObjectWithoutChildren(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompRestoreObjectWithoutChildren);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompRestoreObjectWithoutChildren, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentStorageMgr_sompRestoreObjectWithoutChildren (
            Self.som_object,
            Ev,
            objectID,
            SOMPPersistentStorageMgrClassData.sompRestoreObjectWithoutChildren);
      RETURN Result;
   END sompRestoreObjectWithoutChildren; 

   PROCEDURE sompDeleteObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
   IS
     
     -- Delete the given persistent object.
     --
     -- If the object is an in-memory object only, it is removed from the Name
     -- Space Mgr and its in-memory IO Group object and then freed.  If the
     -- object also previously existed in a stored IO Group, then the stored
     -- IO Group is modified to indicate that the object has been removed.
      PROCEDURE SOMPPersistentStorageMgr_sompDeleteObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompDeleteObject);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompDeleteObject, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentStorageMgr_sompDeleteObject (
         Self.som_object,
         Ev,
         objectID,
         SOMPPersistentStorageMgrClassData.sompDeleteObject);
   END sompDeleteObject;

   FUNCTION sompObjectExists (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Checks to see if object exists.  If so, returns TRUE otherwise
     -- returns FALSE.
      FUNCTION SOMPPersistentStorageMgr_sompObjectExists(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompObjectExists);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompObjectExists, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentStorageMgr_sompObjectExists (
            Self.som_object,
            Ev,
            objectID,
            SOMPPersistentStorageMgrClassData.sompObjectExists);
      RETURN Result;
   END sompObjectExists; 

   PROCEDURE sompAddObjectToWriteSet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
     
     -- Adds the given object to the set of objects being written by
     -- sompStoreObject. An error occurs if this method is called
     -- before sompStoreObject is called.
     --
     -- This method provides a way for an object's encoder/decoder to add
     -- a persistent object to the set to be written. This is useful for saving
     -- persistent child objects which were not "registered" with their
     -- parent object.
      PROCEDURE SOMPPersistentStorageMgr_sompAddObjectToWriteSet(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompAddObjectToWriteSet);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompAddObjectToWriteSet, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentStorageMgr_sompAddObjectToWriteSet (
         Self.som_object,
         Ev,
         thisObject,
         SOMPPersistentStorageMgrClassData.sompAddObjectToWriteSet);
   END sompAddObjectToWriteSet;

   PROCEDURE sompAddIdToReadSet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
   IS
     
     -- This method adds the given persistent ID to the set of ID's which
     -- represent the persistent object's to be restored by
     -- sompRestoreObject.  If an error occurs the ID is not added to the read set.
     --
     -- ID's can only be added to the read set following a call to
     -- sompRestoreObject. It is expected that encoder/decoder
     -- writers will make use of this method when restoring child objects.
     -- For example:
     --    1) decoder reads object ID in string form
     --    2) decoder creates persistent ID object based on string
     --    3) decoder calls sompAddIdToReadSet with the persistent ID.
      PROCEDURE SOMPPersistentStorageMgr_sompAddIdToReadSet(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompAddIdToReadSet);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompAddIdToReadSet, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentStorageMgr_sompAddIdToReadSet (
         Self.som_object,
         Ev,
         objectID,
         SOMPPersistentStorageMgrClassData.sompAddIdToReadSet);
   END sompAddIdToReadSet;

   FUNCTION sompRestoreObjectFromIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      idString : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Instantiate a persistent ID from the given string and then restore
     -- the object and its children.
     -- If error, returns NULL.
      FUNCTION SOMPPersistentStorageMgr_sompRestoreObjectFromIdString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         idString : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentStorageMgr_sompRestoreObjectFromIdString);
      PRAGMA interface_information (SOMPPersistentStorageMgr_sompRestoreObjectFromIdString, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentStorageMgr_sompRestoreObjectFromIdString (
            Self.som_object,
            Ev,
            idString,
            SOMPPersistentStorageMgrClassData.sompRestoreObjectFromIdString);
      RETURN Result;
   END sompRestoreObjectFromIdString; 

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

END SOMPPersistentStorageMgr; 







