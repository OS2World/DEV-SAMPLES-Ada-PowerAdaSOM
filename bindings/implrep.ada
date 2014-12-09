
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:10 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba.Sequences;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE ImplRepository IS


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
      

   PACKAGE ImplementationDef_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);


   PACKAGE string_Unbounded IS 
      NEW Corba.Sequences.Unbounded(Corba.String);



   FUNCTION find_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      implid : IN SOM.ImplId)
      RETURN SOM.SOMObjectPtr;
     
     -- This method searches the Implementation Repository and returns
     -- an ImplementationDef object with the specified implid.

   FUNCTION find_impldef_by_alias (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      alias_name : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- This method searches the Implementation Repository and returns
     -- an ImplementationDef object with the specified name (alias).

   PROCEDURE find_all_impldefs (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      outimpldefs : OUT ImplementationDef_Unbounded.Sequence;
      Result : OUT SOM.ORBStatus);
     
     -- This method searches the Implementation Repository and returns
     -- all the ImplementationDef objects in it.

   FUNCTION find_impldef_by_class (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      classname : IN Corba.String)
      RETURN ImplementationDef_Unbounded.Sequence;
     
     -- This method searches the class index and returns the sequence of
     -- ImplementationDef objects for servers which implement that class.

   PROCEDURE add_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impldef : IN SOM.SOMObjectPtr);
     
     -- This method inserts an ImplementationDef object into the Implementation
     -- Repository.

   PROCEDURE update_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impldef : IN SOM.SOMObjectPtr);
     
     -- This method replaces an ImplementationDef object in the Implementation
     -- Repository with the supplied object.  The "impl_id" attribute of the
     -- supplied object is used to find the object to replace in the Impl.
     -- Repository.

   PROCEDURE delete_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      implid : IN SOM.ImplId);
     
     -- This method deletes the ImplementationDef object with the specified
     -- implid from the Implementation Repository.

   PROCEDURE add_class_to_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      implid : IN SOM.ImplId;
      classname : IN Corba.String);
     
     -- This method associates the classname with the ImplementationDef
     -- whose id is "implid".  This is meant to indicate that the server
     -- (specified by the ImplementationDef) implements the named class.

   PROCEDURE remove_class_from_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      implid : IN SOM.ImplId;
      classname : IN Corba.String);
     
     -- This method removes the classname from the list of classnames
     -- associated with the ImplementationDef whose id is "implid".

   PROCEDURE remove_class_from_all (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      classname : IN Corba.String);
     
     -- This method removes the classname from all the ImplementationDefs.

   FUNCTION find_classes_by_impldef (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      implid : IN SOM.ImplId)
      RETURN ImplRepository.string_Unbounded.Sequence;
     
     -- This method searches the class index and returns the sequence of
     -- class names supported by a server with specified "implid".

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END ImplRepository; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY ImplRepository IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      find_impldef : SOM.somMToken;
      find_impldef_by_alias : SOM.somMToken;
      find_impldef2 : SOM.somMToken;
      find_impldef_by_alias2 : SOM.somMToken;
      find_impldef_by_class : SOM.somMToken;
      add_impldef : SOM.somMToken;
      update_impldef : SOM.somMToken;
      delete_impldef : SOM.somMToken;
      add_class_to_impldef : SOM.somMToken;
      remove_class_from_impldef : SOM.somMToken;
      remove_class_from_all : SOM.somMToken;
      find_classes_by_impldef : SOM.somMToken;
      implr_get_impl : SOM.somMToken;
      implr_search_impl : SOM.somMToken;
      implr_search_class : SOM.somMToken;
      implr_update_impl : SOM.somMToken;
      find_all_impldefs : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ImplRepositoryClassData : classData;
   FOR ImplRepositoryClassData USE AT standard.system.label("ImplRepositoryClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ImplRepositoryCClassData : CClassData;
   FOR ImplRepositoryCClassData USE AT standard.system.label("ImplRepositoryCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ImplRepositoryClassData.classObject) 
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
      FUNCTION ImplRepositoryNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ImplRepositoryNewClass);
      PRAGMA interface_information (ImplRepositoryNewClass, ".ImplRepositoryNewClass");
   BEGIN
      RETURN ImplRepositoryNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ImplRepositoryClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ImplRepositoryClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION find_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      implid : IN SOM.ImplId)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method searches the Implementation Repository and returns
     -- an ImplementationDef object with the specified implid.
      FUNCTION ImplRepository_find_impldef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         implid : IN SOM.ImplId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, ImplRepository_find_impldef);
      PRAGMA interface_information (ImplRepository_find_impldef, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplRepository_find_impldef (
            Self.som_object,
            Ev,
            implid,
            ImplRepositoryClassData.find_impldef);
      RETURN Result;
   END find_impldef; 

   FUNCTION find_impldef_by_alias (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      alias_name : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method searches the Implementation Repository and returns
     -- an ImplementationDef object with the specified name (alias).
      FUNCTION ImplRepository_find_impldef_by_alias(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         alias_name : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, ImplRepository_find_impldef_by_alias);
      PRAGMA interface_information (ImplRepository_find_impldef_by_alias, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplRepository_find_impldef_by_alias (
            Self.som_object,
            Ev,
            alias_name,
            ImplRepositoryClassData.find_impldef_by_alias);
      RETURN Result;
   END find_impldef_by_alias; 

   PROCEDURE find_all_impldefs (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      outimpldefs : OUT ImplementationDef_Unbounded.Sequence; 
      Result : OUT SOM.ORBStatus)
   IS
     
     -- This method searches the Implementation Repository and returns
     -- all the ImplementationDef objects in it.
      FUNCTION ImplRepository_find_all_impldefs(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         outimpldefs : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, ImplRepository_find_all_impldefs);
      PRAGMA interface_information (ImplRepository_find_all_impldefs, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplRepository_find_all_impldefs (
            Self.som_object,
            Ev,
            SOM.To_SOM_Address(outimpldefs'address),
            ImplRepositoryClassData.find_all_impldefs);
   END find_all_impldefs;

   FUNCTION find_impldef_by_class (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      classname : IN Corba.String)
      RETURN ImplementationDef_Unbounded.Sequence
   IS
     
     -- This method searches the class index and returns the sequence of
     -- ImplementationDef objects for servers which implement that class.
      PROCEDURE ImplRepository_find_impldef_by_class(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         classname : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_find_impldef_by_class);
      PRAGMA interface_information (ImplRepository_find_impldef_by_class, ".xsomcall4");
      Result : ALIASED ImplementationDef_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_find_impldef_by_class (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         classname,
         ImplRepositoryClassData.find_impldef_by_class);
      RETURN Result;
   END find_impldef_by_class; 

   PROCEDURE add_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impldef : IN SOM.SOMObjectPtr)
   IS
     
     -- This method inserts an ImplementationDef object into the Implementation
     -- Repository.
      PROCEDURE ImplRepository_add_impldef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impldef : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_add_impldef);
      PRAGMA interface_information (ImplRepository_add_impldef, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_add_impldef (
         Self.som_object,
         Ev,
         impldef,
         ImplRepositoryClassData.add_impldef);
   END add_impldef;

   PROCEDURE update_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impldef : IN SOM.SOMObjectPtr)
   IS
     
     -- This method replaces an ImplementationDef object in the Implementation
     -- Repository with the supplied object.  The "impl_id" attribute of the
     -- supplied object is used to find the object to replace in the Impl.
     -- Repository.
      PROCEDURE ImplRepository_update_impldef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impldef : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_update_impldef);
      PRAGMA interface_information (ImplRepository_update_impldef, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_update_impldef (
         Self.som_object,
         Ev,
         impldef,
         ImplRepositoryClassData.update_impldef);
   END update_impldef;

   PROCEDURE delete_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      implid : IN SOM.ImplId)
   IS
     
     -- This method deletes the ImplementationDef object with the specified
     -- implid from the Implementation Repository.
      PROCEDURE ImplRepository_delete_impldef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         implid : IN SOM.ImplId;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_delete_impldef);
      PRAGMA interface_information (ImplRepository_delete_impldef, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_delete_impldef (
         Self.som_object,
         Ev,
         implid,
         ImplRepositoryClassData.delete_impldef);
   END delete_impldef;

   PROCEDURE add_class_to_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      implid : IN SOM.ImplId; 
      classname : IN Corba.String)
   IS
     
     -- This method associates the classname with the ImplementationDef
     -- whose id is "implid".  This is meant to indicate that the server
     -- (specified by the ImplementationDef) implements the named class.
      PROCEDURE ImplRepository_add_class_to_impldef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         implid : IN SOM.ImplId; 
         classname : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_add_class_to_impldef);
      PRAGMA interface_information (ImplRepository_add_class_to_impldef, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_add_class_to_impldef (
         Self.som_object,
         Ev,
         implid,
         classname,
         ImplRepositoryClassData.add_class_to_impldef);
   END add_class_to_impldef;

   PROCEDURE remove_class_from_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      implid : IN SOM.ImplId; 
      classname : IN Corba.String)
   IS
     
     -- This method removes the classname from the list of classnames
     -- associated with the ImplementationDef whose id is "implid".
      PROCEDURE ImplRepository_remove_class_from_impldef(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         implid : IN SOM.ImplId; 
         classname : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_remove_class_from_impldef);
      PRAGMA interface_information (ImplRepository_remove_class_from_impldef, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_remove_class_from_impldef (
         Self.som_object,
         Ev,
         implid,
         classname,
         ImplRepositoryClassData.remove_class_from_impldef);
   END remove_class_from_impldef;

   PROCEDURE remove_class_from_all (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      classname : IN Corba.String)
   IS
     
     -- This method removes the classname from all the ImplementationDefs.
      PROCEDURE ImplRepository_remove_class_from_all(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         classname : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_remove_class_from_all);
      PRAGMA interface_information (ImplRepository_remove_class_from_all, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_remove_class_from_all (
         Self.som_object,
         Ev,
         classname,
         ImplRepositoryClassData.remove_class_from_all);
   END remove_class_from_all;

   FUNCTION find_classes_by_impldef (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      implid : IN SOM.ImplId)
      RETURN ImplRepository.string_Unbounded.Sequence
   IS
     
     -- This method searches the class index and returns the sequence of
     -- class names supported by a server with specified "implid".
      PROCEDURE ImplRepository_find_classes_by_impldef(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         implid : IN SOM.ImplId;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplRepository_find_classes_by_impldef);
      PRAGMA interface_information (ImplRepository_find_classes_by_impldef, ".xsomcall4");
      Result : ALIASED ImplRepository.string_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplRepository_find_classes_by_impldef (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         implid,
         ImplRepositoryClassData.find_classes_by_impldef);
      RETURN Result;
   END find_classes_by_impldef; 

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

END ImplRepository; 







