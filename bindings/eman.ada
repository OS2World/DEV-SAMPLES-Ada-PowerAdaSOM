
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:04 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMEEMan IS

   
   -- The Event Manager class (EMan for short) is used to handle several input
   -- events. The main purpose of this class is to provide a service that can do
   -- a blocked (or timed) wait on several event sources concurrently.  Typically,
   -- in a main program,  one registers an interest in an event type with EMan and
   -- specifies a callback (a procedure or a method) to be invoked when the event
   -- of interest occurs. After all the necessary registrations are done, the main
   -- program is ended by a call to process events in EMan. This call is non-returning.
   -- Eman then waits on multiple registered sources of events. The application is then
   -- completely event driven. I.E., it does something only when an event occurs.
   -- The control returns to EMan after processing each event. Further registrations
   -- can be done inside of callback routines. So also unregistrations.
   --
   -- AIX Specifics:
   -- On AIX this event manager supports Timer, Sink (any file, pipe,
   -- socket and Message Queue), Client and WorkProc events.
   --
   -- OS/2 Specifics:
   -- On OS/2 this event manager supports Timer, Sink(sockets only). Client and
   -- WorkProc events.
   -- To cope with multi-threaded applications on OS/2, the event manager
   -- methods are mutually exclusive (i.e., at any time only one thread can be
   -- executing inside of EMan).
   -- If an application thread needs to stop EMan from running (i.e., achieve
   -- mutual exclusion with EMan), it can use the two methods someGetEmanSem
   -- and someReleaseEManSem to acquire and release EMan semaphore(s).
   -- On AIX, at present, since AIX does not support threads calling these two methods
   -- has no effect.

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
      


   PROCEDURE someGetEManSem (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Gets a semaphore to achieve mutual exclusion with EMan's activity.
     -- Callers should not hold this semaphore for too long since it essentially
     -- stops EMan activity for that duration.

   PROCEDURE someReleaseEManSem (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Release the semaphore obtained by someGetEManSem.

   PROCEDURE someChangeRegData (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      registrationId : IN Corba.Long;
      registerData : IN SOM.SOMObjectPtr);
     
     -- Change the registration data associated with the specified id.
     -- This id must have been returned by EMan in a previous Register call.

   PROCEDURE someProcessEvent (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mask : IN Corba.Unsigned_Long);
     
     -- Process one event. This call is non-blocking. If there are no events to
     -- process it returns immediately. The mask specifies what events to process.
     -- The mask is formed by ORing the bit constants specified in eventmsk.h
     -- For example, to processs Timer and Sink events only one would specify
     -- the mask as:  EMProcessTimerEvent | EMProcessSinkEvent

   PROCEDURE someProcessEvents (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Process infinite events. Does not return. Loops forever waiting for events
     -- and dispatching events. The only way this can be broken is by calling
     -- someShutdown in a callback.

   PROCEDURE someQueueEvent (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      event : IN SOM.SOMObjectPtr);
     
     -- Used to be: void someQueueEvent(inout SOMEClientEvent event);
     -- Enqueue the specified client event

   FUNCTION someRegister (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      registerData : IN SOM.SOMObjectPtr;
      targetObject : IN SOM.SOMObjectPtr;
      targetMethod : IN Corba.String;
      targetData : IN SOM.VoidPtr)
      RETURN Corba.Long;
     
     -- Register the object/method pair with EMan given the specified 'registerData'.

   PROCEDURE someRegisterEv (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      registerData : IN SOM.SOMObjectPtr;
      targetObject : IN SOM.SOMObjectPtr;
      callbackEv : IN OUT SOM.Environment;
      targetMethod : IN Corba.String;
      targetData : IN SOM.VoidPtr;
      Result : OUT Corba.Long);
     
     -- Register the object/method pair together with the callback Environment parameter
     -- with EMan given the specified 'registerData'.

   FUNCTION someRegisterProc (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      registerData : IN SOM.SOMObjectPtr;
      targetProcedure : IN SOM.EMRegProc;
      targetData : IN SOM.VoidPtr)
      RETURN Corba.Long;
     
     -- Register the procedure with EMan given the specified 'registerData'.

   PROCEDURE someShutdown (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Shutdown EMan event loop. (i.e., makes the someProcessEvents return!)

   PROCEDURE someUnRegister (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      registrationId : IN Corba.Long);
     
     -- Unregister the data associated with the specified 'registrationId' within EMan

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END SOMEEMan; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMEEMan IS

   
   -- The Event Manager class (EMan for short) is used to handle several input
   -- events. The main purpose of this class is to provide a service that can do
   -- a blocked (or timed) wait on several event sources concurrently.  Typically,
   -- in a main program,  one registers an interest in an event type with EMan and
   -- specifies a callback (a procedure or a method) to be invoked when the event
   -- of interest occurs. After all the necessary registrations are done, the main
   -- program is ended by a call to process events in EMan. This call is non-returning.
   -- Eman then waits on multiple registered sources of events. The application is then
   -- completely event driven. I.E., it does something only when an event occurs.
   -- The control returns to EMan after processing each event. Further registrations
   -- can be done inside of callback routines. So also unregistrations.
   --
   -- AIX Specifics:
   -- On AIX this event manager supports Timer, Sink (any file, pipe,
   -- socket and Message Queue), Client and WorkProc events.
   --
   -- OS/2 Specifics:
   -- On OS/2 this event manager supports Timer, Sink(sockets only). Client and
   -- WorkProc events.
   -- To cope with multi-threaded applications on OS/2, the event manager
   -- methods are mutually exclusive (i.e., at any time only one thread can be
   -- executing inside of EMan).
   -- If an application thread needs to stop EMan from running (i.e., achieve
   -- mutual exclusion with EMan), it can use the two methods someGetEmanSem
   -- and someReleaseEManSem to acquire and release EMan semaphore(s).
   -- On AIX, at present, since AIX does not support threads calling these two methods
   -- has no effect.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      someGetEManSem : SOM.somMToken;
      someReleaseEManSem : SOM.somMToken;
      someChangeRegData : SOM.somMToken;
      someProcessEvent : SOM.somMToken;
      someProcessEvents : SOM.somMToken;
      someQueueEvent : SOM.somMToken;
      someRegister : SOM.somMToken;
      someRegisterEv : SOM.somMToken;
      someRegisterProc : SOM.somMToken;
      someShutdown : SOM.somMToken;
      someUnRegister : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMEEManClassData : classData;
   FOR SOMEEManClassData USE AT standard.system.label("SOMEEManClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMEEManCClassData : CClassData;
   FOR SOMEEManCClassData USE AT standard.system.label("SOMEEManCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMEEManClassData.classObject) 
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
      FUNCTION SOMEEManNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMEEManNewClass);
      PRAGMA interface_information (SOMEEManNewClass, ".SOMEEManNewClass");
   BEGIN
      RETURN SOMEEManNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMEEManClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMEEManClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE someGetEManSem (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Gets a semaphore to achieve mutual exclusion with EMan's activity.
     -- Callers should not hold this semaphore for too long since it essentially
     -- stops EMan activity for that duration.
      PROCEDURE SOMEEMan_someGetEManSem(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someGetEManSem);
      PRAGMA interface_information (SOMEEMan_someGetEManSem, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someGetEManSem (
         Self.som_object,
         Ev,
         SOMEEManClassData.someGetEManSem);
   END someGetEManSem;

   PROCEDURE someReleaseEManSem (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Release the semaphore obtained by someGetEManSem.
      PROCEDURE SOMEEMan_someReleaseEManSem(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someReleaseEManSem);
      PRAGMA interface_information (SOMEEMan_someReleaseEManSem, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someReleaseEManSem (
         Self.som_object,
         Ev,
         SOMEEManClassData.someReleaseEManSem);
   END someReleaseEManSem;

   PROCEDURE someChangeRegData (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      registrationId : IN Corba.Long; 
      registerData : IN SOM.SOMObjectPtr)
   IS
     
     -- Change the registration data associated with the specified id.
     -- This id must have been returned by EMan in a previous Register call.
      PROCEDURE SOMEEMan_someChangeRegData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         registrationId : IN Corba.Long; 
         registerData : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someChangeRegData);
      PRAGMA interface_information (SOMEEMan_someChangeRegData, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someChangeRegData (
         Self.som_object,
         Ev,
         registrationId,
         registerData,
         SOMEEManClassData.someChangeRegData);
   END someChangeRegData;

   PROCEDURE someProcessEvent (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mask : IN Corba.Unsigned_Long)
   IS
     
     -- Process one event. This call is non-blocking. If there are no events to
     -- process it returns immediately. The mask specifies what events to process.
     -- The mask is formed by ORing the bit constants specified in eventmsk.h
     -- For example, to processs Timer and Sink events only one would specify
     -- the mask as:  EMProcessTimerEvent | EMProcessSinkEvent
      PROCEDURE SOMEEMan_someProcessEvent(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mask : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someProcessEvent);
      PRAGMA interface_information (SOMEEMan_someProcessEvent, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someProcessEvent (
         Self.som_object,
         Ev,
         mask,
         SOMEEManClassData.someProcessEvent);
   END someProcessEvent;

   PROCEDURE someProcessEvents (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Process infinite events. Does not return. Loops forever waiting for events
     -- and dispatching events. The only way this can be broken is by calling
     -- someShutdown in a callback.
      PROCEDURE SOMEEMan_someProcessEvents(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someProcessEvents);
      PRAGMA interface_information (SOMEEMan_someProcessEvents, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someProcessEvents (
         Self.som_object,
         Ev,
         SOMEEManClassData.someProcessEvents);
   END someProcessEvents;

   PROCEDURE someQueueEvent (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      event : IN SOM.SOMObjectPtr)
   IS
     
     -- Used to be: void someQueueEvent(inout SOMEClientEvent event);
     -- Enqueue the specified client event
      PROCEDURE SOMEEMan_someQueueEvent(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         event : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someQueueEvent);
      PRAGMA interface_information (SOMEEMan_someQueueEvent, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someQueueEvent (
         Self.som_object,
         Ev,
         event,
         SOMEEManClassData.someQueueEvent);
   END someQueueEvent;

   FUNCTION someRegister (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      registerData : IN SOM.SOMObjectPtr; 
      targetObject : IN SOM.SOMObjectPtr; 
      targetMethod : IN Corba.String; 
      targetData : IN SOM.VoidPtr)
      RETURN Corba.Long
   IS
     
     -- Register the object/method pair with EMan given the specified 'registerData'.
      FUNCTION SOMEEMan_someRegister(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         registerData : IN SOM.SOMObjectPtr; 
         targetObject : IN SOM.SOMObjectPtr; 
         targetMethod : IN Corba.String; 
         targetData : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMEEMan_someRegister);
      PRAGMA interface_information (SOMEEMan_someRegister, ".xsomcall6");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEEMan_someRegister (
            Self.som_object,
            Ev,
            registerData,
            targetObject,
            targetMethod,
            targetData,
            SOMEEManClassData.someRegister);
      RETURN Result;
   END someRegister; 

   PROCEDURE someRegisterEv (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      registerData : IN SOM.SOMObjectPtr; 
      targetObject : IN SOM.SOMObjectPtr; 
      callbackEv : IN OUT SOM.Environment; 
      targetMethod : IN Corba.String; 
      targetData : IN SOM.VoidPtr; 
      Result : OUT Corba.Long)
   IS
     
     -- Register the object/method pair together with the callback Environment parameter
     -- with EMan given the specified 'registerData'.
      FUNCTION SOMEEMan_someRegisterEv(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         registerData : IN SOM.SOMObjectPtr; 
         targetObject : IN SOM.SOMObjectPtr; 
         callbackEv : IN SOM.address; 
         targetMethod : IN Corba.String; 
         targetData : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMEEMan_someRegisterEv);
      PRAGMA interface_information (SOMEEMan_someRegisterEv, ".xsomcall7");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEEMan_someRegisterEv (
            Self.som_object,
            Ev,
            registerData,
            targetObject,
            SOM.To_SOM_Address(callbackEv'address),
            targetMethod,
            targetData,
            SOMEEManClassData.someRegisterEv);
   END someRegisterEv;

   FUNCTION someRegisterProc (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      registerData : IN SOM.SOMObjectPtr; 
      targetProcedure : IN SOM.EMRegProc; 
      targetData : IN SOM.VoidPtr)
      RETURN Corba.Long
   IS
     
     -- Register the procedure with EMan given the specified 'registerData'.
      FUNCTION SOMEEMan_someRegisterProc(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         registerData : IN SOM.SOMObjectPtr; 
         targetProcedure : IN SOM.EMRegProc; 
         targetData : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMEEMan_someRegisterProc);
      PRAGMA interface_information (SOMEEMan_someRegisterProc, ".xsomcall5");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEEMan_someRegisterProc (
            Self.som_object,
            Ev,
            registerData,
            targetProcedure,
            targetData,
            SOMEEManClassData.someRegisterProc);
      RETURN Result;
   END someRegisterProc; 

   PROCEDURE someShutdown (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Shutdown EMan event loop. (i.e., makes the someProcessEvents return!)
      PROCEDURE SOMEEMan_someShutdown(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someShutdown);
      PRAGMA interface_information (SOMEEMan_someShutdown, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someShutdown (
         Self.som_object,
         Ev,
         SOMEEManClassData.someShutdown);
   END someShutdown;

   PROCEDURE someUnRegister (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      registrationId : IN Corba.Long)
   IS
     
     -- Unregister the data associated with the specified 'registrationId' within EMan
      PROCEDURE SOMEEMan_someUnRegister(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         registrationId : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMan_someUnRegister);
      PRAGMA interface_information (SOMEEMan_someUnRegister, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMan_someUnRegister (
         Self.som_object,
         Ev,
         registrationId,
         SOMEEManClassData.someUnRegister);
   END someUnRegister;

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

END SOMEEMan; 







