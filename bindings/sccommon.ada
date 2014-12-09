
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

PACKAGE SOMTCommonEntryC IS

   
   -- This class defines a number of methods and attributes that are
   -- common to <SOMTMethodEntry>, <SOMTDataEntry>, and
   -- <SOMTParameterEntry>.  No entries of this type will actually
   -- be found in the entry graph, instead they will all be one of
   -- the types mentioned above.
   -- Exception: entries whose somtElementType is SOMTTypedefBE, which
   -- represent a reference to a user-defined type, are instance of this class.

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
      


   FUNCTION get_somtTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The object representing the base type of the entry.
     -- This does not include pointer stars or array declarators.

   FUNCTION get_somtPtrs (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The string of stars associated with the entry's type.
     -- For example, an object of type "foo" would have somtPtrs = NULL,
     -- type "foo *" would have somtPtrs = "*", type
     -- "foo **" would have somtPtrs = "**", etc.

   FUNCTION get_somtArrayDimsString (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Array dimensions in string form.

   FUNCTION somtGetFirstArrayDimension (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- The first array dimension, for items of type array.
     -- Zero indicates that the item is not an array.

   FUNCTION somtGetNextArrayDimension (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- The next array dimension, for items of type array,
     -- relative to the previous call to this method or to
     -- somtGetFirstArrayDimension.  Zero indicates no more dimensions.

   FUNCTION get_somtSourceText (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The un-parsed source text for this entry, with leading and
     -- trailing white space removed.  For attribute/typedef declarators
     -- and for user-defined types, this attribute only provides the
     -- source text for the entry's name.  For methods, arguments,
     -- and instance variables, however, this attribute provides the
     -- full definition.

   FUNCTION get_somtType (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The IDL type for this entry in string form. For methods this is the
     -- return type.  For data or parameters this is the type of the data
     -- item or parameter. For user-defined types, this is the type specification.
     -- It is of the form:   <typename><pointer-stars> <array-declarators>

   FUNCTION get_somtVisibility (
      Self : IN Ref)
      RETURN SCTypes.somtVisibilityT;
     
     -- The visibility of this entry.  Note: the visibility of
     -- parameter entries will always be public, and methods can never be
     -- internal.

   PROCEDURE somtIsArray (
      Self : IN Ref;
      size : OUT Corba.Long;
      Result : OUT Corba.Boolean);
     
     -- Returns 1 (true) if the type involves an array.  When the type
     -- involves an array then <size> is set to be the size of the
     -- array.

   FUNCTION somtIsPointer (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the type involves a pointer, and 0 (false)
     -- otherwise

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

END SOMTCommonEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTCommonEntryC IS

   
   -- This class defines a number of methods and attributes that are
   -- common to <SOMTMethodEntry>, <SOMTDataEntry>, and
   -- <SOMTParameterEntry>.  No entries of this type will actually
   -- be found in the entry graph, instead they will all be one of
   -- the types mentioned above.
   -- Exception: entries whose somtElementType is SOMTTypedefBE, which
   -- represent a reference to a user-defined type, are instance of this class.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtSourceText : SOM.somMToken;
      get_somtType : SOM.somMToken;
      get_somtVisibility : SOM.somMToken;
      somtIsArray : SOM.somMToken;
      somtIsPointer : SOM.somMToken;
      somtIsArrayDominant : SOM.somMToken;
      get_somtTypeObj : SOM.somMToken;
      get_somtPtrs : SOM.somMToken;
      get_somtArrayDimsString : SOM.somMToken;
      somtGetFirstArrayDimension : SOM.somMToken;
      somtGetNextArrayDimension : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTCommonEntryCClassData : classData;
   FOR SOMTCommonEntryCClassData USE AT standard.system.label("SOMTCommonEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTCommonEntryCCClassData : CClassData;
   FOR SOMTCommonEntryCCClassData USE AT standard.system.label("SOMTCommonEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTCommonEntryCClassData.classObject) 
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
      FUNCTION SOMTCommonEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTCommonEntryCNewClass);
      PRAGMA interface_information (SOMTCommonEntryCNewClass, ".SOMTCommonEntryCNewClass");
   BEGIN
      RETURN SOMTCommonEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTCommonEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTCommonEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtTypeObj (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The object representing the base type of the entry.
     -- This does not include pointer stars or array declarators.
      FUNCTION SOMTCommonEntryC_U_get_somtTypeObj(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTCommonEntryC_U_get_somtTypeObj);
      PRAGMA interface_information (SOMTCommonEntryC_U_get_somtTypeObj, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_U_get_somtTypeObj (
            Self.som_object,
            SOMTCommonEntryCClassData.get_somtTypeObj);
      RETURN Result;
   END get_somtTypeObj; 

   FUNCTION get_somtPtrs (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The string of stars associated with the entry's type.
     -- For example, an object of type "foo" would have somtPtrs = NULL,
     -- type "foo *" would have somtPtrs = "*", type
     -- "foo **" would have somtPtrs = "**", etc.
      FUNCTION SOMTCommonEntryC_U_get_somtPtrs(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTCommonEntryC_U_get_somtPtrs);
      PRAGMA interface_information (SOMTCommonEntryC_U_get_somtPtrs, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_U_get_somtPtrs (
            Self.som_object,
            SOMTCommonEntryCClassData.get_somtPtrs);
      RETURN Result;
   END get_somtPtrs; 

   FUNCTION get_somtArrayDimsString (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Array dimensions in string form.
      FUNCTION SOMTCommonEntryC_U_get_somtArrayDimsString(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTCommonEntryC_U_get_somtArrayDimsString);
      PRAGMA interface_information (SOMTCommonEntryC_U_get_somtArrayDimsString, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_U_get_somtArrayDimsString (
            Self.som_object,
            SOMTCommonEntryCClassData.get_somtArrayDimsString);
      RETURN Result;
   END get_somtArrayDimsString; 

   FUNCTION somtGetFirstArrayDimension (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- The first array dimension, for items of type array.
     -- Zero indicates that the item is not an array.
      FUNCTION SOMTCommonEntryC_somtGetFirstArrayDimension(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMTCommonEntryC_somtGetFirstArrayDimension);
      PRAGMA interface_information (SOMTCommonEntryC_somtGetFirstArrayDimension, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_somtGetFirstArrayDimension (
            Self.som_object,
            SOMTCommonEntryCClassData.somtGetFirstArrayDimension);
      RETURN Result;
   END somtGetFirstArrayDimension; 

   FUNCTION somtGetNextArrayDimension (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- The next array dimension, for items of type array,
     -- relative to the previous call to this method or to
     -- somtGetFirstArrayDimension.  Zero indicates no more dimensions.
      FUNCTION SOMTCommonEntryC_somtGetNextArrayDimension(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMTCommonEntryC_somtGetNextArrayDimension);
      PRAGMA interface_information (SOMTCommonEntryC_somtGetNextArrayDimension, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_somtGetNextArrayDimension (
            Self.som_object,
            SOMTCommonEntryCClassData.somtGetNextArrayDimension);
      RETURN Result;
   END somtGetNextArrayDimension; 

   FUNCTION get_somtSourceText (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The un-parsed source text for this entry, with leading and
     -- trailing white space removed.  For attribute/typedef declarators
     -- and for user-defined types, this attribute only provides the
     -- source text for the entry's name.  For methods, arguments,
     -- and instance variables, however, this attribute provides the
     -- full definition.
      FUNCTION SOMTCommonEntryC_U_get_somtSourceText(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTCommonEntryC_U_get_somtSourceText);
      PRAGMA interface_information (SOMTCommonEntryC_U_get_somtSourceText, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_U_get_somtSourceText (
            Self.som_object,
            SOMTCommonEntryCClassData.get_somtSourceText);
      RETURN Result;
   END get_somtSourceText; 

   FUNCTION get_somtType (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The IDL type for this entry in string form. For methods this is the
     -- return type.  For data or parameters this is the type of the data
     -- item or parameter. For user-defined types, this is the type specification.
     -- It is of the form:   <typename><pointer-stars> <array-declarators>
      FUNCTION SOMTCommonEntryC_U_get_somtType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTCommonEntryC_U_get_somtType);
      PRAGMA interface_information (SOMTCommonEntryC_U_get_somtType, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_U_get_somtType (
            Self.som_object,
            SOMTCommonEntryCClassData.get_somtType);
      RETURN Result;
   END get_somtType; 

   FUNCTION get_somtVisibility (
      Self : IN Ref)
      RETURN SCTypes.somtVisibilityT
   IS
     
     -- The visibility of this entry.  Note: the visibility of
     -- parameter entries will always be public, and methods can never be
     -- internal.
      FUNCTION SOMTCommonEntryC_U_get_somtVisibility(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.somtVisibilityT; 
      PRAGMA interface (assembly, SOMTCommonEntryC_U_get_somtVisibility);
      PRAGMA interface_information (SOMTCommonEntryC_U_get_somtVisibility, ".xsomcall1");
      Result : ALIASED SCTypes.somtVisibilityT;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_U_get_somtVisibility (
            Self.som_object,
            SOMTCommonEntryCClassData.get_somtVisibility);
      RETURN Result;
   END get_somtVisibility; 

   PROCEDURE somtIsArray (
      Self : IN Ref; 
      size : OUT Corba.Long; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Returns 1 (true) if the type involves an array.  When the type
     -- involves an array then <size> is set to be the size of the
     -- array.
      FUNCTION SOMTCommonEntryC_somtIsArray(
         Self : IN SOM.SOMObjectPtr; 
         size : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTCommonEntryC_somtIsArray);
      PRAGMA interface_information (SOMTCommonEntryC_somtIsArray, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_somtIsArray (
            Self.som_object,
            SOM.To_SOM_Address(size'address),
            SOMTCommonEntryCClassData.somtIsArray);
   END somtIsArray;

   FUNCTION somtIsPointer (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if the type involves a pointer, and 0 (false)
     -- otherwise
      FUNCTION SOMTCommonEntryC_somtIsPointer(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTCommonEntryC_somtIsPointer);
      PRAGMA interface_information (SOMTCommonEntryC_somtIsPointer, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTCommonEntryC_somtIsPointer (
            Self.som_object,
            SOMTCommonEntryCClassData.somtIsPointer);
      RETURN Result;
   END somtIsPointer; 

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

END SOMTCommonEntryC; 







