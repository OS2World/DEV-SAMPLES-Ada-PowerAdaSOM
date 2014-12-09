
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:05:59 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE BOA IS


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
      


   FUNCTION create (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN SOM.ReferenceData;
      intf : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Create an object reference.

   PROCEDURE dispose (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Destroy an object reference.

   FUNCTION get_id (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.ReferenceData;
     
     -- Return ReferenceData associated with referenced object.

   FUNCTION get_principal (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr;
      req_ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Return a Principal object, which describes who issued a request on
     -- the specified object.  The "req_ev" parameter is the Environment
     -- which was passed as part of the request.

   PROCEDURE set_exception (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      major : IN SOM.exception_type;
      userid : IN Corba.String;
      param : IN SOM.VoidPtr);
     
     -- Return an exception to the client.

   PROCEDURE impl_is_ready (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl : IN SOM.SOMObjectPtr);
     
     -- Indicate that the implementation is now ready to process requests.

   PROCEDURE deactivate_impl (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl : IN SOM.SOMObjectPtr);
     
     -- Indicate that the implementation is no longer ready to process reqs.

   PROCEDURE change_implementation (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr);
     
     -- Change the implementation associated with the referenced object.
     -- (NOTE: Null implementation in this release of DSOM.)

   PROCEDURE obj_is_ready (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr;
      impl : IN SOM.SOMObjectPtr);
     
     -- Indicate that the object is ready to process requests.
     -- (NOTE: Null implementation in this release of DSOM.)

   PROCEDURE deactivate_obj (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Indicate that the object is no longer ready to process requests.
     -- (NOTE: Null implementation in this release of DSOM.)

END BOA; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY BOA IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      create : SOM.somMToken;
      dispose : SOM.somMToken;
      get_id : SOM.somMToken;
      change_implementation : SOM.somMToken;
      get_principal : SOM.somMToken;
      set_exception : SOM.somMToken;
      impl_is_ready : SOM.somMToken;
      deactivate_impl : SOM.somMToken;
      obj_is_ready : SOM.somMToken;
      deactivate_obj : SOM.somMToken;
      activate_impl : SOM.somMToken;
      activate_obj : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   BOAClassData : classData;
   FOR BOAClassData USE AT standard.system.label("BOAClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   BOACClassData : CClassData;
   FOR BOACClassData USE AT standard.system.label("BOACClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            BOAClassData.classObject) 
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
      FUNCTION BOANewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, BOANewClass);
      PRAGMA interface_information (BOANewClass, ".BOANewClass");
   BEGIN
      RETURN BOANewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF BOAClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(BOAClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION create (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN SOM.ReferenceData; 
      intf : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create an object reference.
      FUNCTION BOA_create(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         id : IN SOM.address; 
         intf : IN SOM.SOMObjectPtr; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, BOA_create);
      PRAGMA interface_information (BOA_create, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         BOA_create (
            Self.som_object,
            Ev,
            SOM.To_SOM_Address(id'address),
            intf,
            impl,
            BOAClassData.create);
      RETURN Result;
   END create; 

   PROCEDURE dispose (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Destroy an object reference.
      PROCEDURE BOA_dispose(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_dispose);
      PRAGMA interface_information (BOA_dispose, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_dispose (
         Self.som_object,
         Ev,
         obj,
         BOAClassData.dispose);
   END dispose;

   FUNCTION get_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.ReferenceData
   IS
     
     -- Return ReferenceData associated with referenced object.
      PROCEDURE BOA_get_id(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_get_id);
      PRAGMA interface_information (BOA_get_id, ".xsomcall4");
      Result : ALIASED SOM.ReferenceData;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_get_id (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         obj,
         BOAClassData.get_id);
      RETURN Result;
   END get_id; 

   FUNCTION get_principal (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr; 
      req_ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return a Principal object, which describes who issued a request on
     -- the specified object.  The "req_ev" parameter is the Environment
     -- which was passed as part of the request.
      FUNCTION BOA_get_principal(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr; 
         req_ev : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, BOA_get_principal);
      PRAGMA interface_information (BOA_get_principal, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         BOA_get_principal (
            Self.som_object,
            Ev,
            obj,
            SOM.To_SOM_Address(req_ev'address),
            BOAClassData.get_principal);
      RETURN Result;
   END get_principal; 

   PROCEDURE set_exception (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      major : IN SOM.exception_type; 
      userid : IN Corba.String; 
      param : IN SOM.VoidPtr)
   IS
     
     -- Return an exception to the client.
      PROCEDURE BOA_set_exception(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         major : IN SOM.exception_type; 
         userid : IN Corba.String; 
         param : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_set_exception);
      PRAGMA interface_information (BOA_set_exception, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_set_exception (
         Self.som_object,
         Ev,
         major,
         userid,
         param,
         BOAClassData.set_exception);
   END set_exception;

   PROCEDURE impl_is_ready (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl : IN SOM.SOMObjectPtr)
   IS
     
     -- Indicate that the implementation is now ready to process requests.
      PROCEDURE BOA_impl_is_ready(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_impl_is_ready);
      PRAGMA interface_information (BOA_impl_is_ready, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_impl_is_ready (
         Self.som_object,
         Ev,
         impl,
         BOAClassData.impl_is_ready);
   END impl_is_ready;

   PROCEDURE deactivate_impl (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl : IN SOM.SOMObjectPtr)
   IS
     
     -- Indicate that the implementation is no longer ready to process reqs.
      PROCEDURE BOA_deactivate_impl(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_deactivate_impl);
      PRAGMA interface_information (BOA_deactivate_impl, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_deactivate_impl (
         Self.som_object,
         Ev,
         impl,
         BOAClassData.deactivate_impl);
   END deactivate_impl;

   PROCEDURE change_implementation (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
   IS
     
     -- Change the implementation associated with the referenced object.
     -- (NOTE: Null implementation in this release of DSOM.)
      PROCEDURE BOA_change_implementation(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_change_implementation);
      PRAGMA interface_information (BOA_change_implementation, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_change_implementation (
         Self.som_object,
         Ev,
         obj,
         impl,
         BOAClassData.change_implementation);
   END change_implementation;

   PROCEDURE obj_is_ready (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr; 
      impl : IN SOM.SOMObjectPtr)
   IS
     
     -- Indicate that the object is ready to process requests.
     -- (NOTE: Null implementation in this release of DSOM.)
      PROCEDURE BOA_obj_is_ready(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr; 
         impl : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_obj_is_ready);
      PRAGMA interface_information (BOA_obj_is_ready, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_obj_is_ready (
         Self.som_object,
         Ev,
         obj,
         impl,
         BOAClassData.obj_is_ready);
   END obj_is_ready;

   PROCEDURE deactivate_obj (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Indicate that the object is no longer ready to process requests.
     -- (NOTE: Null implementation in this release of DSOM.)
      PROCEDURE BOA_deactivate_obj(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, BOA_deactivate_obj);
      PRAGMA interface_information (BOA_deactivate_obj, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      BOA_deactivate_obj (
         Self.som_object,
         Ev,
         obj,
         BOAClassData.deactivate_obj);
   END deactivate_obj;

END BOA; 







