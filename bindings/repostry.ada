
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:26 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Container;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Repository IS


   TYPE Ref IS NEW Container.Ref WITH NULL RECORD;

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
      

   TYPE RepositoryDescription IS
   RECORD
      name : SOM.Identifier;
      id : Corba.String;
      defined_in : Corba.String;
   END RECORD;
   PRAGMA Preserve_Layout( RepositoryDescription );
     
     -- The inherited describe_contents method returns an instance
     -- of this (RepositoryDescription) structure in the value
     -- member of the Description structure defined in the Container
     -- interface.

   TYPE irOpenErrorCodes IS (NOACCESS, BADMAGICNUMBER, MISSINGVERSIONINFO, 
                             IOERROR, VERSIONMISMATCH);
   FOR irOpenErrorCodes USE (
      NOACCESS => 1,
      BADMAGICNUMBER => 2,
      MISSINGVERSIONINFO => 3,
      IOERROR => 4,
      VERSIONMISMATCH => 5 );

   irOpenError : EXCEPTION;

   TYPE irOpenError_members IS 
   --NEW Corba.IDL_exception_members WITH
   RECORD
      errorCode : Repository.irOpenErrorCodes;
      fileName : Corba.String;
   END RECORD;
   PRAGMA Preserve_Layout( irOpenError_members );

-- FUNCTION get_members (
--    x      : IN Ada.Exceptions.Exception_Occurrence)
--    RETURN      irOpenError_members;
     
     -- The irOpenError and associated irOpenErrorCodes are a
     -- SOM-unique extension to the Interface Repository.  These
     -- errors may be raised by the somNew when instantiating the
     -- Repository object and can be found in the SOM global
     -- Environment.


   FUNCTION lookup_id (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      search_id : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the object with a RepositoryId given by search_id.

   FUNCTION lookup_modifier (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN Corba.String;
      modifier : IN Corba.String)
      RETURN Corba.String;
     
     -- [SOM-unique extension]
     --
     -- Returns the value string associated with the given SOM modifier
     -- for the object whose id is specified.  If the object does not
     -- exist or does not possess the modifier, NULL (or zero) is returned.
     -- If the modifier exists but does not have a value, a zero-length
     -- value string is returned.
     --
     -- You must free the returned string when finished with it (using
     -- SOMFree).

   PROCEDURE release_cache (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- [SOM-unique extension]
     --
     -- This method releases all currently unreferenced Interface Repository
     -- objects from the internal object cache.  This may release some storage
     -- at the cost of slowing down (slightly) the next few lookup operations.
     -- The internal cache will replenish itself (over time) with each
     -- subsequent lookup operation.

   FUNCTION describe_contents (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      limit_type : IN Container.InterfaceName;
      exclude_inherited : IN Corba.Boolean;
      max_returned_objs : IN Corba.Long)
      RETURN Container.ContainerDescription_Unbounded.Sequence;

   PROCEDURE somFree (
      Self : IN Ref);

   PROCEDURE somDumpSelf (
      Self : IN Ref;
      level : IN Corba.Long);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END Repository; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Repository IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      lookup_id : SOM.somMToken;
      lookup_modifier : SOM.somMToken;
      release_cache : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   RepositoryClassData : classData;
   FOR RepositoryClassData USE AT standard.system.label("RepositoryClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   RepositoryCClassData : CClassData;
   FOR RepositoryCClassData USE AT standard.system.label("RepositoryCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            RepositoryClassData.classObject) 
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
      FUNCTION RepositoryNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, RepositoryNewClass);
      PRAGMA interface_information (RepositoryNewClass, ".RepositoryNewClass");
   BEGIN
      RETURN RepositoryNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF RepositoryClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(RepositoryClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION lookup_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      search_id : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the object with a RepositoryId given by search_id.
      FUNCTION Repository_lookup_id(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         search_id : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, Repository_lookup_id);
      PRAGMA interface_information (Repository_lookup_id, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Repository_lookup_id (
            Self.som_object,
            Ev,
            search_id,
            RepositoryClassData.lookup_id);
      RETURN Result;
   END lookup_id; 

   FUNCTION lookup_modifier (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN Corba.String; 
      modifier : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- [SOM-unique extension]
     --
     -- Returns the value string associated with the given SOM modifier
     -- for the object whose id is specified.  If the object does not
     -- exist or does not possess the modifier, NULL (or zero) is returned.
     -- If the modifier exists but does not have a value, a zero-length
     -- value string is returned.
     --
     -- You must free the returned string when finished with it (using
     -- SOMFree).
      FUNCTION Repository_lookup_modifier(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN Corba.String; 
         modifier : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, Repository_lookup_modifier);
      PRAGMA interface_information (Repository_lookup_modifier, ".xsomcall4");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Repository_lookup_modifier (
            Self.som_object,
            Ev,
            name,
            modifier,
            RepositoryClassData.lookup_modifier);
      RETURN Result;
   END lookup_modifier; 

   PROCEDURE release_cache (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- [SOM-unique extension]
     --
     -- This method releases all currently unreferenced Interface Repository
     -- objects from the internal object cache.  This may release some storage
     -- at the cost of slowing down (slightly) the next few lookup operations.
     -- The internal cache will replenish itself (over time) with each
     -- subsequent lookup operation.
      PROCEDURE Repository_release_cache(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Repository_release_cache);
      PRAGMA interface_information (Repository_release_cache, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Repository_release_cache (
         Self.som_object,
         Ev,
         RepositoryClassData.release_cache);
   END release_cache;

   FUNCTION describe_contents (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      limit_type : IN Container.InterfaceName; 
      exclude_inherited : IN Corba.Boolean; 
      max_returned_objs : IN Corba.Long)
      RETURN Container.ContainerDescription_Unbounded.Sequence
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Container.describe_contents (
            Container.Ref'(som_object=>Self.som_object),
            Ev,
            limit_type,
            exclude_inherited,
            max_returned_objs);
   END describe_contents;

   PROCEDURE somFree (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somFree (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somFree;

   PROCEDURE somDumpSelf (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDumpSelf (
         SOMObject.Ref'(som_object=>Self.som_object),
         level);
   END somDumpSelf;

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

END Repository; 







