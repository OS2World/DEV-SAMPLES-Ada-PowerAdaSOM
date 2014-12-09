
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:18 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTCommonEntryC;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTMethodEntryC IS


   TYPE Ref IS NEW SOMTCommonEntryC.Ref WITH NULL RECORD;

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
      


   FUNCTION get_somtIsVarargs (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if this method definition has a variable length
     -- parameter list.

   FUNCTION get_somtOriginalMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- If this is an override method definition (<SOMTOverrideMethodE>)
     -- then this is the method definition entry that orginially
     -- introduced the method.

   FUNCTION get_somtOriginalClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- If this is an override method definition (<SOMTOverrideMethodE>)
     -- then this is the class definition entry that orginially
     -- introduced the method.

   FUNCTION get_somtMethodGroup (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The group this method is defined in within a class definition.

   FUNCTION get_somtIsPrivateMethod (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether or not the method is private.

   FUNCTION get_somtIsOneway (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether or not the method is oneway.

   FUNCTION get_somtArgCount (
      Self : IN Ref)
      RETURN Corba.Short;
     
     -- The number of arguments for the method.

   FUNCTION somtGetFirstParameter (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first formal parameter entry for this method if it
     -- has one and NULL otherwise.  Note: the target object parameter is
     -- not included, therefore the first parameter is really the second
     -- parameter from a SOM runtime perspective.

   FUNCTION somtGetNextParameter (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next formal parameter entry for this method if it has
     -- one and NULL otherwise.

   FUNCTION somtGetIDLParamList (
      Self : IN Ref;
      buffer : IN Corba.String)
      RETURN Corba.String;
     
     -- Returns the formal parameter list (in IDL syntax) for this method.
     -- The parameter list is built in <buffer> and the address of <buffer>
     -- is returned.
     -- Parameters are delimited with newlines.
     -- The method receiver and any implicit method arguments are NOT included.

   FUNCTION somtGetShortCParamList (
      Self : IN Ref;
      buffer : IN Corba.String;
      selfParm : IN Corba.String;
      varargsParm : IN Corba.String)
      RETURN Corba.String;
     
     -- Returns the formal parameter list (in ANSI C function prototype
     -- form, with types) for this method. The parameter list is built in
     -- <buffer> and the address of <buffer> is returned.
     -- Parameters are delimited with newlines.
     -- If this method takes a variable number of arguments then the
     -- final parameter substring is replaced by <varargsParm>, unless
     -- <varargsParm> is NULL in which case the final parameter is
     -- removed.
     -- If <selfParm> is not null then it is added as an initial
     -- parameter. (The <selfParm> string may actually contain multiple
     -- parameters, delimited by newline characters.)
     -- The method receiver and any implicit method arguments are NOT
     -- included.
     -- The types of the method parameters are given in C form (with pointer
     -- stars, where needed) rather than in the IDL form.

   FUNCTION somtGetFullCParamList (
      Self : IN Ref;
      buffer : IN Corba.String;
      varargsParm : IN Corba.String)
      RETURN Corba.String;
     
     -- Same as somtGetShortCParamList except that the method receiver and
     -- any implicit method arguments (Environment and Context) are included.
     -- The types of the method parameters are given in C form (with pointer
     -- stars, where needed) rather than in the IDL form.

   FUNCTION somtGetShortParamNameList (
      Self : IN Ref;
      buffer : IN Corba.String;
      selfParm : IN Corba.String;
      varargsParm : IN Corba.String)
      RETURN Corba.String;
     
     -- Returns the parameter list for this method in call form (without
     -- types). The argument list is built in <buffer> and the address of
     -- <buffer> is returned. Parameters are delimited with newlines.
     -- If this method takes a variable number of arguments then the
     -- final parameter is replaced by <varargsParm>, unless
     -- <varargsParm> is NULL in which case the final parameter is removed.
     -- If <selfParm> is not null then it is added as an initial
     -- parameter. (The <selfParm> string may actually contain multiple
     -- parameters, delimited by newline characters.)
     -- The method receiver and any implicit method arguments are NOT
     -- included.

   FUNCTION somtGetFullParamNameList (
      Self : IN Ref;
      buffer : IN Corba.String;
      varargsParm : IN Corba.String)
      RETURN Corba.String;
     
     -- Same as somtGetParamNameList except that the method receiver and
     -- any implicit method arguments (Environment and Context) are included.

   FUNCTION somtGetNthParameter (
      Self : IN Ref;
      n : IN Corba.Short)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the object representing the nth explicit method parameter.

   FUNCTION somtGetFirstException (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The first exception this method raises.

   FUNCTION somtGetNextException (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The next exception this method raises,
     -- relative to the previous call to this method or to
     -- somtGetFirstException.

   FUNCTION get_somtContextArray (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- An array of the context string-literals for the method.

   FUNCTION get_somtCReturnType (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The C datatype the method returns. This may not correspond to the
     -- IDL data type (in particular, pointer stars may be added).

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTMethodEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTMethodEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtIsVarargs : SOM.somMToken;
      get_somtOriginalMethod : SOM.somMToken;
      get_somtOriginalClass : SOM.somMToken;
      get_somtMethodGroup : SOM.somMToken;
      somtGetFirstParameter : SOM.somMToken;
      somtGetNextParameter : SOM.somMToken;
      somtGetArgList : SOM.somMToken;
      somtGetParmList : SOM.somMToken;
      get_somtIsPrivateMethod : SOM.somMToken;
      get_somtIsOneway : SOM.somMToken;
      get_somtArgCount : SOM.somMToken;
      somtGetFirstException : SOM.somMToken;
      somtGetNextException : SOM.somMToken;
      get_somtContextArray : SOM.somMToken;
      somtGetShortCPrototype : SOM.somMToken;
      somtGetFullCPrototype : SOM.somMToken;
      somtGetShortParmList : SOM.somMToken;
      somtGetFullParmList : SOM.somMToken;
      somtGetNthParameter : SOM.somMToken;
      get_somtCReturnType : SOM.somMToken;
      somtGetIDLParamList : SOM.somMToken;
      somtGetShortCParamList : SOM.somMToken;
      somtGetFullCParamList : SOM.somMToken;
      somtGetShortParamNameList : SOM.somMToken;
      somtGetFullParamNameList : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTMethodEntryCClassData : classData;
   FOR SOMTMethodEntryCClassData USE AT standard.system.label("SOMTMethodEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTMethodEntryCCClassData : CClassData;
   FOR SOMTMethodEntryCCClassData USE AT standard.system.label("SOMTMethodEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTMethodEntryCClassData.classObject) 
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
      FUNCTION SOMTMethodEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTMethodEntryCNewClass);
      PRAGMA interface_information (SOMTMethodEntryCNewClass, ".SOMTMethodEntryCNewClass");
   BEGIN
      RETURN SOMTMethodEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTMethodEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTMethodEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtIsVarargs (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if this method definition has a variable length
     -- parameter list.
      FUNCTION SOMTMethodEntryC_U_get_somtIsVarargs(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtIsVarargs);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtIsVarargs, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtIsVarargs (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtIsVarargs);
      RETURN Result;
   END get_somtIsVarargs; 

   FUNCTION get_somtOriginalMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- If this is an override method definition (<SOMTOverrideMethodE>)
     -- then this is the method definition entry that orginially
     -- introduced the method.
      FUNCTION SOMTMethodEntryC_U_get_somtOriginalMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtOriginalMethod);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtOriginalMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtOriginalMethod (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtOriginalMethod);
      RETURN Result;
   END get_somtOriginalMethod; 

   FUNCTION get_somtOriginalClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- If this is an override method definition (<SOMTOverrideMethodE>)
     -- then this is the class definition entry that orginially
     -- introduced the method.
      FUNCTION SOMTMethodEntryC_U_get_somtOriginalClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtOriginalClass);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtOriginalClass, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtOriginalClass (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtOriginalClass);
      RETURN Result;
   END get_somtOriginalClass; 

   FUNCTION get_somtMethodGroup (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The group this method is defined in within a class definition.
      FUNCTION SOMTMethodEntryC_U_get_somtMethodGroup(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtMethodGroup);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtMethodGroup, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtMethodGroup (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtMethodGroup);
      RETURN Result;
   END get_somtMethodGroup; 

   FUNCTION get_somtIsPrivateMethod (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether or not the method is private.
      FUNCTION SOMTMethodEntryC_U_get_somtIsPrivateMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtIsPrivateMethod);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtIsPrivateMethod, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtIsPrivateMethod (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtIsPrivateMethod);
      RETURN Result;
   END get_somtIsPrivateMethod; 

   FUNCTION get_somtIsOneway (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether or not the method is oneway.
      FUNCTION SOMTMethodEntryC_U_get_somtIsOneway(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtIsOneway);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtIsOneway, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtIsOneway (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtIsOneway);
      RETURN Result;
   END get_somtIsOneway; 

   FUNCTION get_somtArgCount (
      Self : IN Ref)
      RETURN Corba.Short
   IS
     
     -- The number of arguments for the method.
      FUNCTION SOMTMethodEntryC_U_get_somtArgCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtArgCount);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtArgCount, ".xsomcall1");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtArgCount (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtArgCount);
      RETURN Result;
   END get_somtArgCount; 

   FUNCTION somtGetFirstParameter (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first formal parameter entry for this method if it
     -- has one and NULL otherwise.  Note: the target object parameter is
     -- not included, therefore the first parameter is really the second
     -- parameter from a SOM runtime perspective.
      FUNCTION SOMTMethodEntryC_somtGetFirstParameter(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetFirstParameter);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetFirstParameter, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetFirstParameter (
            Self.som_object,
            SOMTMethodEntryCClassData.somtGetFirstParameter);
      RETURN Result;
   END somtGetFirstParameter; 

   FUNCTION somtGetNextParameter (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next formal parameter entry for this method if it has
     -- one and NULL otherwise.
      FUNCTION SOMTMethodEntryC_somtGetNextParameter(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetNextParameter);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetNextParameter, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetNextParameter (
            Self.som_object,
            SOMTMethodEntryCClassData.somtGetNextParameter);
      RETURN Result;
   END somtGetNextParameter; 

   FUNCTION somtGetIDLParamList (
      Self : IN Ref; 
      buffer : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Returns the formal parameter list (in IDL syntax) for this method.
     -- The parameter list is built in <buffer> and the address of <buffer>
     -- is returned.
     -- Parameters are delimited with newlines.
     -- The method receiver and any implicit method arguments are NOT included.
      FUNCTION SOMTMethodEntryC_somtGetIDLParamList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetIDLParamList);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetIDLParamList, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetIDLParamList (
            Self.som_object,
            buffer,
            SOMTMethodEntryCClassData.somtGetIDLParamList);
      RETURN Result;
   END somtGetIDLParamList; 

   FUNCTION somtGetShortCParamList (
      Self : IN Ref; 
      buffer : IN Corba.String; 
      selfParm : IN Corba.String; 
      varargsParm : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Returns the formal parameter list (in ANSI C function prototype
     -- form, with types) for this method. The parameter list is built in
     -- <buffer> and the address of <buffer> is returned.
     -- Parameters are delimited with newlines.
     -- If this method takes a variable number of arguments then the
     -- final parameter substring is replaced by <varargsParm>, unless
     -- <varargsParm> is NULL in which case the final parameter is
     -- removed.
     -- If <selfParm> is not null then it is added as an initial
     -- parameter. (The <selfParm> string may actually contain multiple
     -- parameters, delimited by newline characters.)
     -- The method receiver and any implicit method arguments are NOT
     -- included.
     -- The types of the method parameters are given in C form (with pointer
     -- stars, where needed) rather than in the IDL form.
      FUNCTION SOMTMethodEntryC_somtGetShortCParamList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String; 
         selfParm : IN Corba.String; 
         varargsParm : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetShortCParamList);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetShortCParamList, ".xsomcall4");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetShortCParamList (
            Self.som_object,
            buffer,
            selfParm,
            varargsParm,
            SOMTMethodEntryCClassData.somtGetShortCParamList);
      RETURN Result;
   END somtGetShortCParamList; 

   FUNCTION somtGetFullCParamList (
      Self : IN Ref; 
      buffer : IN Corba.String; 
      varargsParm : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Same as somtGetShortCParamList except that the method receiver and
     -- any implicit method arguments (Environment and Context) are included.
     -- The types of the method parameters are given in C form (with pointer
     -- stars, where needed) rather than in the IDL form.
      FUNCTION SOMTMethodEntryC_somtGetFullCParamList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String; 
         varargsParm : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetFullCParamList);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetFullCParamList, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetFullCParamList (
            Self.som_object,
            buffer,
            varargsParm,
            SOMTMethodEntryCClassData.somtGetFullCParamList);
      RETURN Result;
   END somtGetFullCParamList; 

   FUNCTION somtGetShortParamNameList (
      Self : IN Ref; 
      buffer : IN Corba.String; 
      selfParm : IN Corba.String; 
      varargsParm : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Returns the parameter list for this method in call form (without
     -- types). The argument list is built in <buffer> and the address of
     -- <buffer> is returned. Parameters are delimited with newlines.
     -- If this method takes a variable number of arguments then the
     -- final parameter is replaced by <varargsParm>, unless
     -- <varargsParm> is NULL in which case the final parameter is removed.
     -- If <selfParm> is not null then it is added as an initial
     -- parameter. (The <selfParm> string may actually contain multiple
     -- parameters, delimited by newline characters.)
     -- The method receiver and any implicit method arguments are NOT
     -- included.
      FUNCTION SOMTMethodEntryC_somtGetShortParamNameList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String; 
         selfParm : IN Corba.String; 
         varargsParm : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetShortParamNameList);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetShortParamNameList, ".xsomcall4");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetShortParamNameList (
            Self.som_object,
            buffer,
            selfParm,
            varargsParm,
            SOMTMethodEntryCClassData.somtGetShortParamNameList);
      RETURN Result;
   END somtGetShortParamNameList; 

   FUNCTION somtGetFullParamNameList (
      Self : IN Ref; 
      buffer : IN Corba.String; 
      varargsParm : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Same as somtGetParamNameList except that the method receiver and
     -- any implicit method arguments (Environment and Context) are included.
      FUNCTION SOMTMethodEntryC_somtGetFullParamNameList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String; 
         varargsParm : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetFullParamNameList);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetFullParamNameList, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetFullParamNameList (
            Self.som_object,
            buffer,
            varargsParm,
            SOMTMethodEntryCClassData.somtGetFullParamNameList);
      RETURN Result;
   END somtGetFullParamNameList; 

   FUNCTION somtGetNthParameter (
      Self : IN Ref; 
      n : IN Corba.Short)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the object representing the nth explicit method parameter.
      FUNCTION SOMTMethodEntryC_somtGetNthParameter(
         Self : IN SOM.SOMObjectPtr; 
         n : IN Corba.Short;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetNthParameter);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetNthParameter, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetNthParameter (
            Self.som_object,
            n,
            SOMTMethodEntryCClassData.somtGetNthParameter);
      RETURN Result;
   END somtGetNthParameter; 

   FUNCTION somtGetFirstException (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The first exception this method raises.
      FUNCTION SOMTMethodEntryC_somtGetFirstException(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetFirstException);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetFirstException, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetFirstException (
            Self.som_object,
            SOMTMethodEntryCClassData.somtGetFirstException);
      RETURN Result;
   END somtGetFirstException; 

   FUNCTION somtGetNextException (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The next exception this method raises,
     -- relative to the previous call to this method or to
     -- somtGetFirstException.
      FUNCTION SOMTMethodEntryC_somtGetNextException(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTMethodEntryC_somtGetNextException);
      PRAGMA interface_information (SOMTMethodEntryC_somtGetNextException, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_somtGetNextException (
            Self.som_object,
            SOMTMethodEntryCClassData.somtGetNextException);
      RETURN Result;
   END somtGetNextException; 

   FUNCTION get_somtContextArray (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- An array of the context string-literals for the method.
      FUNCTION SOMTMethodEntryC_U_get_somtContextArray(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtContextArray);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtContextArray, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtContextArray (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtContextArray);
      RETURN Result;
   END get_somtContextArray; 

   FUNCTION get_somtCReturnType (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The C datatype the method returns. This may not correspond to the
     -- IDL data type (in particular, pointer stars may be added).
      FUNCTION SOMTMethodEntryC_U_get_somtCReturnType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTMethodEntryC_U_get_somtCReturnType);
      PRAGMA interface_information (SOMTMethodEntryC_U_get_somtCReturnType, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTMethodEntryC_U_get_somtCReturnType (
            Self.som_object,
            SOMTMethodEntryCClassData.get_somtCReturnType);
      RETURN Result;
   END get_somtCReturnType; 

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

END SOMTMethodEntryC; 







