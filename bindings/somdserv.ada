
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:46 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH SOMClass;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMDServer IS


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
      


   FUNCTION somdRefFromSOMObj (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somobj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns a DSOM object reference for a SOM object
     -- instance in this server process.  SOMOA will call this method
     -- whenever it returns a result from a method call which includes
     -- a pointer to a SOMObject (versus a pointer to a SOMDObject).
     -- Ownership of the returned object reference is given to the
     -- caller EXCEPT when the somdObjReferencesCached method returns TRUE.
     -- When the input (somobj) is already an object reference, the default
     -- implementation simply returns somobj, rather than creating a new reference.
     -- (Subclasses might override this method to duplicate the input reference, however.)
     -- Hence, callers should note when the returned value is the same as
     -- the input (somobj) when determining whether or not to free the result.

   FUNCTION somdSOMObjFromRef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objref : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method maps a DSOM object reference into a SOM object.
     -- This can be done in whatever way is appropriate for the application.
     -- This method is called by SOMOA in order to translate any method call
     -- parameters which are object references (created from somdRefFromSOMObj
     -- above) into SOM objects.

   PROCEDURE somdDispatchMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somobj : IN SOM.SOMObjectPtr;
      retValue : OUT SOM.somToken;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list);
     
     -- This method is called by SOMOA to dispatch a method on a SOM object.
     -- The intention is to give the Server object an opportunity to intercept
     -- method calls, if desired.  The parameters to this method are the same
     -- as the parameters passed to SOMObject::somDispatch.
     --
     -- The default implementation invokes SOMObject::somDispatch on the
     -- specified target object, "somobj", with the supplied arguments.

   FUNCTION somdCreateObj (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objclass : IN SOM.Identifier;
      hints : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Creates an object of the specified class.  This method (if overridden)
     -- may optionally define creation "hints" which the client may specify in
     -- this call.
     --
     -- Called indirectly by SOMDObjectMgr::somdNewObject.
     --
     -- The default implementation calls somdGetClassObj to get the specified
     -- SOMClass object, and invokes "somNew".  The "hints" argument is ignored
     -- in the default implementation.

   PROCEDURE somdDeleteObj (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somobj : IN SOM.SOMObjectPtr);
     
     -- Deletes a SOM object.  By default, simply calls somFree on the object.
     -- Can be overridden by the application.
     --
     -- Called indirectly by SOMDObjectMgr::somdDestroyObject.

   FUNCTION somdGetClassObj (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objclass : IN SOM.Identifier)
      RETURN SOM.SOMObjectPtr;
     
     -- Creates/returns a class object for the specified class.
     -- (May result in the loading of a DLL for the class.)

   FUNCTION somdObjReferencesCached (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- Whether the server retains ownership of the object references
     -- it creates via the somdRefFromSOMObj method.

END SOMDServer; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMDServer IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somdSOMObjFromRef : SOM.somMToken;
      somdRefFromSOMObj : SOM.somMToken;
      somdCreateObj : SOM.somMToken;
      somdDeleteObj : SOM.somMToken;
      somdGetClassObj : SOM.somMToken;
      somdDispatchMethod : SOM.somMToken;
      somdObjReferencesCached : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMDServerClassData : classData;
   FOR SOMDServerClassData USE AT standard.system.label("SOMDServerClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMDServerCClassData : CClassData;
   FOR SOMDServerCClassData USE AT standard.system.label("SOMDServerCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMDServerClassData.classObject) 
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
      FUNCTION SOMDServerNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMDServerNewClass);
      PRAGMA interface_information (SOMDServerNewClass, ".SOMDServerNewClass");
   BEGIN
      RETURN SOMDServerNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMDServerClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMDServerClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somdRefFromSOMObj (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somobj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns a DSOM object reference for a SOM object
     -- instance in this server process.  SOMOA will call this method
     -- whenever it returns a result from a method call which includes
     -- a pointer to a SOMObject (versus a pointer to a SOMDObject).
     -- Ownership of the returned object reference is given to the
     -- caller EXCEPT when the somdObjReferencesCached method returns TRUE.
     -- When the input (somobj) is already an object reference, the default
     -- implementation simply returns somobj, rather than creating a new reference.
     -- (Subclasses might override this method to duplicate the input reference, however.)
     -- Hence, callers should note when the returned value is the same as
     -- the input (somobj) when determining whether or not to free the result.
      FUNCTION SOMDServer_somdRefFromSOMObj(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somobj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDServer_somdRefFromSOMObj);
      PRAGMA interface_information (SOMDServer_somdRefFromSOMObj, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServer_somdRefFromSOMObj (
            Self.som_object,
            Ev,
            somobj,
            SOMDServerClassData.somdRefFromSOMObj);
      RETURN Result;
   END somdRefFromSOMObj; 

   FUNCTION somdSOMObjFromRef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objref : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method maps a DSOM object reference into a SOM object.
     -- This can be done in whatever way is appropriate for the application.
     -- This method is called by SOMOA in order to translate any method call
     -- parameters which are object references (created from somdRefFromSOMObj
     -- above) into SOM objects.
      FUNCTION SOMDServer_somdSOMObjFromRef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objref : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDServer_somdSOMObjFromRef);
      PRAGMA interface_information (SOMDServer_somdSOMObjFromRef, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServer_somdSOMObjFromRef (
            Self.som_object,
            Ev,
            objref,
            SOMDServerClassData.somdSOMObjFromRef);
      RETURN Result;
   END somdSOMObjFromRef; 

   PROCEDURE somdDispatchMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somobj : IN SOM.SOMObjectPtr; 
      retValue : OUT SOM.somToken; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list)
   IS
     
     -- This method is called by SOMOA to dispatch a method on a SOM object.
     -- The intention is to give the Server object an opportunity to intercept
     -- method calls, if desired.  The parameters to this method are the same
     -- as the parameters passed to SOMObject::somDispatch.
     --
     -- The default implementation invokes SOMObject::somDispatch on the
     -- specified target object, "somobj", with the supplied arguments.
      PROCEDURE SOMDServer_somdDispatchMethod(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somobj : IN SOM.SOMObjectPtr; 
         retValue : IN SOM.address; 
         methodId : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDServer_somdDispatchMethod);
      PRAGMA interface_information (SOMDServer_somdDispatchMethod, ".xsomcall6");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDServer_somdDispatchMethod (
         Self.som_object,
         Ev,
         somobj,
         SOM.To_SOM_Address(retValue'address),
         methodId,
         ap,
         SOMDServerClassData.somdDispatchMethod);
   END somdDispatchMethod;

   FUNCTION somdCreateObj (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objclass : IN SOM.Identifier; 
      hints : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Creates an object of the specified class.  This method (if overridden)
     -- may optionally define creation "hints" which the client may specify in
     -- this call.
     --
     -- Called indirectly by SOMDObjectMgr::somdNewObject.
     --
     -- The default implementation calls somdGetClassObj to get the specified
     -- SOMClass object, and invokes "somNew".  The "hints" argument is ignored
     -- in the default implementation.
      FUNCTION SOMDServer_somdCreateObj(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objclass : IN SOM.Identifier; 
         hints : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDServer_somdCreateObj);
      PRAGMA interface_information (SOMDServer_somdCreateObj, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServer_somdCreateObj (
            Self.som_object,
            Ev,
            objclass,
            hints,
            SOMDServerClassData.somdCreateObj);
      RETURN Result;
   END somdCreateObj; 

   PROCEDURE somdDeleteObj (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somobj : IN SOM.SOMObjectPtr)
   IS
     
     -- Deletes a SOM object.  By default, simply calls somFree on the object.
     -- Can be overridden by the application.
     --
     -- Called indirectly by SOMDObjectMgr::somdDestroyObject.
      PROCEDURE SOMDServer_somdDeleteObj(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somobj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMDServer_somdDeleteObj);
      PRAGMA interface_information (SOMDServer_somdDeleteObj, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMDServer_somdDeleteObj (
         Self.som_object,
         Ev,
         somobj,
         SOMDServerClassData.somdDeleteObj);
   END somdDeleteObj;

   FUNCTION somdGetClassObj (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objclass : IN SOM.Identifier)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Creates/returns a class object for the specified class.
     -- (May result in the loading of a DLL for the class.)
      FUNCTION SOMDServer_somdGetClassObj(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         objclass : IN SOM.Identifier;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMDServer_somdGetClassObj);
      PRAGMA interface_information (SOMDServer_somdGetClassObj, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServer_somdGetClassObj (
            Self.som_object,
            Ev,
            objclass,
            SOMDServerClassData.somdGetClassObj);
      RETURN Result;
   END somdGetClassObj; 

   FUNCTION somdObjReferencesCached (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- Whether the server retains ownership of the object references
     -- it creates via the somdRefFromSOMObj method.
      FUNCTION SOMDServer_somdObjReferencesCached(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMDServer_somdObjReferencesCached);
      PRAGMA interface_information (SOMDServer_somdObjReferencesCached, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMDServer_somdObjReferencesCached (
            Self.som_object,
            Ev,
            SOMDServerClassData.somdObjReferencesCached);
      RETURN Result;
   END somdObjReferencesCached; 

END SOMDServer; 







