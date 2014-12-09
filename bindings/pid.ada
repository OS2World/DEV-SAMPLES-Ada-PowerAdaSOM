
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:22 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMUTStringId;
WITH SOMObject;
WITH SOMUTId;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPPersistentId IS

   
   -- This is the class for a persistent ID.
   --
   -- A persistent ID is a string of the form:
   --
   --   IOGroupMgrClassname ':' RepositoryName ':' RepositoryOffset
   --
   -- For the file system, an example of a persistent ID would be:
   --
   --   "SOMPFSAIOGroupMgr:/u/otp/stuff/animals:0"
   --
   -- where:
   --
   --   SOMPFSAIOGroupMgr is the IO Group Mgr Class name
   --
   --   /u/otp/stuff/animals is the Repository name (i.e. the file name)
   --
   --   0 is the Repository offset (roughly, record number)

   TYPE Ref IS NEW SOMUTStringId.Ref WITH NULL RECORD;

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
      


   PROCEDURE sompSetIOGroupMgrClassName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      newName : IN Corba.String);
     
     -- Sets the IO Group Manager Class portion of the ID.

   FUNCTION sompGetIOGroupMgrClassName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      toBuffer : IN Corba.String)
      RETURN Corba.String;
     
     -- Gets the IO Group Manager Class portion of the ID.

   FUNCTION sompGetIOGroupMgrClassNameLen (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Short;
     
     -- Gets the length of the IO Group Manager Class portion of the ID.

   PROCEDURE sompSetIOGroupName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      newName : IN Corba.String);
     
     -- Sets the path & file portion of the ID.

   FUNCTION sompGetIOGroupName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      toBuffer : IN Corba.String)
      RETURN Corba.String;
     
     -- Gets the path & file portion of the ID.

   FUNCTION sompGetIOGroupNameLen (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Short;
     
     -- Gets the length of the path & file portion of the ID.

   PROCEDURE sompSetGroupOffset (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      offset : IN Corba.Long);
     
     -- Sets the offset portion of the ID.

   FUNCTION sompGetGroupOffset (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Gets the offset portion of the ID.

   FUNCTION sompEqualsIOGroupName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      id : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Compare this object's file & path name the file & path name
     -- part of the given ID. Return TRUE if they are equivalent.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somutSetIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IdString : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somutSetIdId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr);

   FUNCTION somutGetIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      toBuffer : IN Corba.String)
      RETURN Corba.String;

   FUNCTION somutGetIdStringLen (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;

   FUNCTION somutEqualsId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

   FUNCTION somutEqualsString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IdString : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somutCompareId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Short;

   FUNCTION somutCompareString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IdString : IN Corba.String)
      RETURN Corba.Short;

   FUNCTION somutHashId (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;

END SOMPPersistentId; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPPersistentId IS

   
   -- This is the class for a persistent ID.
   --
   -- A persistent ID is a string of the form:
   --
   --   IOGroupMgrClassname ':' RepositoryName ':' RepositoryOffset
   --
   -- For the file system, an example of a persistent ID would be:
   --
   --   "SOMPFSAIOGroupMgr:/u/otp/stuff/animals:0"
   --
   -- where:
   --
   --   SOMPFSAIOGroupMgr is the IO Group Mgr Class name
   --
   --   /u/otp/stuff/animals is the Repository name (i.e. the file name)
   --
   --   0 is the Repository offset (roughly, record number)

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompSetIOGroupMgrClassName : SOM.somMToken;
      sompGetIOGroupMgrClassName : SOM.somMToken;
      sompGetIOGroupMgrClassNameLen : SOM.somMToken;
      sompSetIOGroupName : SOM.somMToken;
      sompGetIOGroupName : SOM.somMToken;
      sompGetIOGroupNameLen : SOM.somMToken;
      sompSetGroupOffset : SOM.somMToken;
      sompGetGroupOffset : SOM.somMToken;
      sompEqualsIOGroupName : SOM.somMToken;
      sompBuildIdString : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPPersistentIdClassData : classData;
   FOR SOMPPersistentIdClassData USE AT standard.system.label("SOMPPersistentIdClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPPersistentIdCClassData : CClassData;
   FOR SOMPPersistentIdCClassData USE AT standard.system.label("SOMPPersistentIdCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPPersistentIdClassData.classObject) 
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
      FUNCTION SOMPPersistentIdNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPPersistentIdNewClass);
      PRAGMA interface_information (SOMPPersistentIdNewClass, ".SOMPPersistentIdNewClass");
   BEGIN
      RETURN SOMPPersistentIdNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPPersistentIdClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPPersistentIdClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompSetIOGroupMgrClassName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      newName : IN Corba.String)
   IS
     
     -- Sets the IO Group Manager Class portion of the ID.
      PROCEDURE SOMPPersistentId_sompSetIOGroupMgrClassName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         newName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentId_sompSetIOGroupMgrClassName);
      PRAGMA interface_information (SOMPPersistentId_sompSetIOGroupMgrClassName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentId_sompSetIOGroupMgrClassName (
         Self.som_object,
         Ev,
         newName,
         SOMPPersistentIdClassData.sompSetIOGroupMgrClassName);
   END sompSetIOGroupMgrClassName;

   FUNCTION sompGetIOGroupMgrClassName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      toBuffer : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Gets the IO Group Manager Class portion of the ID.
      FUNCTION SOMPPersistentId_sompGetIOGroupMgrClassName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         toBuffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMPPersistentId_sompGetIOGroupMgrClassName);
      PRAGMA interface_information (SOMPPersistentId_sompGetIOGroupMgrClassName, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentId_sompGetIOGroupMgrClassName (
            Self.som_object,
            Ev,
            toBuffer,
            SOMPPersistentIdClassData.sompGetIOGroupMgrClassName);
      RETURN Result;
   END sompGetIOGroupMgrClassName; 

   FUNCTION sompGetIOGroupMgrClassNameLen (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Short
   IS
     
     -- Gets the length of the IO Group Manager Class portion of the ID.
      FUNCTION SOMPPersistentId_sompGetIOGroupMgrClassNameLen(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMPPersistentId_sompGetIOGroupMgrClassNameLen);
      PRAGMA interface_information (SOMPPersistentId_sompGetIOGroupMgrClassNameLen, ".xsomcall2");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentId_sompGetIOGroupMgrClassNameLen (
            Self.som_object,
            Ev,
            SOMPPersistentIdClassData.sompGetIOGroupMgrClassNameLen);
      RETURN Result;
   END sompGetIOGroupMgrClassNameLen; 

   PROCEDURE sompSetIOGroupName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      newName : IN Corba.String)
   IS
     
     -- Sets the path & file portion of the ID.
      PROCEDURE SOMPPersistentId_sompSetIOGroupName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         newName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentId_sompSetIOGroupName);
      PRAGMA interface_information (SOMPPersistentId_sompSetIOGroupName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentId_sompSetIOGroupName (
         Self.som_object,
         Ev,
         newName,
         SOMPPersistentIdClassData.sompSetIOGroupName);
   END sompSetIOGroupName;

   FUNCTION sompGetIOGroupName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      toBuffer : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Gets the path & file portion of the ID.
      FUNCTION SOMPPersistentId_sompGetIOGroupName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         toBuffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMPPersistentId_sompGetIOGroupName);
      PRAGMA interface_information (SOMPPersistentId_sompGetIOGroupName, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentId_sompGetIOGroupName (
            Self.som_object,
            Ev,
            toBuffer,
            SOMPPersistentIdClassData.sompGetIOGroupName);
      RETURN Result;
   END sompGetIOGroupName; 

   FUNCTION sompGetIOGroupNameLen (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Short
   IS
     
     -- Gets the length of the path & file portion of the ID.
      FUNCTION SOMPPersistentId_sompGetIOGroupNameLen(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMPPersistentId_sompGetIOGroupNameLen);
      PRAGMA interface_information (SOMPPersistentId_sompGetIOGroupNameLen, ".xsomcall2");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentId_sompGetIOGroupNameLen (
            Self.som_object,
            Ev,
            SOMPPersistentIdClassData.sompGetIOGroupNameLen);
      RETURN Result;
   END sompGetIOGroupNameLen; 

   PROCEDURE sompSetGroupOffset (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      offset : IN Corba.Long)
   IS
     
     -- Sets the offset portion of the ID.
      PROCEDURE SOMPPersistentId_sompSetGroupOffset(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         offset : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPPersistentId_sompSetGroupOffset);
      PRAGMA interface_information (SOMPPersistentId_sompSetGroupOffset, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPPersistentId_sompSetGroupOffset (
         Self.som_object,
         Ev,
         offset,
         SOMPPersistentIdClassData.sompSetGroupOffset);
   END sompSetGroupOffset;

   FUNCTION sompGetGroupOffset (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Gets the offset portion of the ID.
      FUNCTION SOMPPersistentId_sompGetGroupOffset(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMPPersistentId_sompGetGroupOffset);
      PRAGMA interface_information (SOMPPersistentId_sompGetGroupOffset, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentId_sompGetGroupOffset (
            Self.som_object,
            Ev,
            SOMPPersistentIdClassData.sompGetGroupOffset);
      RETURN Result;
   END sompGetGroupOffset; 

   FUNCTION sompEqualsIOGroupName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      id : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Compare this object's file & path name the file & path name
     -- part of the given ID. Return TRUE if they are equivalent.
      FUNCTION SOMPPersistentId_sompEqualsIOGroupName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         id : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPPersistentId_sompEqualsIOGroupName);
      PRAGMA interface_information (SOMPPersistentId_sompEqualsIOGroupName, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPPersistentId_sompEqualsIOGroupName (
            Self.som_object,
            Ev,
            id,
            SOMPPersistentIdClassData.sompEqualsIOGroupName);
      RETURN Result;
   END sompEqualsIOGroupName; 

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

   FUNCTION somutSetIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IdString : IN Corba.String)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTStringId.somutSetIdString (
            SOMUTStringId.Ref'(som_object=>Self.som_object),
            Ev,
            IdString);
   END somutSetIdString;

   PROCEDURE somutSetIdId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMUTId.somutSetIdId (
         SOMUTId.Ref'(som_object=>Self.som_object),
         Ev,
         otherId);
   END somutSetIdId;

   FUNCTION somutGetIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      toBuffer : IN Corba.String)
      RETURN Corba.String
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTStringId.somutGetIdString (
            SOMUTStringId.Ref'(som_object=>Self.som_object),
            Ev,
            toBuffer);
   END somutGetIdString;

   FUNCTION somutGetIdStringLen (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTStringId.somutGetIdStringLen (
            SOMUTStringId.Ref'(som_object=>Self.som_object),
            Ev);
   END somutGetIdStringLen;

   FUNCTION somutEqualsId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTId.somutEqualsId (
            SOMUTId.Ref'(som_object=>Self.som_object),
            Ev,
            otherId);
   END somutEqualsId;

   FUNCTION somutEqualsString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IdString : IN Corba.String)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTStringId.somutEqualsString (
            SOMUTStringId.Ref'(som_object=>Self.som_object),
            Ev,
            IdString);
   END somutEqualsString;

   FUNCTION somutCompareId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Short
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTId.somutCompareId (
            SOMUTId.Ref'(som_object=>Self.som_object),
            Ev,
            otherId);
   END somutCompareId;

   FUNCTION somutCompareString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IdString : IN Corba.String)
      RETURN Corba.Short
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTStringId.somutCompareString (
            SOMUTStringId.Ref'(som_object=>Self.som_object),
            Ev,
            IdString);
   END somutCompareString;

   FUNCTION somutHashId (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTId.somutHashId (
            SOMUTId.Ref'(som_object=>Self.som_object),
            Ev);
   END somutHashId;

END SOMPPersistentId; 







