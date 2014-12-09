
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:56 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_MCollectible;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TCollectibleLong IS


   TYPE Ref IS NEW somf_MCollectible.Ref WITH NULL RECORD;

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
      


   FUNCTION somfTCollectibleLongInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      v : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new set.

   FUNCTION somfGetValue (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Determine the value of the long.

   PROCEDURE somfSetValue (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      v : IN Corba.Long);
     
     -- Set the value of the long in the TCollectibleLong

   PROCEDURE somInit (
      Self : IN Ref);

   FUNCTION somfIsEqual (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

   FUNCTION somfHash (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;

END somf_TCollectibleLong; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TCollectibleLong IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfGetValue : SOM.somMToken;
      somfSetValue : SOM.somMToken;
      somfTCollectibleLongInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TCollectibleLongClassData : classData;
   FOR somf_TCollectibleLongClassData USE AT standard.system.label("somf_TCollectibleLongClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TCollectibleLongCClassData : CClassData;
   FOR somf_TCollectibleLongCClassData USE AT standard.system.label("somf_TCollectibleLongCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TCollectibleLongClassData.classObject) 
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
      FUNCTION somf_TCollectibleLongNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TCollectibleLongNewClass);
      PRAGMA interface_information (somf_TCollectibleLongNewClass, ".somf_TCollectibleLongNewClass");
   BEGIN
      RETURN somf_TCollectibleLongNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TCollectibleLongClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TCollectibleLongClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTCollectibleLongInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      v : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new set.
      FUNCTION somf_TCollectibleLong_somfTCollectibleLongInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         v : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TCollectibleLong_somfTCollectibleLongInit);
      PRAGMA interface_information (somf_TCollectibleLong_somfTCollectibleLongInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollectibleLong_somfTCollectibleLongInit (
            Self.som_object,
            Ev,
            v,
            somf_TCollectibleLongClassData.somfTCollectibleLongInit);
      RETURN Result;
   END somfTCollectibleLongInit; 

   FUNCTION somfGetValue (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Determine the value of the long.
      FUNCTION somf_TCollectibleLong_somfGetValue(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_TCollectibleLong_somfGetValue);
      PRAGMA interface_information (somf_TCollectibleLong_somfGetValue, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollectibleLong_somfGetValue (
            Self.som_object,
            Ev,
            somf_TCollectibleLongClassData.somfGetValue);
      RETURN Result;
   END somfGetValue; 

   PROCEDURE somfSetValue (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      v : IN Corba.Long)
   IS
     
     -- Set the value of the long in the TCollectibleLong
      PROCEDURE somf_TCollectibleLong_somfSetValue(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         v : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TCollectibleLong_somfSetValue);
      PRAGMA interface_information (somf_TCollectibleLong_somfSetValue, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollectibleLong_somfSetValue (
         Self.som_object,
         Ev,
         v,
         somf_TCollectibleLongClassData.somfSetValue);
   END somfSetValue;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

   FUNCTION somfIsEqual (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_MCollectible.somfIsEqual (
            somf_MCollectible.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfIsEqual;

   FUNCTION somfHash (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_MCollectible.somfHash (
            somf_MCollectible.Ref'(som_object=>Self.som_object),
            Ev);
   END somfHash;

END somf_TCollectibleLong; 







