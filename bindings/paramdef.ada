
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:22 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Contained;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE ParameterDef IS


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
      

   TYPE ParameterMode IS (IDL_IN, IDL_OUT, INOUT);
   FOR ParameterMode USE (
      IDL_IN => 1,
      IDL_OUT => 2,
      INOUT => 3 );

   TYPE ParameterDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
      IDL_type : Corba.TypeCode.Object;
      mode : ParameterDef.ParameterMode;
   END RECORD;
   PRAGMA Preserve_Layout( ParameterDescription );
     
     -- The inherited describe method returns an instance of this
     -- (ParameterDescription) structure in the "value" member of the
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

   FUNCTION get_mode (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN ParameterDef.ParameterMode;
     
     -- The ParameterMode of the receiving object;

   PROCEDURE set_mode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mode : IN ParameterDef.ParameterMode);
     
     -- The ParameterMode of the receiving object;

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

END ParameterDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY ParameterDef IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_type : SOM.somMToken;
      set_type : SOM.somMToken;
      get_mode : SOM.somMToken;
      set_mode : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   ParameterDefClassData : classData;
   FOR ParameterDefClassData USE AT standard.system.label("ParameterDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   ParameterDefCClassData : CClassData;
   FOR ParameterDefCClassData USE AT standard.system.label("ParameterDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            ParameterDefClassData.classObject) 
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
      FUNCTION ParameterDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, ParameterDefNewClass);
      PRAGMA interface_information (ParameterDefNewClass, ".ParameterDefNewClass");
   BEGIN
      RETURN ParameterDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF ParameterDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(ParameterDefClassData.classObject));
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
      FUNCTION ParameterDef_U_get_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, ParameterDef_U_get_type);
      PRAGMA interface_information (ParameterDef_U_get_type, ".xsomcall2");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ParameterDef_U_get_type (
            Self.som_object,
            Ev,
            ParameterDefClassData.get_type);
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
      PROCEDURE ParameterDef_U_set_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IDL_type : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ParameterDef_U_set_type);
      PRAGMA interface_information (ParameterDef_U_set_type, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ParameterDef_U_set_type (
         Self.som_object,
         Ev,
         IDL_type,
         ParameterDefClassData.set_type);
   END set_type;

   FUNCTION get_mode (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN ParameterDef.ParameterMode
   IS
     
     -- The ParameterMode of the receiving object;
      FUNCTION ParameterDef_U_get_mode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN ParameterDef.ParameterMode; 
      PRAGMA interface (assembly, ParameterDef_U_get_mode);
      PRAGMA interface_information (ParameterDef_U_get_mode, ".xsomcall2");
      Result : ALIASED ParameterDef.ParameterMode;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         ParameterDef_U_get_mode (
            Self.som_object,
            Ev,
            ParameterDefClassData.get_mode);
      RETURN Result;
   END get_mode; 

   PROCEDURE set_mode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mode : IN ParameterDef.ParameterMode)
   IS
     
     -- The ParameterMode of the receiving object;
      PROCEDURE ParameterDef_U_set_mode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mode : IN ParameterDef.ParameterMode;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, ParameterDef_U_set_mode);
      PRAGMA interface_information (ParameterDef_U_set_mode, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      ParameterDef_U_set_mode (
         Self.som_object,
         Ev,
         mode,
         ParameterDefClassData.set_mode);
   END set_mode;

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

END ParameterDef; 







