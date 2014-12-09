
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:44 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMDObject IS


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
      


   FUNCTION get_implementation (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the implementation definition for the referenced object.

   FUNCTION get_interface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the interface definition for the referenced object.

   FUNCTION is_nil (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- Tests to see if the object reference is nil.
     -- This is a procedure method.  Therefore, it can be invoked on OBJECT_NIL
     -- (a null pointer), but it cannot be overridden.

   FUNCTION is_SOM_ref (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if object reference was created by SOMOA::create_SOM_ref
     -- else returns FALSE.

   FUNCTION is_constant (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if object reference was created by SOMOA::create_constant
     -- else returns FALSE.

   FUNCTION is_proxy (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if object reference (self) is a DSOM client proxy object
     -- (i.e., the target object is remote).  Returns FALSE if the referenced
     -- object is in the same process as the reference.
     --
     -- The default implementation returns FALSE.  Proxy classes which are
     -- subclasses of SOMDObject (like SOMDClientProxy) should override this
     -- method to return TRUE.

   FUNCTION duplicate (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Makes a duplicate of the object reference.
     -- OWNERSHIP of returned object is transferred to the caller.
     -- Call release to free the object.

   PROCEDURE release (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Releases the memory associated with the object reference.

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
     
     -- Creates a request to execute a particular operation on the
     -- referenced object.
     --
     -- CORBA 1.1 introduces this method in this class, but DSOM actually
     -- implements this method in the SOMDClientProxy subclass.

   PROCEDURE create_request_args (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      operation : IN SOM.Identifier;
      arg_list : OUT SOM.SOMObjectPtr;
      result : OUT SOM.NamedValue;
      IDL_Result : OUT SOM.ORBStatus);
     
     -- Creates the appropriate arg_list (NVList) for the specified operation.
     -- Also creates a NamedValue to hold the result.
     -- (Similar in function to ORB_create_operation_list.)
     --
     -- This method is defined in this class, as a companion to the
     -- "create_request" method, but DSOM implements this method in the
     -- SOMDClientProxy subclass.

   PROCEDURE somDefaultInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl);

   PROCEDURE somDestruct (
      Self : IN Ref;
      doFree : IN Corba.Octet;
      ctrl : IN OUT SOM.somDestructCtrl);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMDObject; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMDObject IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_implementation : SOM.somMToken;
      get_interface : SOM.somMToken;
      set_to_nil : SOM.somMToken;
      is_nil : SOM.somMToken;
      is_SOM_ref : SOM.somMToken;
      is_constant : SOM.somMToken;
      is_proxy : SOM.somMToken;
      duplicate : SOM.somMToken;
      release : SOM.somMToken;
      create_request : SOM.somMToken;
      create_request_args : SOM.somMToken;
      get_somd_tag : SOM.somMToken;
      get_somd_flags : SOM.somMToken;
      set_somd_flags : SOM.somMToken;
      get_somd_impl : SOM.somMToken;
      set_somd_impl : SOM.somMToken;
      get_somd_rid : SOM.somMToken;
      set_somd_rid : SOM.somMToken;
      get_somd_id : SOM.somMToken;
      set_somd_id : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMDObjectClassData : classData;
   FOR SOMDObjectClassData USE AT standard.system.label("SOMDObjectClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMDObjectCClassData : CClassData;
   FOR SOMDObjectCClassData USE AT standard.system.label("SOMDObjectCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMDObjectClassData.classObject) 
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
      FUNCTION SOMDObjectNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMDObjectNewClass);
      PRAGMA interface_information (SOMDObjectNewClass, ".SOMDObjectNewClass");
   BEGIN
      RETURN SOMDObjectNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMDObjectClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMDObjectClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_implementation (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the implementation definition for the referenced object.
      FUNCTION SOMDObject_get_implementation(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDObject_get_implementation);
      PRAGMA interface_information (SOMDObject_get_implementation, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_get_implementation (
            Self.som_object,
            Ev,
            SOMDObjectClassData.get_implementation);
      RETURN Result;
   END get_implementation; 

   FUNCTION get_interface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the interface definition for the referenced object.
      FUNCTION SOMDObject_get_interface(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDObject_get_interface);
      PRAGMA interface_information (SOMDObject_get_interface, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_get_interface (
            Self.som_object,
            Ev,
            SOMDObjectClassData.get_interface);
      RETURN Result;
   END get_interface; 

   FUNCTION is_nil (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- Tests to see if the object reference is nil.
     -- This is a procedure method.  Therefore, it can be invoked on OBJECT_NIL
     -- (a null pointer), but it cannot be overridden.
      FUNCTION SOMDObject_is_nil(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDObject_is_nil);
      PRAGMA interface_information (SOMDObject_is_nil, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_is_nil (
            Self.som_object,
            Ev,
            SOMDObjectClassData.is_nil);
      RETURN Result;
   END is_nil; 

   FUNCTION is_SOM_ref (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if object reference was created by SOMOA::create_SOM_ref
     -- else returns FALSE.
      FUNCTION SOMDObject_is_SOM_ref(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDObject_is_SOM_ref);
      PRAGMA interface_information (SOMDObject_is_SOM_ref, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_is_SOM_ref (
            Self.som_object,
            Ev,
            SOMDObjectClassData.is_SOM_ref);
      RETURN Result;
   END is_SOM_ref; 

   FUNCTION is_constant (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if object reference was created by SOMOA::create_constant
     -- else returns FALSE.
      FUNCTION SOMDObject_is_constant(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDObject_is_constant);
      PRAGMA interface_information (SOMDObject_is_constant, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_is_constant (
            Self.som_object,
            Ev,
            SOMDObjectClassData.is_constant);
      RETURN Result;
   END is_constant; 

   FUNCTION is_proxy (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if object reference (self) is a DSOM client proxy object
     -- (i.e., the target object is remote).  Returns FALSE if the referenced
     -- object is in the same process as the reference.
     --
     -- The default implementation returns FALSE.  Proxy classes which are
     -- subclasses of SOMDObject (like SOMDClientProxy) should override this
     -- method to return TRUE.
      FUNCTION SOMDObject_is_proxy(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDObject_is_proxy);
      PRAGMA interface_information (SOMDObject_is_proxy, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_is_proxy (
            Self.som_object,
            Ev,
            SOMDObjectClassData.is_proxy);
      RETURN Result;
   END is_proxy; 

   FUNCTION duplicate (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Makes a duplicate of the object reference.
     -- OWNERSHIP of returned object is transferred to the caller.
     -- Call release to free the object.
      FUNCTION SOMDObject_duplicate(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDObject_duplicate);
      PRAGMA interface_information (SOMDObject_duplicate, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDObject_duplicate (
            Self.som_object,
            Ev,
            SOMDObjectClassData.duplicate);
      RETURN Result;
   END duplicate; 

   PROCEDURE release (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Releases the memory associated with the object reference.
      PROCEDURE SOMDObject_release(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDObject_release);
      PRAGMA interface_information (SOMDObject_release, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDObject_release (
         Self.som_object,
         Ev,
         SOMDObjectClassData.release);
   END release;

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
     
     -- Creates a request to execute a particular operation on the
     -- referenced object.
     --
     -- CORBA 1.1 introduces this method in this class, but DSOM actually
     -- implements this method in the SOMDClientProxy subclass.
      FUNCTION SOMDObject_create_request(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         ctx : IN SOM.SOMObjectPtr; 
         operation : IN SOM.Identifier; 
         arg_list : IN SOM.SOMObjectPtr; 
         result : IN SOM.address; 
         request : IN SOM.SOMObjectPtr; 
         req_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDObject_create_request);
      PRAGMA interface_information (SOMDObject_create_request, ".xsomcall8");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      IDL_Result :=
         SOMDObject_create_request (
            Self.som_object,
            Ev,
            ctx,
            operation,
            arg_list,
            SOM.To_SOM_Address(result'address),
            SOM.To_SOM_Address(request'address),
            req_flags,
            SOMDObjectClassData.create_request);
   END create_request;

   PROCEDURE create_request_args (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      operation : IN SOM.Identifier; 
      arg_list : OUT SOM.SOMObjectPtr; 
      result : OUT SOM.NamedValue; 
      IDL_Result : OUT SOM.ORBStatus)
   IS
     
     -- Creates the appropriate arg_list (NVList) for the specified operation.
     -- Also creates a NamedValue to hold the result.
     -- (Similar in function to ORB_create_operation_list.)
     --
     -- This method is defined in this class, as a companion to the
     -- "create_request" method, but DSOM implements this method in the
     -- SOMDClientProxy subclass.
      FUNCTION SOMDObject_create_request_args(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         operation : IN SOM.Identifier; 
         arg_list : IN SOM.SOMObjectPtr; 
         result : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMDObject_create_request_args);
      PRAGMA interface_information (SOMDObject_create_request_args, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      IDL_Result :=
         SOMDObject_create_request_args (
            Self.som_object,
            Ev,
            operation,
            SOM.To_SOM_Address(arg_list'address),
            SOM.To_SOM_Address(result'address),
            SOMDObjectClassData.create_request_args);
   END create_request_args;

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

   PROCEDURE somDumpSelfInt (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDumpSelfInt (
         SOMObject.Ref'(som_object=>Self.som_object),
         level);
   END somDumpSelfInt;

END SOMDObject; 







