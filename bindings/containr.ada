
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:02 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba.Sequences;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Container IS


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
      

   SUBTYPE InterfaceName IS Corba.String;

   TYPE ContainerDescription IS
   RECORD
      contained_object : SOM.SOMObjectPtr;
      name : SOM.Identifier;
      value : Corba.Any;
   END RECORD;
   PRAGMA Preserve_Layout( ContainerDescription );

   PACKAGE Contained_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);


   PACKAGE ContainerDescription_Unbounded IS 
      NEW Corba.Sequences.Unbounded(Container.ContainerDescription);



   FUNCTION contents (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      limit_type : IN Container.InterfaceName;
      exclude_inherited : IN Corba.Boolean)
      RETURN Container.Contained_Unbounded.Sequence;
     
     -- Returns a list of objects contained by the receiving object.
     -- This operation is used to navigate thru the hierarchy of objects.
     -- Starting with the Repository object, use this operation to list
     -- all of the objects in the Repository, then all of the objects
     -- within the ModuleDef objects, then all of the objects in the
     -- InterfaceDefs, etc.
     --
     -- If restrict_type is set to "all", objects of all interface types
     -- are returned, otherwise only objects of the requested interface type
     -- will be returned.  If exclude_inherited is set to TRUE, inherited
     -- objects, if any, will not be returned.
     --
     -- You are responsible for freeing the contents of the returned
     -- sequence when you are finished with it. Use a code fragment
     -- similar to the following to free it:
     --
     --   if (containedSeq._length)
     --       SOMFree (containedSeq._buffer);

   FUNCTION lookup_name (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      search_name : IN SOM.Identifier;
      levels_to_search : IN Corba.Long;
      limit_type : IN Container.InterfaceName;
      exclude_inherited : IN Corba.Boolean)
      RETURN Container.Contained_Unbounded.Sequence;
     
     -- Locates an object by name within the receiving object, or within
     -- objects contained in the receiving object.  Search_name specifies
     -- the name of the object to be found.  Levels_to_search controls
     -- whether the lookup is constrained to the receiving object or
     -- whether it includes objects contained withing the receiving object.
     -- (Set levels_to_search to -1 to search the receiver and all contained
     -- objects, -- set it to 1 to search the receiver only.)  If
     -- limit_type is set to "all", objects of all interface types
     -- are returned, otherwise only objects of the requested interface type
     -- will be returned.  Only the values "AttributeDef", "ConstantDef",
     -- "ExceptionDef", "InterfaceDef", "ModuleDef", "ParameterDef",
     -- "OperationDef", "TypeDef", or "all" may be specified for limit_type.
     -- If exclude_inherited is set to TRUE, inherited objects will not be
     -- included in the returned sequence.
     --
     -- You are responsible for freeing the contents of the returned
     -- sequence when you are finished with it. Use a code fragment
     -- similar to the following to free it:
     --
     --   if (containedSeq._length)
     --       SOMFree (containedSeq._buffer);

   FUNCTION describe_contents (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      limit_type : IN Container.InterfaceName;
      exclude_inherited : IN Corba.Boolean;
      max_returned_objs : IN Corba.Long)
      RETURN Container.ContainerDescription_Unbounded.Sequence;
     
     -- Combines the "contents" operation and the "describe" operation.  For
     -- each object returned by the contents operation, the description of
     -- the object is returned by invoking its "describe" operation.
     --
     -- Max_returned_objs can be used to limit the number of objects that can
     -- be returned.  If max_returned_objs is set to -1, results for all
     -- contained objects will be returned.
     --
     -- Note: You should SOMFree result._buffer when you are done with it
     -- as well as result._buffer[x].value._value !

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelf (
      Self : IN Ref;
      level : IN Corba.Long);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END Container; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Container IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      contents : SOM.somMToken;
      lookup_name : SOM.somMToken;
      describe_contents : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ContainerClassData : classData;
   FOR ContainerClassData USE AT standard.system.label("ContainerClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ContainerCClassData : CClassData;
   FOR ContainerCClassData USE AT standard.system.label("ContainerCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ContainerClassData.classObject) 
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
      FUNCTION ContainerNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ContainerNewClass);
      PRAGMA interface_information (ContainerNewClass, ".ContainerNewClass");
   BEGIN
      RETURN ContainerNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ContainerClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ContainerClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION contents (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      limit_type : IN Container.InterfaceName; 
      exclude_inherited : IN Corba.Boolean)
      RETURN Container.Contained_Unbounded.Sequence
   IS
     
     -- Returns a list of objects contained by the receiving object.
     -- This operation is used to navigate thru the hierarchy of objects.
     -- Starting with the Repository object, use this operation to list
     -- all of the objects in the Repository, then all of the objects
     -- within the ModuleDef objects, then all of the objects in the
     -- InterfaceDefs, etc.
     --
     -- If restrict_type is set to "all", objects of all interface types
     -- are returned, otherwise only objects of the requested interface type
     -- will be returned.  If exclude_inherited is set to TRUE, inherited
     -- objects, if any, will not be returned.
     --
     -- You are responsible for freeing the contents of the returned
     -- sequence when you are finished with it. Use a code fragment
     -- similar to the following to free it:
     --
     --   if (containedSeq._length)
     --       SOMFree (containedSeq._buffer);
      PROCEDURE Container_contents(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         limit_type : IN Container.InterfaceName; 
         exclude_inherited : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Container_contents);
      PRAGMA interface_information (Container_contents, ".xsomcall5");
      Result : ALIASED Container.Contained_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Container_contents (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         limit_type,
         exclude_inherited,
         ContainerClassData.contents);
      RETURN Result;
   END contents; 

   FUNCTION lookup_name (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      search_name : IN SOM.Identifier; 
      levels_to_search : IN Corba.Long; 
      limit_type : IN Container.InterfaceName; 
      exclude_inherited : IN Corba.Boolean)
      RETURN Container.Contained_Unbounded.Sequence
   IS
     
     -- Locates an object by name within the receiving object, or within
     -- objects contained in the receiving object.  Search_name specifies
     -- the name of the object to be found.  Levels_to_search controls
     -- whether the lookup is constrained to the receiving object or
     -- whether it includes objects contained withing the receiving object.
     -- (Set levels_to_search to -1 to search the receiver and all contained
     -- objects, -- set it to 1 to search the receiver only.)  If
     -- limit_type is set to "all", objects of all interface types
     -- are returned, otherwise only objects of the requested interface type
     -- will be returned.  Only the values "AttributeDef", "ConstantDef",
     -- "ExceptionDef", "InterfaceDef", "ModuleDef", "ParameterDef",
     -- "OperationDef", "TypeDef", or "all" may be specified for limit_type.
     -- If exclude_inherited is set to TRUE, inherited objects will not be
     -- included in the returned sequence.
     --
     -- You are responsible for freeing the contents of the returned
     -- sequence when you are finished with it. Use a code fragment
     -- similar to the following to free it:
     --
     --   if (containedSeq._length)
     --       SOMFree (containedSeq._buffer);
      PROCEDURE Container_lookup_name(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         search_name : IN SOM.Identifier; 
         levels_to_search : IN Corba.Long; 
         limit_type : IN Container.InterfaceName; 
         exclude_inherited : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Container_lookup_name);
      PRAGMA interface_information (Container_lookup_name, ".xsomcall7");
      Result : ALIASED Container.Contained_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Container_lookup_name (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         search_name,
         levels_to_search,
         limit_type,
         exclude_inherited,
         ContainerClassData.lookup_name);
      RETURN Result;
   END lookup_name; 

   FUNCTION describe_contents (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      limit_type : IN Container.InterfaceName; 
      exclude_inherited : IN Corba.Boolean; 
      max_returned_objs : IN Corba.Long)
      RETURN Container.ContainerDescription_Unbounded.Sequence
   IS
     
     -- Combines the "contents" operation and the "describe" operation.  For
     -- each object returned by the contents operation, the description of
     -- the object is returned by invoking its "describe" operation.
     --
     -- Max_returned_objs can be used to limit the number of objects that can
     -- be returned.  If max_returned_objs is set to -1, results for all
     -- contained objects will be returned.
     --
     -- Note: You should SOMFree result._buffer when you are done with it
     -- as well as result._buffer[x].value._value !
      PROCEDURE Container_describe_contents(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         limit_type : IN Container.InterfaceName; 
         exclude_inherited : IN Corba.Boolean; 
         max_returned_objs : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Container_describe_contents);
      PRAGMA interface_information (Container_describe_contents, ".xsomcall6");
      Result : ALIASED Container.ContainerDescription_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Container_describe_contents (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         limit_type,
         exclude_inherited,
         max_returned_objs,
         ContainerClassData.describe_contents);
      RETURN Result;
   END describe_contents; 

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

END Container; 







