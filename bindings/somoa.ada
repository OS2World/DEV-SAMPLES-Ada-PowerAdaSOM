
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:48 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH BOA;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMOA IS


   TYPE Ref IS NEW BOA.Ref WITH NULL RECORD;

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
      


   FUNCTION execute_next_request (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      waitFlag : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- This method receives a single request message, executes it, and
     -- sends the result to the calling client.  If waitFlag is SOMD_WAIT,
     -- the call will block if there is no message pending.  If waitFlag
     -- is SOMD_NO_WAIT, the call will immediately return "SOMDERROR_NoMessages"
     -- if there is no message pending.
     --
     -- ("SOMDERROR_NoMessage" is only returned as a status code, not as an
     -- exception structure.)

   FUNCTION execute_request_loop (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      waitFlag : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- Repeatedly calls execute_next_request.  If waitFlag is SOMD_WAIT,
     -- the call will continue to wait for messages when there is no message
     -- pending.  If waitFlag is SOMD_NO_WAIT, the call will process any
     -- messages that are present, and return "SOMD_NoMessages" as soon as there
     -- are no more messages pending.
     --
     -- ("SOMDERROR_NoMessage" is only returned as a status code, not as an
     -- exception structure.)

   PROCEDURE change_id (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objref : IN SOM.SOMObjectPtr;
      id : IN SOM.ReferenceData);
     
     -- This method changes the ReferenceData associated with the object
     -- identified by "objref".  The ReferenceData previously stored in the
     -- SOMOA's reference data table is replaced with the value of "id".
     -- The new id value cannot be larger than the maximum size of the
     -- original ReferenceData (usually specified as 1024 bytes).

   FUNCTION create_constant (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN SOM.ReferenceData;
      intf : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method is a variant of the "create" method.  Like "create", it
     -- creates an object reference for an object (with the specified interface)
     -- and associates the supplied ReferenceData with the object reference.
     -- The ReferenceData can later be retrieved using the "get_id" method.
     -- Unlike "create", this method creates a "contant" reference whose id
     -- value cannot be changed.  (See "change_id" below.)  This is because
     -- the id is part of the object reference state, versus stored in the
     -- SOMOA reference data table.
     --
     -- This method would be used whenever the application prefers not to
     -- maintain an object's ReferenceData in the SOMOA reference data table.

   FUNCTION create_SOM_ref (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somobj : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This methods creates a simple DSOM reference (SOMDObject) for a local
     -- SOM object.  The reference is "special" in that there is no explicit
     -- ReferenceData associated with the object.  Also, the reference is
     -- only valid while the SOM object exists.
     --
     -- The SOMObject can be retrieved via the get_SOM_object method.
     -- The SOMDObject::is_SOM_ref method can be used to tell if the
     -- reference was created using create_SOM_ref or not.

   FUNCTION get_SOM_object (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somref : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns the SOM object associated with a SOMDObject
     -- reference created by the create_SOM_ref method.

   PROCEDURE activate_impl_failed (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl : IN SOM.SOMObjectPtr;
      rc : IN SOM.ORBStatus);
     
     -- Indicates there was an error when activating this implementation.
     -- Called by a server program.  ORBStatus code is returned to the client
     -- in an exception.

   PROCEDURE interrupt_server (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Wakes up a server waiting for a request message.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION create (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN SOM.ReferenceData;
      intf : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE dispose (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);

   PROCEDURE change_implementation (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr);

   FUNCTION get_id (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.ReferenceData;

   FUNCTION get_principal (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr;
      req_ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE set_exception (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      major : IN SOM.exception_type;
      userid : IN Corba.String;
      param : IN SOM.VoidPtr);

   PROCEDURE impl_is_ready (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl : IN SOM.SOMObjectPtr);

   PROCEDURE deactivate_impl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl : IN SOM.SOMObjectPtr);

   PROCEDURE obj_is_ready (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr);

   PROCEDURE deactivate_obj (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);

END SOMOA; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMOA IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      execute_next_request : SOM.somMToken;
      execute_request_loop : SOM.somMToken;
      create_constant : SOM.somMToken;
      change_id : SOM.somMToken;
      create_SOM_ref : SOM.somMToken;
      get_SOM_object : SOM.somMToken;
      activate_impl_failed : SOM.somMToken;
      interrupt_server : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMOAClassData : classData;
   FOR SOMOAClassData USE AT standard.system.label("SOMOAClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMOACClassData : CClassData;
   FOR SOMOACClassData USE AT standard.system.label("SOMOACClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMOAClassData.classObject) 
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
      FUNCTION SOMOANewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMOANewClass);
      PRAGMA interface_information (SOMOANewClass, ".SOMOANewClass");
   BEGIN
      RETURN SOMOANewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMOAClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMOAClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION execute_next_request (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      waitFlag : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- This method receives a single request message, executes it, and
     -- sends the result to the calling client.  If waitFlag is SOMD_WAIT,
     -- the call will block if there is no message pending.  If waitFlag
     -- is SOMD_NO_WAIT, the call will immediately return "SOMDERROR_NoMessages"
     -- if there is no message pending.
     --
     -- ("SOMDERROR_NoMessage" is only returned as a status code, not as an
     -- exception structure.)
      FUNCTION SOMOA_execute_next_request(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         waitFlag : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMOA_execute_next_request);
      PRAGMA interface_information (SOMOA_execute_next_request, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMOA_execute_next_request (
            Self.som_object,
            Ev,
            waitFlag,
            SOMOAClassData.execute_next_request);
      RETURN Result;
   END execute_next_request; 

   FUNCTION execute_request_loop (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      waitFlag : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- Repeatedly calls execute_next_request.  If waitFlag is SOMD_WAIT,
     -- the call will continue to wait for messages when there is no message
     -- pending.  If waitFlag is SOMD_NO_WAIT, the call will process any
     -- messages that are present, and return "SOMD_NoMessages" as soon as there
     -- are no more messages pending.
     --
     -- ("SOMDERROR_NoMessage" is only returned as a status code, not as an
     -- exception structure.)
      FUNCTION SOMOA_execute_request_loop(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         waitFlag : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, SOMOA_execute_request_loop);
      PRAGMA interface_information (SOMOA_execute_request_loop, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMOA_execute_request_loop (
            Self.som_object,
            Ev,
            waitFlag,
            SOMOAClassData.execute_request_loop);
      RETURN Result;
   END execute_request_loop; 

   PROCEDURE change_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objref : IN SOM.SOMObjectPtr; 
      id : IN SOM.ReferenceData)
   IS
     
     -- This method changes the ReferenceData associated with the object
     -- identified by "objref".  The ReferenceData previously stored in the
     -- SOMOA's reference data table is replaced with the value of "id".
     -- The new id value cannot be larger than the maximum size of the
     -- original ReferenceData (usually specified as 1024 bytes).
      PROCEDURE SOMOA_change_id(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objref : IN SOM.SOMObjectPtr; 
         id : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMOA_change_id);
      PRAGMA interface_information (SOMOA_change_id, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMOA_change_id (
         Self.som_object,
         Ev,
         objref,
         SOM.To_SOM_Address(id'address),
         SOMOAClassData.change_id);
   END change_id;

   FUNCTION create_constant (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN SOM.ReferenceData; 
      intf : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method is a variant of the "create" method.  Like "create", it
     -- creates an object reference for an object (with the specified interface)
     -- and associates the supplied ReferenceData with the object reference.
     -- The ReferenceData can later be retrieved using the "get_id" method.
     -- Unlike "create", this method creates a "contant" reference whose id
     -- value cannot be changed.  (See "change_id" below.)  This is because
     -- the id is part of the object reference state, versus stored in the
     -- SOMOA reference data table.
     --
     -- This method would be used whenever the application prefers not to
     -- maintain an object's ReferenceData in the SOMOA reference data table.
      FUNCTION SOMOA_create_constant(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         id : IN SOM.address; 
         intf : IN SOM.SOMObjectPtr; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMOA_create_constant);
      PRAGMA interface_information (SOMOA_create_constant, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMOA_create_constant (
            Self.som_object,
            Ev,
            SOM.To_SOM_Address(id'address),
            intf,
            impl,
            SOMOAClassData.create_constant);
      RETURN Result;
   END create_constant; 

   FUNCTION create_SOM_ref (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somobj : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This methods creates a simple DSOM reference (SOMDObject) for a local
     -- SOM object.  The reference is "special" in that there is no explicit
     -- ReferenceData associated with the object.  Also, the reference is
     -- only valid while the SOM object exists.
     --
     -- The SOMObject can be retrieved via the get_SOM_object method.
     -- The SOMDObject::is_SOM_ref method can be used to tell if the
     -- reference was created using create_SOM_ref or not.
      FUNCTION SOMOA_create_SOM_ref(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somobj : IN SOM.SOMObjectPtr; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMOA_create_SOM_ref);
      PRAGMA interface_information (SOMOA_create_SOM_ref, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMOA_create_SOM_ref (
            Self.som_object,
            Ev,
            somobj,
            impl,
            SOMOAClassData.create_SOM_ref);
      RETURN Result;
   END create_SOM_ref; 

   FUNCTION get_SOM_object (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somref : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns the SOM object associated with a SOMDObject
     -- reference created by the create_SOM_ref method.
      FUNCTION SOMOA_get_SOM_object(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somref : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMOA_get_SOM_object);
      PRAGMA interface_information (SOMOA_get_SOM_object, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMOA_get_SOM_object (
            Self.som_object,
            Ev,
            somref,
            SOMOAClassData.get_SOM_object);
      RETURN Result;
   END get_SOM_object; 

   PROCEDURE activate_impl_failed (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl : IN SOM.SOMObjectPtr; 
      rc : IN SOM.ORBStatus)
   IS
     
     -- Indicates there was an error when activating this implementation.
     -- Called by a server program.  ORBStatus code is returned to the client
     -- in an exception.
      PROCEDURE SOMOA_activate_impl_failed(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl : IN SOM.SOMObjectPtr; 
         rc : IN SOM.ORBStatus;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMOA_activate_impl_failed);
      PRAGMA interface_information (SOMOA_activate_impl_failed, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMOA_activate_impl_failed (
         Self.som_object,
         Ev,
         impl,
         rc,
         SOMOAClassData.activate_impl_failed);
   END activate_impl_failed;

   PROCEDURE interrupt_server (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Wakes up a server waiting for a request message.
      PROCEDURE SOMOA_interrupt_server(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMOA_interrupt_server);
      PRAGMA interface_information (SOMOA_interrupt_server, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMOA_interrupt_server (
         Self.som_object,
         Ev,
         SOMOAClassData.interrupt_server);
   END interrupt_server;

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

   FUNCTION create (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN SOM.ReferenceData; 
      intf : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         BOA.create (
            BOA.Ref'(som_object=>Self.som_object),
            Ev,
            id,
            intf,
            impl);
   END create;

   PROCEDURE dispose (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.dispose (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         obj);
   END dispose;

   PROCEDURE change_implementation (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.change_implementation (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         obj,
         impl);
   END change_implementation;

   FUNCTION get_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.ReferenceData
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         BOA.get_id (
            BOA.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END get_id;

   FUNCTION get_principal (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr; 
      req_ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         BOA.get_principal (
            BOA.Ref'(som_object=>Self.som_object),
            Ev,
            obj,
            req_ev);
   END get_principal;

   PROCEDURE set_exception (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      major : IN SOM.exception_type; 
      userid : IN Corba.String; 
      param : IN SOM.VoidPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.set_exception (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         major,
         userid,
         param);
   END set_exception;

   PROCEDURE impl_is_ready (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.impl_is_ready (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         impl);
   END impl_is_ready;

   PROCEDURE deactivate_impl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.deactivate_impl (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         impl);
   END deactivate_impl;

   PROCEDURE obj_is_ready (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.obj_is_ready (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         obj,
         impl);
   END obj_is_ready;

   PROCEDURE deactivate_obj (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA.deactivate_obj (
         BOA.Ref'(som_object=>Self.som_object),
         Ev,
         obj);
   END deactivate_obj;

END SOMOA; 







