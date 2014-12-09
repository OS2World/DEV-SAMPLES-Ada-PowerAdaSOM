
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:27 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Request IS


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
      


   FUNCTION add_arg (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN SOM.Identifier;
      arg_type : IN Corba.TypeCode.Object;
      value : IN SOM.VoidPtr;
      len : IN Corba.Long;
      arg_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- Incrementally adds an arg to the Request.
     -- The Request must have been created using the "create_request"
     -- method, with an empty argument list.  (We can't add args to a
     -- list that was passed in to the create_request call. [pg. 109])

   FUNCTION invoke (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      invoke_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- Invokes the Request synchronously, waiting for the response.

   FUNCTION send (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      invoke_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- Invokes the Request asynchronously.  The response must eventually
     -- be checked by invoking get_response or get_next_response.

   FUNCTION get_response (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      response_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- Determines whether an asynchronous Request has completed.

   FUNCTION destroy (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.ORBStatus;
     
     -- Deletes the memory allocated by the ORB for the Request.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END Request; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Request IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      add_arg : SOM.somMToken;
      invoke : SOM.somMToken;
      send : SOM.somMToken;
      get_response : SOM.somMToken;
      destroy : SOM.somMToken;
      get_objref : SOM.somMToken;
      set_objref : SOM.somMToken;
      get_ctx : SOM.somMToken;
      set_ctx : SOM.somMToken;
      get_operation : SOM.somMToken;
      set_operation : SOM.somMToken;
      get_argument_list : SOM.somMToken;
      set_argument_list : SOM.somMToken;
      get_return_result : SOM.somMToken;
      set_return_result : SOM.somMToken;
      get_req_flags : SOM.somMToken;
      set_req_flags : SOM.somMToken;
      get_env : SOM.somMToken;
      set_env : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   RequestClassData : classData;
   FOR RequestClassData USE AT standard.system.label("RequestClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   RequestCClassData : CClassData;
   FOR RequestCClassData USE AT standard.system.label("RequestCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            RequestClassData.classObject) 
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
      FUNCTION RequestNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, RequestNewClass);
      PRAGMA interface_information (RequestNewClass, ".RequestNewClass");
   BEGIN
      RETURN RequestNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF RequestClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(RequestClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION add_arg (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN SOM.Identifier; 
      arg_type : IN Corba.TypeCode.Object; 
      value : IN SOM.VoidPtr; 
      len : IN Corba.Long; 
      arg_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- Incrementally adds an arg to the Request.
     -- The Request must have been created using the "create_request"
     -- method, with an empty argument list.  (We can't add args to a
     -- list that was passed in to the create_request call. [pg. 109])
      FUNCTION Request_add_arg(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN SOM.Identifier; 
         arg_type : IN Corba.TypeCode.Object; 
         value : IN SOM.VoidPtr; 
         len : IN Corba.Long; 
         arg_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Request_add_arg);
      PRAGMA interface_information (Request_add_arg, ".xsomcall7");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Request_add_arg (
            Self.som_object,
            Ev,
            name,
            arg_type,
            value,
            len,
            arg_flags,
            RequestClassData.add_arg);
      RETURN Result;
   END add_arg; 

   FUNCTION invoke (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      invoke_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- Invokes the Request synchronously, waiting for the response.
      FUNCTION Request_invoke(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         invoke_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Request_invoke);
      PRAGMA interface_information (Request_invoke, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Request_invoke (
            Self.som_object,
            Ev,
            invoke_flags,
            RequestClassData.invoke);
      RETURN Result;
   END invoke; 

   FUNCTION send (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      invoke_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- Invokes the Request asynchronously.  The response must eventually
     -- be checked by invoking get_response or get_next_response.
      FUNCTION Request_send(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         invoke_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Request_send);
      PRAGMA interface_information (Request_send, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Request_send (
            Self.som_object,
            Ev,
            invoke_flags,
            RequestClassData.send);
      RETURN Result;
   END send; 

   FUNCTION get_response (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      response_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- Determines whether an asynchronous Request has completed.
      FUNCTION Request_get_response(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         response_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Request_get_response);
      PRAGMA interface_information (Request_get_response, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Request_get_response (
            Self.som_object,
            Ev,
            response_flags,
            RequestClassData.get_response);
      RETURN Result;
   END get_response; 

   FUNCTION destroy (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.ORBStatus
   IS
     
     -- Deletes the memory allocated by the ORB for the Request.
      FUNCTION Request_destroy(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Request_destroy);
      PRAGMA interface_information (Request_destroy, ".xsomcall2");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Request_destroy (
            Self.som_object,
            Ev,
            RequestClassData.destroy);
      RETURN Result;
   END destroy; 

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

END Request; 







