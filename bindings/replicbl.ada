
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:26 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMRNameable;
WITH SOMRLinearizable;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMRReplicbl IS

   
   -- This class provides a link to the Replication Framework. Any class derived
   -- from this class can have instances that are replicated in other address
   -- spaces.  To get the ability to replicate, the derived
   -- class has to abide by the following rules (these rules are binding on
   -- further derivations and contained (constituent) subobjects as well):
   --
   --    1. It must obtain a replica lock before updating its data and must
   --       release the same after the update. (i.e., The update methods
   --       must bracket their code in a (somrLock, somrReleaseNPropagateUpdate)
   --       pair or a (somrLockNLogOp, somrReleaseNPropagateOperation) pair.)
   --    2. If after obtaining the replica lock, if the object decides to abort
   --       an update operation, it must call the appropriate abort method.
   --       (somrReleaseLockNAbortOp or somrReleaseLockNAbortUpdate)
   --    3. In case value logging is used, it must have an update language in which
   --       changes in the state of the object can be described.
   --    4. In case value logging is used, it must provide a method to receive and
   --       interpret update messages propagated by other replicas. (i.e., Must implement
   --       somrApplyUpdates method. When there are subobjects, this implementation
   --       should call them to interpret the updates appropriate to them.)
   --    5. It must have methods to get and set the complete state of the object (including
   --       any subobjects). (i.e., Must provide implementations for somrGetState
   --       and somrSetState.)
   --    6. It should be able to receive and interpret data replication
   --       directives (e.g., "LOST_CONNECTION", "BECOME_STAND_ALONE", etc. )

   TYPE Ref IS NEW SOMRNameable.Ref WITH NULL RECORD;

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
      


   PROCEDURE somrLock (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Get a lock on this replica of the object. An exception is raised if the
     -- lock is not obtained.

   PROCEDURE somrLockNlogOp (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      ClassName : IN Corba.String;
      MthdName : IN Corba.String;
      ap : IN SOM.va_list);
     
     -- Similar to somrLock, but it also logs the method (i.e., MthdName) that is
     -- requesting the lock.
     -- The va_list parameter is for specifying the actual arguments with which "MthdName" is
     -- being called.

   PROCEDURE somrReleaseNPropagateUpdate (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      clsname : IN Corba.String;
      buf : IN Corba.String;
      len : IN Corba.Long;
      intOid : IN Corba.Long);
     
     -- Release the lock locally and propagate the local updates to master and or
     -- other shadows by calling the local replica manager. This propagates
     -- "value log" of state changes. The parameter intOid is used to indicate
     -- a subobject id to which this update is to be applied. If there are no
     -- subobjects, this argument is to be set to 0.

   PROCEDURE somrReleaseLockNAbortUpdate (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Lets the data replication framework know that the user decided to abort
     -- the operation he/she began by calling somrLock. Once a lock is
     -- obtained, either this method or somrReleaseNPropagateUpdate must
     -- be called.

   PROCEDURE somrReleaseNPropagateOperation (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Similar to Propagate update, except now propagate the "operation log"
     -- instead of the value log  prepared by the subclass implementation.

   PROCEDURE somrReleaseLockNAbortOp (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Lets the data replication framework know that the user decided to abort
     -- the operation that he/she began by calling somrLockNLogOp. Once a lock
     -- is obtained, either this method or somrReleaseNPropagateOperation must
     -- be called

   FUNCTION somrRepInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      lType : IN Corba.Char;
      mode : IN Corba.Char)
      RETURN Corba.Long;
     
     -- Makes the object ready for replication. A derived object
     -- MUST call this method for activating replica control.  The parameter
     -- lType indicates the type of logging used: 'v' for value logging and 'o'
     -- for operation logging.  The parameter mode indicates whether the
     -- object is opened for reading("r") or writing ("w").
     --
     -- If no errors occur, a return value of 1 indicates that this is the first
     -- replica to be activated (i.e., the Master), and 0 indicates it is a shadow.
     --
     -- If an error occurs, an exception is raised, and the return value is
     -- indeterminate (and should be ignored).
     --
     -- If the object is already initialized, no action is taken, and a return
     -- code of 0 is returned.

   PROCEDURE somrRepUninit (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Destroys the set up for replication.
     -- If the object is not initialized for replication, no action is taken.

   PROCEDURE somrApplyUpdates (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buf : IN Corba.String;
      len : IN Corba.Long;
      ObjIntId : IN Corba.Long);
     
     -- This method interprets the buffer received as an update to its state.
     -- The format of this update is exactly the same as the one used by the
     -- subclass implementor for the update buffer passed to ReleaseNPropagateUpdate
     -- method. The ObjIntId parameter indicates the internal subobject id to which
     -- this update should be applied. If it is 0, then the update is to be applied
     -- to self.

   PROCEDURE somrDoDirective (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      str : IN Corba.String);
     
     -- The string gives a directive to the object to implement. The directive usually
     -- indications a condition that warrants user intervention/awareness.

   PROCEDURE somrPin (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Makes the replica lock obtained by this replica stay with it until a call
     -- to UnPin is made.  That is, it makes the replica lock un-preemptible.
     -- Raises an Exception if the lock is denied (SOMR_DENIED).

   PROCEDURE somrUnPin (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Declares the replica lock preemptible. That is, other shadows can grab the
     -- replica lock from this shadow.

   FUNCTION somrGetSecurityPolicy (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     --  Returns the security policy for replicated objects that are either
     --  non-persistent or persistent but haven't been created yet.
     --  Caveat: Meaningful only on AIX. Ignored for OS/2.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somrSetObjName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String);

END SOMRReplicbl; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMRReplicbl IS

   
   -- This class provides a link to the Replication Framework. Any class derived
   -- from this class can have instances that are replicated in other address
   -- spaces.  To get the ability to replicate, the derived
   -- class has to abide by the following rules (these rules are binding on
   -- further derivations and contained (constituent) subobjects as well):
   --
   --    1. It must obtain a replica lock before updating its data and must
   --       release the same after the update. (i.e., The update methods
   --       must bracket their code in a (somrLock, somrReleaseNPropagateUpdate)
   --       pair or a (somrLockNLogOp, somrReleaseNPropagateOperation) pair.)
   --    2. If after obtaining the replica lock, if the object decides to abort
   --       an update operation, it must call the appropriate abort method.
   --       (somrReleaseLockNAbortOp or somrReleaseLockNAbortUpdate)
   --    3. In case value logging is used, it must have an update language in which
   --       changes in the state of the object can be described.
   --    4. In case value logging is used, it must provide a method to receive and
   --       interpret update messages propagated by other replicas. (i.e., Must implement
   --       somrApplyUpdates method. When there are subobjects, this implementation
   --       should call them to interpret the updates appropriate to them.)
   --    5. It must have methods to get and set the complete state of the object (including
   --       any subobjects). (i.e., Must provide implementations for somrGetState
   --       and somrSetState.)
   --    6. It should be able to receive and interpret data replication
   --       directives (e.g., "LOST_CONNECTION", "BECOME_STAND_ALONE", etc. )

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somrLock : SOM.somMToken;
      somrLockNlogOp : SOM.somMToken;
      somrReleaseNPropagateUpdate : SOM.somMToken;
      somrReleaseLockNAbortUpdate : SOM.somMToken;
      somrReleaseNPropagateOperation : SOM.somMToken;
      somrReleaseLockNAbortOp : SOM.somMToken;
      somrSendDirective : SOM.somMToken;
      somrGetSavePermit : SOM.somMToken;
      somrRepInit : SOM.somMToken;
      somrRepUninit : SOM.somMToken;
      somrApplyUpdates : SOM.somMToken;
      somrDoDirective : SOM.somMToken;
      somrPin : SOM.somMToken;
      somrUnPin : SOM.somMToken;
      somrGetSecurityPolicy : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMRReplicblClassData : classData;
   FOR SOMRReplicblClassData USE AT standard.system.label("SOMRReplicblClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMRReplicblCClassData : CClassData;
   FOR SOMRReplicblCClassData USE AT standard.system.label("SOMRReplicblCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMRReplicblClassData.classObject) 
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
      FUNCTION SOMRReplicblNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMRReplicblNewClass);
      PRAGMA interface_information (SOMRReplicblNewClass, ".SOMRReplicblNewClass");
   BEGIN
      RETURN SOMRReplicblNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMRReplicblClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMRReplicblClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somrLock (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Get a lock on this replica of the object. An exception is raised if the
     -- lock is not obtained.
      PROCEDURE SOMRReplicbl_somrLock(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrLock);
      PRAGMA interface_information (SOMRReplicbl_somrLock, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrLock (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrLock);
   END somrLock;

   PROCEDURE somrLockNlogOp (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      ClassName : IN Corba.String; 
      MthdName : IN Corba.String; 
      ap : IN SOM.va_list)
   IS
     
     -- Similar to somrLock, but it also logs the method (i.e., MthdName) that is
     -- requesting the lock.
     -- The va_list parameter is for specifying the actual arguments with which "MthdName" is
     -- being called.
      PROCEDURE SOMRReplicbl_somrLockNlogOp(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         ClassName : IN Corba.String; 
         MthdName : IN Corba.String; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrLockNlogOp);
      PRAGMA interface_information (SOMRReplicbl_somrLockNlogOp, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrLockNlogOp (
         Self.som_object,
         Ev,
         ClassName,
         MthdName,
         ap,
         SOMRReplicblClassData.somrLockNlogOp);
   END somrLockNlogOp;

   PROCEDURE somrReleaseNPropagateUpdate (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      clsname : IN Corba.String; 
      buf : IN Corba.String; 
      len : IN Corba.Long; 
      intOid : IN Corba.Long)
   IS
     
     -- Release the lock locally and propagate the local updates to master and or
     -- other shadows by calling the local replica manager. This propagates
     -- "value log" of state changes. The parameter intOid is used to indicate
     -- a subobject id to which this update is to be applied. If there are no
     -- subobjects, this argument is to be set to 0.
      PROCEDURE SOMRReplicbl_somrReleaseNPropagateUpdate(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         clsname : IN Corba.String; 
         buf : IN Corba.String; 
         len : IN Corba.Long; 
         intOid : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrReleaseNPropagateUpdate);
      PRAGMA interface_information (SOMRReplicbl_somrReleaseNPropagateUpdate, ".xsomcall6");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrReleaseNPropagateUpdate (
         Self.som_object,
         Ev,
         clsname,
         buf,
         len,
         intOid,
         SOMRReplicblClassData.somrReleaseNPropagateUpdate);
   END somrReleaseNPropagateUpdate;

   PROCEDURE somrReleaseLockNAbortUpdate (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Lets the data replication framework know that the user decided to abort
     -- the operation he/she began by calling somrLock. Once a lock is
     -- obtained, either this method or somrReleaseNPropagateUpdate must
     -- be called.
      PROCEDURE SOMRReplicbl_somrReleaseLockNAbortUpdate(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrReleaseLockNAbortUpdate);
      PRAGMA interface_information (SOMRReplicbl_somrReleaseLockNAbortUpdate, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrReleaseLockNAbortUpdate (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrReleaseLockNAbortUpdate);
   END somrReleaseLockNAbortUpdate;

   PROCEDURE somrReleaseNPropagateOperation (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Similar to Propagate update, except now propagate the "operation log"
     -- instead of the value log  prepared by the subclass implementation.
      PROCEDURE SOMRReplicbl_somrReleaseNPropagateOperation(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrReleaseNPropagateOperation);
      PRAGMA interface_information (SOMRReplicbl_somrReleaseNPropagateOperation, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrReleaseNPropagateOperation (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrReleaseNPropagateOperation);
   END somrReleaseNPropagateOperation;

   PROCEDURE somrReleaseLockNAbortOp (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Lets the data replication framework know that the user decided to abort
     -- the operation that he/she began by calling somrLockNLogOp. Once a lock
     -- is obtained, either this method or somrReleaseNPropagateOperation must
     -- be called
      PROCEDURE SOMRReplicbl_somrReleaseLockNAbortOp(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrReleaseLockNAbortOp);
      PRAGMA interface_information (SOMRReplicbl_somrReleaseLockNAbortOp, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrReleaseLockNAbortOp (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrReleaseLockNAbortOp);
   END somrReleaseLockNAbortOp;

   FUNCTION somrRepInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      lType : IN Corba.Char; 
      mode : IN Corba.Char)
      RETURN Corba.Long
   IS
     
     -- Makes the object ready for replication. A derived object
     -- MUST call this method for activating replica control.  The parameter
     -- lType indicates the type of logging used: 'v' for value logging and 'o'
     -- for operation logging.  The parameter mode indicates whether the
     -- object is opened for reading("r") or writing ("w").
     --
     -- If no errors occur, a return value of 1 indicates that this is the first
     -- replica to be activated (i.e., the Master), and 0 indicates it is a shadow.
     --
     -- If an error occurs, an exception is raised, and the return value is
     -- indeterminate (and should be ignored).
     --
     -- If the object is already initialized, no action is taken, and a return
     -- code of 0 is returned.
      FUNCTION SOMRReplicbl_somrRepInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         lType : IN Corba.Char; 
         mode : IN Corba.Char;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMRReplicbl_somrRepInit);
      PRAGMA interface_information (SOMRReplicbl_somrRepInit, ".xsomcall4");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMRReplicbl_somrRepInit (
            Self.som_object,
            Ev,
            lType,
            mode,
            SOMRReplicblClassData.somrRepInit);
      RETURN Result;
   END somrRepInit; 

   PROCEDURE somrRepUninit (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Destroys the set up for replication.
     -- If the object is not initialized for replication, no action is taken.
      PROCEDURE SOMRReplicbl_somrRepUninit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrRepUninit);
      PRAGMA interface_information (SOMRReplicbl_somrRepUninit, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrRepUninit (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrRepUninit);
   END somrRepUninit;

   PROCEDURE somrApplyUpdates (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buf : IN Corba.String; 
      len : IN Corba.Long; 
      ObjIntId : IN Corba.Long)
   IS
     
     -- This method interprets the buffer received as an update to its state.
     -- The format of this update is exactly the same as the one used by the
     -- subclass implementor for the update buffer passed to ReleaseNPropagateUpdate
     -- method. The ObjIntId parameter indicates the internal subobject id to which
     -- this update should be applied. If it is 0, then the update is to be applied
     -- to self.
      PROCEDURE SOMRReplicbl_somrApplyUpdates(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         buf : IN Corba.String; 
         len : IN Corba.Long; 
         ObjIntId : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrApplyUpdates);
      PRAGMA interface_information (SOMRReplicbl_somrApplyUpdates, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrApplyUpdates (
         Self.som_object,
         Ev,
         buf,
         len,
         ObjIntId,
         SOMRReplicblClassData.somrApplyUpdates);
   END somrApplyUpdates;

   PROCEDURE somrDoDirective (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      str : IN Corba.String)
   IS
     
     -- The string gives a directive to the object to implement. The directive usually
     -- indications a condition that warrants user intervention/awareness.
      PROCEDURE SOMRReplicbl_somrDoDirective(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         str : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrDoDirective);
      PRAGMA interface_information (SOMRReplicbl_somrDoDirective, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrDoDirective (
         Self.som_object,
         Ev,
         str,
         SOMRReplicblClassData.somrDoDirective);
   END somrDoDirective;

   PROCEDURE somrPin (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Makes the replica lock obtained by this replica stay with it until a call
     -- to UnPin is made.  That is, it makes the replica lock un-preemptible.
     -- Raises an Exception if the lock is denied (SOMR_DENIED).
      PROCEDURE SOMRReplicbl_somrPin(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrPin);
      PRAGMA interface_information (SOMRReplicbl_somrPin, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrPin (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrPin);
   END somrPin;

   PROCEDURE somrUnPin (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Declares the replica lock preemptible. That is, other shadows can grab the
     -- replica lock from this shadow.
      PROCEDURE SOMRReplicbl_somrUnPin(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRReplicbl_somrUnPin);
      PRAGMA interface_information (SOMRReplicbl_somrUnPin, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl_somrUnPin (
         Self.som_object,
         Ev,
         SOMRReplicblClassData.somrUnPin);
   END somrUnPin;

   FUNCTION somrGetSecurityPolicy (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     --  Returns the security policy for replicated objects that are either
     --  non-persistent or persistent but haven't been created yet.
     --  Caveat: Meaningful only on AIX. Ignored for OS/2.
      FUNCTION SOMRReplicbl_somrGetSecurityPolicy(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMRReplicbl_somrGetSecurityPolicy);
      PRAGMA interface_information (SOMRReplicbl_somrGetSecurityPolicy, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMRReplicbl_somrGetSecurityPolicy (
            Self.som_object,
            Ev,
            SOMRReplicblClassData.somrGetSecurityPolicy);
      RETURN Result;
   END somrGetSecurityPolicy; 

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

   PROCEDURE somrSetObjName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRNameable.somrSetObjName (
         SOMRNameable.Ref'(som_object=>Self.som_object),
         Ev,
         name);
   END somrSetObjName;

END SOMRReplicbl; 







