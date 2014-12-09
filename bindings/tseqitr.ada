
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:07 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TIterator;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TSequenceIterator IS


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
      


   FUNCTION somfLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the last object in the TSequence.

   FUNCTION somfPrevious (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the previous object in the TSequence.

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment);

END somf_TSequenceIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSequenceIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfLast : SOM.somMToken;
      somfPrevious : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSequenceIteratorClassData : classData;
   FOR somf_TSequenceIteratorClassData USE AT standard.system.label("somf_TSequenceIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSequenceIteratorCClassData : CClassData;
   FOR somf_TSequenceIteratorCClassData USE AT standard.system.label("somf_TSequenceIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSequenceIteratorClassData.classObject) 
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
      FUNCTION somf_TSequenceIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSequenceIteratorNewClass);
      PRAGMA interface_information (somf_TSequenceIteratorNewClass, ".somf_TSequenceIteratorNewClass");
   BEGIN
      RETURN somf_TSequenceIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSequenceIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSequenceIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the last object in the TSequence.
      FUNCTION somf_TSequenceIterator_somfLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequenceIterator_somfLast);
      PRAGMA interface_information (somf_TSequenceIterator_somfLast, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequenceIterator_somfLast (
            Self.som_object,
            Ev,
            somf_TSequenceIteratorClassData.somfLast);
      RETURN Result;
   END somfLast; 

   FUNCTION somfPrevious (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the previous object in the TSequence.
      FUNCTION somf_TSequenceIterator_somfPrevious(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequenceIterator_somfPrevious);
      PRAGMA interface_information (somf_TSequenceIterator_somfPrevious, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequenceIterator_somfPrevious (
            Self.som_object,
            Ev,
            somf_TSequenceIteratorClassData.somfPrevious);
      RETURN Result;
   END somfPrevious; 

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

END somf_TSequenceIterator; 







