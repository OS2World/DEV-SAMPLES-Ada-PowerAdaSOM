
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:05:59 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMEEvent;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMEClientEvent IS

   
   -- SOMEClientEvent is the class for generic client events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMClientEvent
   --
   -- An instance of this class is initialized and passed to the
   -- callback routine for all client events regardless of their clientevent type.

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
      


   FUNCTION somevGetEventClientData (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.VoidPtr;
     
     -- Returns the client data of the generic client event

   FUNCTION somevGetEventClientType (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Returns the client type of the generic client event

   PROCEDURE somevSetEventClientData (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      clientData : IN SOM.VoidPtr);
     
     -- Sets the client type of the generic client event

   PROCEDURE somevSetEventClientType (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      clientType : IN Corba.String);

   PROCEDURE somInit (
      Self : IN Ref);

END SOMEClientEvent; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMEClientEvent IS

   
   -- SOMEClientEvent is the class for generic client events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMClientEvent
   --
   -- An instance of this class is initialized and passed to the
   -- callback routine for all client events regardless of their clientevent type.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somevGetEventClientData : SOM.somMToken;
      somevGetEventClientType : SOM.somMToken;
      somevSetEventClientData : SOM.somMToken;
      somevSetEventClientType : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMEClientEventClassData : classData;
   FOR SOMEClientEventClassData USE AT standard.system.label("SOMEClientEventClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMEClientEventCClassData : CClassData;
   FOR SOMEClientEventCClassData USE AT standard.system.label("SOMEClientEventCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMEClientEventClassData.classObject) 
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
      FUNCTION SOMEClientEventNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMEClientEventNewClass);
      PRAGMA interface_information (SOMEClientEventNewClass, ".SOMEClientEventNewClass");
   BEGIN
      RETURN SOMEClientEventNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMEClientEventClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMEClientEventClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somevGetEventClientData (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.VoidPtr
   IS
     
     -- Returns the client data of the generic client event
      FUNCTION SOMEClientEvent_somevGetEventClientData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.VoidPtr; 
      PRAGMA interface (assembly, SOMEClientEvent_somevGetEventClientData);
      PRAGMA interface_information (SOMEClientEvent_somevGetEventClientData, ".xsomcall2");
      Result : ALIASED SOM.VoidPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEClientEvent_somevGetEventClientData (
            Self.som_object,
            Ev,
            SOMEClientEventClassData.somevGetEventClientData);
      RETURN Result;
   END somevGetEventClientData; 

   FUNCTION somevGetEventClientType (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Returns the client type of the generic client event
      FUNCTION SOMEClientEvent_somevGetEventClientType(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMEClientEvent_somevGetEventClientType);
      PRAGMA interface_information (SOMEClientEvent_somevGetEventClientType, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMEClientEvent_somevGetEventClientType (
            Self.som_object,
            Ev,
            SOMEClientEventClassData.somevGetEventClientType);
      RETURN Result;
   END somevGetEventClientType; 

   PROCEDURE somevSetEventClientData (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      clientData : IN SOM.VoidPtr)
   IS
     
     -- Sets the client type of the generic client event
      PROCEDURE SOMEClientEvent_somevSetEventClientData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         clientData : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEClientEvent_somevSetEventClientData);
      PRAGMA interface_information (SOMEClientEvent_somevSetEventClientData, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEClientEvent_somevSetEventClientData (
         Self.som_object,
         Ev,
         clientData,
         SOMEClientEventClassData.somevSetEventClientData);
   END somevSetEventClientData;

   PROCEDURE somevSetEventClientType (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      clientType : IN Corba.String)
   IS
      PROCEDURE SOMEClientEvent_somevSetEventClientType(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         clientType : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMEClientEvent_somevSetEventClientType);
      PRAGMA interface_information (SOMEClientEvent_somevSetEventClientType, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMEClientEvent_somevSetEventClientType (
         Self.som_object,
         Ev,
         clientType,
         SOMEClientEventClassData.somevSetEventClientType);
   END somevSetEventClientType;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END SOMEClientEvent; 







