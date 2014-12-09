
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:03 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMEEvent;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMETimerEvent IS

   
   -- SOMETimerEvent is the class for generic timer events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMTimerEvent
   -- An instance of this class is initialized and passed to the callback
   -- of a timer event.

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
      


   FUNCTION somevGetEventInterval (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Returns the interval of the generic timer event (time in milliseconds)

   PROCEDURE somevSetEventInterval (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      interval : IN Corba.Long);
     
     -- Sets the interval of the generic timer event (time in milliseconds)

   PROCEDURE somInit (
      Self : IN Ref);

END SOMETimerEvent; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMETimerEvent IS

   
   -- SOMETimerEvent is the class for generic timer events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMTimerEvent
   -- An instance of this class is initialized and passed to the callback
   -- of a timer event.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somevGetEventInterval : SOM.somMToken;
      somevSetEventInterval : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMETimerEventClassData : classData;
   FOR SOMETimerEventClassData USE AT standard.system.label("SOMETimerEventClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMETimerEventCClassData : CClassData;
   FOR SOMETimerEventCClassData USE AT standard.system.label("SOMETimerEventCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMETimerEventClassData.classObject) 
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
      FUNCTION SOMETimerEventNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMETimerEventNewClass);
      PRAGMA interface_information (SOMETimerEventNewClass, ".SOMETimerEventNewClass");
   BEGIN
      RETURN SOMETimerEventNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMETimerEventClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMETimerEventClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somevGetEventInterval (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Returns the interval of the generic timer event (time in milliseconds)
      FUNCTION SOMETimerEvent_somevGetEventInterval(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMETimerEvent_somevGetEventInterval);
      PRAGMA interface_information (SOMETimerEvent_somevGetEventInterval, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMETimerEvent_somevGetEventInterval (
            Self.som_object,
            Ev,
            SOMETimerEventClassData.somevGetEventInterval);
      RETURN Result;
   END somevGetEventInterval; 

   PROCEDURE somevSetEventInterval (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      interval : IN Corba.Long)
   IS
     
     -- Sets the interval of the generic timer event (time in milliseconds)
      PROCEDURE SOMETimerEvent_somevSetEventInterval(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         interval : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMETimerEvent_somevSetEventInterval);
      PRAGMA interface_information (SOMETimerEvent_somevSetEventInterval, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMETimerEvent_somevSetEventInterval (
         Self.som_object,
         Ev,
         interval,
         SOMETimerEventClassData.somevSetEventInterval);
   END somevSetEventInterval;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END SOMETimerEvent; 







