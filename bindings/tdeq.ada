
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:59 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TSequence;
WITH somf_MCollectible;
WITH SOMObject;
WITH somf_TCollection;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TDeque IS


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
      


   FUNCTION somfTDequeInitF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new deque.

   FUNCTION somfTDequeInitD (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new deque.

   PROCEDURE somfAssign (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN SOM.SOMObjectPtr);
     
     -- Assign the instance of this equal to the instance of source.

   PROCEDURE somfAddAfter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      existingobj : IN SOM.SOMObjectPtr;
      tobeadded : IN SOM.SOMObjectPtr);
     
     -- Add the obj object into the List after the existing object.

   PROCEDURE somfAddBefore (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      existingobj : IN SOM.SOMObjectPtr;
      tobeadded : IN SOM.SOMObjectPtr);
     
     -- Add the obj object into the List before the existing object.

   PROCEDURE somfAddLast (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the obj object as the last object in the List.

   PROCEDURE somfAddFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the obj object as the first object in the List.

   FUNCTION somfRemoveLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the last object in the List.

   FUNCTION somfRemoveFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the first object in the deque.

   FUNCTION somfCreateSequenceIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns a new iterator which is suitable for use in iterating
     -- over the objects in this collection.

   FUNCTION somfRemoveQ (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the object on the deque/queue
     -- (This call can be used to simulate a queue)

   PROCEDURE somfInsert (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the object to the deque/queue
     -- (This call can be used to simulate a queue)

   FUNCTION somfPop (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the object on the top of the deque/stack
     -- (This call can be used to simulate a stack)

   PROCEDURE somfPush (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the object to the top of the deque/stack
     -- (This call can be used to simulate a stack)

   FUNCTION somfCreateNewLink (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      p : IN SOM.SOMObjectPtr;
      n : IN SOM.SOMObjectPtr;
      v : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Create a new TDeque link, using a TDequeLinkable instance.

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

END somf_TDeque; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TDeque IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfAddAfter : SOM.somMToken;
      somfAddBefore : SOM.somMToken;
      somfAddLast : SOM.somMToken;
      somfAddFirst : SOM.somMToken;
      somfRemoveLast : SOM.somMToken;
      somfRemoveFirst : SOM.somMToken;
      somfCreateSequenceIterator : SOM.somMToken;
      somfRemoveQ : SOM.somMToken;
      somfInsert : SOM.somMToken;
      somfPop : SOM.somMToken;
      somfPush : SOM.somMToken;
      somfCreateNewLink : SOM.somMToken;
      somfAssign : SOM.somMToken;
      somfTDequeInitF : SOM.somMToken;
      somfTDequeInitD : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TDequeClassData : classData;
   FOR somf_TDequeClassData USE AT standard.system.label("somf_TDequeClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TDequeCClassData : CClassData;
   FOR somf_TDequeCClassData USE AT standard.system.label("somf_TDequeCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TDequeClassData.classObject) 
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
      FUNCTION somf_TDequeNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TDequeNewClass);
      PRAGMA interface_information (somf_TDequeNewClass, ".somf_TDequeNewClass");
   BEGIN
      RETURN somf_TDequeNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TDequeClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TDequeClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTDequeInitF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new deque.
      FUNCTION somf_TDeque_somfTDequeInitF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfTDequeInitF);
      PRAGMA interface_information (somf_TDeque_somfTDequeInitF, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfTDequeInitF (
            Self.som_object,
            Ev,
            testfn,
            somf_TDequeClassData.somfTDequeInitF);
      RETURN Result;
   END somfTDequeInitF; 

   FUNCTION somfTDequeInitD (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new deque.
      FUNCTION somf_TDeque_somfTDequeInitD(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfTDequeInitD);
      PRAGMA interface_information (somf_TDeque_somfTDequeInitD, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfTDequeInitD (
            Self.som_object,
            Ev,
            s,
            somf_TDequeClassData.somfTDequeInitD);
      RETURN Result;
   END somfTDequeInitD; 

   PROCEDURE somfAssign (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN SOM.SOMObjectPtr)
   IS
     
     -- Assign the instance of this equal to the instance of source.
      PROCEDURE somf_TDeque_somfAssign(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfAssign);
      PRAGMA interface_information (somf_TDeque_somfAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfAssign (
         Self.som_object,
         Ev,
         s,
         somf_TDequeClassData.somfAssign);
   END somfAssign;

   PROCEDURE somfAddAfter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      existingobj : IN SOM.SOMObjectPtr; 
      tobeadded : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object into the List after the existing object.
      PROCEDURE somf_TDeque_somfAddAfter(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         existingobj : IN SOM.SOMObjectPtr; 
         tobeadded : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfAddAfter);
      PRAGMA interface_information (somf_TDeque_somfAddAfter, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfAddAfter (
         Self.som_object,
         Ev,
         existingobj,
         tobeadded,
         somf_TDequeClassData.somfAddAfter);
   END somfAddAfter;

   PROCEDURE somfAddBefore (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      existingobj : IN SOM.SOMObjectPtr; 
      tobeadded : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object into the List before the existing object.
      PROCEDURE somf_TDeque_somfAddBefore(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         existingobj : IN SOM.SOMObjectPtr; 
         tobeadded : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfAddBefore);
      PRAGMA interface_information (somf_TDeque_somfAddBefore, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfAddBefore (
         Self.som_object,
         Ev,
         existingobj,
         tobeadded,
         somf_TDequeClassData.somfAddBefore);
   END somfAddBefore;

   PROCEDURE somfAddLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object as the last object in the List.
      PROCEDURE somf_TDeque_somfAddLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfAddLast);
      PRAGMA interface_information (somf_TDeque_somfAddLast, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfAddLast (
         Self.som_object,
         Ev,
         obj,
         somf_TDequeClassData.somfAddLast);
   END somfAddLast;

   PROCEDURE somfAddFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object as the first object in the List.
      PROCEDURE somf_TDeque_somfAddFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfAddFirst);
      PRAGMA interface_information (somf_TDeque_somfAddFirst, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfAddFirst (
         Self.som_object,
         Ev,
         obj,
         somf_TDequeClassData.somfAddFirst);
   END somfAddFirst;

   FUNCTION somfRemoveLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the last object in the List.
      FUNCTION somf_TDeque_somfRemoveLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfRemoveLast);
      PRAGMA interface_information (somf_TDeque_somfRemoveLast, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfRemoveLast (
            Self.som_object,
            Ev,
            somf_TDequeClassData.somfRemoveLast);
      RETURN Result;
   END somfRemoveLast; 

   FUNCTION somfRemoveFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the first object in the deque.
      FUNCTION somf_TDeque_somfRemoveFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfRemoveFirst);
      PRAGMA interface_information (somf_TDeque_somfRemoveFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfRemoveFirst (
            Self.som_object,
            Ev,
            somf_TDequeClassData.somfRemoveFirst);
      RETURN Result;
   END somfRemoveFirst; 

   FUNCTION somfCreateSequenceIterator (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns a new iterator which is suitable for use in iterating
     -- over the objects in this collection.
      FUNCTION somf_TDeque_somfCreateSequenceIterator(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfCreateSequenceIterator);
      PRAGMA interface_information (somf_TDeque_somfCreateSequenceIterator, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfCreateSequenceIterator (
            Self.som_object,
            Ev,
            somf_TDequeClassData.somfCreateSequenceIterator);
      RETURN Result;
   END somfCreateSequenceIterator; 

   FUNCTION somfRemoveQ (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the object on the deque/queue
     -- (This call can be used to simulate a queue)
      FUNCTION somf_TDeque_somfRemoveQ(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfRemoveQ);
      PRAGMA interface_information (somf_TDeque_somfRemoveQ, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfRemoveQ (
            Self.som_object,
            Ev,
            somf_TDequeClassData.somfRemoveQ);
      RETURN Result;
   END somfRemoveQ; 

   PROCEDURE somfInsert (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the object to the deque/queue
     -- (This call can be used to simulate a queue)
      PROCEDURE somf_TDeque_somfInsert(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfInsert);
      PRAGMA interface_information (somf_TDeque_somfInsert, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfInsert (
         Self.som_object,
         Ev,
         obj,
         somf_TDequeClassData.somfInsert);
   END somfInsert;

   FUNCTION somfPop (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the object on the top of the deque/stack
     -- (This call can be used to simulate a stack)
      FUNCTION somf_TDeque_somfPop(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfPop);
      PRAGMA interface_information (somf_TDeque_somfPop, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfPop (
            Self.som_object,
            Ev,
            somf_TDequeClassData.somfPop);
      RETURN Result;
   END somfPop; 

   PROCEDURE somfPush (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the object to the top of the deque/stack
     -- (This call can be used to simulate a stack)
      PROCEDURE somf_TDeque_somfPush(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDeque_somfPush);
      PRAGMA interface_information (somf_TDeque_somfPush, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDeque_somfPush (
         Self.som_object,
         Ev,
         obj,
         somf_TDequeClassData.somfPush);
   END somfPush;

   FUNCTION somfCreateNewLink (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      p : IN SOM.SOMObjectPtr; 
      n : IN SOM.SOMObjectPtr; 
      v : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create a new TDeque link, using a TDequeLinkable instance.
      FUNCTION somf_TDeque_somfCreateNewLink(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         p : IN SOM.SOMObjectPtr; 
         n : IN SOM.SOMObjectPtr; 
         v : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDeque_somfCreateNewLink);
      PRAGMA interface_information (somf_TDeque_somfCreateNewLink, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDeque_somfCreateNewLink (
            Self.som_object,
            Ev,
            p,
            n,
            v,
            somf_TDequeClassData.somfCreateNewLink);
      RETURN Result;
   END somfCreateNewLink; 

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

END somf_TDeque; 







