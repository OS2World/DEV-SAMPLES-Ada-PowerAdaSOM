
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:00 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Context IS


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
      


   FUNCTION set_one_value (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      prop_name : IN SOM.Identifier;
      value : IN Corba.String)
      RETURN SOM.ORBStatus;
     
     --  This method sets or adds a single context object property. If prop_name
     --  does not exist in the property list, it is added. If prop_name
     --  does exist, its value is changed.
     --

   FUNCTION set_values (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      values : IN SOM.SOMObjectPtr)
      RETURN SOM.ORBStatus;
     
     --  This method sets or changes one or more property values in the context
     --  object. If a prop_name specified in the NVList does not exist in the
     --  Context object property list, it is added. If a prop_name specified in
     --  the NVList does exist in the Context object property list, its value
     --  is changed.
     --

   PROCEDURE get_values (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      start_scope : IN SOM.Identifier;
      op_flags : IN SOM.Flags;
      prop_name : IN SOM.Identifier;
      values : OUT SOM.SOMObjectPtr;
      Result : OUT SOM.ORBStatus);
     
     --  This method retrieves the specified context property value(s) If
     --  prop_name has a trailing wildcard ("*"), then all matching properties
     --  and their values are returned. The returned NVList is the responsibility
     --  of the caller,
     --
     --  If no matching properties are found, and error is returned the property
     --  list contains no values.
     --
     --  Scope indicates the context object level at which to initiate the search
     --  for the specified properties (e.g. "_USER", "_SYSTEM"). If the property
     --  is not found at the indicated level, the search continues up the context
     --  object tree until a match is found or all context objects in the chain
     --  have been searched.
     --
     --  If scope name is ommitted, the search begins with the specified context
     --  object. If the specified scope name is not found, an exception is
     --  returned.
     --
     --  The following operation flags may be specified:
     --
     --  CTX_RESTRICT_SCOPE  Searching is limited to the specified search scope or
     --                      context object.
     --

   FUNCTION delete_values (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      prop_name : IN SOM.Identifier)
      RETURN SOM.ORBStatus;
     
     --  This method deletes the specified property value(s) from the context
     --  object.  If prop_name has a trailing wildcard character ("*"), then
     --  all property names which match will be deleted.
     --
     --  Search scope is always limited to the specified context object.
     --
     --  If no matching property is found, an exception is returned.
     --

   PROCEDURE create_child (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      ctx_name : IN SOM.Identifier;
      child_ctx : OUT SOM.SOMObjectPtr;
      Result : OUT SOM.ORBStatus);
     
     --
     --  This method creates a child context object.
     --
     --  The returned context object is chained to its parent context. That is,
     --  searches on the child context object will look in the parent context
     --  (and so on, up the context tree), if necessary, for matching property
     --  names.
     --

   FUNCTION destroy (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     --  This operation deletes the indicated context object.
     --  The following flags may be specified:
     --
     --  CTX_DELETE_DESCENDENTS    Deletes the indicated context object and all
     --                            of its descendent context objects as well.
     --
     --  An exception is returned if there are one or more child context objects
     --  and the CTX_DELETE_DESCENDENTS flag was not set.
     --

   PROCEDURE somInit (
      Self : IN Ref);

END Context; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Context IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      set_one_value : SOM.somMToken;
      set_values : SOM.somMToken;
      get_values : SOM.somMToken;
      delete_values : SOM.somMToken;
      create_child : SOM.somMToken;
      destroy : SOM.somMToken;
      get_context_name : SOM.somMToken;
      set_context_name : SOM.somMToken;
      get_context_parent : SOM.somMToken;
      set_context_parent : SOM.somMToken;
      get_properties : SOM.somMToken;
      set_properties : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ContextClassData : classData;
   FOR ContextClassData USE AT standard.system.label("ContextClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ContextCClassData : CClassData;
   FOR ContextCClassData USE AT standard.system.label("ContextCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ContextClassData.classObject) 
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
      FUNCTION ContextNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ContextNewClass);
      PRAGMA interface_information (ContextNewClass, ".ContextNewClass");
   BEGIN
      RETURN ContextNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ContextClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ContextClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION set_one_value (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      prop_name : IN SOM.Identifier; 
      value : IN Corba.String)
      RETURN SOM.ORBStatus
   IS
     
     --  This method sets or adds a single context object property. If prop_name
     --  does not exist in the property list, it is added. If prop_name
     --  does exist, its value is changed.
     --
      FUNCTION Context_set_one_value(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         prop_name : IN SOM.Identifier; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Context_set_one_value);
      PRAGMA interface_information (Context_set_one_value, ".xsomcall4");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Context_set_one_value (
            Self.som_object,
            Ev,
            prop_name,
            value,
            ContextClassData.set_one_value);
      RETURN Result;
   END set_one_value; 

   FUNCTION set_values (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      values : IN SOM.SOMObjectPtr)
      RETURN SOM.ORBStatus
   IS
     
     --  This method sets or changes one or more property values in the context
     --  object. If a prop_name specified in the NVList does not exist in the
     --  Context object property list, it is added. If a prop_name specified in
     --  the NVList does exist in the Context object property list, its value
     --  is changed.
     --
      FUNCTION Context_set_values(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         values : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Context_set_values);
      PRAGMA interface_information (Context_set_values, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Context_set_values (
            Self.som_object,
            Ev,
            values,
            ContextClassData.set_values);
      RETURN Result;
   END set_values; 

   PROCEDURE get_values (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      start_scope : IN SOM.Identifier; 
      op_flags : IN SOM.Flags; 
      prop_name : IN SOM.Identifier; 
      values : OUT SOM.SOMObjectPtr; 
      Result : OUT SOM.ORBStatus)
   IS
     
     --  This method retrieves the specified context property value(s) If
     --  prop_name has a trailing wildcard ("*"), then all matching properties
     --  and their values are returned. The returned NVList is the responsibility
     --  of the caller,
     --
     --  If no matching properties are found, and error is returned the property
     --  list contains no values.
     --
     --  Scope indicates the context object level at which to initiate the search
     --  for the specified properties (e.g. "_USER", "_SYSTEM"). If the property
     --  is not found at the indicated level, the search continues up the context
     --  object tree until a match is found or all context objects in the chain
     --  have been searched.
     --
     --  If scope name is ommitted, the search begins with the specified context
     --  object. If the specified scope name is not found, an exception is
     --  returned.
     --
     --  The following operation flags may be specified:
     --
     --  CTX_RESTRICT_SCOPE  Searching is limited to the specified search scope or
     --                      context object.
     --
      FUNCTION Context_get_values(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         start_scope : IN SOM.Identifier; 
         op_flags : IN SOM.Flags; 
         prop_name : IN SOM.Identifier; 
         values : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Context_get_values);
      PRAGMA interface_information (Context_get_values, ".xsomcall6");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Context_get_values (
            Self.som_object,
            Ev,
            start_scope,
            op_flags,
            prop_name,
            SOM.To_SOM_Address(values'address),
            ContextClassData.get_values);
   END get_values;

   FUNCTION delete_values (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      prop_name : IN SOM.Identifier)
      RETURN SOM.ORBStatus
   IS
     
     --  This method deletes the specified property value(s) from the context
     --  object.  If prop_name has a trailing wildcard character ("*"), then
     --  all property names which match will be deleted.
     --
     --  Search scope is always limited to the specified context object.
     --
     --  If no matching property is found, an exception is returned.
     --
      FUNCTION Context_delete_values(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         prop_name : IN SOM.Identifier;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Context_delete_values);
      PRAGMA interface_information (Context_delete_values, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Context_delete_values (
            Self.som_object,
            Ev,
            prop_name,
            ContextClassData.delete_values);
      RETURN Result;
   END delete_values; 

   PROCEDURE create_child (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      ctx_name : IN SOM.Identifier; 
      child_ctx : OUT SOM.SOMObjectPtr; 
      Result : OUT SOM.ORBStatus)
   IS
     
     --
     --  This method creates a child context object.
     --
     --  The returned context object is chained to its parent context. That is,
     --  searches on the child context object will look in the parent context
     --  (and so on, up the context tree), if necessary, for matching property
     --  names.
     --
      FUNCTION Context_create_child(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         ctx_name : IN SOM.Identifier; 
         child_ctx : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Context_create_child);
      PRAGMA interface_information (Context_create_child, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Context_create_child (
            Self.som_object,
            Ev,
            ctx_name,
            SOM.To_SOM_Address(child_ctx'address),
            ContextClassData.create_child);
   END create_child;

   FUNCTION destroy (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     --  This operation deletes the indicated context object.
     --  The following flags may be specified:
     --
     --  CTX_DELETE_DESCENDENTS    Deletes the indicated context object and all
     --                            of its descendent context objects as well.
     --
     --  An exception is returned if there are one or more child context objects
     --  and the CTX_DELETE_DESCENDENTS flag was not set.
     --
      FUNCTION Context_destroy(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, Context_destroy);
      PRAGMA interface_information (Context_destroy, ".xsomcall3");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Context_destroy (
            Self.som_object,
            Ev,
            flags,
            ContextClassData.destroy);
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

END Context; 







