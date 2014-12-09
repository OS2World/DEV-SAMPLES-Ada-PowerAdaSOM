
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:09 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE ImplementationDef IS


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
      


   FUNCTION get_impl_id (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_id"

   PROCEDURE set_impl_id (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_id : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_id"

   FUNCTION get_impl_alias (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_alias"

   PROCEDURE set_impl_alias (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_alias : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_alias"

   FUNCTION get_impl_program (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_program"

   PROCEDURE set_impl_program (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_program : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_program"

   FUNCTION get_impl_flags (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.Flags;
     
     --Method from the IDL attribute statement:
     --"attribute Flags impl_flags"

   PROCEDURE set_impl_flags (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_flags : IN SOM.Flags);
     
     --Method from the IDL attribute statement:
     --"attribute Flags impl_flags"

   FUNCTION get_impl_server_class (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_server_class"

   PROCEDURE set_impl_server_class (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_server_class : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_server_class"

   FUNCTION get_impl_refdata_file (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_file"

   PROCEDURE set_impl_refdata_file (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_refdata_file : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_file"

   FUNCTION get_impl_refdata_bkup (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_bkup"

   PROCEDURE set_impl_refdata_bkup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_refdata_bkup : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_bkup"

   FUNCTION get_impl_hostname (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     --Method from the IDL attribute statement:
     --"attribute string impl_hostname"

   PROCEDURE set_impl_hostname (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      impl_hostname : IN Corba.String);
     
     --Method from the IDL attribute statement:
     --"attribute string impl_hostname"

END ImplementationDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY ImplementationDef IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      set_impl_id : SOM.somMToken;
      get_impl_id : SOM.somMToken;
      set_impl_alias : SOM.somMToken;
      get_impl_alias : SOM.somMToken;
      set_impl_program : SOM.somMToken;
      get_impl_program : SOM.somMToken;
      set_impl_flags : SOM.somMToken;
      get_impl_flags : SOM.somMToken;
      set_impl_server_class : SOM.somMToken;
      get_impl_server_class : SOM.somMToken;
      set_impl_socket_class : SOM.somMToken;
      get_impl_socket_class : SOM.somMToken;
      set_impl_refdata_file : SOM.somMToken;
      get_impl_refdata_file : SOM.somMToken;
      set_impl_refdata_bkup : SOM.somMToken;
      get_impl_refdata_bkup : SOM.somMToken;
      set_impl_hostname : SOM.somMToken;
      get_impl_hostname : SOM.somMToken;
      set_impl_def_struct : SOM.somMToken;
      get_impl_def_struct : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ImplementationDefClassData : classData;
   FOR ImplementationDefClassData USE AT standard.system.label("ImplementationDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ImplementationDefCClassData : CClassData;
   FOR ImplementationDefCClassData USE AT standard.system.label("ImplementationDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ImplementationDefClassData.classObject) 
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
      FUNCTION ImplementationDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ImplementationDefNewClass);
      PRAGMA interface_information (ImplementationDefNewClass, ".ImplementationDefNewClass");
   BEGIN
      RETURN ImplementationDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ImplementationDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ImplementationDefClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_impl_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_id"
      FUNCTION ImplementationDef_U_get_impl_id(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_id);
      PRAGMA interface_information (ImplementationDef_U_get_impl_id, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_id (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_id);
      RETURN Result;
   END get_impl_id; 

   PROCEDURE set_impl_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_id : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_id"
      PROCEDURE ImplementationDef_U_set_impl_id(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_id : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_id);
      PRAGMA interface_information (ImplementationDef_U_set_impl_id, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_id (
         Self.som_object,
         Ev,
         impl_id,
         ImplementationDefClassData.set_impl_id);
   END set_impl_id;

   FUNCTION get_impl_alias (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_alias"
      FUNCTION ImplementationDef_U_get_impl_alias(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_alias);
      PRAGMA interface_information (ImplementationDef_U_get_impl_alias, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_alias (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_alias);
      RETURN Result;
   END get_impl_alias; 

   PROCEDURE set_impl_alias (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_alias : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_alias"
      PROCEDURE ImplementationDef_U_set_impl_alias(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_alias : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_alias);
      PRAGMA interface_information (ImplementationDef_U_set_impl_alias, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_alias (
         Self.som_object,
         Ev,
         impl_alias,
         ImplementationDefClassData.set_impl_alias);
   END set_impl_alias;

   FUNCTION get_impl_program (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_program"
      FUNCTION ImplementationDef_U_get_impl_program(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_program);
      PRAGMA interface_information (ImplementationDef_U_get_impl_program, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_program (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_program);
      RETURN Result;
   END get_impl_program; 

   PROCEDURE set_impl_program (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_program : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_program"
      PROCEDURE ImplementationDef_U_set_impl_program(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_program : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_program);
      PRAGMA interface_information (ImplementationDef_U_set_impl_program, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_program (
         Self.som_object,
         Ev,
         impl_program,
         ImplementationDefClassData.set_impl_program);
   END set_impl_program;

   FUNCTION get_impl_flags (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.Flags
   IS
     
     --Method from the IDL attribute statement:
     --"attribute Flags impl_flags"
      FUNCTION ImplementationDef_U_get_impl_flags(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.Flags; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_flags);
      PRAGMA interface_information (ImplementationDef_U_get_impl_flags, ".xsomcall2");
      Result : ALIASED SOM.Flags;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_flags (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_flags);
      RETURN Result;
   END get_impl_flags; 

   PROCEDURE set_impl_flags (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_flags : IN SOM.Flags)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute Flags impl_flags"
      PROCEDURE ImplementationDef_U_set_impl_flags(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_flags);
      PRAGMA interface_information (ImplementationDef_U_set_impl_flags, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_flags (
         Self.som_object,
         Ev,
         impl_flags,
         ImplementationDefClassData.set_impl_flags);
   END set_impl_flags;

   FUNCTION get_impl_server_class (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_server_class"
      FUNCTION ImplementationDef_U_get_impl_server_class(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_server_class);
      PRAGMA interface_information (ImplementationDef_U_get_impl_server_class, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_server_class (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_server_class);
      RETURN Result;
   END get_impl_server_class; 

   PROCEDURE set_impl_server_class (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_server_class : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_server_class"
      PROCEDURE ImplementationDef_U_set_impl_server_class(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_server_class : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_server_class);
      PRAGMA interface_information (ImplementationDef_U_set_impl_server_class, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_server_class (
         Self.som_object,
         Ev,
         impl_server_class,
         ImplementationDefClassData.set_impl_server_class);
   END set_impl_server_class;

   FUNCTION get_impl_refdata_file (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_file"
      FUNCTION ImplementationDef_U_get_impl_refdata_file(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_refdata_file);
      PRAGMA interface_information (ImplementationDef_U_get_impl_refdata_file, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_refdata_file (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_refdata_file);
      RETURN Result;
   END get_impl_refdata_file; 

   PROCEDURE set_impl_refdata_file (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_refdata_file : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_file"
      PROCEDURE ImplementationDef_U_set_impl_refdata_file(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_refdata_file : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_refdata_file);
      PRAGMA interface_information (ImplementationDef_U_set_impl_refdata_file, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_refdata_file (
         Self.som_object,
         Ev,
         impl_refdata_file,
         ImplementationDefClassData.set_impl_refdata_file);
   END set_impl_refdata_file;

   FUNCTION get_impl_refdata_bkup (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_bkup"
      FUNCTION ImplementationDef_U_get_impl_refdata_bkup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_refdata_bkup);
      PRAGMA interface_information (ImplementationDef_U_get_impl_refdata_bkup, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_refdata_bkup (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_refdata_bkup);
      RETURN Result;
   END get_impl_refdata_bkup; 

   PROCEDURE set_impl_refdata_bkup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_refdata_bkup : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_refdata_bkup"
      PROCEDURE ImplementationDef_U_set_impl_refdata_bkup(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_refdata_bkup : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_refdata_bkup);
      PRAGMA interface_information (ImplementationDef_U_set_impl_refdata_bkup, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_refdata_bkup (
         Self.som_object,
         Ev,
         impl_refdata_bkup,
         ImplementationDefClassData.set_impl_refdata_bkup);
   END set_impl_refdata_bkup;

   FUNCTION get_impl_hostname (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_hostname"
      FUNCTION ImplementationDef_U_get_impl_hostname(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, ImplementationDef_U_get_impl_hostname);
      PRAGMA interface_information (ImplementationDef_U_get_impl_hostname, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ImplementationDef_U_get_impl_hostname (
            Self.som_object,
            Ev,
            ImplementationDefClassData.get_impl_hostname);
      RETURN Result;
   END get_impl_hostname; 

   PROCEDURE set_impl_hostname (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      impl_hostname : IN Corba.String)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute string impl_hostname"
      PROCEDURE ImplementationDef_U_set_impl_hostname(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         impl_hostname : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ImplementationDef_U_set_impl_hostname);
      PRAGMA interface_information (ImplementationDef_U_set_impl_hostname, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ImplementationDef_U_set_impl_hostname (
         Self.som_object,
         Ev,
         impl_hostname,
         ImplementationDefClassData.set_impl_hostname);
   END set_impl_hostname;

END ImplementationDef; 







