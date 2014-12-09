
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:00 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Contained;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE ConstantDef IS


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
      

   TYPE ConstantDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
      IDL_type : Corba.TypeCode.Object;
      value : Corba.Any;
   END RECORD;
   PRAGMA Preserve_Layout( ConstantDescription );
     
     -- The inherited describe method returns an instance of this
     -- (ConstantDescription) structure in the "value" member of the
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

   FUNCTION get_value (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Any;
     
     -- The value of the receiving constant object;
     -- "value" is an any carrying a string per CORBA 7.5.9 p. 123

   PROCEDURE set_value (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      value : IN Corba.Any);
     
     -- The value of the receiving constant object;
     -- "value" is an any carrying a string per CORBA 7.5.9 p. 123

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

END ConstantDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY ConstantDef IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_type : SOM.somMToken;
      set_type : SOM.somMToken;
      get_value : SOM.somMToken;
      set_value : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ConstantDefClassData : classData;
   FOR ConstantDefClassData USE AT standard.system.label("ConstantDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ConstantDefCClassData : CClassData;
   FOR ConstantDefCClassData USE AT standard.system.label("ConstantDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ConstantDefClassData.classObject) 
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
      FUNCTION ConstantDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ConstantDefNewClass);
      PRAGMA interface_information (ConstantDefNewClass, ".ConstantDefNewClass");
   BEGIN
      RETURN ConstantDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ConstantDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ConstantDefClassData.classObject));
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
      FUNCTION ConstantDef_U_get_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, ConstantDef_U_get_type);
      PRAGMA interface_information (ConstantDef_U_get_type, ".xsomcall2");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ConstantDef_U_get_type (
            Self.som_object,
            Ev,
            ConstantDefClassData.get_type);
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
      PROCEDURE ConstantDef_U_set_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IDL_type : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ConstantDef_U_set_type);
      PRAGMA interface_information (ConstantDef_U_set_type, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ConstantDef_U_set_type (
         Self.som_object,
         Ev,
         IDL_type,
         ConstantDefClassData.set_type);
   END set_type;

   FUNCTION get_value (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Any
   IS
     
     -- The value of the receiving constant object;
     -- "value" is an any carrying a string per CORBA 7.5.9 p. 123
      PROCEDURE ConstantDef_U_get_value(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ConstantDef_U_get_value);
      PRAGMA interface_information (ConstantDef_U_get_value, ".xsomcall3");
      Result : ALIASED Corba.Any;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ConstantDef_U_get_value (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         ConstantDefClassData.get_value);
      RETURN Result;
   END get_value; 

   PROCEDURE set_value (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      value : IN Corba.Any)
   IS
     
     -- The value of the receiving constant object;
     -- "value" is an any carrying a string per CORBA 7.5.9 p. 123
      PROCEDURE ConstantDef_U_set_value(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         value : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ConstantDef_U_set_value);
      PRAGMA interface_information (ConstantDef_U_set_value, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ConstantDef_U_set_value (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(value'address),
         ConstantDefClassData.set_value);
   END set_value;

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

END ConstantDef; 







