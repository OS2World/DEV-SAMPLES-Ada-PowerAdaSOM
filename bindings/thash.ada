
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:02 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_MCollectible;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_THashTable IS


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
      

   kDefaultHashTableSize : CONSTANT Corba.Long := 23;

   kDefaultGrowthRate : CONSTANT Corba.Long := 20;

   kDefaultRehashThreshold : CONSTANT Corba.Long := 80;

   TYPE ETableClassification IS (kUnchecked, kNormal, kFast);
   FOR ETableClassification USE (
      kUnchecked => 1,
      kNormal => 2,
      kFast => 3 );


   FUNCTION somfTHashTableInitFLLL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      tablesize : IN Corba.Long;
      rate : IN Corba.Long;
      threshold : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new hash table.

   FUNCTION somfTHashTableInitFLL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      tablesize : IN Corba.Long;
      rate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new hash table.

   FUNCTION somfTHashTableInitFL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      tablesize : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new hash table.

   FUNCTION somfTHashTableInitH (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new hash table.

   PROCEDURE somfAssign (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      source : IN SOM.SOMObjectPtr);
     
     -- Assign the instance of this equal to the instance of source.

   FUNCTION somfCount (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Return the number of objects in this.

   FUNCTION somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove obj from this.  Return the object which was actually removed
     -- (which if you are using an IsSame test function may not be the same
     -- as the object passed in only "equal").

   FUNCTION somfDelete (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Remove key from this and deallocate the storage that these objects might
     -- have owned (that is, the destructor function is called for each object
     -- in the collection).  Return the object which was actually removed (which
     -- if you are using an IsSame test function may not be the same as the object
     -- passed in only "equal").

   FUNCTION somfMember (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Each object in this is compared to obj using the function testFn.  Return the
     -- object for which testFn returned TRUE.  Return SOMF_NIL if not object was found.

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

   PROCEDURE somfDeleteAllKeys (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the keys from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).

   PROCEDURE somfDeleteAllValues (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the values from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).

   FUNCTION somfAddMMB (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr;
      value : IN SOM.SOMObjectPtr;
      replace : IN Corba.Boolean)
      RETURN SOM.SOMObjectPtr;
     
     -- Add key and value to this.  If replace = TRUE, replace a copy if it already
     -- exists.

   FUNCTION somfAddMM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr;
      value : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Add key and value to this.  Replace a copy if it already exists.

   PROCEDURE somfGrow (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Grow the Hash Table

   FUNCTION somfRetrieve (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Retrieve and return the value associated with key.

   PROCEDURE somfSetGrowthRate (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      rate : IN Corba.Long);
     
     -- Set the growth rate of the hash table.

   PROCEDURE somfSetRehashThreshold (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      threshold : IN Corba.Long);
     
     -- Set the rehash threshold of the hash table.

   FUNCTION somfGetGrowthRate (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Return the growth rate of the hash table.

   FUNCTION somfGetRehashThreshold (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Return the rehash threshold of the hash table.

   PROCEDURE somfSetHashFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      fn : IN somf_MCollectible.somf_MCollectibleHashFn);
     
     -- Set the hash function to fn.

   FUNCTION somfGetHashFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleHashFn;
     
     -- Return the hash function.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END somf_THashTable; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_THashTable IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfCount : SOM.somMToken;
      somfRemove : SOM.somMToken;
      somfDelete : SOM.somMToken;
      somfMember : SOM.somMToken;
      somfRemoveAll : SOM.somMToken;
      somfDeleteAll : SOM.somMToken;
      somfDeleteAllKeys : SOM.somMToken;
      somfDeleteAllValues : SOM.somMToken;
      somfAddMMB : SOM.somMToken;
      somfAddMM : SOM.somMToken;
      somfGrow : SOM.somMToken;
      somfRetrieve : SOM.somMToken;
      somfSetGrowthRate : SOM.somMToken;
      somfSetRehashThreshold : SOM.somMToken;
      somfGetGrowthRate : SOM.somMToken;
      somfGetRehashThreshold : SOM.somMToken;
      somfSetHashFunction : SOM.somMToken;
      somfGetHashFunction : SOM.somMToken;
      somfFind : SOM.somMToken;
      somfMakeNewTable : SOM.somMToken;
      somfCopyIn : SOM.somMToken;
      somfAssign : SOM.somMToken;
      somfTHashTableInitFLLL : SOM.somMToken;
      somfTHashTableInitFLL : SOM.somMToken;
      somfTHashTableInitFL : SOM.somMToken;
      somfTHashTableInitH : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_THashTableClassData : classData;
   FOR somf_THashTableClassData USE AT standard.system.label("somf_THashTableClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_THashTableCClassData : CClassData;
   FOR somf_THashTableCClassData USE AT standard.system.label("somf_THashTableCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_THashTableClassData.classObject) 
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
      FUNCTION somf_THashTableNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_THashTableNewClass);
      PRAGMA interface_information (somf_THashTableNewClass, ".somf_THashTableNewClass");
   BEGIN
      RETURN somf_THashTableNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_THashTableClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_THashTableClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTHashTableInitFLLL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      tablesize : IN Corba.Long; 
      rate : IN Corba.Long; 
      threshold : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new hash table.
      FUNCTION somf_THashTable_somfTHashTableInitFLLL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         tablesize : IN Corba.Long; 
         rate : IN Corba.Long; 
         threshold : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfTHashTableInitFLLL);
      PRAGMA interface_information (somf_THashTable_somfTHashTableInitFLLL, ".xsomcall6");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfTHashTableInitFLLL (
            Self.som_object,
            Ev,
            testfn,
            tablesize,
            rate,
            threshold,
            somf_THashTableClassData.somfTHashTableInitFLLL);
      RETURN Result;
   END somfTHashTableInitFLLL; 

   FUNCTION somfTHashTableInitFLL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      tablesize : IN Corba.Long; 
      rate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new hash table.
      FUNCTION somf_THashTable_somfTHashTableInitFLL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         tablesize : IN Corba.Long; 
         rate : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfTHashTableInitFLL);
      PRAGMA interface_information (somf_THashTable_somfTHashTableInitFLL, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfTHashTableInitFLL (
            Self.som_object,
            Ev,
            testfn,
            tablesize,
            rate,
            somf_THashTableClassData.somfTHashTableInitFLL);
      RETURN Result;
   END somfTHashTableInitFLL; 

   FUNCTION somfTHashTableInitFL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      tablesize : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new hash table.
      FUNCTION somf_THashTable_somfTHashTableInitFL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         tablesize : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfTHashTableInitFL);
      PRAGMA interface_information (somf_THashTable_somfTHashTableInitFL, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfTHashTableInitFL (
            Self.som_object,
            Ev,
            testfn,
            tablesize,
            somf_THashTableClassData.somfTHashTableInitFL);
      RETURN Result;
   END somfTHashTableInitFL; 

   FUNCTION somfTHashTableInitH (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new hash table.
      FUNCTION somf_THashTable_somfTHashTableInitH(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         h : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfTHashTableInitH);
      PRAGMA interface_information (somf_THashTable_somfTHashTableInitH, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfTHashTableInitH (
            Self.som_object,
            Ev,
            h,
            somf_THashTableClassData.somfTHashTableInitH);
      RETURN Result;
   END somfTHashTableInitH; 

   PROCEDURE somfAssign (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      source : IN SOM.SOMObjectPtr)
   IS
     
     -- Assign the instance of this equal to the instance of source.
      PROCEDURE somf_THashTable_somfAssign(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         source : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfAssign);
      PRAGMA interface_information (somf_THashTable_somfAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfAssign (
         Self.som_object,
         Ev,
         source,
         somf_THashTableClassData.somfAssign);
   END somfAssign;

   FUNCTION somfCount (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Return the number of objects in this.
      FUNCTION somf_THashTable_somfCount(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_THashTable_somfCount);
      PRAGMA interface_information (somf_THashTable_somfCount, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfCount (
            Self.som_object,
            Ev,
            somf_THashTableClassData.somfCount);
      RETURN Result;
   END somfCount; 

   FUNCTION somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove obj from this.  Return the object which was actually removed
     -- (which if you are using an IsSame test function may not be the same
     -- as the object passed in only "equal").
      FUNCTION somf_THashTable_somfRemove(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfRemove);
      PRAGMA interface_information (somf_THashTable_somfRemove, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfRemove (
            Self.som_object,
            Ev,
            key,
            somf_THashTableClassData.somfRemove);
      RETURN Result;
   END somfRemove; 

   FUNCTION somfDelete (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Remove key from this and deallocate the storage that these objects might
     -- have owned (that is, the destructor function is called for each object
     -- in the collection).  Return the object which was actually removed (which
     -- if you are using an IsSame test function may not be the same as the object
     -- passed in only "equal").
      FUNCTION somf_THashTable_somfDelete(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfDelete);
      PRAGMA interface_information (somf_THashTable_somfDelete, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfDelete (
            Self.som_object,
            Ev,
            key,
            somf_THashTableClassData.somfDelete);
      RETURN Result;
   END somfDelete; 

   FUNCTION somfMember (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Each object in this is compared to obj using the function testFn.  Return the
     -- object for which testFn returned TRUE.  Return SOMF_NIL if not object was found.
      FUNCTION somf_THashTable_somfMember(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfMember);
      PRAGMA interface_information (somf_THashTable_somfMember, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfMember (
            Self.som_object,
            Ev,
            key,
            somf_THashTableClassData.somfMember);
      RETURN Result;
   END somfMember; 

   PROCEDURE somfRemoveAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the objects from this.
      PROCEDURE somf_THashTable_somfRemoveAll(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfRemoveAll);
      PRAGMA interface_information (somf_THashTable_somfRemoveAll, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfRemoveAll (
         Self.som_object,
         Ev,
         somf_THashTableClassData.somfRemoveAll);
   END somfRemoveAll;

   PROCEDURE somfDeleteAll (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the objects from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).
      PROCEDURE somf_THashTable_somfDeleteAll(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfDeleteAll);
      PRAGMA interface_information (somf_THashTable_somfDeleteAll, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfDeleteAll (
         Self.som_object,
         Ev,
         somf_THashTableClassData.somfDeleteAll);
   END somfDeleteAll;

   PROCEDURE somfDeleteAllKeys (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the keys from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).
      PROCEDURE somf_THashTable_somfDeleteAllKeys(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfDeleteAllKeys);
      PRAGMA interface_information (somf_THashTable_somfDeleteAllKeys, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfDeleteAllKeys (
         Self.som_object,
         Ev,
         somf_THashTableClassData.somfDeleteAllKeys);
   END somfDeleteAllKeys;

   PROCEDURE somfDeleteAllValues (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the values from this and deallocate the storage that these
     -- objects might have owned (that is, the destructor function is called
     -- for each object in the collection).
      PROCEDURE somf_THashTable_somfDeleteAllValues(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfDeleteAllValues);
      PRAGMA interface_information (somf_THashTable_somfDeleteAllValues, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfDeleteAllValues (
         Self.som_object,
         Ev,
         somf_THashTableClassData.somfDeleteAllValues);
   END somfDeleteAllValues;

   FUNCTION somfAddMMB (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr; 
      value : IN SOM.SOMObjectPtr; 
      replace : IN Corba.Boolean)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Add key and value to this.  If replace = TRUE, replace a copy if it already
     -- exists.
      FUNCTION somf_THashTable_somfAddMMB(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr; 
         value : IN SOM.SOMObjectPtr; 
         replace : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfAddMMB);
      PRAGMA interface_information (somf_THashTable_somfAddMMB, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfAddMMB (
            Self.som_object,
            Ev,
            key,
            value,
            replace,
            somf_THashTableClassData.somfAddMMB);
      RETURN Result;
   END somfAddMMB; 

   FUNCTION somfAddMM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr; 
      value : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Add key and value to this.  Replace a copy if it already exists.
      FUNCTION somf_THashTable_somfAddMM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr; 
         value : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfAddMM);
      PRAGMA interface_information (somf_THashTable_somfAddMM, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfAddMM (
            Self.som_object,
            Ev,
            key,
            value,
            somf_THashTableClassData.somfAddMM);
      RETURN Result;
   END somfAddMM; 

   PROCEDURE somfGrow (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Grow the Hash Table
      PROCEDURE somf_THashTable_somfGrow(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfGrow);
      PRAGMA interface_information (somf_THashTable_somfGrow, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfGrow (
         Self.som_object,
         Ev,
         somf_THashTableClassData.somfGrow);
   END somfGrow;

   FUNCTION somfRetrieve (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Retrieve and return the value associated with key.
      FUNCTION somf_THashTable_somfRetrieve(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_THashTable_somfRetrieve);
      PRAGMA interface_information (somf_THashTable_somfRetrieve, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfRetrieve (
            Self.som_object,
            Ev,
            key,
            somf_THashTableClassData.somfRetrieve);
      RETURN Result;
   END somfRetrieve; 

   PROCEDURE somfSetGrowthRate (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      rate : IN Corba.Long)
   IS
     
     -- Set the growth rate of the hash table.
      PROCEDURE somf_THashTable_somfSetGrowthRate(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         rate : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfSetGrowthRate);
      PRAGMA interface_information (somf_THashTable_somfSetGrowthRate, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfSetGrowthRate (
         Self.som_object,
         Ev,
         rate,
         somf_THashTableClassData.somfSetGrowthRate);
   END somfSetGrowthRate;

   PROCEDURE somfSetRehashThreshold (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      threshold : IN Corba.Long)
   IS
     
     -- Set the rehash threshold of the hash table.
      PROCEDURE somf_THashTable_somfSetRehashThreshold(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         threshold : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfSetRehashThreshold);
      PRAGMA interface_information (somf_THashTable_somfSetRehashThreshold, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfSetRehashThreshold (
         Self.som_object,
         Ev,
         threshold,
         somf_THashTableClassData.somfSetRehashThreshold);
   END somfSetRehashThreshold;

   FUNCTION somfGetGrowthRate (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Return the growth rate of the hash table.
      FUNCTION somf_THashTable_somfGetGrowthRate(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_THashTable_somfGetGrowthRate);
      PRAGMA interface_information (somf_THashTable_somfGetGrowthRate, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfGetGrowthRate (
            Self.som_object,
            Ev,
            somf_THashTableClassData.somfGetGrowthRate);
      RETURN Result;
   END somfGetGrowthRate; 

   FUNCTION somfGetRehashThreshold (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Return the rehash threshold of the hash table.
      FUNCTION somf_THashTable_somfGetRehashThreshold(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, somf_THashTable_somfGetRehashThreshold);
      PRAGMA interface_information (somf_THashTable_somfGetRehashThreshold, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfGetRehashThreshold (
            Self.som_object,
            Ev,
            somf_THashTableClassData.somfGetRehashThreshold);
      RETURN Result;
   END somfGetRehashThreshold; 

   PROCEDURE somfSetHashFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      fn : IN somf_MCollectible.somf_MCollectibleHashFn)
   IS
     
     -- Set the hash function to fn.
      PROCEDURE somf_THashTable_somfSetHashFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         fn : IN somf_MCollectible.somf_MCollectibleHashFn;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_THashTable_somfSetHashFunction);
      PRAGMA interface_information (somf_THashTable_somfSetHashFunction, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_THashTable_somfSetHashFunction (
         Self.som_object,
         Ev,
         fn,
         somf_THashTableClassData.somfSetHashFunction);
   END somfSetHashFunction;

   FUNCTION somfGetHashFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleHashFn
   IS
     
     -- Return the hash function.
      FUNCTION somf_THashTable_somfGetHashFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MCollectible.somf_MCollectibleHashFn; 
      PRAGMA interface (assembly, somf_THashTable_somfGetHashFunction);
      PRAGMA interface_information (somf_THashTable_somfGetHashFunction, ".xsomcall2");
      Result : ALIASED somf_MCollectible.somf_MCollectibleHashFn;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_THashTable_somfGetHashFunction (
            Self.som_object,
            Ev,
            somf_THashTableClassData.somfGetHashFunction);
      RETURN Result;
   END somfGetHashFunction; 

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

END somf_THashTable; 







