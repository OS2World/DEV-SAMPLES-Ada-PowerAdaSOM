
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:08 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TIterator;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TSetIterator IS


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
      


   FUNCTION somfTSetIteratorInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize somf_TSetIterator using somf_TSet h.

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

END somf_TSetIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSetIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfTSetIteratorInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSetIteratorClassData : classData;
   FOR somf_TSetIteratorClassData USE AT standard.system.label("somf_TSetIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSetIteratorCClassData : CClassData;
   FOR somf_TSetIteratorCClassData USE AT standard.system.label("somf_TSetIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSetIteratorClassData.classObject) 
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
      FUNCTION somf_TSetIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSetIteratorNewClass);
      PRAGMA interface_information (somf_TSetIteratorNewClass, ".somf_TSetIteratorNewClass");
   BEGIN
      RETURN somf_TSetIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSetIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSetIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTSetIteratorInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize somf_TSetIterator using somf_TSet h.
      FUNCTION somf_TSetIterator_somfTSetIteratorInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         h : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSetIterator_somfTSetIteratorInit);
      PRAGMA interface_information (somf_TSetIterator_somfTSetIteratorInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSetIterator_somfTSetIteratorInit (
            Self.som_object,
            Ev,
            h,
            somf_TSetIteratorClassData.somfTSetIteratorInit);
      RETURN Result;
   END somfTSetIteratorInit; 

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

END somf_TSetIterator; 







