
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:25 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Principal IS

   
   --   This is a class interface definition which defines the CORBA-defined
   --   Principal object. CORBA defines the Principal object but (at this
   --   time) does not define the interface to this object. The methods for
   --   this object are, therefore, subject to change in future implementations.
   --
   --   The BOA guarantees that for every method invocation it will identify
   --   the principal on whose behalf the request is performed. An object
   --   implementation may request an instance of this class to determine
   --   if a method invocation has been made by someone with the appropriate
   --   authority. An instance of this class is returned when the following
   --   method is invoked on the BOA:
   --
   --     get_principal(in BOA boaobj, in Environment lcl_ev,
   --                   in SOMDObject obj, in Environment req_ev);
   --

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
      


   FUNCTION get_userName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- User who made the request.

   PROCEDURE set_userName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      userName : IN Corba.String);
     
     -- User who made the request.

   FUNCTION get_hostName (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.String;
     
     -- Host from which the request was made.

   PROCEDURE set_hostName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      hostName : IN Corba.String);
     
     -- Host from which the request was made.

   PROCEDURE somUninit (
      Self : IN Ref);

END Principal; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Principal IS

   
   --   This is a class interface definition which defines the CORBA-defined
   --   Principal object. CORBA defines the Principal object but (at this
   --   time) does not define the interface to this object. The methods for
   --   this object are, therefore, subject to change in future implementations.
   --
   --   The BOA guarantees that for every method invocation it will identify
   --   the principal on whose behalf the request is performed. An object
   --   implementation may request an instance of this class to determine
   --   if a method invocation has been made by someone with the appropriate
   --   authority. An instance of this class is returned when the following
   --   method is invoked on the BOA:
   --
   --     get_principal(in BOA boaobj, in Environment lcl_ev,
   --                   in SOMDObject obj, in Environment req_ev);
   --

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      set_userName : SOM.somMToken;
      get_userName : SOM.somMToken;
      set_hostName : SOM.somMToken;
      get_hostName : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   PrincipalClassData : classData;
   FOR PrincipalClassData USE AT standard.system.label("PrincipalClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   PrincipalCClassData : CClassData;
   FOR PrincipalCClassData USE AT standard.system.label("PrincipalCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            PrincipalClassData.classObject) 
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
      FUNCTION PrincipalNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, PrincipalNewClass);
      PRAGMA interface_information (PrincipalNewClass, ".PrincipalNewClass");
   BEGIN
      RETURN PrincipalNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF PrincipalClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(PrincipalClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_userName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- User who made the request.
      FUNCTION Principal_U_get_userName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, Principal_U_get_userName);
      PRAGMA interface_information (Principal_U_get_userName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Principal_U_get_userName (
            Self.som_object,
            Ev,
            PrincipalClassData.get_userName);
      RETURN Result;
   END get_userName; 

   PROCEDURE set_userName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      userName : IN Corba.String)
   IS
     
     -- User who made the request.
      PROCEDURE Principal_U_set_userName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         userName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Principal_U_set_userName);
      PRAGMA interface_information (Principal_U_set_userName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Principal_U_set_userName (
         Self.som_object,
         Ev,
         userName,
         PrincipalClassData.set_userName);
   END set_userName;

   FUNCTION get_hostName (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.String
   IS
     
     -- Host from which the request was made.
      FUNCTION Principal_U_get_hostName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, Principal_U_get_hostName);
      PRAGMA interface_information (Principal_U_get_hostName, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Principal_U_get_hostName (
            Self.som_object,
            Ev,
            PrincipalClassData.get_hostName);
      RETURN Result;
   END get_hostName; 

   PROCEDURE set_hostName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      hostName : IN Corba.String)
   IS
     
     -- Host from which the request was made.
      PROCEDURE Principal_U_set_hostName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         hostName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Principal_U_set_hostName);
      PRAGMA interface_information (Principal_U_set_hostName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Principal_U_set_hostName (
         Self.som_object,
         Ev,
         hostName,
         PrincipalClassData.set_hostName);
   END set_hostName;

   PROCEDURE somUninit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somUninit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somUninit;

END Principal; 







