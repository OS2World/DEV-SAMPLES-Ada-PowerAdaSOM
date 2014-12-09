
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:21 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Contained;
WITH Container;
WITH Corba.Sequences;
WITH ParameterDef;
WITH ExceptionDef;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE OperationDef IS


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
      

   TYPE OperationMode IS (NORMAL, ONEWAY);
   FOR OperationMode USE (
      NORMAL => 1,
      ONEWAY => 2 );

   PACKAGE ContextIdentifier_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.ContextIdentifier);


   PACKAGE ParameterDescription_Unbounded IS 
      NEW Corba.Sequences.Unbounded(ParameterDef.ParameterDescription);


   PACKAGE ExceptionDescription_Unbounded IS 
      NEW Corba.Sequences.Unbounded(ExceptionDef.ExceptionDescription);


   TYPE OperationDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
      result : Corba.TypeCode.Object;
      mode : OperationDef.OperationMode;
      contexts : ContextIdentifier_Unbounded.Sequence;
      parameter : ParameterDescription_Unbounded.Sequence;
      exceptions : ExceptionDescription_Unbounded.Sequence;
   END RECORD;
   PRAGMA Preserve_Layout( OperationDescription );
     
     -- The inherited describe method returns an instance of this
     -- (OperationDescription) structure in the "value" member of the
     -- Description structure defined in the Contained interface.
     -- The inherited describe_contents method in the Container
     -- interface returns a sequence of these Description structures
     -- each carrying a reference to an OperationDescription structure
     -- in its "value" member.


   FUNCTION get_result (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.TypeCode.Object;
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.

   PROCEDURE set_result (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      result : IN Corba.TypeCode.Object);
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.

   FUNCTION get_mode (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN OperationDef.OperationMode;
     
     -- The OperationMode of the receiving object;

   PROCEDURE set_mode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mode : IN OperationDef.OperationMode);
     
     -- The OperationMode of the receiving object;

   FUNCTION get_contexts (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN ContextIdentifier_Unbounded.Sequence;
     
     -- The list of ContextIdentifiers associated with the
     -- receiving object.

   PROCEDURE set_contexts (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      contexts : IN ContextIdentifier_Unbounded.Sequence);
     
     -- The list of ContextIdentifiers associated with the
     -- receiving object.

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

END OperationDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY OperationDef IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_result : SOM.somMToken;
      set_result : SOM.somMToken;
      get_mode : SOM.somMToken;
      set_mode : SOM.somMToken;
      get_contexts : SOM.somMToken;
      set_contexts : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   OperationDefClassData : classData;
   FOR OperationDefClassData USE AT standard.system.label("OperationDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   OperationDefCClassData : CClassData;
   FOR OperationDefCClassData USE AT standard.system.label("OperationDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            OperationDefClassData.classObject) 
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
      FUNCTION OperationDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, OperationDefNewClass);
      PRAGMA interface_information (OperationDefNewClass, ".OperationDefNewClass");
   BEGIN
      RETURN OperationDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF OperationDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(OperationDefClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_result (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.TypeCode.Object
   IS
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.
      FUNCTION OperationDef_U_get_result(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, OperationDef_U_get_result);
      PRAGMA interface_information (OperationDef_U_get_result, ".xsomcall2");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         OperationDef_U_get_result (
            Self.som_object,
            Ev,
            OperationDefClassData.get_result);
      RETURN Result;
   END get_result; 

   PROCEDURE set_result (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      result : IN Corba.TypeCode.Object)
   IS
     
     -- The TypeCode of the receiving object.  The memory used to hold
     -- the TypeCode is contained in the receiving object, which retains
     -- ownership.  Hence, do not free the returned TypeCode.  If you want
     -- to obtain a separate copy, use the TypeCode_copy operation.
      PROCEDURE OperationDef_U_set_result(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         result : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, OperationDef_U_set_result);
      PRAGMA interface_information (OperationDef_U_set_result, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      OperationDef_U_set_result (
         Self.som_object,
         Ev,
         result,
         OperationDefClassData.set_result);
   END set_result;

   FUNCTION get_mode (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN OperationDef.OperationMode
   IS
     
     -- The OperationMode of the receiving object;
      FUNCTION OperationDef_U_get_mode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN OperationDef.OperationMode; 
      PRAGMA interface (assembly, OperationDef_U_get_mode);
      PRAGMA interface_information (OperationDef_U_get_mode, ".xsomcall2");
      Result : ALIASED OperationDef.OperationMode;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         OperationDef_U_get_mode (
            Self.som_object,
            Ev,
            OperationDefClassData.get_mode);
      RETURN Result;
   END get_mode; 

   PROCEDURE set_mode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mode : IN OperationDef.OperationMode)
   IS
     
     -- The OperationMode of the receiving object;
      PROCEDURE OperationDef_U_set_mode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mode : IN OperationDef.OperationMode;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, OperationDef_U_set_mode);
      PRAGMA interface_information (OperationDef_U_set_mode, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      OperationDef_U_set_mode (
         Self.som_object,
         Ev,
         mode,
         OperationDefClassData.set_mode);
   END set_mode;

   FUNCTION get_contexts (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN ContextIdentifier_Unbounded.Sequence
   IS
     
     -- The list of ContextIdentifiers associated with the
     -- receiving object.
      PROCEDURE OperationDef_U_get_contexts(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, OperationDef_U_get_contexts);
      PRAGMA interface_information (OperationDef_U_get_contexts, ".xsomcall3");
      Result : ALIASED ContextIdentifier_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      OperationDef_U_get_contexts (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         OperationDefClassData.get_contexts);
      RETURN Result;
   END get_contexts; 

   PROCEDURE set_contexts (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      contexts : IN ContextIdentifier_Unbounded.Sequence)
   IS
     
     -- The list of ContextIdentifiers associated with the
     -- receiving object.
      PROCEDURE OperationDef_U_set_contexts(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         contexts : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, OperationDef_U_set_contexts);
      PRAGMA interface_information (OperationDef_U_set_contexts, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      OperationDef_U_set_contexts (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(contexts'address),
         OperationDefClassData.set_contexts);
   END set_contexts;

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

END OperationDef; 







