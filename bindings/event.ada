
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

PACKAGE SOMEEvent IS

   
   -- SOMEEvent is the base class for all generic events within the Event Manager.
   -- It simply timestamps an event before it is passed to a callback routine.
   -- The event type is set to the true type by a subclass. The types currently used
   -- by the event management framework are defined in eventmsk.h.
   -- An subclassing of this class must avoid name and value collisions with eventmsk.h

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
      


   FUNCTION somevGetEventTime (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;
     
     -- Returns the time of the generic event in milliseconds

   FUNCTION somevGetEventType (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;
     
     -- Returns the type of generic event

   PROCEDURE somevSetEventTime (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      time : IN Corba.Unsigned_Long);
     
     -- Sets the time of the generic event (time is in milliseconds)

   PROCEDURE somevSetEventType (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IDL_type : IN Corba.Unsigned_Long);
     
     -- Sets the type of generic event

   PROCEDURE somInit (
      Self : IN Ref);

END SOMEEvent; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMEEvent IS

   
   -- SOMEEvent is the base class for all generic events within the Event Manager.
   -- It simply timestamps an event before it is passed to a callback routine.
   -- The event type is set to the true type by a subclass. The types currently used
   -- by the event management framework are defined in eventmsk.h.
   -- An subclassing of this class must avoid name and value collisions with eventmsk.h

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somevGetEventTime : SOM.somMToken;
      somevGetEventType : SOM.somMToken;
      somevSetEventTime : SOM.somMToken;
      somevSetEventType : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMEEventClassData : classData;
   FOR SOMEEventClassData USE AT standard.system.label("SOMEEventClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMEEventCClassData : CClassData;
   FOR SOMEEventCClassData USE AT standard.system.label("SOMEEventCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMEEventClassData.classObject) 
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
      FUNCTION SOMEEventNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMEEventNewClass);
      PRAGMA interface_information (SOMEEventNewClass, ".SOMEEventNewClass");
   BEGIN
      RETURN SOMEEventNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMEEventClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMEEventClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somevGetEventTime (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Returns the time of the generic event in milliseconds
      FUNCTION SOMEEvent_somevGetEventTime(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMEEvent_somevGetEventTime);
      PRAGMA interface_information (SOMEEvent_somevGetEventTime, ".xsomcall2");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEEvent_somevGetEventTime (
            Self.som_object,
            Ev,
            SOMEEventClassData.somevGetEventTime);
      RETURN Result;
   END somevGetEventTime; 

   FUNCTION somevGetEventType (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Returns the type of generic event
      FUNCTION SOMEEvent_somevGetEventType(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMEEvent_somevGetEventType);
      PRAGMA interface_information (SOMEEvent_somevGetEventType, ".xsomcall2");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEEvent_somevGetEventType (
            Self.som_object,
            Ev,
            SOMEEventClassData.somevGetEventType);
      RETURN Result;
   END somevGetEventType; 

   PROCEDURE somevSetEventTime (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      time : IN Corba.Unsigned_Long)
   IS
     
     -- Sets the time of the generic event (time is in milliseconds)
      PROCEDURE SOMEEvent_somevSetEventTime(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         time : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEvent_somevSetEventTime);
      PRAGMA interface_information (SOMEEvent_somevSetEventTime, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEvent_somevSetEventTime (
         Self.som_object,
         Ev,
         time,
         SOMEEventClassData.somevSetEventTime);
   END somevSetEventTime;

   PROCEDURE somevSetEventType (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IDL_type : IN Corba.Unsigned_Long)
   IS
     
     -- Sets the type of generic event
      PROCEDURE SOMEEvent_somevSetEventType(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IDL_type : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEvent_somevSetEventType);
      PRAGMA interface_information (SOMEEvent_somevSetEventType, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEvent_somevSetEventType (
         Self.som_object,
         Ev,
         IDL_type,
         SOMEEventClassData.somevSetEventType);
   END somevSetEventType;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END SOMEEvent; 







