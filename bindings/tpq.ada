
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:05 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TCollection;
WITH somf_MOrderableCollectible;
WITH somf_MCollectible;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TPriorityQueue IS


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
      

   kInitialPriorityQueueSize : CONSTANT Corba.Long := 20;


   FUNCTION somfTPriorityQueueInitF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MOrderableCollectible.somf_MOrderableCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize a new TPriorityQueue

   FUNCTION somfTPriorityQueueInitP (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      q : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize a new TPriorityQueue

   PROCEDURE somfAssign (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      source : IN SOM.SOMObjectPtr);
     
     -- Assign the instance of this equal to the instance of source.

   PROCEDURE somfInsert (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Insert obj in this

   FUNCTION somfPop (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the object with the "highest" priority from the priority queue,
     -- and return it.

   FUNCTION somfPeek (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the object with the "highest" priority from the TPriorityQueue,
     -- but don't remove it.

   FUNCTION somfReplace (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method removes the object with the highest priority from the
     -- TPriorityQueue, then inserts obj into the TPriorityQueue.

   PROCEDURE somfChange (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- DO NOT USE THIS METHOD, it does nothing.

   PROCEDURE somfSetEqualityComparisonFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      fn : IN somf_MCollectible.somf_MCollectibleCompareFn);
     
     -- Set the equality comparison function being used by the priority queue.

   FUNCTION somfGetEqualityComparisonFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleCompareFn;
     
     -- Return the equality comparison function being used by the priority queue.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfAdd (
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

   FUNCTION somfMember (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfCreateIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

END somf_TPriorityQueue; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TPriorityQueue IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfInsert : SOM.somMToken;
      somfPop : SOM.somMToken;
      somfPeek : SOM.somMToken;
      somfReplace : SOM.somMToken;
      somfChange : SOM.somMToken;
      somfSetEqualityComparisonFunction : SOM.somMToken;
      somfGetEqualityComparisonFunction : SOM.somMToken;
      somfDownHeap : SOM.somMToken;
      somfUpHeap : SOM.somMToken;
      somfGrowHeap : SOM.somMToken;
      somfMakeNewTable : SOM.somMToken;
      somfCopyIn : SOM.somMToken;
      somfAssign : SOM.somMToken;
      somfTPriorityQueueInitF : SOM.somMToken;
      somfTPriorityQueueInitP : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TPriorityQueueClassData : classData;
   FOR somf_TPriorityQueueClassData USE AT standard.system.label("somf_TPriorityQueueClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TPriorityQueueCClassData : CClassData;
   FOR somf_TPriorityQueueCClassData USE AT standard.system.label("somf_TPriorityQueueCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TPriorityQueueClassData.classObject) 
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
      FUNCTION somf_TPriorityQueueNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TPriorityQueueNewClass);
      PRAGMA interface_information (somf_TPriorityQueueNewClass, ".somf_TPriorityQueueNewClass");
   BEGIN
      RETURN somf_TPriorityQueueNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TPriorityQueueClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TPriorityQueueClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTPriorityQueueInitF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MOrderableCollectible.somf_MOrderableCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize a new TPriorityQueue
      FUNCTION somf_TPriorityQueue_somfTPriorityQueueInitF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MOrderableCollectible.somf_MOrderableCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPriorityQueue_somfTPriorityQueueInitF);
      PRAGMA interface_information (somf_TPriorityQueue_somfTPriorityQueueInitF, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPriorityQueue_somfTPriorityQueueInitF (
            Self.som_object,
            Ev,
            testfn,
            somf_TPriorityQueueClassData.somfTPriorityQueueInitF);
      RETURN Result;
   END somfTPriorityQueueInitF; 

   FUNCTION somfTPriorityQueueInitP (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      q : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize a new TPriorityQueue
      FUNCTION somf_TPriorityQueue_somfTPriorityQueueInitP(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         q : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPriorityQueue_somfTPriorityQueueInitP);
      PRAGMA interface_information (somf_TPriorityQueue_somfTPriorityQueueInitP, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPriorityQueue_somfTPriorityQueueInitP (
            Self.som_object,
            Ev,
            q,
            somf_TPriorityQueueClassData.somfTPriorityQueueInitP);
      RETURN Result;
   END somfTPriorityQueueInitP; 

   PROCEDURE somfAssign (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      source : IN SOM.SOMObjectPtr)
   IS
     
     -- Assign the instance of this equal to the instance of source.
      PROCEDURE somf_TPriorityQueue_somfAssign(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         source : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPriorityQueue_somfAssign);
      PRAGMA interface_information (somf_TPriorityQueue_somfAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPriorityQueue_somfAssign (
         Self.som_object,
         Ev,
         source,
         somf_TPriorityQueueClassData.somfAssign);
   END somfAssign;

   PROCEDURE somfInsert (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Insert obj in this
      PROCEDURE somf_TPriorityQueue_somfInsert(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPriorityQueue_somfInsert);
      PRAGMA interface_information (somf_TPriorityQueue_somfInsert, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPriorityQueue_somfInsert (
         Self.som_object,
         Ev,
         obj,
         somf_TPriorityQueueClassData.somfInsert);
   END somfInsert;

   FUNCTION somfPop (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the object with the "highest" priority from the priority queue,
     -- and return it.
      FUNCTION somf_TPriorityQueue_somfPop(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPriorityQueue_somfPop);
      PRAGMA interface_information (somf_TPriorityQueue_somfPop, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPriorityQueue_somfPop (
            Self.som_object,
            Ev,
            somf_TPriorityQueueClassData.somfPop);
      RETURN Result;
   END somfPop; 

   FUNCTION somfPeek (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the object with the "highest" priority from the TPriorityQueue,
     -- but don't remove it.
      FUNCTION somf_TPriorityQueue_somfPeek(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPriorityQueue_somfPeek);
      PRAGMA interface_information (somf_TPriorityQueue_somfPeek, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPriorityQueue_somfPeek (
            Self.som_object,
            Ev,
            somf_TPriorityQueueClassData.somfPeek);
      RETURN Result;
   END somfPeek; 

   FUNCTION somfReplace (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method removes the object with the highest priority from the
     -- TPriorityQueue, then inserts obj into the TPriorityQueue.
      FUNCTION somf_TPriorityQueue_somfReplace(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPriorityQueue_somfReplace);
      PRAGMA interface_information (somf_TPriorityQueue_somfReplace, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPriorityQueue_somfReplace (
            Self.som_object,
            Ev,
            obj,
            somf_TPriorityQueueClassData.somfReplace);
      RETURN Result;
   END somfReplace; 

   PROCEDURE somfChange (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- DO NOT USE THIS METHOD, it does nothing.
      PROCEDURE somf_TPriorityQueue_somfChange(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPriorityQueue_somfChange);
      PRAGMA interface_information (somf_TPriorityQueue_somfChange, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPriorityQueue_somfChange (
         Self.som_object,
         Ev,
         obj,
         somf_TPriorityQueueClassData.somfChange);
   END somfChange;

   PROCEDURE somfSetEqualityComparisonFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      fn : IN somf_MCollectible.somf_MCollectibleCompareFn)
   IS
     
     -- Set the equality comparison function being used by the priority queue.
      PROCEDURE somf_TPriorityQueue_somfSetEqualityComparisonFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         fn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPriorityQueue_somfSetEqualityComparisonFunction);
      PRAGMA interface_information (somf_TPriorityQueue_somfSetEqualityComparisonFunction, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPriorityQueue_somfSetEqualityComparisonFunction (
         Self.som_object,
         Ev,
         fn,
         somf_TPriorityQueueClassData.somfSetEqualityComparisonFunction);
   END somfSetEqualityComparisonFunction;

   FUNCTION somfGetEqualityComparisonFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleCompareFn
   IS
     
     -- Return the equality comparison function being used by the priority queue.
      FUNCTION somf_TPriorityQueue_somfGetEqualityComparisonFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MCollectible.somf_MCollectibleCompareFn; 
      PRAGMA interface (assembly, somf_TPriorityQueue_somfGetEqualityComparisonFunction);
      PRAGMA interface_information (somf_TPriorityQueue_somfGetEqualityComparisonFunction, ".xsomcall2");
      Result : ALIASED somf_MCollectible.somf_MCollectibleCompareFn;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPriorityQueue_somfGetEqualityComparisonFunction (
            Self.som_object,
            Ev,
            somf_TPriorityQueueClassData.somfGetEqualityComparisonFunction);
      RETURN Result;
   END somfGetEqualityComparisonFunction; 

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

END somf_TPriorityQueue; 







