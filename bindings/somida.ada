
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:47 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMUTId IS

   
   -- This is the abstract base class for an ID. Only the interface is
   -- defined. Refer to derived classes for details.
   --
   -- Instances of classes derived from this one should represent a
   -- value which can be used to identify something... such as an object,
   -- a file, a network node, etc, etc...
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
      


   PROCEDURE somutSetIdId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr);
     
     -- Sets the ID equal to ID of the given ID.

   FUNCTION somutEqualsId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Checks to see if this object's ID is equivalent to the given ID.
     -- Returns TRUE if the ID's are equivalent, FALSE otherwise.

   FUNCTION somutCompareId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Short;
     
     -- Performs an ordered comparison with another Id.
     -- If this ID < otherId  -1 is returned.
     -- If this ID = otherId   0 is returned.
     -- If this ID > otherId   1 is returned.

   FUNCTION somutHashId (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;
     
     -- Returns an unsigned integer hash value based on the ID.

END SOMUTId; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMUTId IS

   
   -- This is the abstract base class for an ID. Only the interface is
   -- defined. Refer to derived classes for details.
   --
   -- Instances of classes derived from this one should represent a
   -- value which can be used to identify something... such as an object,
   -- a file, a network node, etc, etc...
   --

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somutSetIdId : SOM.somMToken;
      somutEqualsId : SOM.somMToken;
      somutCompareId : SOM.somMToken;
      somutHashId : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMUTIdClassData : classData;
   FOR SOMUTIdClassData USE AT standard.system.label("SOMUTIdClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMUTIdCClassData : CClassData;
   FOR SOMUTIdCClassData USE AT standard.system.label("SOMUTIdCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMUTIdClassData.classObject) 
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
      FUNCTION SOMUTIdNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMUTIdNewClass);
      PRAGMA interface_information (SOMUTIdNewClass, ".SOMUTIdNewClass");
   BEGIN
      RETURN SOMUTIdNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMUTIdClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMUTIdClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somutSetIdId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
   IS
     
     -- Sets the ID equal to ID of the given ID.
      PROCEDURE SOMUTId_somutSetIdId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         otherId : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMUTId_somutSetIdId);
      PRAGMA interface_information (SOMUTId_somutSetIdId, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMUTId_somutSetIdId (
         Self.som_object,
         Ev,
         otherId,
         SOMUTIdClassData.somutSetIdId);
   END somutSetIdId;

   FUNCTION somutEqualsId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Checks to see if this object's ID is equivalent to the given ID.
     -- Returns TRUE if the ID's are equivalent, FALSE otherwise.
      FUNCTION SOMUTId_somutEqualsId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         otherId : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMUTId_somutEqualsId);
      PRAGMA interface_information (SOMUTId_somutEqualsId, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTId_somutEqualsId (
            Self.som_object,
            Ev,
            otherId,
            SOMUTIdClassData.somutEqualsId);
      RETURN Result;
   END somutEqualsId; 

   FUNCTION somutCompareId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Short
   IS
     
     -- Performs an ordered comparison with another Id.
     -- If this ID < otherId  -1 is returned.
     -- If this ID = otherId   0 is returned.
     -- If this ID > otherId   1 is returned.
      FUNCTION SOMUTId_somutCompareId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         otherId : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMUTId_somutCompareId);
      PRAGMA interface_information (SOMUTId_somutCompareId, ".xsomcall3");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTId_somutCompareId (
            Self.som_object,
            Ev,
            otherId,
            SOMUTIdClassData.somutCompareId);
      RETURN Result;
   END somutCompareId; 

   FUNCTION somutHashId (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Returns an unsigned integer hash value based on the ID.
      FUNCTION SOMUTId_somutHashId(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMUTId_somutHashId);
      PRAGMA interface_information (SOMUTId_somutHashId, ".xsomcall2");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTId_somutHashId (
            Self.som_object,
            Ev,
            SOMUTIdClassData.somutHashId);
      RETURN Result;
   END somutHashId; 

END SOMUTId; 







