
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:23 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPPersistentObject IS


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
      

   SOMP_STATE_UNDEFINED : CONSTANT Corba.Unsigned_Short := 32768;

   SOMP_STATE_UNSTABLE : CONSTANT Corba.Unsigned_Short := 16384;

   SOMP_STATE_STABLE : CONSTANT Corba.Unsigned_Short := 4096;

   SOMP_STATE_DIRTY : CONSTANT Corba.Unsigned_Short := 2048;

   SOMP_STATE_COMPACT : CONSTANT Corba.Unsigned_Short := 1024;


   PROCEDURE sompInitNextAvail (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisAssigner : IN SOM.SOMObjectPtr);

   PROCEDURE sompInitNearObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      nearObject : IN SOM.SOMObjectPtr);

   PROCEDURE sompInitGivenId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisId : IN SOM.SOMObjectPtr);

   FUNCTION sompGetPersistentId (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION sompGetPersistentIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      outBuff : IN Corba.String)
      RETURN Corba.String;
     
     -- Get persistent ID. Returns string representation of persistent ID.
     -- Puts the fully-qualified persistent object ID in the caller-supplied
     -- buffer.  (The caller must allocate the memory for the buffer, and
     -- is also responsible for freeing it when appropriate.)

   PROCEDURE sompSetEncoderDecoderName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      myName : IN Corba.String);
     
     -- Set the class name of the EncoderDecoder.
     -- If this method is not called, the encoder/decoder class name is the
     -- one returned by the class object.

   FUNCTION sompGetEncoderDecoderName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Get the class name of the EncoderDecoder

   FUNCTION sompEquals (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Checks to see if this object's ID is equivalent to the given ID.
     -- Returns TRUE if the ID's are equivalent, FALSE otherwise.

   PROCEDURE sompPassivate (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- This method is called by the persistence framework just prior
     -- to saving a persistent object.  It provides a means for a
     -- client to tidy up any data necessary in the persistent object
     -- (or its embedded objects) before the save operation is
     -- completed.  This method does nothing if not overridden by the
     -- client.

   PROCEDURE sompActivated (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- This method is called by the persistence framework after a
     -- persistent object is restored.  It provides a means for a client
     -- to perform any initializations prior to the use of the persistent
     -- object. That is, make the object useable. If not overridden, this
     -- method sets the state of the object to POSTATE_STABLE.

   FUNCTION sompGetRelativeIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      ifNearThisObject : IN SOM.SOMObjectPtr;
      relativeIdString : IN Corba.String)
      RETURN Corba.String;
     
     -- if the persistent object is in the same IOGroup as <ifNearThisObject>,
     -- places an Id string of the form:
     --
     --            <IOGroupMgrClassName>:$RELATIVE:<offset>
     --
     -- in relativeIdString, else places a fully-qualified Id of the form:
     --
     --            <IOGroupMgrClassName>:<path/filename>:<offset>
     --
     -- in relativeIdString.  Returns pointer to relativeIdString through the
     -- operation name.  Note: the caller must allocate relativeIdString prior
     -- to invoking the operation.

   FUNCTION sompInitIOGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      nearPersistentObj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the IO group for this object. (Used at InitPersistentID time)
     -- Each persistent object is a member of an I/O Group. An I/O Group
     -- can consist of one or more persistent objects.
     --
     -- The I/O Group in which this persistent object is a member is
     -- determined by the "nearPersistentObj" argument.
     -- If given nearPersistentObj is NULL, a new IOGroup may be instantiated.
     -- Otherwise, nearPersistentObj is expected to be a persistent object with
     -- an existing IOGroup. This object is made a member of the
     -- nearPersistentObj I/O Group.
     --
     -- An I/O Group offset is assigned by this method. This offset may
     -- be returned via sompGetPersistentOffset on the ID of this object.

   PROCEDURE sompSetDirty (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Sets the state of an object to dirty.  Front method for SetState.

   FUNCTION sompIsDirty (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- This is used for optimization.  The default always returns TRUE.  Optimized
     -- persistent objects can override this to return sompGetDirty(), and then
     -- be sure to invoke sompSetDirty() whenever the object is updated.

   FUNCTION sompGetDirty (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- This returns TRUE if the dirty bit is set, FALSE otherwise.

   PROCEDURE sompMarkForCompaction (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Note to the Persistence Framework that the next time this object is
     -- saved, the entire IO Group should be compacted, if possible.

   PROCEDURE sompSetState (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      state : IN Corba.Unsigned_Short);
     
     -- Sets specified state.
     -- See po.csc for a description of the possible states.

   FUNCTION sompCheckState (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      state : IN Corba.Unsigned_Short)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if given state is true for this object.
     -- See po.csc for a description of the possible states.

   PROCEDURE sompClearState (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      state : IN Corba.Unsigned_Short);
     
     -- Clears specified state.

   FUNCTION sompGetEncoderDecoder (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- If an Encoder/Decoder has not already been instantiated, one
     -- is instantiated. A pointer to the encoder/decoder is
     -- returned. NULL is returned if this object's encoder/decoder
     -- cannot be instantiated.  This method should only be used by the IO Group
     -- Mgr class.

   PROCEDURE sompFreeEncoderDecoder (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Free this object's encoder/decoder. This method should only be used
     -- by the IO Group Manager class.

   FUNCTION sompGetIOGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Get a pointer to the IOGroup collection object for this object.
     -- Within the returned collection are this object and any objects
     -- initialized near it (with sompInitNearObject). This method is intended
     -- to be use by IO Group Mgr implementors.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END SOMPPersistentObject; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPPersistentObject IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompInitNextAvail : SOM.somMToken;
      sompInitNearObject : SOM.somMToken;
      sompInitGivenId : SOM.somMToken;
      sompGetPersistentId : SOM.somMToken;
      sompGetPersistentIdString : SOM.somMToken;
      sompSetEncoderDecoderName : SOM.somMToken;
      sompGetEncoderDecoderName : SOM.somMToken;
      sompRegisterPersistentPointer : SOM.somMToken;
      sompUnRegisterPersistentPointer : SOM.somMToken;
      sompPersistentPointerCount : SOM.somMToken;
      sompGetNthPersistentPointer : SOM.somMToken;
      sompEquals : SOM.somMToken;
      sompPassivate : SOM.somMToken;
      sompActivated : SOM.somMToken;
      sompGetRelativeIdString : SOM.somMToken;
      sompUnInitIOGroup : SOM.somMToken;
      sompSetDirty : SOM.somMToken;
      sompMarkForCompaction : SOM.somMToken;
      sompSetState : SOM.somMToken;
      sompCheckState : SOM.somMToken;
      sompClearState : SOM.somMToken;
      sompInitIOGroup : SOM.somMToken;
      sompGetEncoderDecoder : SOM.somMToken;
      sompFreeEncoderDecoder : SOM.somMToken;
      sompGetIOGroup : SOM.somMToken;
      sompSetIOGroup : SOM.somMToken;
      sompGetStoredLength : SOM.somMToken;
      sompSetStoredLength : SOM.somMToken;
      sompGetMIOffset : SOM.somMToken;
      sompSetMIOffset : SOM.somMToken;
      sompIsDirty : SOM.somMToken;
      sompGetDirty : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPPersistentObjectClassData : classData;
   FOR SOMPPersistentObjectClassData USE AT standard.system.label("SOMPPersistentObjectClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPPersistentObjectCClassData : CClassData;
   FOR SOMPPersistentObjectCClassData USE AT standard.system.label("SOMPPersistentObjectCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPPersistentObjectClassData.classObject) 
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
      FUNCTION SOMPPersistentObjectNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPPersistentObjectNewClass);
      PRAGMA interface_information (SOMPPersistentObjectNewClass, ".SOMPPersistentObjectNewClass");
   BEGIN
      RETURN SOMPPersistentObjectNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPPersistentObjectClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPPersistentObjectClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompInitNextAvail (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisAssigner : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMPPersistentObject_sompInitNextAvail(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisAssigner : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompInitNextAvail);
      PRAGMA interface_information (SOMPPersistentObject_sompInitNextAvail, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompInitNextAvail (
         Self.som_object,
         Ev,
         thisAssigner,
         SOMPPersistentObjectClassData.sompInitNextAvail);
   END sompInitNextAvail;

   PROCEDURE sompInitNearObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      nearObject : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMPPersistentObject_sompInitNearObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         nearObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompInitNearObject);
      PRAGMA interface_information (SOMPPersistentObject_sompInitNearObject, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompInitNearObject (
         Self.som_object,
         Ev,
         nearObject,
         SOMPPersistentObjectClassData.sompInitNearObject);
   END sompInitNearObject;

   PROCEDURE sompInitGivenId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisId : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMPPersistentObject_sompInitGivenId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisId : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompInitGivenId);
      PRAGMA interface_information (SOMPPersistentObject_sompInitGivenId, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompInitGivenId (
         Self.som_object,
         Ev,
         thisId,
         SOMPPersistentObjectClassData.sompInitGivenId);
   END sompInitGivenId;

   FUNCTION sompGetPersistentId (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMPPersistentObject_sompGetPersistentId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetPersistentId);
      PRAGMA interface_information (SOMPPersistentObject_sompGetPersistentId, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetPersistentId (
            Self.som_object,
            Ev,
            SOMPPersistentObjectClassData.sompGetPersistentId);
      RETURN Result;
   END sompGetPersistentId; 

   FUNCTION sompGetPersistentIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      outBuff : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Get persistent ID. Returns string representation of persistent ID.
     -- Puts the fully-qualified persistent object ID in the caller-supplied
     -- buffer.  (The caller must allocate the memory for the buffer, and
     -- is also responsible for freeing it when appropriate.)
      FUNCTION SOMPPersistentObject_sompGetPersistentIdString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         outBuff : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetPersistentIdString);
      PRAGMA interface_information (SOMPPersistentObject_sompGetPersistentIdString, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetPersistentIdString (
            Self.som_object,
            Ev,
            outBuff,
            SOMPPersistentObjectClassData.sompGetPersistentIdString);
      RETURN Result;
   END sompGetPersistentIdString; 

   PROCEDURE sompSetEncoderDecoderName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      myName : IN Corba.String)
   IS
     
     -- Set the class name of the EncoderDecoder.
     -- If this method is not called, the encoder/decoder class name is the
     -- one returned by the class object.
      PROCEDURE SOMPPersistentObject_sompSetEncoderDecoderName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         myName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompSetEncoderDecoderName);
      PRAGMA interface_information (SOMPPersistentObject_sompSetEncoderDecoderName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompSetEncoderDecoderName (
         Self.som_object,
         Ev,
         myName,
         SOMPPersistentObjectClassData.sompSetEncoderDecoderName);
   END sompSetEncoderDecoderName;

   FUNCTION sompGetEncoderDecoderName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Get the class name of the EncoderDecoder
      FUNCTION SOMPPersistentObject_sompGetEncoderDecoderName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetEncoderDecoderName);
      PRAGMA interface_information (SOMPPersistentObject_sompGetEncoderDecoderName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetEncoderDecoderName (
            Self.som_object,
            Ev,
            SOMPPersistentObjectClassData.sompGetEncoderDecoderName);
      RETURN Result;
   END sompGetEncoderDecoderName; 

   FUNCTION sompEquals (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Checks to see if this object's ID is equivalent to the given ID.
     -- Returns TRUE if the ID's are equivalent, FALSE otherwise.
      FUNCTION SOMPPersistentObject_sompEquals(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         otherId : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompEquals);
      PRAGMA interface_information (SOMPPersistentObject_sompEquals, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompEquals (
            Self.som_object,
            Ev,
            otherId,
            SOMPPersistentObjectClassData.sompEquals);
      RETURN Result;
   END sompEquals; 

   PROCEDURE sompPassivate (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- This method is called by the persistence framework just prior
     -- to saving a persistent object.  It provides a means for a
     -- client to tidy up any data necessary in the persistent object
     -- (or its embedded objects) before the save operation is
     -- completed.  This method does nothing if not overridden by the
     -- client.
      PROCEDURE SOMPPersistentObject_sompPassivate(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompPassivate);
      PRAGMA interface_information (SOMPPersistentObject_sompPassivate, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompPassivate (
         Self.som_object,
         Ev,
         SOMPPersistentObjectClassData.sompPassivate);
   END sompPassivate;

   PROCEDURE sompActivated (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- This method is called by the persistence framework after a
     -- persistent object is restored.  It provides a means for a client
     -- to perform any initializations prior to the use of the persistent
     -- object. That is, make the object useable. If not overridden, this
     -- method sets the state of the object to POSTATE_STABLE.
      PROCEDURE SOMPPersistentObject_sompActivated(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompActivated);
      PRAGMA interface_information (SOMPPersistentObject_sompActivated, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompActivated (
         Self.som_object,
         Ev,
         SOMPPersistentObjectClassData.sompActivated);
   END sompActivated;

   FUNCTION sompGetRelativeIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      ifNearThisObject : IN SOM.SOMObjectPtr; 
      relativeIdString : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- if the persistent object is in the same IOGroup as <ifNearThisObject>,
     -- places an Id string of the form:
     --
     --            <IOGroupMgrClassName>:$RELATIVE:<offset>
     --
     -- in relativeIdString, else places a fully-qualified Id of the form:
     --
     --            <IOGroupMgrClassName>:<path/filename>:<offset>
     --
     -- in relativeIdString.  Returns pointer to relativeIdString through the
     -- operation name.  Note: the caller must allocate relativeIdString prior
     -- to invoking the operation.
      FUNCTION SOMPPersistentObject_sompGetRelativeIdString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         ifNearThisObject : IN SOM.SOMObjectPtr; 
         relativeIdString : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetRelativeIdString);
      PRAGMA interface_information (SOMPPersistentObject_sompGetRelativeIdString, ".xsomcall4");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetRelativeIdString (
            Self.som_object,
            Ev,
            ifNearThisObject,
            relativeIdString,
            SOMPPersistentObjectClassData.sompGetRelativeIdString);
      RETURN Result;
   END sompGetRelativeIdString; 

   FUNCTION sompInitIOGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      nearPersistentObj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the IO group for this object. (Used at InitPersistentID time)
     -- Each persistent object is a member of an I/O Group. An I/O Group
     -- can consist of one or more persistent objects.
     --
     -- The I/O Group in which this persistent object is a member is
     -- determined by the "nearPersistentObj" argument.
     -- If given nearPersistentObj is NULL, a new IOGroup may be instantiated.
     -- Otherwise, nearPersistentObj is expected to be a persistent object with
     -- an existing IOGroup. This object is made a member of the
     -- nearPersistentObj I/O Group.
     --
     -- An I/O Group offset is assigned by this method. This offset may
     -- be returned via sompGetPersistentOffset on the ID of this object.
      FUNCTION SOMPPersistentObject_sompInitIOGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         nearPersistentObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompInitIOGroup);
      PRAGMA interface_information (SOMPPersistentObject_sompInitIOGroup, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompInitIOGroup (
            Self.som_object,
            Ev,
            nearPersistentObj,
            SOMPPersistentObjectClassData.sompInitIOGroup);
      RETURN Result;
   END sompInitIOGroup; 

   PROCEDURE sompSetDirty (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Sets the state of an object to dirty.  Front method for SetState.
      PROCEDURE SOMPPersistentObject_sompSetDirty(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompSetDirty);
      PRAGMA interface_information (SOMPPersistentObject_sompSetDirty, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompSetDirty (
         Self.som_object,
         Ev,
         SOMPPersistentObjectClassData.sompSetDirty);
   END sompSetDirty;

   FUNCTION sompIsDirty (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- This is used for optimization.  The default always returns TRUE.  Optimized
     -- persistent objects can override this to return sompGetDirty(), and then
     -- be sure to invoke sompSetDirty() whenever the object is updated.
      FUNCTION SOMPPersistentObject_sompIsDirty(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompIsDirty);
      PRAGMA interface_information (SOMPPersistentObject_sompIsDirty, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompIsDirty (
            Self.som_object,
            Ev,
            SOMPPersistentObjectClassData.sompIsDirty);
      RETURN Result;
   END sompIsDirty; 

   FUNCTION sompGetDirty (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- This returns TRUE if the dirty bit is set, FALSE otherwise.
      FUNCTION SOMPPersistentObject_sompGetDirty(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetDirty);
      PRAGMA interface_information (SOMPPersistentObject_sompGetDirty, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetDirty (
            Self.som_object,
            Ev,
            SOMPPersistentObjectClassData.sompGetDirty);
      RETURN Result;
   END sompGetDirty; 

   PROCEDURE sompMarkForCompaction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Note to the Persistence Framework that the next time this object is
     -- saved, the entire IO Group should be compacted, if possible.
      PROCEDURE SOMPPersistentObject_sompMarkForCompaction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompMarkForCompaction);
      PRAGMA interface_information (SOMPPersistentObject_sompMarkForCompaction, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompMarkForCompaction (
         Self.som_object,
         Ev,
         SOMPPersistentObjectClassData.sompMarkForCompaction);
   END sompMarkForCompaction;

   PROCEDURE sompSetState (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      state : IN Corba.Unsigned_Short)
   IS
     
     -- Sets specified state.
     -- See po.csc for a description of the possible states.
      PROCEDURE SOMPPersistentObject_sompSetState(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         state : IN Corba.Unsigned_Short;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompSetState);
      PRAGMA interface_information (SOMPPersistentObject_sompSetState, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompSetState (
         Self.som_object,
         Ev,
         state,
         SOMPPersistentObjectClassData.sompSetState);
   END sompSetState;

   FUNCTION sompCheckState (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      state : IN Corba.Unsigned_Short)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if given state is true for this object.
     -- See po.csc for a description of the possible states.
      FUNCTION SOMPPersistentObject_sompCheckState(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         state : IN Corba.Unsigned_Short;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompCheckState);
      PRAGMA interface_information (SOMPPersistentObject_sompCheckState, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompCheckState (
            Self.som_object,
            Ev,
            state,
            SOMPPersistentObjectClassData.sompCheckState);
      RETURN Result;
   END sompCheckState; 

   PROCEDURE sompClearState (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      state : IN Corba.Unsigned_Short)
   IS
     
     -- Clears specified state.
      PROCEDURE SOMPPersistentObject_sompClearState(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         state : IN Corba.Unsigned_Short;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompClearState);
      PRAGMA interface_information (SOMPPersistentObject_sompClearState, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompClearState (
         Self.som_object,
         Ev,
         state,
         SOMPPersistentObjectClassData.sompClearState);
   END sompClearState;

   FUNCTION sompGetEncoderDecoder (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- If an Encoder/Decoder has not already been instantiated, one
     -- is instantiated. A pointer to the encoder/decoder is
     -- returned. NULL is returned if this object's encoder/decoder
     -- cannot be instantiated.  This method should only be used by the IO Group
     -- Mgr class.
      FUNCTION SOMPPersistentObject_sompGetEncoderDecoder(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetEncoderDecoder);
      PRAGMA interface_information (SOMPPersistentObject_sompGetEncoderDecoder, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetEncoderDecoder (
            Self.som_object,
            Ev,
            SOMPPersistentObjectClassData.sompGetEncoderDecoder);
      RETURN Result;
   END sompGetEncoderDecoder; 

   PROCEDURE sompFreeEncoderDecoder (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Free this object's encoder/decoder. This method should only be used
     -- by the IO Group Manager class.
      PROCEDURE SOMPPersistentObject_sompFreeEncoderDecoder(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentObject_sompFreeEncoderDecoder);
      PRAGMA interface_information (SOMPPersistentObject_sompFreeEncoderDecoder, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentObject_sompFreeEncoderDecoder (
         Self.som_object,
         Ev,
         SOMPPersistentObjectClassData.sompFreeEncoderDecoder);
   END sompFreeEncoderDecoder;

   FUNCTION sompGetIOGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Get a pointer to the IOGroup collection object for this object.
     -- Within the returned collection are this object and any objects
     -- initialized near it (with sompInitNearObject). This method is intended
     -- to be use by IO Group Mgr implementors.
      FUNCTION SOMPPersistentObject_sompGetIOGroup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPPersistentObject_sompGetIOGroup);
      PRAGMA interface_information (SOMPPersistentObject_sompGetIOGroup, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentObject_sompGetIOGroup (
            Self.som_object,
            Ev,
            SOMPPersistentObjectClassData.sompGetIOGroup);
      RETURN Result;
   END sompGetIOGroup; 

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

END SOMPPersistentObject; 








-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:23 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMClass;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE M_SOMPPersistentObject IS


   TYPE Ref IS NEW SOMClass.Ref WITH NULL RECORD;

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
      


   PROCEDURE sompSetClassLevelEncoderDecoderName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      myName : IN Corba.String);
     
     -- Set Encoder/Decoder name at the class level

   FUNCTION sompGetClassLevelEncoderDecoderName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Get class level Encoder/Decoder name.

   PROCEDURE somInit (
      Self : IN Ref);

END M_SOMPPersistentObject; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY M_SOMPPersistentObject IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompRegisterEDPair : SOM.somMToken;
      sompGetTotalEDPairs : SOM.somMToken;
      sompGetNthEDPair : SOM.somMToken;
      sompGetNthEDPairObj : SOM.somMToken;
      sompSetClassLevelEncoderDecoderName : SOM.somMToken;
      sompGetClassLevelEncoderDecoderName : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   M_SOMPPersistentObjectClassData : classData;
   FOR M_SOMPPersistentObjectClassData USE AT standard.system.label("M_SOMPPersistentObjectClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   M_SOMPPersistentObjectCClassData : CClassData;
   FOR M_SOMPPersistentObjectCClassData USE AT standard.system.label("M_SOMPPersistentObjectCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            M_SOMPPersistentObjectClassData.classObject) 
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
      FUNCTION M_SOMPPersistentObjectNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, M_SOMPPersistentObjectNewClass);
      PRAGMA interface_information (M_SOMPPersistentObjectNewClass, ".M_SOMPPersistentObjectNewClass");
   BEGIN
      RETURN M_SOMPPersistentObjectNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF M_SOMPPersistentObjectClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(M_SOMPPersistentObjectClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompSetClassLevelEncoderDecoderName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      myName : IN Corba.String)
   IS
     
     -- Set Encoder/Decoder name at the class level
      PROCEDURE M_SOMPPersistentObject_sompSetClassLevelEncoderDecoderName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         myName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, M_SOMPPersistentObject_sompSetClassLevelEncoderDecoderName);
      PRAGMA interface_information (M_SOMPPersistentObject_sompSetClassLevelEncoderDecoderName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      M_SOMPPersistentObject_sompSetClassLevelEncoderDecoderName (
         Self.som_object,
         Ev,
         myName,
         M_SOMPPersistentObjectClassData.sompSetClassLevelEncoderDecoderName);
   END sompSetClassLevelEncoderDecoderName;

   FUNCTION sompGetClassLevelEncoderDecoderName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Get class level Encoder/Decoder name.
      FUNCTION M_SOMPPersistentObject_sompGetClassLevelEncoderDecoderName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, M_SOMPPersistentObject_sompGetClassLevelEncoderDecoderName);
      PRAGMA interface_information (M_SOMPPersistentObject_sompGetClassLevelEncoderDecoderName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         M_SOMPPersistentObject_sompGetClassLevelEncoderDecoderName (
            Self.som_object,
            Ev,
            M_SOMPPersistentObjectClassData.sompGetClassLevelEncoderDecoderName);
      RETURN Result;
   END sompGetClassLevelEncoderDecoderName; 

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END M_SOMPPersistentObject; 







