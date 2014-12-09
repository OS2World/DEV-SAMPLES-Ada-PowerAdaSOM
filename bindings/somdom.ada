
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:45 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH ObjectMgr;
WITH Corba.Sequences;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMDObjectMgr IS


   TYPE Ref IS NEW ObjectMgr.Ref WITH NULL RECORD;

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
      

   PACKAGE SOMDServer_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);



   FUNCTION somdFindServer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      serverid : IN SOM.ImplId)
      RETURN SOM.SOMObjectPtr;
     
     -- Finds and returns a proxy to the Server object which is identified by the
     -- ImplId.  (ImplId is defined at server registration time, and can be
     -- obtained from the ImplDef.)
     --
     -- OWNERSHIP of returned SOMDServer object is transferred to the caller.

   FUNCTION somdFindServerByName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      servername : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Finds and returns a proxy to the Server object with the specified name.
     -- (The name is defined at server registration time, and can be obtained
     -- from the ImplDef.)
     --
     -- OWNERSHIP of returned SOMDServer object is transferred to the caller.

   FUNCTION somdFindServersByClass (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objclass : IN SOM.Identifier)
      RETURN SOMDObjectMgr.SOMDServer_Unbounded.Sequence;
     
     -- Finds all Server objects which can create an object of the named class.
     --
     -- OWNERSHIP of returned SOMDServer objects is transferred to the caller.

   FUNCTION somdFindAnyServerByClass (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objclass : IN SOM.Identifier)
      RETURN SOM.SOMObjectPtr;
     
     -- Finds (any) Server object which can create an object of the named class.
     -- (This is a specialization of the somdFindServerByClass method.)
     --
     -- OWNERSHIP of returned SOMDServer object is transferred to the caller.

   FUNCTION get_somd21somFree (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     --Method from the IDL attribute statement:
     --"attribute boolean somd21somFree"

   PROCEDURE set_somd21somFree (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somd21somFree : IN Corba.Boolean);
     
     --Method from the IDL attribute statement:
     --"attribute boolean somd21somFree"

   PROCEDURE somInit (
      Self : IN Ref);

   FUNCTION somdNewObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objclass : IN SOM.Identifier;
      hints : IN Corba.String)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somdGetIdFromObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.String;

   FUNCTION somdGetObjectFromId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN Corba.String)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somdReleaseObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);

   PROCEDURE somdDestroyObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);

