
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:19 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE NVList IS


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
      


   FUNCTION add_item (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      item_name : IN SOM.Identifier;
      item_type : IN Corba.TypeCode.Object;
      value : IN SOM.VoidPtr;
      value_len : IN Corba.Long;
      item_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;

   FUNCTION free (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.ORBStatus;

   FUNCTION free_memory (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.ORBStatus;

   PROCEDURE get_count (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      count : OUT Corba.Long;
      Result : OUT SOM.ORBStatus);
     
     --
     -- These are the accessor functions which allow indexing
     -- into the NVList
     --

   FUNCTION set_item (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      item_number : IN Corba.Long;
      item_name : IN SOM.Identifier;
      item_type : IN Corba.TypeCode.Object;
      value : IN SOM.VoidPtr;
      value_len : IN Corba.Long;
      item_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus;
     
     -- Items are numbered 0 ... N

   PROCEDURE get_item (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      item_number : IN Corba.Long;
      item_name : OUT SOM.Identifier;
      item_type : OUT Corba.TypeCode.Object;
      value : OUT SOM.VoidPtr;
      value_len : OUT Corba.Long;
      item_flags : OUT SOM.Flags;
      Result : OUT SOM.ORBStatus);
     
     -- Items are numbered 0 ... N

   PROCEDURE somInit (
      Self : IN Ref);

END NVList; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY NVList IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      add_item : SOM.somMToken;
      remove_item : SOM.somMToken;
      free : SOM.somMToken;
      free_memory : SOM.somMToken;
      get_count : SOM.somMToken;
      set_item : SOM.somMToken;
      get_item : SOM.somMToken;
      get_item_by_name : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   NVListClassData : classData;
   FOR NVListClassData USE AT standard.system.label("NVListClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   NVListCClassData : CClassData;
   FOR NVListCClassData USE AT standard.system.label("NVListCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            NVListClassData.classObject) 
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
      FUNCTION NVListNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, NVListNewClass);
      PRAGMA interface_information (NVListNewClass, ".NVListNewClass");
   BEGIN
      RETURN NVListNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF NVListClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(NVListClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION add_item (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      item_name : IN SOM.Identifier; 
      item_type : IN Corba.TypeCode.Object; 
      value : IN SOM.VoidPtr; 
      value_len : IN Corba.Long; 
      item_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
      FUNCTION NVList_add_item(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         item_name : IN SOM.Identifier; 
         item_type : IN Corba.TypeCode.Object; 
         value : IN SOM.VoidPtr; 
         value_len : IN Corba.Long; 
         item_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, NVList_add_item);
      PRAGMA interface_information (NVList_add_item, ".xsomcall7");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         NVList_add_item (
            Self.som_object,
            Ev,
            item_name,
            item_type,
            value,
            value_len,
            item_flags,
            NVListClassData.add_item);
      RETURN Result;
   END add_item; 

   FUNCTION free (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.ORBStatus
   IS
      FUNCTION NVList_free(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, NVList_free);
      PRAGMA interface_information (NVList_free, ".xsomcall2");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         NVList_free (
            Self.som_object,
            Ev,
            NVListClassData.free);
      RETURN Result;
   END free; 

   FUNCTION free_memory (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.ORBStatus
   IS
      FUNCTION NVList_free_memory(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, NVList_free_memory);
      PRAGMA interface_information (NVList_free_memory, ".xsomcall2");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         NVList_free_memory (
            Self.som_object,
            Ev,
            NVListClassData.free_memory);
      RETURN Result;
   END free_memory; 

   PROCEDURE get_count (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      count : OUT Corba.Long; 
      Result : OUT SOM.ORBStatus)
   IS
     
     --
     -- These are the accessor functions which allow indexing
     -- into the NVList
     --
      FUNCTION NVList_get_count(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         count : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, NVList_get_count);
      PRAGMA interface_information (NVList_get_count, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         NVList_get_count (
            Self.som_object,
            Ev,
            SOM.To_SOM_Address(count'address),
            NVListClassData.get_count);
   END get_count;

   FUNCTION set_item (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      item_number : IN Corba.Long; 
      item_name : IN SOM.Identifier; 
      item_type : IN Corba.TypeCode.Object; 
      value : IN SOM.VoidPtr; 
      value_len : IN Corba.Long; 
      item_flags : IN SOM.Flags)
      RETURN SOM.ORBStatus
   IS
     
     -- Items are numbered 0 ... N
      FUNCTION NVList_set_item(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         item_number : IN Corba.Long; 
         item_name : IN SOM.Identifier; 
         item_type : IN Corba.TypeCode.Object; 
         value : IN SOM.VoidPtr; 
         value_len : IN Corba.Long; 
         item_flags : IN SOM.Flags;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, NVList_set_item);
      PRAGMA interface_information (NVList_set_item, ".xsomcall8");
      Result : ALIASED SOM.ORBStatus;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         NVList_set_item (
            Self.som_object,
            Ev,
            item_number,
            item_name,
            item_type,
            value,
            value_len,
            item_flags,
            NVListClassData.set_item);
      RETURN Result;
   END set_item; 

   PROCEDURE get_item (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      item_number : IN Corba.Long; 
      item_name : OUT SOM.Identifier; 
      item_type : OUT Corba.TypeCode.Object; 
      value : OUT SOM.VoidPtr; 
      value_len : OUT Corba.Long; 
      item_flags : OUT SOM.Flags; 
      Result : OUT SOM.ORBStatus)
   IS
     
     -- Items are numbered 0 ... N
      FUNCTION NVList_get_item(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         item_number : IN Corba.Long; 
         item_name : IN SOM.address; 
         item_type : IN SOM.address; 
         value : IN SOM.address; 
         value_len : IN SOM.address; 
         item_flags : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.ORBStatus; 
      PRAGMA interface (assembly, NVList_get_item);
      PRAGMA interface_information (NVList_get_item, ".xsomcall8");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         NVList_get_item (
            Self.som_object,
            Ev,
            item_number,
            SOM.To_SOM_Address(item_name'address),
            SOM.To_SOM_Address(item_type'address),
            SOM.To_SOM_Address(value'address),
            SOM.To_SOM_Address(value_len'address),
            SOM.To_SOM_Address(item_flags'address),
            NVListClassData.get_item);
   END get_item;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END NVList; 







