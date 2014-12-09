
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:19 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPObjectSet IS

   
   -- This class is an abstact definition for a set of objects
   -- and the operations which can be performed on the set.

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
      


   FUNCTION sompSetGetNth (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n : IN Corba.Unsigned_Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the nth object from the set.

   FUNCTION sompFindByID (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      lookfor : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the object with the ID given by <lookfor>. The true type of the
     -- ID passed depends on the objects in the set. (All the objects in the
     -- set are expected to be of the same type.)

   FUNCTION sompFindByAddress (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      lookfor : IN SOM.SOMObjectPtr)
      RETURN Corba.Long;
     
     -- Returns the position in the set of the "lookfor" object or
     -- -1 if the object was not found.

   PROCEDURE sompAddToSet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisObject : IN SOM.SOMObjectPtr);
     
     -- Add an object to the set.

   PROCEDURE sompSetDeleteNth (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n : IN Corba.Unsigned_Long);
     
     -- Delete the nth object from the set.

   FUNCTION sompGetSetSize (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Returns the set size.

   FUNCTION sompObjEqualsID (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      cmpObj : IN SOM.SOMObjectPtr;
      lookfor : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if the given object <cmpObj> has the given
     -- ID <lookfor>. Override this to make the appropriate
     -- comparison for the objects in the set.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMPObjectSet; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPObjectSet IS

   
   -- This class is an abstact definition for a set of objects
   -- and the operations which can be performed on the set.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompSetGetNth : SOM.somMToken;
      sompFindByID : SOM.somMToken;
      sompFindByAddress : SOM.somMToken;
      sompAddToSet : SOM.somMToken;
      sompSetDeleteNth : SOM.somMToken;
      sompGetSetSize : SOM.somMToken;
      sompObjEqualsID : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPObjectSetClassData : classData;
   FOR SOMPObjectSetClassData USE AT standard.system.label("SOMPObjectSetClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPObjectSetCClassData : CClassData;
   FOR SOMPObjectSetCClassData USE AT standard.system.label("SOMPObjectSetCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPObjectSetClassData.classObject) 
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
      FUNCTION SOMPObjectSetNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPObjectSetNewClass);
      PRAGMA interface_information (SOMPObjectSetNewClass, ".SOMPObjectSetNewClass");
   BEGIN
      RETURN SOMPObjectSetNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPObjectSetClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPObjectSetClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sompSetGetNth (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n : IN Corba.Unsigned_Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the nth object from the set.
      FUNCTION SOMPObjectSet_sompSetGetNth(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPObjectSet_sompSetGetNth);
      PRAGMA interface_information (SOMPObjectSet_sompSetGetNth, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPObjectSet_sompSetGetNth (
            Self.som_object,
            Ev,
            n,
            SOMPObjectSetClassData.sompSetGetNth);
      RETURN Result;
   END sompSetGetNth; 

   FUNCTION sompFindByID (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      lookfor : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the object with the ID given by <lookfor>. The true type of the
     -- ID passed depends on the objects in the set. (All the objects in the
     -- set are expected to be of the same type.)
      FUNCTION SOMPObjectSet_sompFindByID(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         lookfor : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMPObjectSet_sompFindByID);
      PRAGMA interface_information (SOMPObjectSet_sompFindByID, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPObjectSet_sompFindByID (
            Self.som_object,
            Ev,
            lookfor,
            SOMPObjectSetClassData.sompFindByID);
      RETURN Result;
   END sompFindByID; 

   FUNCTION sompFindByAddress (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      lookfor : IN SOM.SOMObjectPtr)
      RETURN Corba.Long
   IS
     
     -- Returns the position in the set of the "lookfor" object or
     -- -1 if the object was not found.
      FUNCTION SOMPObjectSet_sompFindByAddress(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         lookfor : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMPObjectSet_sompFindByAddress);
      PRAGMA interface_information (SOMPObjectSet_sompFindByAddress, ".xsomcall3");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPObjectSet_sompFindByAddress (
            Self.som_object,
            Ev,
            lookfor,
            SOMPObjectSetClassData.sompFindByAddress);
      RETURN Result;
   END sompFindByAddress; 

   PROCEDURE sompAddToSet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
     
     -- Add an object to the set.
      PROCEDURE SOMPObjectSet_sompAddToSet(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPObjectSet_sompAddToSet);
      PRAGMA interface_information (SOMPObjectSet_sompAddToSet, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPObjectSet_sompAddToSet (
         Self.som_object,
         Ev,
         thisObject,
         SOMPObjectSetClassData.sompAddToSet);
   END sompAddToSet;

   PROCEDURE sompSetDeleteNth (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n : IN Corba.Unsigned_Long)
   IS
     
     -- Delete the nth object from the set.
      PROCEDURE SOMPObjectSet_sompSetDeleteNth(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPObjectSet_sompSetDeleteNth);
      PRAGMA interface_information (SOMPObjectSet_sompSetDeleteNth, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPObjectSet_sompSetDeleteNth (
         Self.som_object,
         Ev,
         n,
         SOMPObjectSetClassData.sompSetDeleteNth);
   END sompSetDeleteNth;

   FUNCTION sompGetSetSize (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Returns the set size.
      FUNCTION SOMPObjectSet_sompGetSetSize(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMPObjectSet_sompGetSetSize);
      PRAGMA interface_information (SOMPObjectSet_sompGetSetSize, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPObjectSet_sompGetSetSize (
            Self.som_object,
            Ev,
            SOMPObjectSetClassData.sompGetSetSize);
      RETURN Result;
   END sompGetSetSize; 

   FUNCTION sompObjEqualsID (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      cmpObj : IN SOM.SOMObjectPtr; 
      lookfor : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if the given object <cmpObj> has the given
     -- ID <lookfor>. Override this to make the appropriate
     -- comparison for the objects in the set.
      FUNCTION SOMPObjectSet_sompObjEqualsID(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         cmpObj : IN SOM.SOMObjectPtr; 
         lookfor : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMPObjectSet_sompObjEqualsID);
      PRAGMA interface_information (SOMPObjectSet_sompObjEqualsID, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPObjectSet_sompObjEqualsID (
            Self.som_object,
            Ev,
            cmpObj,
            lookfor,
            SOMPObjectSetClassData.sompObjEqualsID);
      RETURN Result;
   END sompObjEqualsID; 

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

END SOMPObjectSet; 







