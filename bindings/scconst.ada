
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:14 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTConstEntryC IS


   TYPE Ref IS NEW SOMTEntryC.Ref WITH NULL RECORD;

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
      


   FUNCTION get_somtConstTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- A pointer to an object representing
     -- the type of the const.

   FUNCTION get_somtConstType (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The type of the constant's value.

   FUNCTION get_somtConstStringVal (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The string value of the constant (unevaluated).

   FUNCTION get_somtConstNumVal (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- The number value of the constant.
     -- This attribute is not valid if the value cannot
     -- be stored in an unsigned long (string, float, double, negative).
     -- The somtConstIsNegative attribute can be used to determine
     -- if the value is negative.  The somtConstType attribute can
     -- be used to determine whether the value is a float or double.

   FUNCTION get_somtConstNumNegVal (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The number value of the constant, if negative.

   FUNCTION get_somtConstIsNegative (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether the constant's value is a negative integer and
     -- must be obtained using somtConstNumNegVal rather than somtConstNumVal.

   FUNCTION get_somtConstVal (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The string value of the constant (evaluated).
     -- The "get" method for this attribute returns a string whose
     -- ownership is transferred to the caller.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTConstEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTConstEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtConstStringVal : SOM.somMToken;
      get_somtConstNumVal : SOM.somMToken;
      get_somtConstType : SOM.somMToken;
      get_somtConstTypeObj : SOM.somMToken;
      get_somtConstVal : SOM.somMToken;
      get_somtConstNumNegVal : SOM.somMToken;
      get_somtConstIsNegative : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTConstEntryCClassData : classData;
   FOR SOMTConstEntryCClassData USE AT standard.system.label("SOMTConstEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTConstEntryCCClassData : CClassData;
   FOR SOMTConstEntryCCClassData USE AT standard.system.label("SOMTConstEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTConstEntryCClassData.classObject) 
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
      FUNCTION SOMTConstEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTConstEntryCNewClass);
      PRAGMA interface_information (SOMTConstEntryCNewClass, ".SOMTConstEntryCNewClass");
   BEGIN
      RETURN SOMTConstEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTConstEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTConstEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtConstTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- A pointer to an object representing
     -- the type of the const.
      FUNCTION SOMTConstEntryC_U_get_somtConstTypeObj(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstTypeObj);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstTypeObj, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstTypeObj (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstTypeObj);
      RETURN Result;
   END get_somtConstTypeObj; 

   FUNCTION get_somtConstType (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The type of the constant's value.
      FUNCTION SOMTConstEntryC_U_get_somtConstType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstType);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstType, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstType (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstType);
      RETURN Result;
   END get_somtConstType; 

   FUNCTION get_somtConstStringVal (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The string value of the constant (unevaluated).
      FUNCTION SOMTConstEntryC_U_get_somtConstStringVal(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstStringVal);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstStringVal, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstStringVal (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstStringVal);
      RETURN Result;
   END get_somtConstStringVal; 

   FUNCTION get_somtConstNumVal (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- The number value of the constant.
     -- This attribute is not valid if the value cannot
     -- be stored in an unsigned long (string, float, double, negative).
     -- The somtConstIsNegative attribute can be used to determine
     -- if the value is negative.  The somtConstType attribute can
     -- be used to determine whether the value is a float or double.
      FUNCTION SOMTConstEntryC_U_get_somtConstNumVal(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstNumVal);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstNumVal, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstNumVal (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstNumVal);
      RETURN Result;
   END get_somtConstNumVal; 

   FUNCTION get_somtConstNumNegVal (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The number value of the constant, if negative.
      FUNCTION SOMTConstEntryC_U_get_somtConstNumNegVal(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstNumNegVal);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstNumNegVal, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstNumNegVal (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstNumNegVal);
      RETURN Result;
   END get_somtConstNumNegVal; 

   FUNCTION get_somtConstIsNegative (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether the constant's value is a negative integer and
     -- must be obtained using somtConstNumNegVal rather than somtConstNumVal.
      FUNCTION SOMTConstEntryC_U_get_somtConstIsNegative(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstIsNegative);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstIsNegative, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstIsNegative (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstIsNegative);
      RETURN Result;
   END get_somtConstIsNegative; 

   FUNCTION get_somtConstVal (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The string value of the constant (evaluated).
     -- The "get" method for this attribute returns a string whose
     -- ownership is transferred to the caller.
      FUNCTION SOMTConstEntryC_U_get_somtConstVal(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTConstEntryC_U_get_somtConstVal);
      PRAGMA interface_information (SOMTConstEntryC_U_get_somtConstVal, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTConstEntryC_U_get_somtConstVal (
            Self.som_object,
            SOMTConstEntryCClassData.get_somtConstVal);
      RETURN Result;
   END get_somtConstVal; 

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

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref; 
      emitter : IN SOM.SOMObjectPtr; 
      prefix : IN Corba.String)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMTEntryC.somtSetSymbolsOnEntry (
            SOMTEntryC.Ref'(som_object=>Self.som_object),
            emitter,
            prefix);
   END somtSetSymbolsOnEntry;

END SOMTConstEntryC; 







