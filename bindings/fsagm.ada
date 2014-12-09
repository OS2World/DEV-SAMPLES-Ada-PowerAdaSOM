
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:08 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPIOGroupMgrAbstract;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPAscii IS

   
   -- This is an IO Group Manager which stores groups of objects
   -- to the file system using the media interface SOMPAsciiMediaInterface.
   --
   -- This IO Group Manager stores non-object data (for example the number
   -- of objects in the group) in ASCII format.
   -- The file is readable but should not be editted.

   TYPE Ref IS NEW SOMPIOGroupMgrAbstract.Ref WITH NULL RECORD;

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
      

   TYPE stack_contents IS
   RECORD
      fileName : Corba.String;
      fileOffset : Corba.Long;
   END RECORD;
   PRAGMA Preserve_Layout( stack_contents );

   SUBTYPE SOMPTStackContents IS SOMPAscii.stack_contents;

   TYPE TOC_meta IS
   RECORD
      numObjects : Corba.Unsigned_Long;
      lastOffset : Corba.Long;
   END RECORD;
   PRAGMA Preserve_Layout( TOC_meta );

   SUBTYPE SOMPTTOCmeta IS SOMPAscii.TOC_meta;

   TYPE TOC_entry IS
   RECORD
      podOffset : Corba.Long;
      flags : Corba.Unsigned_Short;
      podPos : Corba.Long;
      podLen : Corba.Long;
   END RECORD;
   PRAGMA Preserve_Layout( TOC_entry );

   SUBTYPE SOMPTTOCentry IS SOMPAscii.TOC_entry;


   PROCEDURE sompNewMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IOInfo : IN Corba.String);

   FUNCTION sompGetMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE sompFreeMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   FUNCTION sompInstantiateMediaInterface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION sompWriteGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisPo : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

   FUNCTION sompReadGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE sompReadObjectData (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisPo : IN SOM.SOMObjectPtr);

   PROCEDURE sompDeleteObjectFromGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr);

   FUNCTION sompGroupExists (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IOInfo : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION sompObjectInGroup (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      objectID : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

   FUNCTION sompMediaFormatOk (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaFormatName : IN Corba.String)
      RETURN Corba.Boolean;

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END SOMPAscii; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPAscii IS

   
   -- This is an IO Group Manager which stores groups of objects
   -- to the file system using the media interface SOMPAsciiMediaInterface.
   --
   -- This IO Group Manager stores non-object data (for example the number
   -- of objects in the group) in ASCII format.
   -- The file is readable but should not be editted.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompWriteAnObject : SOM.somMToken;
      sompReadAnObject : SOM.somMToken;
      sompWriteTOC : SOM.somMToken;
      sompGroupIsDirty : SOM.somMToken;
      sompObjectIsDirty : SOM.somMToken;
      sompFindObjectInGroup : SOM.somMToken;
      sompSetHeaderLength : SOM.somMToken;
      sompGetHeaderLength : SOM.somMToken;
      sompReadTOCOffset : SOM.somMToken;
      sompWriteTOCOffset : SOM.somMToken;
      sompReadTOCMeta : SOM.somMToken;
      sompWriteTOCMeta : SOM.somMToken;
      sompReadTOCEntry : SOM.somMToken;
      sompWriteTOCEntry : SOM.somMToken;
      sompCalcTOCEntryPos : SOM.somMToken;
      sompCopyGroup : SOM.somMToken;
      sompCopyObjectData : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPAsciiClassData : classData;
   FOR SOMPAsciiClassData USE AT standard.system.label("SOMPAsciiClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPAsciiCClassData : CClassData;
   FOR SOMPAsciiCClassData USE AT standard.system.label("SOMPAsciiCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPAsciiClassData.classObject) 
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
      FUNCTION SOMPAsciiNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPAsciiNewClass);
      PRAGMA interface_information (SOMPAsciiNewClass, ".SOMPAsciiNewClass");
   BEGIN
      RETURN SOMPAsciiNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPAsciiClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPAsciiClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompNewMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IOInfo : IN Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract.sompNewMediaInterface (
         SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         IOInfo);
   END sompNewMediaInterface;

   FUNCTION sompGetMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompGetMediaInterface (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev);
   END sompGetMediaInterface;

   PROCEDURE sompFreeMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract.sompFreeMediaInterface (
         SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
         Ev);
   END sompFreeMediaInterface;

   FUNCTION sompInstantiateMediaInterface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompInstantiateMediaInterface (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev);
   END sompInstantiateMediaInterface;

   FUNCTION sompWriteGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisPo : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompWriteGroup (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev,
            thisPo);
   END sompWriteGroup;

   FUNCTION sompReadGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompReadGroup (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev,
            objectID);
   END sompReadGroup;

   PROCEDURE sompReadObjectData (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisPo : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract.sompReadObjectData (
         SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         thisPo);
   END sompReadObjectData;

   PROCEDURE sompDeleteObjectFromGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPIOGroupMgrAbstract.sompDeleteObjectFromGroup (
         SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         objectID);
   END sompDeleteObjectFromGroup;

   FUNCTION sompGroupExists (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IOInfo : IN Corba.String)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompGroupExists (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev,
            IOInfo);
   END sompGroupExists;

   FUNCTION sompObjectInGroup (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      objectID : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompObjectInGroup (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev,
            objectID);
   END sompObjectInGroup;

   FUNCTION sompMediaFormatOk (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaFormatName : IN Corba.String)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPIOGroupMgrAbstract.sompMediaFormatOk (
            SOMPIOGroupMgrAbstract.Ref'(som_object=>Self.som_object),
            Ev,
            mediaFormatName);
   END sompMediaFormatOk;

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

END SOMPAscii; 







