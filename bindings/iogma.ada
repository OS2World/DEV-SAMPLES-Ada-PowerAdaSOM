
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:11 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPIOGroupMgrAbstract IS

   
   -- This is the abstract class for an IO Group Manager object.  An IO Group
   -- Manager is a class which is used by the Persistent Storage Manager
   -- (see psm.sc) for storing/restoring persistent objects and groups of
   -- persistent objects.
   --
   -- An IO Group Manager object is the principle object which knows the
   -- stored format of a group of objects stored on some media.  The IO
   -- Group Manager does not know how an individual object is formatted.
   -- The stored format of an individual object is known only by the
   -- encoder/decoder for that object. The encoder/decoder for an object
   -- is invoked by the IO Group Manager.
   --
   -- There may be many IO Group Managers available in the system. The
   -- IO Group Manager which is used to store a given persistent object is
   -- determined by the persistent ID (see pid.sc) of that object. The
   -- class name of the IO Group Manager is part of the persistent ID.

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
      


   PROCEDURE sompNewMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IOInfo : IN Corba.String);
     
     -- Gets a new Media Interface for this IO Group Mgr and prepares it
     -- for I/O.  This method must be called prior to calling any of the
     -- other methods of this class since other methods rely on the media
     -- interface.

   FUNCTION sompGetMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns this group's media interface. If sompNewMediaInterface
     -- has not been called first, this method returns NULL.
     -- This method also returns NULL after (the last) sompFreeMediaInterface.

   PROCEDURE sompFreeMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Frees this IOGroup Mgr's media interface.

   FUNCTION sompInstantiateMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Override this if you want to change the MediaInterface
     -- this IOGroupMananager uses to write out IO Groups.

   FUNCTION sompWriteGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisPo : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Store the object and everything grouped with it or just store
     -- the object given. It is the choice of the IO Group Mgr implementor.
     --
     -- To store the object and all the others grouped with,
     -- invoke _sompGetIOGroup(thisPo) to get the group and then
     -- iterate across the group, storing each object. If a group is
     -- stored this method must return TRUE.
     -- Note:
     -- Only objects in the IO Group which have been marked as "dirty"
     -- should be stored. (See po.idl for methods to get the state of a
     -- persistent object.)
     --
     -- If the IO Group Mgr is written to store only the given object,
     -- this method must return FALSE.
     --
     -- OLD INTERFACE...
     -- void sompWriteGroup(in SOMPIOGroup thisGroup) raises(SOMPError::sompException);

   FUNCTION sompReadGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- At the very least, this method will instantiate the persistent object which
     -- is specified by the given objectID and return that object. This method
     -- may be implemented to instantiate all the objects stored in the same group
     -- as the specified object. It may restore objects and mark them as
     -- SOMP_STATE_STABLE, however this is typically accomplished via the
     -- sompReadObjectData.
     -- The returned object is NULL if an error is encountered and
     -- an exception is raised.
     -- OLD INTERFACE...
     -- SOMPIOGroup sompReadGroup(in string IOInfo) raises(SOMPError::sompException);
     -- Restores the IO Group with the name given in <IOInfo>.
     -- The instance data of the objects in the IO Group is not read.
     -- The returned IO Group is NULL if an error is encountered and
     -- an exception is raised.

   PROCEDURE sompReadObjectData (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisPo : IN SOM.SOMObjectPtr);
     
     -- Read the given persistent object's data from storage.

   FUNCTION sompGroupExists (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IOInfo : IN Corba.String)
      RETURN Corba.Boolean;
     
     -- See if the IO Group with the name given in <IOInfo> exists in persistent
     -- storage. Returns TRUE if group exists, FALSE otherwise.

   FUNCTION sompObjectInGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- See if the persisent object specified by <objectID> is in the group.
     -- If so, return TRUE, otherwise FALSE.

   FUNCTION sompMediaFormatOk (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaFormatName : IN Corba.String)
      RETURN Corba.Boolean;
     
     -- Check to see if the given mediaFormatName is supported by this
     -- IO Group Manager. If it is, returns TRUE, otherwise returns FALSE.

   PROCEDURE sompDeleteObjectFromGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr);
     
     -- Delete the persisent object specified by <objectID>.

