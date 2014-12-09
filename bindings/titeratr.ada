
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:03 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TIterator IS


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
      

   kIteratorOutOfSync : CONSTANT Corba.Unsigned_Long := 900;


   FUNCTION somfNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Retrieve the next object in the collection and return it.  The order that
     -- objects are retrieved is in an order that reflects the "ordered-ness"
     -- of the collection (or the lack of ordering on the collection elements).
     -- If the collection has changed since the last time somfFirst was called,
     -- this method will FAIL.

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Reset the iterator and return the first element of the collection.  This
     -- resyncs the iterator to the collection if other operations on the
     -- collection caused the iterator to be invalidated.

   PROCEDURE somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove the current object, the one just returned by First or Next,
     -- from the Collection.

END somf_TIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfNext : SOM.somMToken;
      somfFirst : SOM.somMToken;
      somfRemove : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TIteratorClassData : classData;
   FOR somf_TIteratorClassData USE AT standard.system.label("somf_TIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TIteratorCClassData : CClassData;
   FOR somf_TIteratorCClassData USE AT standard.system.label("somf_TIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TIteratorClassData.classObject) 
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
      FUNCTION somf_TIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TIteratorNewClass);
      PRAGMA interface_information (somf_TIteratorNewClass, ".somf_TIteratorNewClass");
   BEGIN
      RETURN somf_TIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfNext (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Retrieve the next object in the collection and return it.  The order that
     -- objects are retrieved is in an order that reflects the "ordered-ness"
     -- of the collection (or the lack of ordering on the collection elements).
     -- If the collection has changed since the last time somfFirst was called,
     -- this method will FAIL.
      FUNCTION somf_TIterator_somfNext(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TIterator_somfNext);
      PRAGMA interface_information (somf_TIterator_somfNext, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TIterator_somfNext (
            Self.som_object,
            Ev,
            somf_TIteratorClassData.somfNext);
      RETURN Result;
   END somfNext; 

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Reset the iterator and return the first element of the collection.  This
     -- resyncs the iterator to the collection if other operations on the
     -- collection caused the iterator to be invalidated.
      FUNCTION somf_TIterator_somfFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TIterator_somfFirst);
      PRAGMA interface_information (somf_TIterator_somfFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TIterator_somfFirst (
            Self.som_object,
            Ev,
            somf_TIteratorClassData.somfFirst);
      RETURN Result;
   END somfFirst; 

   PROCEDURE somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove the current object, the one just returned by First or Next,
     -- from the Collection.
      PROCEDURE somf_TIterator_somfRemove(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TIterator_somfRemove);
      PRAGMA interface_information (somf_TIterator_somfRemove, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TIterator_somfRemove (
         Self.som_object,
         Ev,
         somf_TIteratorClassData.somfRemove);
   END somfRemove;

END somf_TIterator; 







