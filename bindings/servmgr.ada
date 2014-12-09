
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:40 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMDServerMgr IS


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
      


   FUNCTION somdShutdownServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus;

   FUNCTION somdStartServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus;

   FUNCTION somdRestartServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus;

   FUNCTION somdListServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus;

   FUNCTION somdDisableServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus;

   FUNCTION somdEnableServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus;

   FUNCTION somdIsServerEnabled (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impldef : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

END SOMDServerMgr; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMDServerMgr IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somdShutdownServer : SOM.somMToken;
      somdStartServer : SOM.somMToken;
      somdRestartServer : SOM.somMToken;
      somdListServer : SOM.somMToken;
      somdDisableServer : SOM.somMToken;
      somdEnableServer : SOM.somMToken;
      somdIsServerEnabled : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMDServerMgrClassData : classData;
   FOR SOMDServerMgrClassData USE AT standard.system.label("SOMDServerMgrClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMDServerMgrCClassData : CClassData;
   FOR SOMDServerMgrCClassData USE AT standard.system.label("SOMDServerMgrCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMDServerMgrClassData.classObject) 
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
      FUNCTION SOMDServerMgrNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMDServerMgrNewClass);
      PRAGMA interface_information (SOMDServerMgrNewClass, ".SOMDServerMgrNewClass");
   BEGIN
      RETURN SOMDServerMgrNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMDServerMgrClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMDServerMgrClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somdShutdownServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
      FUNCTION SOMDServerMgr_somdShutdownServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         server_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDServerMgr_somdShutdownServer);
      PRAGMA interface_information (SOMDServerMgr_somdShutdownServer, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdShutdownServer (
            Self.som_object,
            Ev,
            server_alias,
            SOMDServerMgrClassData.somdShutdownServer);
      RETURN Result;
   END somdShutdownServer; 

   FUNCTION somdStartServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
      FUNCTION SOMDServerMgr_somdStartServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         server_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDServerMgr_somdStartServer);
      PRAGMA interface_information (SOMDServerMgr_somdStartServer, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdStartServer (
            Self.som_object,
            Ev,
            server_alias,
            SOMDServerMgrClassData.somdStartServer);
      RETURN Result;
   END somdStartServer; 

   FUNCTION somdRestartServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
      FUNCTION SOMDServerMgr_somdRestartServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         server_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDServerMgr_somdRestartServer);
      PRAGMA interface_information (SOMDServerMgr_somdRestartServer, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdRestartServer (
            Self.som_object,
            Ev,
            server_alias,
            SOMDServerMgrClassData.somdRestartServer);
      RETURN Result;
   END somdRestartServer; 

   FUNCTION somdListServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
      FUNCTION SOMDServerMgr_somdListServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         server_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDServerMgr_somdListServer);
      PRAGMA interface_information (SOMDServerMgr_somdListServer, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdListServer (
            Self.som_object,
            Ev,
            server_alias,
            SOMDServerMgrClassData.somdListServer);
      RETURN Result;
   END somdListServer; 

   FUNCTION somdDisableServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
      FUNCTION SOMDServerMgr_somdDisableServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         server_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDServerMgr_somdDisableServer);
      PRAGMA interface_information (SOMDServerMgr_somdDisableServer, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdDisableServer (
            Self.som_object,
            Ev,
            server_alias,
            SOMDServerMgrClassData.somdDisableServer);
      RETURN Result;
   END somdDisableServer; 

   FUNCTION somdEnableServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      server_alias : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
      FUNCTION SOMDServerMgr_somdEnableServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         server_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDServerMgr_somdEnableServer);
      PRAGMA interface_information (SOMDServerMgr_somdEnableServer, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdEnableServer (
            Self.som_object,
            Ev,
            server_alias,
            SOMDServerMgrClassData.somdEnableServer);
      RETURN Result;
   END somdEnableServer; 

   FUNCTION somdIsServerEnabled (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impldef : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMDServerMgr_somdIsServerEnabled(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impldef : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDServerMgr_somdIsServerEnabled);
      PRAGMA interface_information (SOMDServerMgr_somdIsServerEnabled, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServerMgr_somdIsServerEnabled (
            Self.som_object,
            Ev,
            impldef,
            SOMDServerMgrClassData.somdIsServerEnabled);
      RETURN Result;
   END somdIsServerEnabled; 

END SOMDServerMgr; 







