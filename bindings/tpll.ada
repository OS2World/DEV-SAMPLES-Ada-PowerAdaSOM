
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:04 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TPrimitiveLinkedList IS


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
      


   FUNCTION somfCount (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;
     
     -- Return the number of objects in this.

   PROCEDURE somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      aLink : IN SOM.SOMObjectPtr);
     
     -- Remove the somf_MLinkable object from the List.

   PROCEDURE somfRemoveAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the objects from this.

   FUNCTION somfRemoveFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the first object in the List.

   FUNCTION somfRemoveLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove the last object in the List.

   PROCEDURE somfAddBefore (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      existing : IN SOM.SOMObjectPtr;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the obj object into the List before the existing object.

   PROCEDURE somfAddAfter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      existing : IN SOM.SOMObjectPtr;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the obj object into the List after the existing object.

   PROCEDURE somfAddFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the obj object as the first object in the List.

   PROCEDURE somfAddLast (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr);
     
     -- Add the obj object as the last object in the List.

   FUNCTION somfAfter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      existingobj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the object that comes after the existingobj object in the List.

   FUNCTION somfBefore (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      existingobj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the object that comes before the existingobj object in the List.

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the first object in the List.

   FUNCTION somfLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the last object in the List.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END somf_TPrimitiveLinkedList; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TPrimitiveLinkedList IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfCount : SOM.somMToken;
      somfRemove : SOM.somMToken;
      somfRemoveAll : SOM.somMToken;
      somfRemoveFirst : SOM.somMToken;
      somfRemoveLast : SOM.somMToken;
      somfAddBefore : SOM.somMToken;
      somfAddAfter : SOM.somMToken;
      somfAddFirst : SOM.somMToken;
      somfAddLast : SOM.somMToken;
      somfAfter : SOM.somMToken;
      somfBefore : SOM.somMToken;
      somfFirst : SOM.somMToken;
      somfLast : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TPrimitiveLinkedListClassData : classData;
   FOR somf_TPrimitiveLinkedListClassData USE AT standard.system.label("somf_TPrimitiveLinkedListClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TPrimitiveLinkedListCClassData : CClassData;
   FOR somf_TPrimitiveLinkedListCClassData USE AT standard.system.label("somf_TPrimitiveLinkedListCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TPrimitiveLinkedListClassData.classObject) 
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
      FUNCTION somf_TPrimitiveLinkedListNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TPrimitiveLinkedListNewClass);
      PRAGMA interface_information (somf_TPrimitiveLinkedListNewClass, ".somf_TPrimitiveLinkedListNewClass");
   BEGIN
      RETURN somf_TPrimitiveLinkedListNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TPrimitiveLinkedListClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TPrimitiveLinkedListClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfCount (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
     
     -- Return the number of objects in this.
      FUNCTION somf_TPrimitiveLinkedList_somfCount(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfCount);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfCount, ".xsomcall2");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfCount (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListClassData.somfCount);
      RETURN Result;
   END somfCount; 

   PROCEDURE somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      aLink : IN SOM.SOMObjectPtr)
   IS
     
     -- Remove the somf_MLinkable object from the List.
      PROCEDURE somf_TPrimitiveLinkedList_somfRemove(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         aLink : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfRemove);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfRemove, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPrimitiveLinkedList_somfRemove (
         Self.som_object,
         Ev,
         aLink,
         somf_TPrimitiveLinkedListClassData.somfRemove);
   END somfRemove;

   PROCEDURE somfRemoveAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the objects from this.
      PROCEDURE somf_TPrimitiveLinkedList_somfRemoveAll(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfRemoveAll);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfRemoveAll, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPrimitiveLinkedList_somfRemoveAll (
         Self.som_object,
         Ev,
         somf_TPrimitiveLinkedListClassData.somfRemoveAll);
   END somfRemoveAll;

   FUNCTION somfRemoveFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the first object in the List.
      FUNCTION somf_TPrimitiveLinkedList_somfRemoveFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfRemoveFirst);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfRemoveFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfRemoveFirst (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListClassData.somfRemoveFirst);
      RETURN Result;
   END somfRemoveFirst; 

   FUNCTION somfRemoveLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove the last object in the List.
      FUNCTION somf_TPrimitiveLinkedList_somfRemoveLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfRemoveLast);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfRemoveLast, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfRemoveLast (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListClassData.somfRemoveLast);
      RETURN Result;
   END somfRemoveLast; 

   PROCEDURE somfAddBefore (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      existing : IN SOM.SOMObjectPtr; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object into the List before the existing object.
      PROCEDURE somf_TPrimitiveLinkedList_somfAddBefore(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         existing : IN SOM.SOMObjectPtr; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfAddBefore);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfAddBefore, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPrimitiveLinkedList_somfAddBefore (
         Self.som_object,
         Ev,
         existing,
         obj,
         somf_TPrimitiveLinkedListClassData.somfAddBefore);
   END somfAddBefore;

   PROCEDURE somfAddAfter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      existing : IN SOM.SOMObjectPtr; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object into the List after the existing object.
      PROCEDURE somf_TPrimitiveLinkedList_somfAddAfter(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         existing : IN SOM.SOMObjectPtr; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfAddAfter);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfAddAfter, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPrimitiveLinkedList_somfAddAfter (
         Self.som_object,
         Ev,
         existing,
         obj,
         somf_TPrimitiveLinkedListClassData.somfAddAfter);
   END somfAddAfter;

   PROCEDURE somfAddFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object as the first object in the List.
      PROCEDURE somf_TPrimitiveLinkedList_somfAddFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfAddFirst);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfAddFirst, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPrimitiveLinkedList_somfAddFirst (
         Self.som_object,
         Ev,
         obj,
         somf_TPrimitiveLinkedListClassData.somfAddFirst);
   END somfAddFirst;

   PROCEDURE somfAddLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
   IS
     
     -- Add the obj object as the last object in the List.
      PROCEDURE somf_TPrimitiveLinkedList_somfAddLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfAddLast);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfAddLast, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TPrimitiveLinkedList_somfAddLast (
         Self.som_object,
         Ev,
         obj,
         somf_TPrimitiveLinkedListClassData.somfAddLast);
   END somfAddLast;

   FUNCTION somfAfter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      existingobj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the object that comes after the existingobj object in the List.
      FUNCTION somf_TPrimitiveLinkedList_somfAfter(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         existingobj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfAfter);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfAfter, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfAfter (
            Self.som_object,
            Ev,
            existingobj,
            somf_TPrimitiveLinkedListClassData.somfAfter);
      RETURN Result;
   END somfAfter; 

   FUNCTION somfBefore (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      existingobj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the object that comes before the existingobj object in the List.
      FUNCTION somf_TPrimitiveLinkedList_somfBefore(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         existingobj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfBefore);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfBefore, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfBefore (
            Self.som_object,
            Ev,
            existingobj,
            somf_TPrimitiveLinkedListClassData.somfBefore);
      RETURN Result;
   END somfBefore; 

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the first object in the List.
      FUNCTION somf_TPrimitiveLinkedList_somfFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfFirst);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfFirst (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListClassData.somfFirst);
      RETURN Result;
   END somfFirst; 

   FUNCTION somfLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the last object in the List.
      FUNCTION somf_TPrimitiveLinkedList_somfLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedList_somfLast);
      PRAGMA interface_information (somf_TPrimitiveLinkedList_somfLast, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedList_somfLast (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListClassData.somfLast);
      RETURN Result;
   END somfLast; 

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

END somf_TPrimitiveLinkedList; 







