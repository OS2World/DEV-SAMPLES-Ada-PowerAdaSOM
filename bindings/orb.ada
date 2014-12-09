
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:21 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE ORB IS


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
      


   FUNCTION object_to_string (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.String;
     
     -- Converts an object reference to its external form.
     -- OWNERSHIP of allocated memory is transferred to the caller.
     -- Use ORBfree to release the allocated memory.

   FUNCTION string_to_object (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      str : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Converts externalized form back to an object reference.

   PROCEDURE create_list (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      count : IN Corba.Long;
      new_list : OUT SOM.SOMObjectPtr;
      Result : OUT SOM.ORBStatus);
     
     -- Creates a NamedValue list, of specified size,
     -- for use in Requests.
     -- OWNERSHIP of allocated "new_list" is transferred to the caller.

   PROCEDURE create_operation_list (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      oper : IN SOM.SOMObjectPtr;
      new_list : OUT SOM.SOMObjectPtr;
      Result : OUT SOM.ORBStatus);
     
     -- Creates a NamedValue list for the specified operation,
     -- for use in Requests invoking that operation.
     -- OWNERSHIP of allocated "new_list" is transferred to the caller.

   PROCEDURE get_default_context (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      ctx : OUT SOM.SOMObjectPtr;
      Result : OUT SOM.ORBStatus);
     
     -- Get default context.
     -- OWNERSHIP of allocated Context object is transferred to the caller.

END ORB; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY ORB IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      object_to_string : SOM.somMToken;
      string_to_object : SOM.somMToken;
      create_list : SOM.somMToken;
      create_operation_list : SOM.somMToken;
      get_default_context : SOM.somMToken;
      object_to_binary : SOM.somMToken;
      binary_to_object : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ORBClassData : classData;
   FOR ORBClassData USE AT standard.system.label("ORBClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ORBCClassData : CClassData;
   FOR ORBCClassData USE AT standard.system.label("ORBCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ORBClassData.classObject) 
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
      FUNCTION ORBNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ORBNewClass);
      PRAGMA interface_information (ORBNewClass, ".ORBNewClass");
   BEGIN
      RETURN ORBNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ORBClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ORBClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION object_to_string (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.String
   IS
     
     -- Converts an object reference to its external form.
     -- OWNERSHIP of allocated memory is transferred to the caller.
     -- Use ORBfree to release the allocated memory.
      FUNCTION ORB_object_to_string(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ORB_object_to_string);
      PRAGMA interface_information (ORB_object_to_string, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ORB_object_to_string (
            Self.som_object,
            Ev,
            obj,
            ORBClassData.object_to_string);
      RETURN Result;
   END object_to_string; 

   FUNCTION string_to_object (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      str : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Converts externalized form back to an object reference.
      FUNCTION ORB_string_to_object(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         str : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, ORB_string_to_object);
      PRAGMA interface_information (ORB_string_to_object, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ORB_string_to_object (
            Self.som_object,
            Ev,
            str,
            ORBClassData.string_to_object);
      RETURN Result;
   END string_to_object; 

   PROCEDURE create_list (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      count : IN Corba.Long; 
      new_list : OUT SOM.SOMObjectPtr; 
      Result : OUT SOM.ORBStatus)
   IS
     
     -- Creates a NamedValue list, of specified size,
     -- for use in Requests.
     -- OWNERSHIP of allocated "new_list" is transferred to the caller.
      FUNCTION ORB_create_list(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         count : IN Corba.Long; 
         new_list : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, ORB_create_list);
      PRAGMA interface_information (ORB_create_list, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ORB_create_list (
            Self.som_object,
            Ev,
            count,
            SOM.To_SOM_Address(new_list'address),
            ORBClassData.create_list);
   END create_list;

   PROCEDURE create_operation_list (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      oper : IN SOM.SOMObjectPtr; 
      new_list : OUT SOM.SOMObjectPtr; 
      Result : OUT SOM.ORBStatus)
   IS
     
     -- Creates a NamedValue list for the specified operation,
     -- for use in Requests invoking that operation.
     -- OWNERSHIP of allocated "new_list" is transferred to the caller.
      FUNCTION ORB_create_operation_list(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         oper : IN SOM.SOMObjectPtr; 
         new_list : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, ORB_create_operation_list);
      PRAGMA interface_information (ORB_create_operation_list, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ORB_create_operation_list (
            Self.som_object,
            Ev,
            oper,
            SOM.To_SOM_Address(new_list'address),
            ORBClassData.create_operation_list);
   END create_operation_list;

   PROCEDURE get_default_context (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      ctx : OUT SOM.SOMObjectPtr; 
      Result : OUT SOM.ORBStatus)
   IS
     
     -- Get default context.
     -- OWNERSHIP of allocated Context object is transferred to the caller.
      FUNCTION ORB_get_default_context(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         ctx : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, ORB_get_default_context);
      PRAGMA interface_information (ORB_get_default_context, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ORB_get_default_context (
            Self.som_object,
            Ev,
            SOM.To_SOM_Address(ctx'address),
            ORBClassData.get_default_context);
   END get_default_context;

END ORB; 







