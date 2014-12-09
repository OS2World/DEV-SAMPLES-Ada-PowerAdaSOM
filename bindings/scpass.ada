
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:20 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTPassthruEntryC IS


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
      


   FUNCTION get_somtPassthruBody (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The source content text of this passthru entry without
     -- any modification. Newlines that were present in the source will
     -- still be present.

   FUNCTION get_somtPassthruLanguage (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the name of the language for which this passthru entry
     -- is intended. Language names are always all upper case.

   FUNCTION get_somtPassthruTarget (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the target for this passthru entry.

   FUNCTION somtIsBeforePassthru (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if this passthru entry is to be put at the
     -- beginning of the file or 0 (false) if this passthru entry is to
     -- go later in the file.

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTPassthruEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTPassthruEntryC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtPassthruBody : SOM.somMToken;
      get_somtPassthruTarget : SOM.somMToken;
      get_somtPassthruLanguage : SOM.somMToken;
      somtIsBeforePassthru : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTPassthruEntryCClassData : classData;
   FOR SOMTPassthruEntryCClassData USE AT standard.system.label("SOMTPassthruEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTPassthruEntryCCClassData : CClassData;
   FOR SOMTPassthruEntryCCClassData USE AT standard.system.label("SOMTPassthruEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTPassthruEntryCClassData.classObject) 
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
      FUNCTION SOMTPassthruEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTPassthruEntryCNewClass);
      PRAGMA interface_information (SOMTPassthruEntryCNewClass, ".SOMTPassthruEntryCNewClass");
   BEGIN
      RETURN SOMTPassthruEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTPassthruEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTPassthruEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtPassthruBody (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The source content text of this passthru entry without
     -- any modification. Newlines that were present in the source will
     -- still be present.
      FUNCTION SOMTPassthruEntryC_U_get_somtPassthruBody(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTPassthruEntryC_U_get_somtPassthruBody);
      PRAGMA interface_information (SOMTPassthruEntryC_U_get_somtPassthruBody, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTPassthruEntryC_U_get_somtPassthruBody (
            Self.som_object,
            SOMTPassthruEntryCClassData.get_somtPassthruBody);
      RETURN Result;
   END get_somtPassthruBody; 

   FUNCTION get_somtPassthruLanguage (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the name of the language for which this passthru entry
     -- is intended. Language names are always all upper case.
      FUNCTION SOMTPassthruEntryC_U_get_somtPassthruLanguage(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTPassthruEntryC_U_get_somtPassthruLanguage);
      PRAGMA interface_information (SOMTPassthruEntryC_U_get_somtPassthruLanguage, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTPassthruEntryC_U_get_somtPassthruLanguage (
            Self.som_object,
            SOMTPassthruEntryCClassData.get_somtPassthruLanguage);
      RETURN Result;
   END get_somtPassthruLanguage; 

   FUNCTION get_somtPassthruTarget (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the target for this passthru entry.
      FUNCTION SOMTPassthruEntryC_U_get_somtPassthruTarget(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTPassthruEntryC_U_get_somtPassthruTarget);
      PRAGMA interface_information (SOMTPassthruEntryC_U_get_somtPassthruTarget, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTPassthruEntryC_U_get_somtPassthruTarget (
            Self.som_object,
            SOMTPassthruEntryCClassData.get_somtPassthruTarget);
      RETURN Result;
   END get_somtPassthruTarget; 

   FUNCTION somtIsBeforePassthru (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if this passthru entry is to be put at the
     -- beginning of the file or 0 (false) if this passthru entry is to
     -- go later in the file.
      FUNCTION SOMTPassthruEntryC_somtIsBeforePassthru(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTPassthruEntryC_somtIsBeforePassthru);
      PRAGMA interface_information (SOMTPassthruEntryC_somtIsBeforePassthru, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTPassthruEntryC_somtIsBeforePassthru (
            Self.som_object,
            SOMTPassthruEntryCClassData.somtIsBeforePassthru);
      RETURN Result;
   END somtIsBeforePassthru; 

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

END SOMTPassthruEntryC; 







