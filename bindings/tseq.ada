
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:06 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TCollection;
WITH somf_MCollectible;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TSequence IS


   TYPE Ref IS NEW somf_TCollection.Ref WITH NULL RECORD;

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
      


   FUNCTION somfAfter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the object found after obj.

   FUNCTION somfBefore (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the object found before obj.

   FUNCTION somfLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the last object in this.

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the first object in this.

   FUNCTION somfOccurrencesOf (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long;
     
     -- Determine the number of times obj is in this.

   FUNCTION somfTSequenceInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- This method initializes a new TSequence.

   FUNCTION somfAdd (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somfRemoveAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   PROCEDURE somfDeleteAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   FUNCTION somfCount (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;

   FUNCTION somfCreateIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somInit (
      Self : IN Ref);

END somf_TSequence; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSequence IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfFirst : SOM.somMToken;
      somfAfter : SOM.somMToken;
      somfBefore : SOM.somMToken;
      somfLast : SOM.somMToken;
      somfOccurrencesOf : SOM.somMToken;
      somfTSequenceInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSequenceClassData : classData;
   FOR somf_TSequenceClassData USE AT standard.system.label("somf_TSequenceClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSequenceCClassData : CClassData;
   FOR somf_TSequenceCClassData USE AT standard.system.label("somf_TSequenceCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSequenceClassData.classObject) 
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
      FUNCTION somf_TSequenceNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSequenceNewClass);
      PRAGMA interface_information (somf_TSequenceNewClass, ".somf_TSequenceNewClass");
   BEGIN
      RETURN somf_TSequenceNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSequenceClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSequenceClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfAfter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the object found after obj.
      FUNCTION somf_TSequence_somfAfter(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequence_somfAfter);
      PRAGMA interface_information (somf_TSequence_somfAfter, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequence_somfAfter (
            Self.som_object,
            Ev,
            obj,
            somf_TSequenceClassData.somfAfter);
      RETURN Result;
   END somfAfter; 

   FUNCTION somfBefore (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the object found before obj.
      FUNCTION somf_TSequence_somfBefore(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequence_somfBefore);
      PRAGMA interface_information (somf_TSequence_somfBefore, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequence_somfBefore (
            Self.som_object,
            Ev,
            obj,
            somf_TSequenceClassData.somfBefore);
      RETURN Result;
   END somfBefore; 

   FUNCTION somfLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the last object in this.
      FUNCTION somf_TSequence_somfLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequence_somfLast);
      PRAGMA interface_information (somf_TSequence_somfLast, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequence_somfLast (
            Self.som_object,
            Ev,
            somf_TSequenceClassData.somfLast);
      RETURN Result;
   END somfLast; 

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the first object in this.
      FUNCTION somf_TSequence_somfFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequence_somfFirst);
      PRAGMA interface_information (somf_TSequence_somfFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequence_somfFirst (
            Self.som_object,
            Ev,
            somf_TSequenceClassData.somfFirst);
      RETURN Result;
   END somfFirst; 

   FUNCTION somfOccurrencesOf (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long
   IS
     
     -- Determine the number of times obj is in this.
      FUNCTION somf_TSequence_somfOccurrencesOf(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_TSequence_somfOccurrencesOf);
      PRAGMA interface_information (somf_TSequence_somfOccurrencesOf, ".xsomcall3");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequence_somfOccurrencesOf (
            Self.som_object,
            Ev,
            obj,
            somf_TSequenceClassData.somfOccurrencesOf);
      RETURN Result;
   END somfOccurrencesOf; 

   FUNCTION somfTSequenceInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method initializes a new TSequence.
      FUNCTION somf_TSequence_somfTSequenceInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSequence_somfTSequenceInit);
      PRAGMA interface_information (somf_TSequence_somfTSequenceInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSequence_somfTSequenceInit (
            Self.som_object,
            Ev,
            testfn,
            somf_TSequenceClassData.somfTSequenceInit);
      RETURN Result;
   END somfTSequenceInit; 

   FUNCTION somfAdd (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TCollection.somfAdd (
            somf_TCollection.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfAdd;

   FUNCTION somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TCollection.somfRemove (
            somf_TCollection.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfRemove;

   PROCEDURE somfRemoveAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollection.somfRemoveAll (
         somf_TCollection.Ref'(som_object=>Self.som_object),
         Ev);
   END somfRemoveAll;

   PROCEDURE somfDeleteAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollection.somfDeleteAll (
         somf_TCollection.Ref'(som_object=>Self.som_object),
         Ev);
   END somfDeleteAll;

   FUNCTION somfCount (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TCollection.somfCount (
            somf_TCollection.Ref'(som_object=>Self.som_object),
            Ev);
   END somfCount;

   FUNCTION somfCreateIterator (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TCollection.somfCreateIterator (
            somf_TCollection.Ref'(som_object=>Self.som_object),
            Ev);
   END somfCreateIterator;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END somf_TSequence; 







