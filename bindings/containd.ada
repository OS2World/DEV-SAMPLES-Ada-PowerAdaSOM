
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:01 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba.Sequences;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE Contained IS


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
      

   TYPE Description IS
   RECORD
      name : SOM.Identifier;
      value : Corba.Any;
   END RECORD;
   PRAGMA Preserve_Layout( Description );

   PACKAGE somModifier_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.somModifier);


   PACKAGE Container_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);



   FUNCTION get_name (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.Identifier;
     
     -- The value of the "name" field of the receiving object
     --
     -- This is a simple name that indentifies the receiving object
     -- within its containment hierarchy.  Outside of the containment
     -- hierarchy this name is not necessarily unique, and may require
     -- qualification by ModuleDef name, InterfaceDef name, etc.

   PROCEDURE set_name (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      name : IN SOM.Identifier);
     
     -- The value of the "name" field of the receiving object
     --
     -- This is a simple name that indentifies the receiving object
     -- within its containment hierarchy.  Outside of the containment
     -- hierarchy this name is not necessarily unique, and may require
     -- qualification by ModuleDef name, InterfaceDef name, etc.

   FUNCTION get_id (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.RepositoryId;
     
     -- The value of the "id" field of the receiving object
     --
     -- The "id" is a string that uniquely identifies any object in
     -- the interface repository.  No qualification is needed for
     -- an "id".  Notice that "RepositoryId"s have no relationship
     -- to the SOM type "somId".

   PROCEDURE set_id (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN SOM.RepositoryId);
     
     -- The value of the "id" field of the receiving object
     --
     -- The "id" is a string that uniquely identifies any object in
     -- the interface repository.  No qualification is needed for
     -- an "id".  Notice that "RepositoryId"s have no relationship
     -- to the SOM type "somId".

   FUNCTION get_defined_in (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.RepositoryId;
     
     -- The value of the "defined_in" field of the receiving object
     --
     -- This "id" uniquely identifies the container where the
     -- receiving object is defined.  Objects that have global scope
     -- and do not appear within any other objects are by default
     -- placed in the "Repository" object.

   PROCEDURE set_defined_in (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      defined_in : IN SOM.RepositoryId);
     
     -- The value of the "defined_in" field of the receiving object
     --
     -- This "id" uniquely identifies the container where the
     -- receiving object is defined.  Objects that have global scope
     -- and do not appear within any other objects are by default
     -- placed in the "Repository" object.

   FUNCTION get_somModifiers (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Contained.somModifier_Unbounded.Sequence;
     
     -- [SOM-unique extension]
     --
     -- The somModifiers attribute is a sequence containing all of
     -- the "modifiers" attached to the corresponding IDL object in
     -- the SOM-unique implementation section of the IDL file where
     -- the receiving object was originally defined.

   PROCEDURE set_somModifiers (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      somModifiers : IN Contained.somModifier_Unbounded.Sequence);
     
     -- [SOM-unique extension]
     --
     -- The somModifiers attribute is a sequence containing all of
     -- the "modifiers" attached to the corresponding IDL object in
     -- the SOM-unique implementation section of the IDL file where
     -- the receiving object was originally defined.

   FUNCTION within (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Contained.Container_Unbounded.Sequence;
     
     -- Returns a list of objects that contain the receiving object.
     -- If the object is an interface or module, it can only be contained
     -- by the object that defines it.  Other objects can be contained by
     -- objects that define or inherit them.
     --
     -- When you have finished using the sequence returned by this method
     -- it is your responsibility to release the storage allocated for it.
     -- To free the sequence, use a call similar to the following:
     --
     --   if (seqname._length)
     --       SOMFree (seqname._buffer);

   FUNCTION describe (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Contained.Description;
     
     -- Returns a structure containing all of the attributes defined in
     -- the interface of the receiving object.
     --
     -- Warning: this method returns pointers to things withing objects
     -- (for example, name).  Don't use the somFree method to release
     -- any of these objects while this information is still needed..
     --
     -- When you have finished using the information in the returned
     -- Description structure, it is your responsibility to release
     -- the associated storage using a call similar to the following:
     --
     --   if (desc.value._value)
     --       SOMFree (desc.value._value);

   PROCEDURE somFree (
      Self : IN Ref);

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

END Contained; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY Contained IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      within : SOM.somMToken;
      describe : SOM.somMToken;
      get_name : SOM.somMToken;
      set_name : SOM.somMToken;
      get_id : SOM.somMToken;
      set_id : SOM.somMToken;
      get_defined_in : SOM.somMToken;
      set_defined_in : SOM.somMToken;
      get_somModifiers : SOM.somMToken;
      set_somModifiers : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ContainedClassData : classData;
   FOR ContainedClassData USE AT standard.system.label("ContainedClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ContainedCClassData : CClassData;
   FOR ContainedCClassData USE AT standard.system.label("ContainedCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ContainedClassData.classObject) 
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
      FUNCTION ContainedNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ContainedNewClass);
      PRAGMA interface_information (ContainedNewClass, ".ContainedNewClass");
   BEGIN
      RETURN ContainedNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ContainedClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ContainedClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_name (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.Identifier
   IS
     
     -- The value of the "name" field of the receiving object
     --
     -- This is a simple name that indentifies the receiving object
     -- within its containment hierarchy.  Outside of the containment
     -- hierarchy this name is not necessarily unique, and may require
     -- qualification by ModuleDef name, InterfaceDef name, etc.
      FUNCTION Contained_U_get_name(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.Identifier; 
      PRAGMA interface (assembly, Contained_U_get_name);
      PRAGMA interface_information (Contained_U_get_name, ".xsomcall2");
      Result : ALIASED SOM.Identifier;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Contained_U_get_name (
            Self.som_object,
            Ev,
            ContainedClassData.get_name);
      RETURN Result;
   END get_name; 

   PROCEDURE set_name (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      name : IN SOM.Identifier)
   IS
     
     -- The value of the "name" field of the receiving object
     --
     -- This is a simple name that indentifies the receiving object
     -- within its containment hierarchy.  Outside of the containment
     -- hierarchy this name is not necessarily unique, and may require
     -- qualification by ModuleDef name, InterfaceDef name, etc.
      PROCEDURE Contained_U_set_name(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         name : IN SOM.Identifier;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_U_set_name);
      PRAGMA interface_information (Contained_U_set_name, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_U_set_name (
         Self.som_object,
         Ev,
         name,
         ContainedClassData.set_name);
   END set_name;

   FUNCTION get_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.RepositoryId
   IS
     
     -- The value of the "id" field of the receiving object
     --
     -- The "id" is a string that uniquely identifies any object in
     -- the interface repository.  No qualification is needed for
     -- an "id".  Notice that "RepositoryId"s have no relationship
     -- to the SOM type "somId".
      FUNCTION Contained_U_get_id(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.RepositoryId; 
      PRAGMA interface (assembly, Contained_U_get_id);
      PRAGMA interface_information (Contained_U_get_id, ".xsomcall2");
      Result : ALIASED SOM.RepositoryId;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Contained_U_get_id (
            Self.som_object,
            Ev,
            ContainedClassData.get_id);
      RETURN Result;
   END get_id; 

   PROCEDURE set_id (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN SOM.RepositoryId)
   IS
     
     -- The value of the "id" field of the receiving object
     --
     -- The "id" is a string that uniquely identifies any object in
     -- the interface repository.  No qualification is needed for
     -- an "id".  Notice that "RepositoryId"s have no relationship
     -- to the SOM type "somId".
      PROCEDURE Contained_U_set_id(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         id : IN SOM.RepositoryId;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_U_set_id);
      PRAGMA interface_information (Contained_U_set_id, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_U_set_id (
         Self.som_object,
         Ev,
         id,
         ContainedClassData.set_id);
   END set_id;

   FUNCTION get_defined_in (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.RepositoryId
   IS
     
     -- The value of the "defined_in" field of the receiving object
     --
     -- This "id" uniquely identifies the container where the
     -- receiving object is defined.  Objects that have global scope
     -- and do not appear within any other objects are by default
     -- placed in the "Repository" object.
      FUNCTION Contained_U_get_defined_in(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.RepositoryId; 
      PRAGMA interface (assembly, Contained_U_get_defined_in);
      PRAGMA interface_information (Contained_U_get_defined_in, ".xsomcall2");
      Result : ALIASED SOM.RepositoryId;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         Contained_U_get_defined_in (
            Self.som_object,
            Ev,
            ContainedClassData.get_defined_in);
      RETURN Result;
   END get_defined_in; 

   PROCEDURE set_defined_in (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      defined_in : IN SOM.RepositoryId)
   IS
     
     -- The value of the "defined_in" field of the receiving object
     --
     -- This "id" uniquely identifies the container where the
     -- receiving object is defined.  Objects that have global scope
     -- and do not appear within any other objects are by default
     -- placed in the "Repository" object.
      PROCEDURE Contained_U_set_defined_in(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         defined_in : IN SOM.RepositoryId;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_U_set_defined_in);
      PRAGMA interface_information (Contained_U_set_defined_in, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_U_set_defined_in (
         Self.som_object,
         Ev,
         defined_in,
         ContainedClassData.set_defined_in);
   END set_defined_in;

   FUNCTION get_somModifiers (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Contained.somModifier_Unbounded.Sequence
   IS
     
     -- [SOM-unique extension]
     --
     -- The somModifiers attribute is a sequence containing all of
     -- the "modifiers" attached to the corresponding IDL object in
     -- the SOM-unique implementation section of the IDL file where
     -- the receiving object was originally defined.
      PROCEDURE Contained_U_get_somModifiers(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_U_get_somModifiers);
      PRAGMA interface_information (Contained_U_get_somModifiers, ".xsomcall3");
      Result : ALIASED Contained.somModifier_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_U_get_somModifiers (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         ContainedClassData.get_somModifiers);
      RETURN Result;
   END get_somModifiers; 

   PROCEDURE set_somModifiers (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      somModifiers : IN Contained.somModifier_Unbounded.Sequence)
   IS
     
     -- [SOM-unique extension]
     --
     -- The somModifiers attribute is a sequence containing all of
     -- the "modifiers" attached to the corresponding IDL object in
     -- the SOM-unique implementation section of the IDL file where
     -- the receiving object was originally defined.
      PROCEDURE Contained_U_set_somModifiers(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         somModifiers : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_U_set_somModifiers);
      PRAGMA interface_information (Contained_U_set_somModifiers, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_U_set_somModifiers (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(somModifiers'address),
         ContainedClassData.set_somModifiers);
   END set_somModifiers;

   FUNCTION within (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Contained.Container_Unbounded.Sequence
   IS
     
     -- Returns a list of objects that contain the receiving object.
     -- If the object is an interface or module, it can only be contained
     -- by the object that defines it.  Other objects can be contained by
     -- objects that define or inherit them.
     --
     -- When you have finished using the sequence returned by this method
     -- it is your responsibility to release the storage allocated for it.
     -- To free the sequence, use a call similar to the following:
     --
     --   if (seqname._length)
     --       SOMFree (seqname._buffer);
      PROCEDURE Contained_within(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_within);
      PRAGMA interface_information (Contained_within, ".xsomcall3");
      Result : ALIASED Contained.Container_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_within (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         ContainedClassData.within);
      RETURN Result;
   END within; 

   FUNCTION describe (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Contained.Description
   IS
     
     -- Returns a structure containing all of the attributes defined in
     -- the interface of the receiving object.
     --
     -- Warning: this method returns pointers to things withing objects
     -- (for example, name).  Don't use the somFree method to release
     -- any of these objects while this information is still needed..
     --
     -- When you have finished using the information in the returned
     -- Description structure, it is your responsibility to release
     -- the associated storage using a call similar to the following:
     --
     --   if (desc.value._value)
     --       SOMFree (desc.value._value);
      PROCEDURE Contained_describe(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, Contained_describe);
      PRAGMA interface_information (Contained_describe, ".xsomcall3");
      Result : ALIASED Contained.Description;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Contained_describe (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         ContainedClassData.describe);
      RETURN Result;
   END describe; 

   PROCEDURE somFree (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somFree (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somFree;

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

END Contained; 







