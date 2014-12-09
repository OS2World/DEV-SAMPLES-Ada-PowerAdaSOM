
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:03 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TIterator;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_THashTableIterator IS


   TYPE Ref IS NEW somf_TIterator.Ref WITH NULL RECORD;

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
      


   FUNCTION somfTHashTableIteratorInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize somf_THashTableIterator using somf_THashTable h.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION somfNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment);

END somf_THashTableIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_THashTableIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfTHashTableIteratorInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_THashTableIteratorClassData : classData;
   FOR somf_THashTableIteratorClassData USE AT standard.system.label("somf_THashTableIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_THashTableIteratorCClassData : CClassData;
   FOR somf_THashTableIteratorCClassData USE AT standard.system.label("somf_THashTableIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_THashTableIteratorClassData.classObject) 
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
      FUNCTION somf_THashTableIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_THashTableIteratorNewClass);
      PRAGMA interface_information (somf_THashTableIteratorNewClass, ".somf_THashTableIteratorNewClass");
   BEGIN
      RETURN somf_THashTableIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_THashTableIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_THashTableIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTHashTableIteratorInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize somf_THashTableIterator using somf_THashTable h.
      FUNCTION somf_THashTableIterator_somfTHashTableIteratorInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         h : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTableIterator_somfTHashTableIteratorInit);
      PRAGMA interface_information (somf_THashTableIterator_somfTHashTableIteratorInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTableIterator_somfTHashTableIteratorInit (
            Self.som_object,
            Ev,
            h,
            somf_THashTableIteratorClassData.somfTHashTableIteratorInit);
      RETURN Result;
   END somfTHashTableIteratorInit; 

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

   FUNCTION somfNext (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TIterator.somfNext (
            somf_TIterator.Ref'(som_object=>Self.som_object),
            Ev);
   END somfNext;

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TIterator.somfFirst (
            somf_TIterator.Ref'(som_object=>Self.som_object),
            Ev);
   END somfFirst;

   PROCEDURE somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TIterator.somfRemove (
         somf_TIterator.Ref'(som_object=>Self.som_object),
         Ev);
   END somfRemove;

END somf_THashTableIterator; 







