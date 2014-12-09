
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:57 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_MCollectible;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TCollection IS


   TYPE Ref IS NEW somf_MCollectible.Ref WITH NULL RECORD;

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
      

   kCollectionSizeHint : CONSTANT Corba.Long := 8;


   FUNCTION somfAdd (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Add obj to this.

   PROCEDURE somfAddAll (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      col : IN SOM.SOMObjectPtr);
     
     -- Add all of the objects in collection to this.  Essentially this is
     -- equivalent to getting an iterator for the collection passed in and adding
     -- each element in the collection to this.

   FUNCTION somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove obj from this.  Return the object which was actually removed
     -- (which if you are using an IsEqual test function may not be the same as the
     -- object passed in only "equal")

   PROCEDURE somfRemoveAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the objects from this.

   PROCEDURE somfDeleteAll (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the objects from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).

   FUNCTION somfCount (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Return the number of objects in this.

   FUNCTION somfMember (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Each object in this is compared to obj using the function testFn.  Return the
     -- object for which testFn returned TRUE.  Return SOMF_NIL if not object was found.

   FUNCTION somfCreateIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns a new iterator which is suitable for use in iterating
     -- over the objects in this collection.

   FUNCTION somfTestFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleCompareFn;
     
     -- Return the test function.  This is usually either IsSame or IsEqual.

   PROCEDURE somfSetTestFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn);
     
     -- Set the test function.

   FUNCTION somfTCollectionInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the somf_TCollection test function to testfn.

   FUNCTION somfIsEqual (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

END somf_TCollection; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TCollection IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfAdd : SOM.somMToken;
      somfAddAll : SOM.somMToken;
      somfRemove : SOM.somMToken;
      somfRemoveAll : SOM.somMToken;
      somfDeleteAll : SOM.somMToken;
      somfCount : SOM.somMToken;
      somfMember : SOM.somMToken;
      somfCreateIterator : SOM.somMToken;
      somfTestFunction : SOM.somMToken;
      somfSetTestFunction : SOM.somMToken;
      somfTCollectionInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TCollectionClassData : classData;
   FOR somf_TCollectionClassData USE AT standard.system.label("somf_TCollectionClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TCollectionCClassData : CClassData;
   FOR somf_TCollectionCClassData USE AT standard.system.label("somf_TCollectionCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TCollectionClassData.classObject) 
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
      FUNCTION somf_TCollectionNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TCollectionNewClass);
      PRAGMA interface_information (somf_TCollectionNewClass, ".somf_TCollectionNewClass");
   BEGIN
      RETURN somf_TCollectionNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TCollectionClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TCollectionClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfAdd (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Add obj to this.
      FUNCTION somf_TCollection_somfAdd(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TCollection_somfAdd);
      PRAGMA interface_information (somf_TCollection_somfAdd, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfAdd (
            Self.som_object,
            Ev,
            obj,
            somf_TCollectionClassData.somfAdd);
      RETURN Result;
   END somfAdd; 

   PROCEDURE somfAddAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      col : IN SOM.SOMObjectPtr)
   IS
     
     -- Add all of the objects in collection to this.  Essentially this is
     -- equivalent to getting an iterator for the collection passed in and adding
     -- each element in the collection to this.
      PROCEDURE somf_TCollection_somfAddAll(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         col : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TCollection_somfAddAll);
      PRAGMA interface_information (somf_TCollection_somfAddAll, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollection_somfAddAll (
         Self.som_object,
         Ev,
         col,
         somf_TCollectionClassData.somfAddAll);
   END somfAddAll;

   FUNCTION somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove obj from this.  Return the object which was actually removed
     -- (which if you are using an IsEqual test function may not be the same as the
     -- object passed in only "equal")
      FUNCTION somf_TCollection_somfRemove(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TCollection_somfRemove);
      PRAGMA interface_information (somf_TCollection_somfRemove, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfRemove (
            Self.som_object,
            Ev,
            obj,
            somf_TCollectionClassData.somfRemove);
      RETURN Result;
   END somfRemove; 

   PROCEDURE somfRemoveAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the objects from this.
      PROCEDURE somf_TCollection_somfRemoveAll(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TCollection_somfRemoveAll);
      PRAGMA interface_information (somf_TCollection_somfRemoveAll, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollection_somfRemoveAll (
         Self.som_object,
         Ev,
         somf_TCollectionClassData.somfRemoveAll);
   END somfRemoveAll;

   PROCEDURE somfDeleteAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the objects from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).
      PROCEDURE somf_TCollection_somfDeleteAll(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TCollection_somfDeleteAll);
      PRAGMA interface_information (somf_TCollection_somfDeleteAll, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollection_somfDeleteAll (
         Self.som_object,
         Ev,
         somf_TCollectionClassData.somfDeleteAll);
   END somfDeleteAll;

   FUNCTION somfCount (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Return the number of objects in this.
      FUNCTION somf_TCollection_somfCount(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_TCollection_somfCount);
      PRAGMA interface_information (somf_TCollection_somfCount, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfCount (
            Self.som_object,
            Ev,
            somf_TCollectionClassData.somfCount);
      RETURN Result;
   END somfCount; 

   FUNCTION somfMember (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Each object in this is compared to obj using the function testFn.  Return the
     -- object for which testFn returned TRUE.  Return SOMF_NIL if not object was found.
      FUNCTION somf_TCollection_somfMember(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TCollection_somfMember);
      PRAGMA interface_information (somf_TCollection_somfMember, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfMember (
            Self.som_object,
            Ev,
            obj,
            somf_TCollectionClassData.somfMember);
      RETURN Result;
   END somfMember; 

   FUNCTION somfCreateIterator (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns a new iterator which is suitable for use in iterating
     -- over the objects in this collection.
      FUNCTION somf_TCollection_somfCreateIterator(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TCollection_somfCreateIterator);
      PRAGMA interface_information (somf_TCollection_somfCreateIterator, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfCreateIterator (
            Self.som_object,
            Ev,
            somf_TCollectionClassData.somfCreateIterator);
      RETURN Result;
   END somfCreateIterator; 

   FUNCTION somfTestFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleCompareFn
   IS
     
     -- Return the test function.  This is usually either IsSame or IsEqual.
      FUNCTION somf_TCollection_somfTestFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MCollectible.somf_MCollectibleCompareFn; 
      PRAGMA interface (assembly, somf_TCollection_somfTestFunction);
      PRAGMA interface_information (somf_TCollection_somfTestFunction, ".xsomcall2");
      Result : ALIASED somf_MCollectible.somf_MCollectibleCompareFn;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfTestFunction (
            Self.som_object,
            Ev,
            somf_TCollectionClassData.somfTestFunction);
      RETURN Result;
   END somfTestFunction; 

   PROCEDURE somfSetTestFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
   IS
     
     -- Set the test function.
      PROCEDURE somf_TCollection_somfSetTestFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TCollection_somfSetTestFunction);
      PRAGMA interface_information (somf_TCollection_somfSetTestFunction, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TCollection_somfSetTestFunction (
         Self.som_object,
         Ev,
         testfn,
         somf_TCollectionClassData.somfSetTestFunction);
   END somfSetTestFunction;

   FUNCTION somfTCollectionInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the somf_TCollection test function to testfn.
      FUNCTION somf_TCollection_somfTCollectionInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TCollection_somfTCollectionInit);
      PRAGMA interface_information (somf_TCollection_somfTCollectionInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TCollection_somfTCollectionInit (
            Self.som_object,
            Ev,
            testfn,
            somf_TCollectionClassData.somfTCollectionInit);
      RETURN Result;
   END somfTCollectionInit; 

   FUNCTION somfIsEqual (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_MCollectible.somfIsEqual (
            somf_MCollectible.Ref'(som_object=>Self.som_object),
            Ev,
            obj);
   END somfIsEqual;

END somf_TCollection; 







