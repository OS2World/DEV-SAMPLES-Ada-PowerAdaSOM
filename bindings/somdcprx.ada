
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:44 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMDObject;
WITH SOMClass;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMDClientProxy IS


   TYPE Ref IS NEW SOMDObject.Ref WITH NULL RECORD;

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
      


   PROCEDURE somdTargetFree (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Forwards _somFree method call to the remote target object.

   FUNCTION somdTargetGetClass (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Forwards _somGetClass method call to the remote target object.

   FUNCTION somdTargetGetClassName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Forwards _somGetClassName method call to the remote target object.

   PROCEDURE somdProxyFree (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Performs _somFree method call on the local proxy object.

   FUNCTION somdProxyGetClass (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Performs _somGetClass method call on the local proxy object.

   FUNCTION somdProxyGetClassName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Performs _somGetClassName method call on the local proxy object.

   PROCEDURE somdReleaseResources (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Instructs the proxy to free any memory it owns for use by the client.

   PROCEDURE create_request (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      ctx : IN SOM.SOMObjectPtr;
      operation : IN SOM.Identifier;
      arg_list : IN SOM.SOMObjectPtr;
      result : IN OUT SOM.NamedValue;
      request : OUT SOM.SOMObjectPtr;
      req_flags : IN SOM.Flags;
      IDL_Result : OUT SOM.ORBStatus);

   PROCEDURE create_request_args (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      operation : IN SOM.Identifier;
      arg_list : OUT SOM.SOMObjectPtr;
      result : OUT SOM.NamedValue;
      IDL_Result : OUT SOM.ORBStatus);

   FUNCTION is_proxy (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;

   PROCEDURE release (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   PROCEDURE somDispatch (
      Self : IN Ref;
      retValue : OUT SOM.somToken;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list;
      Result : OUT Corba.Boolean);

   PROCEDURE somDispatchV (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list);

   FUNCTION somDispatchL (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Long;

   FUNCTION somDispatchD (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Double;

   FUNCTION somDispatchA (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN SOM.VoidPtr;

   PROCEDURE somFree (
      Self : IN Ref);

   FUNCTION somGetClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somGetClassName (
      Self : IN Ref)
      RETURN Corba.String;

   PROCEDURE somDestruct (
      Self : IN Ref;
      doFree : IN Corba.Octet;
      ctrl : IN OUT SOM.somDestructCtrl);

   PROCEDURE somDefaultInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl);

END SOMDClientProxy; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMDClientProxy IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somdTargetFree : SOM.somMToken;
      somdTargetGetClass : SOM.somMToken;
      somdTargetGetClassName : SOM.somMToken;
      somdProxyFree : SOM.somMToken;
      somdProxyGetClass : SOM.somMToken;
      somdProxyGetClassName : SOM.somMToken;
      set_binding : SOM.somMToken;
      get_binding : SOM.somMToken;
      reset_binding : SOM.somMToken;
      get_ctx_seq : SOM.somMToken;
      set_ctx_seq : SOM.somMToken;
      somdReleaseResources : SOM.somMToken;
      get_memoryMgr : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMDClientProxyClassData : classData;
   FOR SOMDClientProxyClassData USE AT standard.system.label("SOMDClientProxyClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMDClientProxyCClassData : CClassData;
   FOR SOMDClientProxyCClassData USE AT standard.system.label("SOMDClientProxyCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMDClientProxyClassData.classObject) 
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
      FUNCTION SOMDClientProxyNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMDClientProxyNewClass);
      PRAGMA interface_information (SOMDClientProxyNewClass, ".SOMDClientProxyNewClass");
   BEGIN
      RETURN SOMDClientProxyNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMDClientProxyClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMDClientProxyClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somdTargetFree (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Forwards _somFree method call to the remote target object.
      PROCEDURE SOMDClientProxy_somdTargetFree(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDClientProxy_somdTargetFree);
      PRAGMA interface_information (SOMDClientProxy_somdTargetFree, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDClientProxy_somdTargetFree (
         Self.som_object,
         Ev,
         SOMDClientProxyClassData.somdTargetFree);
   END somdTargetFree;

   FUNCTION somdTargetGetClass (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Forwards _somGetClass method call to the remote target object.
      FUNCTION SOMDClientProxy_somdTargetGetClass(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDClientProxy_somdTargetGetClass);
      PRAGMA interface_information (SOMDClientProxy_somdTargetGetClass, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDClientProxy_somdTargetGetClass (
            Self.som_object,
            Ev,
            SOMDClientProxyClassData.somdTargetGetClass);
      RETURN Result;
   END somdTargetGetClass; 

   FUNCTION somdTargetGetClassName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Forwards _somGetClassName method call to the remote target object.
      FUNCTION SOMDClientProxy_somdTargetGetClassName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMDClientProxy_somdTargetGetClassName);
      PRAGMA interface_information (SOMDClientProxy_somdTargetGetClassName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDClientProxy_somdTargetGetClassName (
            Self.som_object,
            Ev,
            SOMDClientProxyClassData.somdTargetGetClassName);
      RETURN Result;
   END somdTargetGetClassName; 

   PROCEDURE somdProxyFree (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Performs _somFree method call on the local proxy object.
      PROCEDURE SOMDClientProxy_somdProxyFree(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDClientProxy_somdProxyFree);
      PRAGMA interface_information (SOMDClientProxy_somdProxyFree, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDClientProxy_somdProxyFree (
         Self.som_object,
         Ev,
         SOMDClientProxyClassData.somdProxyFree);
   END somdProxyFree;

   FUNCTION somdProxyGetClass (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Performs _somGetClass method call on the local proxy object.
      FUNCTION SOMDClientProxy_somdProxyGetClass(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDClientProxy_somdProxyGetClass);
      PRAGMA interface_information (SOMDClientProxy_somdProxyGetClass, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDClientProxy_somdProxyGetClass (
            Self.som_object,
            Ev,
            SOMDClientProxyClassData.somdProxyGetClass);
      RETURN Result;
   END somdProxyGetClass; 

   FUNCTION somdProxyGetClassName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Performs _somGetClassName method call on the local proxy object.
      FUNCTION SOMDClientProxy_somdProxyGetClassName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMDClientProxy_somdProxyGetClassName);
      PRAGMA interface_information (SOMDClientProxy_somdProxyGetClassName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDClientProxy_somdProxyGetClassName (
            Self.som_object,
            Ev,
            SOMDClientProxyClassData.somdProxyGetClassName);
      RETURN Result;
   END somdProxyGetClassName; 

   PROCEDURE somdReleaseResources (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Instructs the proxy to free any memory it owns for use by the client.
      PROCEDURE SOMDClientProxy_somdReleaseResources(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDClientProxy_somdReleaseResources);
      PRAGMA interface_information (SOMDClientProxy_somdReleaseResources, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDClientProxy_somdReleaseResources (
         Self.som_object,
         Ev,
         SOMDClientProxyClassData.somdReleaseResources);
   END somdReleaseResources;

   PROCEDURE create_request (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      ctx : IN SOM.SOMObjectPtr; 
      operation : IN SOM.Identifier; 
      arg_list : IN SOM.SOMObjectPtr; 
      result : IN OUT SOM.NamedValue; 
      request : OUT SOM.SOMObjectPtr; 
      req_flags : IN SOM.Flags; 
      IDL_Result : OUT SOM.ORBStatus)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDObject.create_request (
         SOMDObject.Ref'(som_object=>Self.som_object),
         Ev,
         ctx,
         operation,
         arg_list,
         result,
         request,
         req_flags,
         IDL_Result);
   END create_request;

   PROCEDURE create_request_args (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      operation : IN SOM.Identifier; 
      arg_list : OUT SOM.SOMObjectPtr; 
      result : OUT SOM.NamedValue; 
      IDL_Result : OUT SOM.ORBStatus)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDObject.create_request_args (
         SOMDObject.Ref'(som_object=>Self.som_object),
         Ev,
         operation,
         arg_list,
         result,
         IDL_Result);
   END create_request_args;

   FUNCTION is_proxy (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMDObject.is_proxy (
            SOMDObject.Ref'(som_object=>Self.som_object),
            Ev);
   END is_proxy;

   PROCEDURE release (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDObject.release (
         SOMDObject.Ref'(som_object=>Self.som_object),
         Ev);
   END release;

   PROCEDURE somDispatch (
      Self : IN Ref; 
      retValue : OUT SOM.somToken; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list; 
      Result : OUT Corba.Boolean)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDispatch (
         SOMObject.Ref'(som_object=>Self.som_object),
         retValue,
         methodId,
         ap,
         Result);
   END somDispatch;

   PROCEDURE somDispatchV (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDispatchV (
         SOMObject.Ref'(som_object=>Self.som_object),
         methodId,
         descriptor,
         ap);
   END somDispatchV;

   FUNCTION somDispatchL (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somDispatchL (
            SOMObject.Ref'(som_object=>Self.som_object),
            methodId,
            descriptor,
            ap);
   END somDispatchL;

   FUNCTION somDispatchD (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Double
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somDispatchD (
            SOMObject.Ref'(som_object=>Self.som_object),
            methodId,
            descriptor,
            ap);
   END somDispatchD;

   FUNCTION somDispatchA (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN SOM.VoidPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somDispatchA (
            SOMObject.Ref'(som_object=>Self.som_object),
            methodId,
            descriptor,
            ap);
   END somDispatchA;

   PROCEDURE somFree (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somFree (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somFree;

   FUNCTION somGetClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somGetClass (
            SOMObject.Ref'(som_object=>Self.som_object));
   END somGetClass;

   FUNCTION somGetClassName (
      Self : IN Ref)
      RETURN Corba.String
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somGetClassName (
            SOMObject.Ref'(som_object=>Self.som_object));
   END somGetClassName;

   PROCEDURE somDestruct (
      Self : IN Ref; 
      doFree : IN Corba.Octet; 
      ctrl : IN OUT SOM.somDestructCtrl)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDestruct (
         SOMObject.Ref'(som_object=>Self.som_object),
         doFree,
         ctrl);
   END somDestruct;

   PROCEDURE somDefaultInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDefaultInit (
         SOMObject.Ref'(som_object=>Self.som_object),
         ctrl);
   END somDefaultInit;

END SOMDClientProxy; 







