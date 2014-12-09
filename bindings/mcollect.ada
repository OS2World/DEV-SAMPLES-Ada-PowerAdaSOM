
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:14 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_MCollectible IS


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
      

   kReasonableLowerBound : CONSTANT Corba.Long := 5;

   SUBTYPE somf_MCollectibleCompareFn IS SOM.somMToken;

   SUBTYPE somf_MCollectibleHashFn IS SOM.somMToken;


   FUNCTION somfClone (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- somfClone provides a general function for creating a new instance of this.

   FUNCTION somfClonePointer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      clonee : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- somfClonePointer returns a pointer to a Clone

   FUNCTION somfHash (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- somfHash returns a value suitable for use as a hashing probe for this.
     -- The default function will simply return the address of the object.
     -- The default function is almost certainly not adequate if you are overriding
     -- somfIsEqual because you need to make sure that all objects that "are equal"
     -- to each other return the same hash value.  For example, a TText object would
     -- return a hash value computed using the characters in the string instead of
     -- the address of the string.

   FUNCTION somfIsEqual (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- somfIsEqual returns TRUE if obj is isomorphic to this.  The default function
     -- will give you a nasty message.  For example, the somfIsEqual method
     -- for TText objects will do a string comparison.  All of the utility classes
     -- allow you to specify what methods to use when comparing objects for
     -- insertion, deletion, etc.

   FUNCTION somfIsSame (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- The default function for somfIsSame is a pointer comparison

   FUNCTION somfIsNotEqual (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- somfIsNotEqual returns TRUE if obj is NOT isomorphic to this.  It uses
     -- somfIsEqual, so overriding somfIsEqual will handle the logic of somfIsNotEqual too.

END somf_MCollectible; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_MCollectible IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfClone : SOM.somMToken;
      somfClonePointer : SOM.somMToken;
      somfHash : SOM.somMToken;
      somfIsEqual : SOM.somMToken;
      somfIsSame : SOM.somMToken;
      somfIsNotEqual : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_MCollectibleClassData : classData;
   FOR somf_MCollectibleClassData USE AT standard.system.label("somf_MCollectibleClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_MCollectibleCClassData : CClassData;
   FOR somf_MCollectibleCClassData USE AT standard.system.label("somf_MCollectibleCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_MCollectibleClassData.classObject) 
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
      FUNCTION somf_MCollectibleNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_MCollectibleNewClass);
      PRAGMA interface_information (somf_MCollectibleNewClass, ".somf_MCollectibleNewClass");
   BEGIN
      RETURN somf_MCollectibleNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_MCollectibleClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_MCollectibleClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfClone (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- somfClone provides a general function for creating a new instance of this.
      FUNCTION somf_MCollectible_somfClone(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_MCollectible_somfClone);
      PRAGMA interface_information (somf_MCollectible_somfClone, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MCollectible_somfClone (
            Self.som_object,
            Ev,
            somf_MCollectibleClassData.somfClone);
      RETURN Result;
   END somfClone; 

   FUNCTION somfClonePointer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      clonee : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- somfClonePointer returns a pointer to a Clone
      FUNCTION somf_MCollectible_somfClonePointer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         clonee : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_MCollectible_somfClonePointer);
      PRAGMA interface_information (somf_MCollectible_somfClonePointer, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MCollectible_somfClonePointer (
            Self.som_object,
            Ev,
            clonee,
            somf_MCollectibleClassData.somfClonePointer);
      RETURN Result;
   END somfClonePointer; 

   FUNCTION somfHash (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- somfHash returns a value suitable for use as a hashing probe for this.
     -- The default function will simply return the address of the object.
     -- The default function is almost certainly not adequate if you are overriding
     -- somfIsEqual because you need to make sure that all objects that "are equal"
     -- to each other return the same hash value.  For example, a TText object would
     -- return a hash value computed using the characters in the string instead of
     -- the address of the string.
      FUNCTION somf_MCollectible_somfHash(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_MCollectible_somfHash);
      PRAGMA interface_information (somf_MCollectible_somfHash, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MCollectible_somfHash (
            Self.som_object,
            Ev,
            somf_MCollectibleClassData.somfHash);
      RETURN Result;
   END somfHash; 

   FUNCTION somfIsEqual (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- somfIsEqual returns TRUE if obj is isomorphic to this.  The default function
     -- will give you a nasty message.  For example, the somfIsEqual method
     -- for TText objects will do a string comparison.  All of the utility classes
     -- allow you to specify what methods to use when comparing objects for
     -- insertion, deletion, etc.
      FUNCTION somf_MCollectible_somfIsEqual(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MCollectible_somfIsEqual);
      PRAGMA interface_information (somf_MCollectible_somfIsEqual, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MCollectible_somfIsEqual (
            Self.som_object,
            Ev,
            obj,
            somf_MCollectibleClassData.somfIsEqual);
      RETURN Result;
   END somfIsEqual; 

   FUNCTION somfIsSame (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- The default function for somfIsSame is a pointer comparison
      FUNCTION somf_MCollectible_somfIsSame(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MCollectible_somfIsSame);
      PRAGMA interface_information (somf_MCollectible_somfIsSame, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MCollectible_somfIsSame (
            Self.som_object,
            Ev,
            obj,
            somf_MCollectibleClassData.somfIsSame);
      RETURN Result;
   END somfIsSame; 

   FUNCTION somfIsNotEqual (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- somfIsNotEqual returns TRUE if obj is NOT isomorphic to this.  It uses
     -- somfIsEqual, so overriding somfIsEqual will handle the logic of somfIsNotEqual too.
      FUNCTION somf_MCollectible_somfIsNotEqual(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MCollectible_somfIsNotEqual);
      PRAGMA interface_information (somf_MCollectible_somfIsNotEqual, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MCollectible_somfIsNotEqual (
            Self.som_object,
            Ev,
            obj,
            somf_MCollectibleClassData.somfIsNotEqual);
      RETURN Result;
   END somfIsNotEqual; 

END somf_MCollectible; 







