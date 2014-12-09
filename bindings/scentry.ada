
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:16 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTEntryC IS

   
   -- A SOM class interface definition is compiled to produce a graph
   -- structure whose nodes are instances of <SOMTEntry> or its
   -- sub-classes.  Each entry is derived from some syntactic element of
   -- the definition source. The attributes defined in <SOMTEntryC>
   -- refer to this syntactic element in a fairly obvious way.
   --

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
      


   FUNCTION get_somtEntryName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The name associated with this entry.  Eg, the name of
     -- the data item, the class, the method, the type, etc.

   PROCEDURE set_somtEntryName (
      Self : IN Ref;
      somtEntryName : IN Corba.String);
     
     -- The name associated with this entry.  Eg, the name of
     -- the data item, the class, the method, the type, etc.

   FUNCTION get_somtElementType (
      Self : IN Ref)
      RETURN SCTypes.SOMTTypes;
     
     -- Returns the type of this entry.
     -- This is not datatype, but entry type (method, class,
     -- passthru, etc.). The value is defined by SOMTTypes.

   PROCEDURE set_somtElementType (
      Self : IN Ref;
      somtElementType : IN SCTypes.SOMTTypes);
     
     -- Returns the type of this entry.
     -- This is not datatype, but entry type (method, class,
     -- passthru, etc.). The value is defined by SOMTTypes.

   FUNCTION get_somtElementTypeName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- String version of somtElementType.

   FUNCTION get_somtEntryComment (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the comment associated with this entry, or NULL is this
     -- entry has no associated comment.  Comments will have comment
     -- delimitors removed, but will retain newline characters as
     -- specified in the source file. (use smLookupComment)

   FUNCTION get_somtSourceLineNumber (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- Returns the line number in the source file where this entry's
     -- syntactic form ended.

   FUNCTION get_somtTypeCode (
      Self : IN Ref)
      RETURN Corba.TypeCode.Object;
     
     -- The typecode, if appropriate, or NULL.

   FUNCTION get_somtIsReference (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether the entry is just a reference to the real type (TRUE)
     -- rather than a declaration of it (FALSE).

   FUNCTION get_somtIDLScopedName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The IDL scoped name of the entry (using double colon as delimiter).

   FUNCTION get_somtCScopedName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The C scoped name of the entry (using underscore as delimiter).

   FUNCTION somtGetModifierValue (
      Self : IN Ref;
      modifierName : IN Corba.String)
      RETURN Corba.String;
     
     -- Returns the value of the named modifier if this entry has the
     -- named modifier and NULL otherwise. Note: if the modifier is
     -- present but does not have a value then a value of <'\1'> is
     -- returned.

   PROCEDURE somtGetFirstModifier (
      Self : IN Ref;
      modifierName : IN OUT Corba.String;
      modifierValue : IN OUT Corba.String;
      Result : OUT Corba.Boolean);
     
     -- Returns the first modifier associated with this entry.  1 (true)
     -- is returned if the entry has at least one modifier and 0 (false)
     -- otherwise.

   PROCEDURE somtGetNextModifier (
      Self : IN Ref;
      modifierName : IN OUT Corba.String;
      modifierValue : IN OUT Corba.String;
      Result : OUT Corba.Boolean);
     
     -- Returns the next modifier (with respect to the last call to
     -- <somtGetNextModifier> or <somtGetFirstModifier>)
     -- associated with this entry.  1 (true) is returned if the entry
     -- had another modifier and 0 (false) otherwise.

   FUNCTION somtFormatModifier (
      Self : IN Ref;
      buffer : IN Corba.String;
      name : IN Corba.String;
      value : IN Corba.String)
      RETURN Corba.Long;
     
     -- Formats the indicated name/value pair into buffer.  Buffer must
     -- be big enough to hold all the formatted pair, no checks are made.
     -- The number of characters added to buffer are returned (not
     -- including the trailing null character).
     -- Note: value may be null
     -- You will probably never call this method, it is provided so that
     -- you can override it to control the format returned in
     -- <somtGetModifierList>.

   FUNCTION somtGetModifierList (
      Self : IN Ref;
      buffer : IN Corba.String)
      RETURN Corba.Long;
     
     -- The modifiers for this entry are placed in <buffer> in template
     -- list form (newline separated).  Buffer must be big enough to
     -- hold all the modifiers, no checks are made. The number of
     -- modifiers is returned.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;
     
     -- Places a number of symbol/value pairs in <t>.  All the symbols
     -- will begin with <prefix>.

   PROCEDURE somtSetEntryStruct (
      Self : IN Ref;
      es : IN OUT SCTypes.IDL_Entry);
     
     -- Sets the entry struct data member.
     -- Note, when overridding this method, it is important to call the
     -- parent version of the method first and then do your processing.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION somPrintSelf (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   PROCEDURE somDumpSelf (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTEntryC IS

   
   -- A SOM class interface definition is compiled to produce a graph
   -- structure whose nodes are instances of <SOMTEntry> or its
   -- sub-classes.  Each entry is derived from some syntactic element of
   -- the definition source. The attributes defined in <SOMTEntryC>
   -- refer to this syntactic element in a fairly obvious way.
   --

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtEntryName : SOM.somMToken;
      set_somtEntryName : SOM.somMToken;
      get_somtElementType : SOM.somMToken;
      set_somtElementType : SOM.somMToken;
      get_somtEntryComment : SOM.somMToken;
      get_somtSourceLineNumber : SOM.somMToken;
      get_somtTypeCode : SOM.somMToken;
      get_somtIsReference : SOM.somMToken;
      somtGetModifierValue : SOM.somMToken;
      somtGetFirstModifier : SOM.somMToken;
      somtGetNextModifier : SOM.somMToken;
      somtFormatModifier : SOM.somMToken;
      somtGetModifierList : SOM.somMToken;
      somtSetSymbolsOnEntry : SOM.somMToken;
      somtSetEntryStruct : SOM.somMToken;
      get_somtEntryStruct : SOM.somMToken;
      somtShowAssocEntry : SOM.somMToken;
      get_somtCScopedName : SOM.somMToken;
      get_somtIDLScopedName : SOM.somMToken;
      get_somtElementTypeName : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTEntryCClassData : classData;
   FOR SOMTEntryCClassData USE AT standard.system.label("SOMTEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTEntryCCClassData : CClassData;
   FOR SOMTEntryCCClassData USE AT standard.system.label("SOMTEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTEntryCClassData.classObject) 
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
      FUNCTION SOMTEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTEntryCNewClass);
      PRAGMA interface_information (SOMTEntryCNewClass, ".SOMTEntryCNewClass");
   BEGIN
      RETURN SOMTEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtEntryName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The name associated with this entry.  Eg, the name of
     -- the data item, the class, the method, the type, etc.
      FUNCTION SOMTEntryC_U_get_somtEntryName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtEntryName);
      PRAGMA interface_information (SOMTEntryC_U_get_somtEntryName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtEntryName (
            Self.som_object,
            SOMTEntryCClassData.get_somtEntryName);
      RETURN Result;
   END get_somtEntryName; 

   PROCEDURE set_somtEntryName (
      Self : IN Ref; 
      somtEntryName : IN Corba.String)
   IS
     
     -- The name associated with this entry.  Eg, the name of
     -- the data item, the class, the method, the type, etc.
      PROCEDURE SOMTEntryC_U_set_somtEntryName(
         Self : IN SOM.SOMObjectPtr; 
         somtEntryName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEntryC_U_set_somtEntryName);
      PRAGMA interface_information (SOMTEntryC_U_set_somtEntryName, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEntryC_U_set_somtEntryName (
         Self.som_object,
         somtEntryName,
         SOMTEntryCClassData.set_somtEntryName);
   END set_somtEntryName;

   FUNCTION get_somtElementType (
      Self : IN Ref)
      RETURN SCTypes.SOMTTypes
   IS
     
     -- Returns the type of this entry.
     -- This is not datatype, but entry type (method, class,
     -- passthru, etc.). The value is defined by SOMTTypes.
      FUNCTION SOMTEntryC_U_get_somtElementType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.SOMTTypes; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtElementType);
      PRAGMA interface_information (SOMTEntryC_U_get_somtElementType, ".xsomcall1");
      Result : ALIASED SCTypes.SOMTTypes;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtElementType (
            Self.som_object,
            SOMTEntryCClassData.get_somtElementType);
      RETURN Result;
   END get_somtElementType; 

   PROCEDURE set_somtElementType (
      Self : IN Ref; 
      somtElementType : IN SCTypes.SOMTTypes)
   IS
     
     -- Returns the type of this entry.
     -- This is not datatype, but entry type (method, class,
     -- passthru, etc.). The value is defined by SOMTTypes.
      PROCEDURE SOMTEntryC_U_set_somtElementType(
         Self : IN SOM.SOMObjectPtr; 
         somtElementType : IN SCTypes.SOMTTypes;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEntryC_U_set_somtElementType);
      PRAGMA interface_information (SOMTEntryC_U_set_somtElementType, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEntryC_U_set_somtElementType (
         Self.som_object,
         somtElementType,
         SOMTEntryCClassData.set_somtElementType);
   END set_somtElementType;

   FUNCTION get_somtElementTypeName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- String version of somtElementType.
      FUNCTION SOMTEntryC_U_get_somtElementTypeName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtElementTypeName);
      PRAGMA interface_information (SOMTEntryC_U_get_somtElementTypeName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtElementTypeName (
            Self.som_object,
            SOMTEntryCClassData.get_somtElementTypeName);
      RETURN Result;
   END get_somtElementTypeName; 

   FUNCTION get_somtEntryComment (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the comment associated with this entry, or NULL is this
     -- entry has no associated comment.  Comments will have comment
     -- delimitors removed, but will retain newline characters as
     -- specified in the source file. (use smLookupComment)
      FUNCTION SOMTEntryC_U_get_somtEntryComment(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtEntryComment);
      PRAGMA interface_information (SOMTEntryC_U_get_somtEntryComment, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtEntryComment (
            Self.som_object,
            SOMTEntryCClassData.get_somtEntryComment);
      RETURN Result;
   END get_somtEntryComment; 

   FUNCTION get_somtSourceLineNumber (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Returns the line number in the source file where this entry's
     -- syntactic form ended.
      FUNCTION SOMTEntryC_U_get_somtSourceLineNumber(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtSourceLineNumber);
      PRAGMA interface_information (SOMTEntryC_U_get_somtSourceLineNumber, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtSourceLineNumber (
            Self.som_object,
            SOMTEntryCClassData.get_somtSourceLineNumber);
      RETURN Result;
   END get_somtSourceLineNumber; 

   FUNCTION get_somtTypeCode (
      Self : IN Ref)
      RETURN Corba.TypeCode.Object
   IS
     
     -- The typecode, if appropriate, or NULL.
      FUNCTION SOMTEntryC_U_get_somtTypeCode(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtTypeCode);
      PRAGMA interface_information (SOMTEntryC_U_get_somtTypeCode, ".xsomcall1");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtTypeCode (
            Self.som_object,
            SOMTEntryCClassData.get_somtTypeCode);
      RETURN Result;
   END get_somtTypeCode; 

   FUNCTION get_somtIsReference (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether the entry is just a reference to the real type (TRUE)
     -- rather than a declaration of it (FALSE).
      FUNCTION SOMTEntryC_U_get_somtIsReference(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtIsReference);
      PRAGMA interface_information (SOMTEntryC_U_get_somtIsReference, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtIsReference (
            Self.som_object,
            SOMTEntryCClassData.get_somtIsReference);
      RETURN Result;
   END get_somtIsReference; 

   FUNCTION get_somtIDLScopedName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The IDL scoped name of the entry (using double colon as delimiter).
      FUNCTION SOMTEntryC_U_get_somtIDLScopedName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtIDLScopedName);
      PRAGMA interface_information (SOMTEntryC_U_get_somtIDLScopedName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtIDLScopedName (
            Self.som_object,
            SOMTEntryCClassData.get_somtIDLScopedName);
      RETURN Result;
   END get_somtIDLScopedName; 

   FUNCTION get_somtCScopedName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The C scoped name of the entry (using underscore as delimiter).
      FUNCTION SOMTEntryC_U_get_somtCScopedName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEntryC_U_get_somtCScopedName);
      PRAGMA interface_information (SOMTEntryC_U_get_somtCScopedName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_U_get_somtCScopedName (
            Self.som_object,
            SOMTEntryCClassData.get_somtCScopedName);
      RETURN Result;
   END get_somtCScopedName; 

   FUNCTION somtGetModifierValue (
      Self : IN Ref; 
      modifierName : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Returns the value of the named modifier if this entry has the
     -- named modifier and NULL otherwise. Note: if the modifier is
     -- present but does not have a value then a value of <'\1'> is
     -- returned.
      FUNCTION SOMTEntryC_somtGetModifierValue(
         Self : IN SOM.SOMObjectPtr; 
         modifierName : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEntryC_somtGetModifierValue);
      PRAGMA interface_information (SOMTEntryC_somtGetModifierValue, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_somtGetModifierValue (
            Self.som_object,
            modifierName,
            SOMTEntryCClassData.somtGetModifierValue);
      RETURN Result;
   END somtGetModifierValue; 

   PROCEDURE somtGetFirstModifier (
      Self : IN Ref; 
      modifierName : IN OUT Corba.String; 
      modifierValue : IN OUT Corba.String; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Returns the first modifier associated with this entry.  1 (true)
     -- is returned if the entry has at least one modifier and 0 (false)
     -- otherwise.
      FUNCTION SOMTEntryC_somtGetFirstModifier(
         Self : IN SOM.SOMObjectPtr; 
         modifierName : IN SOM.address; 
         modifierValue : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEntryC_somtGetFirstModifier);
      PRAGMA interface_information (SOMTEntryC_somtGetFirstModifier, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_somtGetFirstModifier (
            Self.som_object,
            SOM.To_SOM_Address(modifierName'address),
            SOM.To_SOM_Address(modifierValue'address),
            SOMTEntryCClassData.somtGetFirstModifier);
   END somtGetFirstModifier;

   PROCEDURE somtGetNextModifier (
      Self : IN Ref; 
      modifierName : IN OUT Corba.String; 
      modifierValue : IN OUT Corba.String; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Returns the next modifier (with respect to the last call to
     -- <somtGetNextModifier> or <somtGetFirstModifier>)
     -- associated with this entry.  1 (true) is returned if the entry
     -- had another modifier and 0 (false) otherwise.
      FUNCTION SOMTEntryC_somtGetNextModifier(
         Self : IN SOM.SOMObjectPtr; 
         modifierName : IN SOM.address; 
         modifierValue : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEntryC_somtGetNextModifier);
      PRAGMA interface_information (SOMTEntryC_somtGetNextModifier, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_somtGetNextModifier (
            Self.som_object,
            SOM.To_SOM_Address(modifierName'address),
            SOM.To_SOM_Address(modifierValue'address),
            SOMTEntryCClassData.somtGetNextModifier);
   END somtGetNextModifier;

   FUNCTION somtFormatModifier (
      Self : IN Ref; 
      buffer : IN Corba.String; 
      name : IN Corba.String; 
      value : IN Corba.String)
      RETURN Corba.Long
   IS
     
     -- Formats the indicated name/value pair into buffer.  Buffer must
     -- be big enough to hold all the formatted pair, no checks are made.
     -- The number of characters added to buffer are returned (not
     -- including the trailing null character).
     -- Note: value may be null
     -- You will probably never call this method, it is provided so that
     -- you can override it to control the format returned in
     -- <somtGetModifierList>.
      FUNCTION SOMTEntryC_somtFormatModifier(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String; 
         name : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTEntryC_somtFormatModifier);
      PRAGMA interface_information (SOMTEntryC_somtFormatModifier, ".xsomcall4");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_somtFormatModifier (
            Self.som_object,
            buffer,
            name,
            value,
            SOMTEntryCClassData.somtFormatModifier);
      RETURN Result;
   END somtFormatModifier; 

   FUNCTION somtGetModifierList (
      Self : IN Ref; 
      buffer : IN Corba.String)
      RETURN Corba.Long
   IS
     
     -- The modifiers for this entry are placed in <buffer> in template
     -- list form (newline separated).  Buffer must be big enough to
     -- hold all the modifiers, no checks are made. The number of
     -- modifiers is returned.
      FUNCTION SOMTEntryC_somtGetModifierList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTEntryC_somtGetModifierList);
      PRAGMA interface_information (SOMTEntryC_somtGetModifierList, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_somtGetModifierList (
            Self.som_object,
            buffer,
            SOMTEntryCClassData.somtGetModifierList);
      RETURN Result;
   END somtGetModifierList; 

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref; 
      emitter : IN SOM.SOMObjectPtr; 
      prefix : IN Corba.String)
      RETURN Corba.Long
   IS
     
     -- Places a number of symbol/value pairs in <t>.  All the symbols
     -- will begin with <prefix>.
      FUNCTION SOMTEntryC_somtSetSymbolsOnEntry(
         Self : IN SOM.SOMObjectPtr; 
         emitter : IN SOM.SOMObjectPtr; 
         prefix : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTEntryC_somtSetSymbolsOnEntry);
      PRAGMA interface_information (SOMTEntryC_somtSetSymbolsOnEntry, ".xsomcall3");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEntryC_somtSetSymbolsOnEntry (
            Self.som_object,
            emitter,
            prefix,
            SOMTEntryCClassData.somtSetSymbolsOnEntry);
      RETURN Result;
   END somtSetSymbolsOnEntry; 

   PROCEDURE somtSetEntryStruct (
      Self : IN Ref; 
      es : IN OUT SCTypes.IDL_Entry)
   IS
     
     -- Sets the entry struct data member.
     -- Note, when overridding this method, it is important to call the
     -- parent version of the method first and then do your processing.
      PROCEDURE SOMTEntryC_somtSetEntryStruct(
         Self : IN SOM.SOMObjectPtr; 
         es : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEntryC_somtSetEntryStruct);
      PRAGMA interface_information (SOMTEntryC_somtSetEntryStruct, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEntryC_somtSetEntryStruct (
         Self.som_object,
         SOM.To_SOM_Address(es'address),
         SOMTEntryCClassData.somtSetEntryStruct);
   END somtSetEntryStruct;

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

   FUNCTION somPrintSelf (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somPrintSelf (
            SOMObject.Ref'(som_object=>Self.som_object));
   END somPrintSelf;

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

END SOMTEntryC; 