END SOMPIOGroupMgrAbstract; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPIOGroupMgrAbstract IS

   
   -- This is the abstract class for an IO Group Manager object.  An IO Group
   -- Manager is a class which is used by the Persistent Storage Manager
   -- (see psm.sc) for storing/restoring persistent objects and groups of
   -- persistent objects.
   --
   -- An IO Group Manager object is the principle object which knows the
   -- stored format of a group of objects stored on some media.  The IO
   -- Group Manager does not know how an individual object is formatted.
   -- The stored format of an individual object is known only by the
   -- encoder/decoder for that object. The encoder/decoder for an object
   -- is invoked by the IO Group Manager.
   --
   -- There may be many IO Group Managers available in the system. The
   -- IO Group Manager which is used to store a given persistent object is
   -- determined by the persistent ID (see pid.sc) of that object. The
   -- class name of the IO Group Manager is part of the persistent ID.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompNewMediaInterface : SOM.somMToken;
      sompGetMediaInterface : SOM.somMToken;
      sompFreeMediaInterface : SOM.somMToken;
      sompInstantiateMediaInterface : SOM.somMToken;
      sompWriteGroup : SOM.somMToken;
      sompReadGroup : SOM.somMToken;
      sompReadObjectData : SOM.somMToken;
      sompGroupExists : SOM.somMToken;
      sompObjectInGroup : SOM.somMToken;
      sompMediaFormatOk : SOM.somMToken;
      sompDeleteObjectFromGroup : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPIOGroupMgrAbstractClassData : classData;
   FOR SOMPIOGroupMgrAbstractClassData USE AT standard.system.label("SOMPIOGroupMgrAbstractClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPIOGroupMgrAbstractCClassData : CClassData;
   FOR SOMPIOGroupMgrAbstractCClassData USE AT standard.system.label("SOMPIOGroupMgrAbstractCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPIOGroupMgrAbstractClassData.classObject) 
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
      FUNCTION SOMPIOGroupMgrAbstractNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPIOGroupMgrAbstractNewClass);
      PRAGMA interface_information (SOMPIOGroupMgrAbstractNewClass, ".SOMPIOGroupMgrAbstractNewClass");
   BEGIN
      RETURN SOMPIOGroupMgrAbstractNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPIOGroupMgrAbstractClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPIOGroupMgrAbstractClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompNewMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IOInfo : IN Corba.String)
   IS
     
     -- Gets a new Media Interface for this IO Group Mgr and prepares it
     -- for I/O.  This method must be called prior to calling any of the
     -- other methods of this class since other methods rely on the media
     -- interface.
      PROCEDURE SOMPIOGroupMgrAbstract_sompNewMediaInterface(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IOInfo : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompNewMediaInterface);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompNewMediaInterface, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract_sompNewMediaInterface (
         Self.som_object,
         Ev,
         IOInfo,
         SOMPIOGroupMgrAbstractClassData.sompNewMediaInterface);
   END sompNewMediaInterface;

   FUNCTION sompGetMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns this group's media interface. If sompNewMediaInterface
     -- has not been called first, this method returns NULL.
     -- This method also returns NULL after (the last) sompFreeMediaInterface.
      FUNCTION SOMPIOGroupMgrAbstract_sompGetMediaInterface(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompGetMediaInterface);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompGetMediaInterface, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompGetMediaInterface (
            Self.som_object,
            Ev,
            SOMPIOGroupMgrAbstractClassData.sompGetMediaInterface);
      RETURN Result;
   END sompGetMediaInterface; 

   PROCEDURE sompFreeMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Frees this IOGroup Mgr's media interface.
      PROCEDURE SOMPIOGroupMgrAbstract_sompFreeMediaInterface(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompFreeMediaInterface);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompFreeMediaInterface, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract_sompFreeMediaInterface (
         Self.som_object,
         Ev,
         SOMPIOGroupMgrAbstractClassData.sompFreeMediaInterface);
   END sompFreeMediaInterface;

   FUNCTION sompInstantiateMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Override this if you want to change the MediaInterface
     -- this IOGroupMananager uses to write out IO Groups.
      FUNCTION SOMPIOGroupMgrAbstract_sompInstantiateMediaInterface(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompInstantiateMediaInterface);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompInstantiateMediaInterface, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompInstantiateMediaInterface (
            Self.som_object,
            Ev,
            SOMPIOGroupMgrAbstractClassData.sompInstantiateMediaInterface);
      RETURN Result;
   END sompInstantiateMediaInterface; 

   FUNCTION sompWriteGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisPo : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Store the object and everything grouped with it or just store
     -- the object given. It is the choice of the IO Group Mgr implementor.
     --
     -- To store the object and all the others grouped with,
     -- invoke _sompGetIOGroup(thisPo) to get the group and then
     -- iterate across the group, storing each object. If a group is
     -- stored this method must return TRUE.
     -- Note:
     -- Only objects in the IO Group which have been marked as "dirty"
     -- should be stored. (See po.idl for methods to get the state of a
     -- persistent object.)
     --
     -- If the IO Group Mgr is written to store only the given object,
     -- this method must return FALSE.
     --
     -- OLD INTERFACE...
     -- void sompWriteGroup(in SOMPIOGroup thisGroup) raises(SOMPError::sompException);
      FUNCTION SOMPIOGroupMgrAbstract_sompWriteGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisPo : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompWriteGroup);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompWriteGroup, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompWriteGroup (
            Self.som_object,
            Ev,
            thisPo,
            SOMPIOGroupMgrAbstractClassData.sompWriteGroup);
      RETURN Result;
   END sompWriteGroup; 

   FUNCTION sompReadGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- At the very least, this method will instantiate the persistent object which
     -- is specified by the given objectID and return that object. This method
     -- may be implemented to instantiate all the objects stored in the same group
     -- as the specified object. It may restore objects and mark them as
     -- SOMP_STATE_STABLE, however this is typically accomplished via the
     -- sompReadObjectData.
     -- The returned object is NULL if an error is encountered and
     -- an exception is raised.
     -- OLD INTERFACE...
     -- SOMPIOGroup sompReadGroup(in string IOInfo) raises(SOMPError::sompException);
     -- Restores the IO Group with the name given in <IOInfo>.
     -- The instance data of the objects in the IO Group is not read.
     -- The returned IO Group is NULL if an error is encountered and
     -- an exception is raised.
      FUNCTION SOMPIOGroupMgrAbstract_sompReadGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompReadGroup);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompReadGroup, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompReadGroup (
            Self.som_object,
            Ev,
            objectID,
            SOMPIOGroupMgrAbstractClassData.sompReadGroup);
      RETURN Result;
   END sompReadGroup; 

   PROCEDURE sompReadObjectData (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisPo : IN SOM.SOMObjectPtr)
   IS
     
     -- Read the given persistent object's data from storage.
      PROCEDURE SOMPIOGroupMgrAbstract_sompReadObjectData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisPo : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompReadObjectData);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompReadObjectData, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract_sompReadObjectData (
         Self.som_object,
         Ev,
         thisPo,
         SOMPIOGroupMgrAbstractClassData.sompReadObjectData);
   END sompReadObjectData;

   FUNCTION sompGroupExists (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IOInfo : IN Corba.String)
      RETURN Corba.Boolean
   IS
     
     -- See if the IO Group with the name given in <IOInfo> exists in persistent
     -- storage. Returns TRUE if group exists, FALSE otherwise.
      FUNCTION SOMPIOGroupMgrAbstract_sompGroupExists(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IOInfo : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompGroupExists);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompGroupExists, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompGroupExists (
            Self.som_object,
            Ev,
            IOInfo,
            SOMPIOGroupMgrAbstractClassData.sompGroupExists);
      RETURN Result;
   END sompGroupExists; 

   FUNCTION sompObjectInGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- See if the persisent object specified by <objectID> is in the group.
     -- If so, return TRUE, otherwise FALSE.
      FUNCTION SOMPIOGroupMgrAbstract_sompObjectInGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompObjectInGroup);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompObjectInGroup, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompObjectInGroup (
            Self.som_object,
            Ev,
            objectID,
            SOMPIOGroupMgrAbstractClassData.sompObjectInGroup);
      RETURN Result;
   END sompObjectInGroup; 

   FUNCTION sompMediaFormatOk (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaFormatName : IN Corba.String)
      RETURN Corba.Boolean
   IS
     
     -- Check to see if the given mediaFormatName is supported by this
     -- IO Group Manager. If it is, returns TRUE, otherwise returns FALSE.
      FUNCTION SOMPIOGroupMgrAbstract_sompMediaFormatOk(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mediaFormatName : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompMediaFormatOk);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompMediaFormatOk, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPIOGroupMgrAbstract_sompMediaFormatOk (
            Self.som_object,
            Ev,
            mediaFormatName,
            SOMPIOGroupMgrAbstractClassData.sompMediaFormatOk);
      RETURN Result;
   END sompMediaFormatOk; 

   PROCEDURE sompDeleteObjectFromGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
   IS
     
     -- Delete the persisent object specified by <objectID>.
      PROCEDURE SOMPIOGroupMgrAbstract_sompDeleteObjectFromGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objectID : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPIOGroupMgrAbstract_sompDeleteObjectFromGroup);
      PRAGMA interface_information (SOMPIOGroupMgrAbstract_sompDeleteObjectFromGroup, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract_sompDeleteObjectFromGroup (
         Self.som_object,
         Ev,
         objectID,
         SOMPIOGroupMgrAbstractClassData.sompDeleteObjectFromGroup);
   END sompDeleteObjectFromGroup;

END SOMPIOGroupMgrAbstract; 







