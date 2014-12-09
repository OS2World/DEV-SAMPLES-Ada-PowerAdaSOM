
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:11 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Contained;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE TypeDef IS


   TYPE Ref IS NEW Contained.Ref WITH NULL RECORD;

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
      

   TYPE TypeDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
      IDL_type : Corba.TypeCode.Object;
   END RECORD;
   PRAGMA Preserve_Layout( TypeDescription );
     
     -- The inherited describe method returns an instance of this
     -- (TypeDescription) structure in the "value" member of the
     -- Description structure defined in the Contained interface.


   FUNCTION get_type (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.TypeCode.Object;
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.

   PROCEDURE set_type (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IDL_type : IN Corba.TypeCode.Object);
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.

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

   FUNCTION describe (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Contained.Description;

END TypeDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY TypeDef IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_type : SOM.somMToken;
      set_type : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   TypeDefClassData : classData;
   FOR TypeDefClassData USE AT standard.system.label("TypeDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   TypeDefCClassData : CClassData;
   FOR TypeDefCClassData USE AT standard.system.label("TypeDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            TypeDefClassData.classObject) 
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
      FUNCTION TypeDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, TypeDefNewClass);
      PRAGMA interface_information (TypeDefNewClass, ".TypeDefNewClass");
   BEGIN
      RETURN TypeDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF TypeDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(TypeDefClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_type (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.TypeCode.Object
   IS
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.
      FUNCTION TypeDef_U_get_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, TypeDef_U_get_type);
      PRAGMA interface_information (TypeDef_U_get_type, ".xsomcall2");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         TypeDef_U_get_type (
            Self.som_object,
            Ev,
            TypeDefClassData.get_type);
      RETURN Result;
   END get_type; 

   PROCEDURE set_type (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IDL_type : IN Corba.TypeCode.Object)
   IS
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.
      PROCEDURE TypeDef_U_set_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IDL_type : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, TypeDef_U_set_type);
      PRAGMA interface_information (TypeDef_U_set_type, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      TypeDef_U_set_type (
         Self.som_object,
         Ev,
         IDL_type,
         TypeDefClassData.set_type);
   END set_type;

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

   FUNCTION describe (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Contained.Description
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Contained.describe (
            Contained.Ref'(som_object=>Self.som_object),
            Ev);
   END describe;

END TypeDef; 







