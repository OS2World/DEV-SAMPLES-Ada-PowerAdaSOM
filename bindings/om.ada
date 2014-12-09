
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:20 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE ObjectMgr IS


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
      


   FUNCTION somdNewObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objclass : IN SOM.Identifier;
      hints : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns a new object of the named class.  This is a "basic" creation
     -- method, where the decisions about where and how to create the object
     -- are mostly left up to the Object Manager.  However, the Object Manager
     -- may optionally define creation "hints" which the client may specify in
     -- this call.
     --
     -- OWNERSHIP of returned object is transferred to the caller.
     -- methods for identification & location/activation

   FUNCTION somdGetIdFromObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.String;
     
     -- Returns a external id for an object managed by this Object Manager.
     -- The id is unambiguous -- it always refers to the same object (as long
     -- as the object exists).
     --
     -- OWNERSHIP of returned id string is transferred to the caller.

   FUNCTION somdGetObjectFromId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Finds and/or activates an object implemented by this Object Manager,
     -- given its id.
     --
     -- OWNERSHIP of returned object is transferred to the caller.
     -- methods for releasing / destroying objects

   PROCEDURE somdReleaseObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Indicates that the client has finished using the object, and the
     -- "connection" to the object, if any, can be released.

   PROCEDURE somdDestroyObject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Causes the specified object to be destroyed.  (There is an implicit
     -- somoReleaseObject call made.)

END ObjectMgr; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY ObjectMgr IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somdNewObject : SOM.somMToken;
      somdGetIdFromObject : SOM.somMToken;
      somdGetObjectFromId : SOM.somMToken;
      somdReleaseObject : SOM.somMToken;
      somdDestroyObject : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ObjectMgrClassData : classData;
   FOR ObjectMgrClassData USE AT standard.system.label("ObjectMgrClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ObjectMgrCClassData : CClassData;
   FOR ObjectMgrCClassData USE AT standard.system.label("ObjectMgrCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ObjectMgrClassData.classObject) 
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
      FUNCTION ObjectMgrNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ObjectMgrNewClass);
      PRAGMA interface_information (ObjectMgrNewClass, ".ObjectMgrNewClass");
   BEGIN
      RETURN ObjectMgrNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ObjectMgrClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ObjectMgrClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somdNewObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objclass : IN SOM.Identifier; 
      hints : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns a new object of the named class.  This is a "basic" creation
     -- method, where the decisions about where and how to create the object
     -- are mostly left up to the Object Manager.  However, the Object Manager
     -- may optionally define creation "hints" which the client may specify in
     -- this call.
     --
     -- OWNERSHIP of returned object is transferred to the caller.
     -- methods for identification & location/activation
      FUNCTION ObjectMgr_somdNewObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objclass : IN SOM.Identifier; 
         hints : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, ObjectMgr_somdNewObject);
      PRAGMA interface_information (ObjectMgr_somdNewObject, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ObjectMgr_somdNewObject (
            Self.som_object,
            Ev,
            objclass,
            hints,
            ObjectMgrClassData.somdNewObject);
      RETURN Result;
   END somdNewObject; 

   FUNCTION somdGetIdFromObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.String
   IS
     
     -- Returns a external id for an object managed by this Object Manager.
     -- The id is unambiguous -- it always refers to the same object (as long
     -- as the object exists).
     --
     -- OWNERSHIP of returned id string is transferred to the caller.
      FUNCTION ObjectMgr_somdGetIdFromObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ObjectMgr_somdGetIdFromObject);
      PRAGMA interface_information (ObjectMgr_somdGetIdFromObject, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ObjectMgr_somdGetIdFromObject (
            Self.som_object,
            Ev,
            obj,
            ObjectMgrClassData.somdGetIdFromObject);
      RETURN Result;
   END somdGetIdFromObject; 

   FUNCTION somdGetObjectFromId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Finds and/or activates an object implemented by this Object Manager,
     -- given its id.
     --
     -- OWNERSHIP of returned object is transferred to the caller.
     -- methods for releasing / destroying objects
      FUNCTION ObjectMgr_somdGetObjectFromId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         id : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, ObjectMgr_somdGetObjectFromId);
      PRAGMA interface_information (ObjectMgr_somdGetObjectFromId, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ObjectMgr_somdGetObjectFromId (
            Self.som_object,
            Ev,
            id,
            ObjectMgrClassData.somdGetObjectFromId);
      RETURN Result;
   END somdGetObjectFromId; 

   PROCEDURE somdReleaseObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Indicates that the client has finished using the object, and the
     -- "connection" to the object, if any, can be released.
      PROCEDURE ObjectMgr_somdReleaseObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ObjectMgr_somdReleaseObject);
      PRAGMA interface_information (ObjectMgr_somdReleaseObject, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ObjectMgr_somdReleaseObject (
         Self.som_object,
         Ev,
         obj,
         ObjectMgrClassData.somdReleaseObject);
   END somdReleaseObject;

   PROCEDURE somdDestroyObject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Causes the specified object to be destroyed.  (There is an implicit
     -- somoReleaseObject call made.)
      PROCEDURE ObjectMgr_somdDestroyObject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ObjectMgr_somdDestroyObject);
      PRAGMA interface_information (ObjectMgr_somdDestroyObject, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ObjectMgr_somdDestroyObject (
         Self.som_object,
         Ev,
         obj,
         ObjectMgrClassData.somdDestroyObject);
   END somdDestroyObject;

END ObjectMgr; 







