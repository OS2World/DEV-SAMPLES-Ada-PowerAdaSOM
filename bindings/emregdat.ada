
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

PACKAGE SOMEEMRegisterData IS

   
   -- SOMEEMRegisterData is the class utilized for holding registration
   -- data for events types to be registered with Event Management Framework(EMan)

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
      


   PROCEDURE someClearRegData (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Clears the registration data

   PROCEDURE someSetRegDataClientType (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      clientType : IN Corba.String);
     
     -- Sets the client event type within the registration data

   PROCEDURE someSetRegDataEventMask (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      eventType : IN Corba.Long;
      ap : IN SOM.va_list);
     
     -- Sets the generic event mask within the registration data, using NULL terminated
     -- event type list. Event types are defined in eventmsk.h

   PROCEDURE someSetRegDataSink (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sink : IN Corba.Long);
     
     -- Sets the sink, or source i/o file descriptor, within the registration data

   PROCEDURE someSetRegDataSinkMask (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sinkMask : IN Corba.Unsigned_Long);
     
     -- Sets the sink mask within the registration data

   PROCEDURE someSetRegDataTimerCount (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      count : IN Corba.Long);
     
     -- Sets the number of times the timer will trigger, within the registration data.
     -- The default behavior is for the timer to trigger indefinitely.

   PROCEDURE someSetRegDataTimerInterval (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      interval : IN Corba.Long);
     
     -- Sets the timer interval within the registration data.
     -- Interval specification is in milliseconds

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END SOMEEMRegisterData; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMEEMRegisterData IS

   
   -- SOMEEMRegisterData is the class utilized for holding registration
   -- data for events types to be registered with Event Management Framework(EMan)

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      someClearRegData : SOM.somMToken;
      someSetRegDataClientType : SOM.somMToken;
      someSetRegDataEventMask : SOM.somMToken;
      someSetRegDataSink : SOM.somMToken;
      someSetRegDataSinkMask : SOM.somMToken;
      someSetRegDataTimerCount : SOM.somMToken;
      someSetRegDataTimerInterval : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMEEMRegisterDataClassData : classData;
   FOR SOMEEMRegisterDataClassData USE AT standard.system.label("SOMEEMRegisterDataClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMEEMRegisterDataCClassData : CClassData;
   FOR SOMEEMRegisterDataCClassData USE AT standard.system.label("SOMEEMRegisterDataCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMEEMRegisterDataClassData.classObject) 
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
      FUNCTION SOMEEMRegisterDataNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMEEMRegisterDataNewClass);
      PRAGMA interface_information (SOMEEMRegisterDataNewClass, ".SOMEEMRegisterDataNewClass");
   BEGIN
      RETURN SOMEEMRegisterDataNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMEEMRegisterDataClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMEEMRegisterDataClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE someClearRegData (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Clears the registration data
      PROCEDURE SOMEEMRegisterData_someClearRegData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someClearRegData);
      PRAGMA interface_information (SOMEEMRegisterData_someClearRegData, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someClearRegData (
         Self.som_object,
         Ev,
         SOMEEMRegisterDataClassData.someClearRegData);
   END someClearRegData;

   PROCEDURE someSetRegDataClientType (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      clientType : IN Corba.String)
   IS
     
     -- Sets the client event type within the registration data
      PROCEDURE SOMEEMRegisterData_someSetRegDataClientType(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         clientType : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someSetRegDataClientType);
      PRAGMA interface_information (SOMEEMRegisterData_someSetRegDataClientType, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someSetRegDataClientType (
         Self.som_object,
         Ev,
         clientType,
         SOMEEMRegisterDataClassData.someSetRegDataClientType);
   END someSetRegDataClientType;

   PROCEDURE someSetRegDataEventMask (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      eventType : IN Corba.Long; 
      ap : IN SOM.va_list)
   IS
     
     -- Sets the generic event mask within the registration data, using NULL terminated
     -- event type list. Event types are defined in eventmsk.h
      PROCEDURE SOMEEMRegisterData_someSetRegDataEventMask(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         eventType : IN Corba.Long; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someSetRegDataEventMask);
      PRAGMA interface_information (SOMEEMRegisterData_someSetRegDataEventMask, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someSetRegDataEventMask (
         Self.som_object,
         Ev,
         eventType,
         ap,
         SOMEEMRegisterDataClassData.someSetRegDataEventMask);
   END someSetRegDataEventMask;

   PROCEDURE someSetRegDataSink (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sink : IN Corba.Long)
   IS
     
     -- Sets the sink, or source i/o file descriptor, within the registration data
      PROCEDURE SOMEEMRegisterData_someSetRegDataSink(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sink : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someSetRegDataSink);
      PRAGMA interface_information (SOMEEMRegisterData_someSetRegDataSink, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someSetRegDataSink (
         Self.som_object,
         Ev,
         sink,
         SOMEEMRegisterDataClassData.someSetRegDataSink);
   END someSetRegDataSink;

   PROCEDURE someSetRegDataSinkMask (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sinkMask : IN Corba.Unsigned_Long)
   IS
     
     -- Sets the sink mask within the registration data
      PROCEDURE SOMEEMRegisterData_someSetRegDataSinkMask(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sinkMask : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someSetRegDataSinkMask);
      PRAGMA interface_information (SOMEEMRegisterData_someSetRegDataSinkMask, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someSetRegDataSinkMask (
         Self.som_object,
         Ev,
         sinkMask,
         SOMEEMRegisterDataClassData.someSetRegDataSinkMask);
   END someSetRegDataSinkMask;

   PROCEDURE someSetRegDataTimerCount (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      count : IN Corba.Long)
   IS
     
     -- Sets the number of times the timer will trigger, within the registration data.
     -- The default behavior is for the timer to trigger indefinitely.
      PROCEDURE SOMEEMRegisterData_someSetRegDataTimerCount(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         count : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someSetRegDataTimerCount);
      PRAGMA interface_information (SOMEEMRegisterData_someSetRegDataTimerCount, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someSetRegDataTimerCount (
         Self.som_object,
         Ev,
         count,
         SOMEEMRegisterDataClassData.someSetRegDataTimerCount);
   END someSetRegDataTimerCount;

   PROCEDURE someSetRegDataTimerInterval (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      interval : IN Corba.Long)
   IS
     
     -- Sets the timer interval within the registration data.
     -- Interval specification is in milliseconds
      PROCEDURE SOMEEMRegisterData_someSetRegDataTimerInterval(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         interval : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEEMRegisterData_someSetRegDataTimerInterval);
      PRAGMA interface_information (SOMEEMRegisterData_someSetRegDataTimerInterval, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEEMRegisterData_someSetRegDataTimerInterval (
         Self.som_object,
         Ev,
         interval,
         SOMEEMRegisterDataClassData.someSetRegDataTimerInterval);
   END someSetRegDataTimerInterval;

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

END SOMEEMRegisterData; 







