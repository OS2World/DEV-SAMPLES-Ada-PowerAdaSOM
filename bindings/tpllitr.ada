
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

PACKAGE somf_TPrimitiveLinkedListIterator IS


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
      


   FUNCTION somfTPrimitiveLinkedListIteratorInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      list : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize somf_TPrimitiveLinkedListIterator using somf_TPrimitiveLinkedList list.

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Reset the iterator and return the first element of the list.

   FUNCTION somfNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Retrieve the next object in the list and return it.

   FUNCTION somfLast (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Retrieve the last object in the list and return it.

   FUNCTION somfPrevious (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Retrieve the previous object in the list and return it.

   PROCEDURE somUninit (
      Self : IN Ref);

END somf_TPrimitiveLinkedListIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TPrimitiveLinkedListIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfFirst : SOM.somMToken;
      somfNext : SOM.somMToken;
      somfLast : SOM.somMToken;
      somfPrevious : SOM.somMToken;
      somfTPrimitiveLinkedListIteratorInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TPrimitiveLinkedListIteratorClassData : classData;
   FOR somf_TPrimitiveLinkedListIteratorClassData USE AT standard.system.label("somf_TPrimitiveLinkedListIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TPrimitiveLinkedListIteratorCClassData : CClassData;
   FOR somf_TPrimitiveLinkedListIteratorCClassData USE AT standard.system.label("somf_TPrimitiveLinkedListIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TPrimitiveLinkedListIteratorClassData.classObject) 
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
      FUNCTION somf_TPrimitiveLinkedListIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TPrimitiveLinkedListIteratorNewClass);
      PRAGMA interface_information (somf_TPrimitiveLinkedListIteratorNewClass, ".somf_TPrimitiveLinkedListIteratorNewClass");
   BEGIN
      RETURN somf_TPrimitiveLinkedListIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TPrimitiveLinkedListIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TPrimitiveLinkedListIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTPrimitiveLinkedListIteratorInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      list : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize somf_TPrimitiveLinkedListIterator using somf_TPrimitiveLinkedList list.
      FUNCTION somf_TPrimitiveLinkedListIterator_somfTPrimitiveLinkedListIteratorInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         list : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedListIterator_somfTPrimitiveLinkedListIteratorInit);
      PRAGMA interface_information (somf_TPrimitiveLinkedListIterator_somfTPrimitiveLinkedListIteratorInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedListIterator_somfTPrimitiveLinkedListIteratorInit (
            Self.som_object,
            Ev,
            list,
            somf_TPrimitiveLinkedListIteratorClassData.somfTPrimitiveLinkedListIteratorInit);
      RETURN Result;
   END somfTPrimitiveLinkedListIteratorInit; 

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Reset the iterator and return the first element of the list.
      FUNCTION somf_TPrimitiveLinkedListIterator_somfFirst(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedListIterator_somfFirst);
      PRAGMA interface_information (somf_TPrimitiveLinkedListIterator_somfFirst, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedListIterator_somfFirst (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListIteratorClassData.somfFirst);
      RETURN Result;
   END somfFirst; 

   FUNCTION somfNext (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Retrieve the next object in the list and return it.
      FUNCTION somf_TPrimitiveLinkedListIterator_somfNext(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedListIterator_somfNext);
      PRAGMA interface_information (somf_TPrimitiveLinkedListIterator_somfNext, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedListIterator_somfNext (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListIteratorClassData.somfNext);
      RETURN Result;
   END somfNext; 

   FUNCTION somfLast (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Retrieve the last object in the list and return it.
      FUNCTION somf_TPrimitiveLinkedListIterator_somfLast(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedListIterator_somfLast);
      PRAGMA interface_information (somf_TPrimitiveLinkedListIterator_somfLast, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedListIterator_somfLast (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListIteratorClassData.somfLast);
      RETURN Result;
   END somfLast; 

   FUNCTION somfPrevious (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Retrieve the previous object in the list and return it.
      FUNCTION somf_TPrimitiveLinkedListIterator_somfPrevious(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TPrimitiveLinkedListIterator_somfPrevious);
      PRAGMA interface_information (somf_TPrimitiveLinkedListIterator_somfPrevious, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TPrimitiveLinkedListIterator_somfPrevious (
            Self.som_object,
            Ev,
            somf_TPrimitiveLinkedListIteratorClassData.somfPrevious);
      RETURN Result;
   END somfPrevious; 

   PROCEDURE somUninit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somUninit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somUninit;

END somf_TPrimitiveLinkedListIterator; 







