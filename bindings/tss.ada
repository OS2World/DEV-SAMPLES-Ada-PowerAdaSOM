
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:09 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TSequence;
WITH somf_MOrderableCollectible;
WITH SOMObject;
WITH somf_MCollectible;
WITH somf_TCollection;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TSortedSequence IS


   TYPE Ref IS NEW somf_TSequence.Ref WITH NULL RECORD;

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
      


   FUNCTION somfTSortedSequenceInitF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the new TSortedSequence

   FUNCTION somfTSortedSequenceInitS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the new TSortedSequence

   PROCEDURE somfAssign (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN SOM.SOMObjectPtr);
     
     -- Assign the instance of this equal to the instance of source.

   FUNCTION somfCreateSequenceIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns a new iterator which is suitable for use in iterating
     -- over the objects in this collection.

   FUNCTION somfGetSequencingFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn;
     
     -- Return a pointer to the function used to compare elements in the
     -- collection, and consequently determines the sequence of the collection.

   PROCEDURE somfSetSequencingFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      fn : IN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn);
     
     -- Sets the pointer to the function used to compare elements in the
     -- collection, and consequently determines the sequence of the collection.

   FUNCTION somfCreateSortedSequenceNode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n1 : IN SOM.SOMObjectPtr;
      obj : IN SOM.SOMObjectPtr;
      n2 : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Create a new TSortedSequenceNode in the TSortedSequence.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

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

   PROCEDURE somfDeleteAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   PROCEDURE somfRemoveAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   FUNCTION somfCount (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;

   FUNCTION somfAfter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfBefore (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfMember (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfCreateIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfOccurrencesOf (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long;

END somf_TSortedSequence; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSortedSequence IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfCreateSequenceIterator : SOM.somMToken;
      somfGetSequencingFunction : SOM.somMToken;
      somfSetSequencingFunction : SOM.somMToken;
      somfCreateSortedSequenceNode : SOM.somMToken;
      somfRotate : SOM.somMToken;
      somfSplit : SOM.somMToken;
      somfBalance : SOM.somMToken;
      somfInternalRemoveAll : SOM.somMToken;
      somfInternalDeleteAll : SOM.somMToken;
      somfAssign : SOM.somMToken;
      somfTSortedSequenceInitF : SOM.somMToken;
      somfTSortedSequenceInitS : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSortedSequenceClassData : classData;
   FOR somf_TSortedSequenceClassData USE AT standard.system.label("somf_TSortedSequenceClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSortedSequenceCClassData : CClassData;
   FOR somf_TSortedSequenceCClassData USE AT standard.system.label("somf_TSortedSequenceCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSortedSequenceClassData.classObject) 
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
      FUNCTION somf_TSortedSequenceNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSortedSequenceNewClass);
      PRAGMA interface_information (somf_TSortedSequenceNewClass, ".somf_TSortedSequenceNewClass");
   BEGIN
      RETURN somf_TSortedSequenceNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSortedSequenceClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSortedSequenceClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTSortedSequenceInitF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the new TSortedSequence
      FUNCTION somf_TSortedSequence_somfTSortedSequenceInitF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequence_somfTSortedSequenceInitF);
      PRAGMA interface_information (somf_TSortedSequence_somfTSortedSequenceInitF, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequence_somfTSortedSequenceInitF (
            Self.som_object,
            Ev,
            testfn,
            somf_TSortedSequenceClassData.somfTSortedSequenceInitF);
      RETURN Result;
   END somfTSortedSequenceInitF; 

   FUNCTION somfTSortedSequenceInitS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the new TSortedSequence
      FUNCTION somf_TSortedSequence_somfTSortedSequenceInitS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequence_somfTSortedSequenceInitS);
      PRAGMA interface_information (somf_TSortedSequence_somfTSortedSequenceInitS, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequence_somfTSortedSequenceInitS (
            Self.som_object,
            Ev,
            s,
            somf_TSortedSequenceClassData.somfTSortedSequenceInitS);
      RETURN Result;
   END somfTSortedSequenceInitS; 

   PROCEDURE somfAssign (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN SOM.SOMObjectPtr)
   IS
     
     -- Assign the instance of this equal to the instance of source.
      PROCEDURE somf_TSortedSequence_somfAssign(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequence_somfAssign);
      PRAGMA interface_information (somf_TSortedSequence_somfAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequence_somfAssign (
         Self.som_object,
         Ev,
         s,
         somf_TSortedSequenceClassData.somfAssign);
   END somfAssign;

   FUNCTION somfCreateSequenceIterator (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns a new iterator which is suitable for use in iterating
     -- over the objects in this collection.
      FUNCTION somf_TSortedSequence_somfCreateSequenceIterator(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequence_somfCreateSequenceIterator);
      PRAGMA interface_information (somf_TSortedSequence_somfCreateSequenceIterator, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequence_somfCreateSequenceIterator (
            Self.som_object,
            Ev,
            somf_TSortedSequenceClassData.somfCreateSequenceIterator);
      RETURN Result;
   END somfCreateSequenceIterator; 

   FUNCTION somfGetSequencingFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn
   IS
     
     -- Return a pointer to the function used to compare elements in the
     -- collection, and consequently determines the sequence of the collection.
      FUNCTION somf_TSortedSequence_somfGetSequencingFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn; 
      PRAGMA interface (assembly, somf_TSortedSequence_somfGetSequencingFunction);
      PRAGMA interface_information (somf_TSortedSequence_somfGetSequencingFunction, ".xsomcall2");
      Result : ALIASED somf_MOrderableCollectible.somf_MBetterOrderableCompareFn;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequence_somfGetSequencingFunction (
            Self.som_object,
            Ev,
            somf_TSortedSequenceClassData.somfGetSequencingFunction);
      RETURN Result;
   END somfGetSequencingFunction; 

   PROCEDURE somfSetSequencingFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      fn : IN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn)
   IS
     
     -- Sets the pointer to the function used to compare elements in the
     -- collection, and consequently determines the sequence of the collection.
      PROCEDURE somf_TSortedSequence_somfSetSequencingFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         fn : IN somf_MOrderableCollectible.somf_MBetterOrderableCompareFn;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequence_somfSetSequencingFunction);
      PRAGMA interface_information (somf_TSortedSequence_somfSetSequencingFunction, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequence_somfSetSequencingFunction (
         Self.som_object,
         Ev,
         fn,
         somf_TSortedSequenceClassData.somfSetSequencingFunction);
   END somfSetSequencingFunction;

   FUNCTION somfCreateSortedSequenceNode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n1 : IN SOM.SOMObjectPtr; 
      obj : IN SOM.SOMObjectPtr; 
      n2 : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create a new TSortedSequenceNode in the TSortedSequence.
      FUNCTION somf_TSortedSequence_somfCreateSortedSequenceNode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n1 : IN SOM.SOMObjectPtr; 
         obj : IN SOM.SOMObjectPtr; 
         n2 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequence_somfCreateSortedSequenceNode);
      PRAGMA interface_information (somf_TSortedSequence_somfCreateSortedSequenceNode, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequence_somfCreateSortedSequenceNode (
            Self.som_object,
            Ev,
            n1,
            obj,
            n2,
            somf_TSortedSequenceClassData.somfCreateSortedSequenceNode);
      RETURN Result;
   END somfCreateSortedSequenceNode; 

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

   FUNCTION somfAfter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequence.somfAfter (
            somf_TSequence.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfAfter;

   FUNCTION somfBefore (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequence.somfBefore (
            somf_TSequence.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfBefore;

   FUNCTION somfLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequence.somfLast (
            somf_TSequence.Ref'(som_object=>Self.som_object),
            Ev);
   END somfLast;

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequence.somfFirst (
            somf_TSequence.Ref'(som_object=>Self.som_object),
            Ev);
   END somfFirst;

   FUNCTION somfMember (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TCollection.somfMember (
            somf_TCollection.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfMember;

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

   FUNCTION somfOccurrencesOf (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TSequence.somfOccurrencesOf (
            somf_TSequence.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfOccurrencesOf;

END somf_TSortedSequence; 







