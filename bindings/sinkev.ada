
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:40 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMEEvent;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMESinkEvent IS

   
   -- SOMESinkEvent is the class for generic sink events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMSinkEvent (for files, pipes, and sockets)
   --      EMMsgQEvent (for AIX message queues)
   --
   -- On AIX, an instance of this class is created, initialized and passed to the
   -- callback routine  for events (input/output/exception) associated with files,
   -- sockets, pipes and Message Queues. On OS/2, the same is done for sockets only.

   TYPE Ref IS NEW SOMEEvent.Ref WITH NULL RECORD;

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
      


   FUNCTION somevGetEventSink (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Returns the sink, or source of file i/o, of the generic sink event.
     -- For message queues it is the queue id, for files it is the file descriptor,
     -- for sockets it is the socket id and for pipes it is the pipe descriptor.

   PROCEDURE somevSetEventSink (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sink : IN Corba.Long);
     
     -- Sets the sink, or source of file i/o, of the generic sink event.
     -- For message queues it is the queue id, for files it is the file descriptor,
     -- for sockets it is the socket id and for pipes it is the pipe descriptor.

   PROCEDURE somInit (
      Self : IN Ref);

END SOMESinkEvent; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMESinkEvent IS

   
   -- SOMESinkEvent is the class for generic sink events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMSinkEvent (for files, pipes, and sockets)
   --      EMMsgQEvent (for AIX message queues)
   --
   -- On AIX, an instance of this class is created, initialized and passed to the
   -- callback routine  for events (input/output/exception) associated with files,
   -- sockets, pipes and Message Queues. On OS/2, the same is done for sockets only.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somevGetEventSink : SOM.somMToken;
      somevSetEventSink : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMESinkEventClassData : classData;
   FOR SOMESinkEventClassData USE AT standard.system.label("SOMESinkEventClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMESinkEventCClassData : CClassData;
   FOR SOMESinkEventCClassData USE AT standard.system.label("SOMESinkEventCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMESinkEventClassData.classObject) 
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
      FUNCTION SOMESinkEventNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMESinkEventNewClass);
      PRAGMA interface_information (SOMESinkEventNewClass, ".SOMESinkEventNewClass");
   BEGIN
      RETURN SOMESinkEventNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMESinkEventClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMESinkEventClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somevGetEventSink (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Returns the sink, or source of file i/o, of the generic sink event.
     -- For message queues it is the queue id, for files it is the file descriptor,
     -- for sockets it is the socket id and for pipes it is the pipe descriptor.
      FUNCTION SOMESinkEvent_somevGetEventSink(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMESinkEvent_somevGetEventSink);
      PRAGMA interface_information (SOMESinkEvent_somevGetEventSink, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMESinkEvent_somevGetEventSink (
            Self.som_object,
            Ev,
            SOMESinkEventClassData.somevGetEventSink);
      RETURN Result;
   END somevGetEventSink; 

   PROCEDURE somevSetEventSink (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sink : IN Corba.Long)
   IS
     
     -- Sets the sink, or source of file i/o, of the generic sink event.
     -- For message queues it is the queue id, for files it is the file descriptor,
     -- for sockets it is the socket id and for pipes it is the pipe descriptor.
      PROCEDURE SOMESinkEvent_somevSetEventSink(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sink : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMESinkEvent_somevSetEventSink);
      PRAGMA interface_information (SOMESinkEvent_somevSetEventSink, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMESinkEvent_somevSetEventSink (
         Self.som_object,
         Ev,
         sink,
         SOMESinkEventClassData.somevSetEventSink);
   END somevSetEventSink;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END SOMESinkEvent; 







