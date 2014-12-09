
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:05:58 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Contained;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE AttributeDef IS


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
      

   TYPE AttributeMode IS (NORMAL, READONLY);
   FOR AttributeMode USE (
      NORMAL => 1,
      READONLY => 2 );

   TYPE AttributeDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
      IDL_type : Corba.TypeCode.Object;
      mode : AttributeDef.AttributeMode;
   END RECORD;
   PRAGMA Preserve_Layout( AttributeDescription );
     
     -- The inherited describe method returns an instance of this
     -- (AttributeDescription) structure in the "value" member of the
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
      RETURN AttributeDef.AttributeMode;
     
     -- The AttributeMode of the receiving object;

   PROCEDURE set_mode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mode : IN AttributeDef.AttributeMode);
     
     -- The AttributeMode of the receiving object;

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

END AttributeDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY AttributeDef IS

   

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

   AttributeDefClassData : classData;
   FOR AttributeDefClassData USE AT standard.system.label("AttributeDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   AttributeDefCClassData : CClassData;
   FOR AttributeDefCClassData USE AT standard.system.label("AttributeDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            AttributeDefClassData.classObject) 
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
      FUNCTION AttributeDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, AttributeDefNewClass);
      PRAGMA interface_information (AttributeDefNewClass, ".AttributeDefNewClass");
   BEGIN
      RETURN AttributeDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF AttributeDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(AttributeDefClassData.classObject));
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
      FUNCTION AttributeDef_U_get_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, AttributeDef_U_get_type);
      PRAGMA interface_information (AttributeDef_U_get_type, ".xsomcall2");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         AttributeDef_U_get_type (
            Self.som_object,
            Ev,
            AttributeDefClassData.get_type);
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
      PROCEDURE AttributeDef_U_set_type(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IDL_type : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, AttributeDef_U_set_type);
      PRAGMA interface_information (AttributeDef_U_set_type, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      AttributeDef_U_set_type (
         Self.som_object,
         Ev,
         IDL_type,
         AttributeDefClassData.set_type);
   END set_type;

   FUNCTION get_mode (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN AttributeDef.AttributeMode
   IS
     
     -- The AttributeMode of the receiving object;
      FUNCTION AttributeDef_U_get_mode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN AttributeDef.AttributeMode; 
      PRAGMA interface (assembly, AttributeDef_U_get_mode);
      PRAGMA interface_information (AttributeDef_U_get_mode, ".xsomcall2");
      Result : ALIASED AttributeDef.AttributeMode;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         AttributeDef_U_get_mode (
            Self.som_object,
            Ev,
            AttributeDefClassData.get_mode);
      RETURN Result;
   END get_mode; 

   PROCEDURE set_mode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mode : IN AttributeDef.AttributeMode)
   IS
     
     -- The AttributeMode of the receiving object;
      PROCEDURE AttributeDef_U_set_mode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mode : IN AttributeDef.AttributeMode;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, AttributeDef_U_set_mode);
      PRAGMA interface_information (AttributeDef_U_set_mode, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      AttributeDef_U_set_mode (
         Self.som_object,
         Ev,
         mode,
         AttributeDefClassData.set_mode);
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

END AttributeDef; 







