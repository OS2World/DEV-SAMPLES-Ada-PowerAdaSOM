
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:10 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TSequenceIterator;
WITH somf_TIterator;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TSortedSequenceIterator IS


   TYPE Ref IS NEW somf_TSequenceIterator.Ref WITH NULL RECORD;

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
      


   FUNCTION somfTSortedSequenceIteratorInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new sorted sequence iterator.

   FUNCTION somfStartHere (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Start Iterating through the TSroted Sequence, only don't start at the
     -- front of the collection, start at obj.

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfPrevious (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment);

END somf_TSortedSequenceIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSortedSequenceIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfStartHere : SOM.somMToken;
      somfTSortedSequenceIteratorInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSortedSequenceIteratorClassData : classData;
   FOR somf_TSortedSequenceIteratorClassData USE AT standard.system.label("somf_TSortedSequenceIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSortedSequenceIteratorCClassData : CClassData;
   FOR somf_TSortedSequenceIteratorCClassData USE AT standard.system.label("somf_TSortedSequenceIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSortedSequenceIteratorClassData.classObject) 
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
      FUNCTION somf_TSortedSequenceIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSortedSequenceIteratorNewClass);
      PRAGMA interface_information (somf_TSortedSequenceIteratorNewClass, ".somf_TSortedSequenceIteratorNewClass");
   BEGIN
      RETURN somf_TSortedSequenceIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSortedSequenceIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSortedSequenceIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTSortedSequenceIteratorInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new sorted sequence iterator.
      FUNCTION somf_TSortedSequenceIterator_somfTSortedSequenceIteratorInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         h : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceIterator_somfTSortedSequenceIteratorInit);
      PRAGMA interface_information (somf_TSortedSequenceIterator_somfTSortedSequenceIteratorInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceIterator_somfTSortedSequenceIteratorInit (
            Self.som_object,
            Ev,
            h,
            somf_TSortedSequenceIteratorClassData.somfTSortedSequenceIteratorInit);
      RETURN Result;
   END somfTSortedSequenceIteratorInit; 

   FUNCTION somfStartHere (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Start Iterating through the TSroted Sequence, only don't start at the
     -- front of the collection, start at obj.
      FUNCTION somf_TSortedSequenceIterator_somfStartHere(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceIterator_somfStartHere);
      PRAGMA interface_information (somf_TSortedSequenceIterator_somfStartHere, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceIterator_somfStartHere (
            Self.som_object,
            Ev,
            obj,
            somf_TSortedSequenceIteratorClassData.somfStartHere);
      RETURN Result;
   END somfStartHere; 

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

   FUNCTION somfLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequenceIterator.somfLast (
            somf_TSequenceIterator.Ref'(som_object=>Self.som_object),
            Ev);
   END somfLast;

   FUNCTION somfPrevious (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequenceIterator.somfPrevious (
            somf_TSequenceIterator.Ref'(som_object=>Self.som_object),
            Ev);
   END somfPrevious;

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

END somf_TSortedSequenceIterator; 