END SOMDObjectMgr; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMDObjectMgr IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somdFindServer : SOM.somMToken;
      somdFindServerByName : SOM.somMToken;
      somdFindServersByClass : SOM.somMToken;
      somdFindAnyServerByClass : SOM.somMToken;
      get_somd21somFree : SOM.somMToken;
      set_somd21somFree : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMDObjectMgrClassData : classData;
   FOR SOMDObjectMgrClassData USE AT standard.system.label("SOMDObjectMgrClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMDObjectMgrCClassData : CClassData;
   FOR SOMDObjectMgrCClassData USE AT standard.system.label("SOMDObjectMgrCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMDObjectMgrClassData.classObject) 
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
      FUNCTION SOMDObjectMgrNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMDObjectMgrNewClass);
      PRAGMA interface_information (SOMDObjectMgrNewClass, ".SOMDObjectMgrNewClass");
   BEGIN
      RETURN SOMDObjectMgrNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMDObjectMgrClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMDObjectMgrClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somdFindServer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      serverid : IN SOM.ImplId)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Finds and returns a proxy to the Server object which is identified by the
     -- ImplId.  (ImplId is defined at server registration time, and can be
     -- obtained from the ImplDef.)
     --
     -- OWNERSHIP of returned SOMDServer object is transferred to the caller.
      FUNCTION SOMDObjectMgr_somdFindServer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         serverid : IN SOM.ImplId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDObjectMgr_somdFindServer);
      PRAGMA interface_information (SOMDObjectMgr_somdFindServer, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObjectMgr_somdFindServer (
            Self.som_object,
            Ev,
            serverid,
            SOMDObjectMgrClassData.somdFindServer);
      RETURN Result;
   END somdFindServer; 

   FUNCTION somdFindServerByName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      servername : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Finds and returns a proxy to the Server object with the specified name.
     -- (The name is defined at server registration time, and can be obtained
     -- from the ImplDef.)
     --
     -- OWNERSHIP of returned SOMDServer object is transferred to the caller.
      FUNCTION SOMDObjectMgr_somdFindServerByName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         servername : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDObjectMgr_somdFindServerByName);
      PRAGMA interface_information (SOMDObjectMgr_somdFindServerByName, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObjectMgr_somdFindServerByName (
            Self.som_object,
            Ev,
            servername,
            SOMDObjectMgrClassData.somdFindServerByName);
      RETURN Result;
   END somdFindServerByName; 

   FUNCTION somdFindServersByClass (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objclass : IN SOM.Identifier)
      RETURN SOMDObjectMgr.SOMDServer_Unbounded.Sequence
   IS
     
     -- Finds all Server objects which can create an object of the named class.
     --
     -- OWNERSHIP of returned SOMDServer objects is transferred to the caller.
      PROCEDURE SOMDObjectMgr_somdFindServersByClass(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objclass : IN SOM.Identifier;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDObjectMgr_somdFindServersByClass);
      PRAGMA interface_information (SOMDObjectMgr_somdFindServersByClass, ".xsomcall4");
      Result : ALIASED SOMDObjectMgr.SOMDServer_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDObjectMgr_somdFindServersByClass (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         objclass,
         SOMDObjectMgrClassData.somdFindServersByClass);
      RETURN Result;
   END somdFindServersByClass; 

   FUNCTION somdFindAnyServerByClass (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objclass : IN SOM.Identifier)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Finds (any) Server object which can create an object of the named class.
     -- (This is a specialization of the somdFindServerByClass method.)
     --
     -- OWNERSHIP of returned SOMDServer object is transferred to the caller.
      FUNCTION SOMDObjectMgr_somdFindAnyServerByClass(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objclass : IN SOM.Identifier;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDObjectMgr_somdFindAnyServerByClass);
      PRAGMA interface_information (SOMDObjectMgr_somdFindAnyServerByClass, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObjectMgr_somdFindAnyServerByClass (
            Self.som_object,
            Ev,
            objclass,
            SOMDObjectMgrClassData.somdFindAnyServerByClass);
      RETURN Result;
   END somdFindAnyServerByClass; 

   FUNCTION get_somd21somFree (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     --Method from the IDL attribute statement:
     --"attribute boolean somd21somFree"
      FUNCTION SOMDObjectMgr_U_get_somd21somFree(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDObjectMgr_U_get_somd21somFree);
      PRAGMA interface_information (SOMDObjectMgr_U_get_somd21somFree, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObjectMgr_U_get_somd21somFree (
            Self.som_object,
            Ev,
            SOMDObjectMgrClassData.get_somd21somFree);
      RETURN Result;
   END get_somd21somFree; 

   PROCEDURE set_somd21somFree (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somd21somFree : IN Corba.Boolean)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute boolean somd21somFree"
      PROCEDURE SOMDObjectMgr_U_set_somd21somFree(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somd21somFree : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDObjectMgr_U_set_somd21somFree);
      PRAGMA interface_information (SOMDObjectMgr_U_set_somd21somFree, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDObjectMgr_U_set_somd21somFree (
         Self.som_object,
         Ev,
         somd21somFree,
         SOMDObjectMgrClassData.set_somd21somFree);
   END set_somd21somFree;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

   FUNCTION somdNewObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objclass : IN SOM.Identifier; 
      hints : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         ObjectMgr.somdNewObject (
            ObjectMgr.Ref'(som_object=>Self.som_object),
            Ev,
            objclass,
            hints);
   END somdNewObject;

   FUNCTION somdGetIdFromObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.String
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         ObjectMgr.somdGetIdFromObject (
            ObjectMgr.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somdGetIdFromObject;

   FUNCTION somdGetObjectFromId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         ObjectMgr.somdGetObjectFromId (
            ObjectMgr.Ref'(som_object=>Self.som_object),
            Ev,
            id);
   END somdGetObjectFromId;

   PROCEDURE somdReleaseObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ObjectMgr.somdReleaseObject (
         ObjectMgr.Ref'(som_object=>Self.som_object),
         Ev,
         obj);
   END somdReleaseObject;

   PROCEDURE somdDestroyObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ObjectMgr.somdDestroyObject (
         ObjectMgr.Ref'(som_object=>Self.som_object),
         Ev,
         obj);
   END somdDestroyObject;

END SOMDObjectMgr; 







