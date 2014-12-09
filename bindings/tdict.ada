
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:01 1997
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

PACKAGE somf_TDictionary IS


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
      


   FUNCTION somfTDictionaryInitFLL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      sizeHint : IN Corba.Long;
      growthRate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   FUNCTION somfTDictionaryInitFL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      sizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   FUNCTION somfTDictionaryInitF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   FUNCTION somfTDictionaryInitLLF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sizeHint : IN Corba.Long;
      growthRate : IN Corba.Long;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   FUNCTION somfTDictionaryInitLL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sizeHint : IN Corba.Long;
      growthRate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   FUNCTION somfTDictionaryInitL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   FUNCTION somfTDictionaryInitD (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      dictionary : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary.

   PROCEDURE somfAssign (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      source : IN SOM.SOMObjectPtr);
     
     -- Assign the instance of this equal to the instance of source.

   PROCEDURE somfDeleteAllKeys (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the entries in the dictionary.  Reset the count to be zero.
     -- Call the destructor on every key in the dictionary.

   PROCEDURE somfDeleteAllValues (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Remove all of the entries in the dictionary.  Reset the count to be zero.
     -- Call the destructor on every value in the hash table.  If you have a value
     -- which appears more than once, you will be sorry you used this method because
     -- the utility classes will delete the same object more than once.  This
     -- is not good.

   FUNCTION somfValueAt (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the value associated with the key.  Return SOMF_NIL if the key could not
     -- be found.

   FUNCTION somfKeyAtMF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      val : IN SOM.SOMObjectPtr;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the first key found which has val as its value.  This involves a slow
     -- search.

   FUNCTION somfKeyAtM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      val : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the first key found which has val as its value.  This involves a slow
     -- search. This method uses the same compare function as specified in
     -- the constructor.

   FUNCTION somfDeleteKey (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Delete the key from the key,value pair associated with key and remove the
     -- key,value pair from the dictionary.  Return the value that was removed
     -- as a result of this call.

   FUNCTION somfAddKeyValuePairMMB (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr;
      val : IN SOM.SOMObjectPtr;
      replace : IN Corba.Boolean)
      RETURN SOM.SOMObjectPtr;
     
     -- If replace = FALSE, then only add key,value pair to the table if there is not
     -- an existing key,value pair.  Otherwise, if replace=TRUE, add the key,value
     -- pair to the hash table.  Either way, return the key that existed (if any) in
     -- the hash table before this call.  Proper memory management may involve
     -- checking to see if the key returned is "the same" as the key passes in when
     -- replacing key,value pairs.

   FUNCTION somfAddKeyValuePairMM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      key : IN SOM.SOMObjectPtr;
      val : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Add the key,value pair to the hash table, and return the key that existed
     -- (if any) in the hash table before this call.  Proper memory management may
     -- involve checking to see if the key returned is "the same" as the key passes
     -- in when replacing key,value pairs.

   PROCEDURE somfSetHashFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      fn : IN somf_MCollectible.somf_MCollectibleHashFn);
     
     -- Set the hash function to fn.  By default this is set to MCollectible's Hash
     -- (which is usually overridden in the objects you are adding to the hash
     -- table).  You can use any hash function that you like as long as it has the
     -- type signature of somf_MCollectibleHashFn.  Most of the time, you won't need to
     -- do this.

   FUNCTION somfGetHashFunction (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleHashFn;
     
     -- Return the hash function.

   FUNCTION somfCreateNewImplementationFLLL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      tablesize : IN Corba.Long;
      rate : IN Corba.Long;
      threshold : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.

   FUNCTION somfCreateNewImplementationF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.

   FUNCTION somfCreateNewImplementationFL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      tablesize : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.

   FUNCTION somfCreateNewImplementationFLL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      tablesize : IN Corba.Long;
      rate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.

   FUNCTION somfCopyImplementation (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Return a hash table that is a copy of the hash table in this.  Normally you
     -- won't have to do this.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION somfCreateIterator (
      Self : IN Ref;
      Ev : IN SOM.Environment)
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

   FUNCTION somfMember (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfAdd (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;

END somf_TDictionary; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TDictionary IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfDeleteAllKeys : SOM.somMToken;
      somfDeleteAllValues : SOM.somMToken;
      somfValueAt : SOM.somMToken;
      somfKeyAtMF : SOM.somMToken;
      somfKeyAtM : SOM.somMToken;
      somfDeleteKey : SOM.somMToken;
      somfAddKeyValuePairMMB : SOM.somMToken;
      somfAddKeyValuePairMM : SOM.somMToken;
      somfSetHashFunction : SOM.somMToken;
      somfGetHashFunction : SOM.somMToken;
      somfCreateNewImplementationFLLL : SOM.somMToken;
      somfCreateNewImplementationF : SOM.somMToken;
      somfCreateNewImplementationFL : SOM.somMToken;
      somfCreateNewImplementationFLL : SOM.somMToken;
      somfCopyImplementation : SOM.somMToken;
      somfAssign : SOM.somMToken;
      somfTDictionaryInitFLL : SOM.somMToken;
      somfTDictionaryInitFL : SOM.somMToken;
      somfTDictionaryInitF : SOM.somMToken;
      somfTDictionaryInitLLF : SOM.somMToken;
      somfTDictionaryInitLL : SOM.somMToken;
      somfTDictionaryInitL : SOM.somMToken;
      somfTDictionaryInitD : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TDictionaryClassData : classData;
   FOR somf_TDictionaryClassData USE AT standard.system.label("somf_TDictionaryClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TDictionaryCClassData : CClassData;
   FOR somf_TDictionaryCClassData USE AT standard.system.label("somf_TDictionaryCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TDictionaryClassData.classObject) 
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
      FUNCTION somf_TDictionaryNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TDictionaryNewClass);
      PRAGMA interface_information (somf_TDictionaryNewClass, ".somf_TDictionaryNewClass");
   BEGIN
      RETURN somf_TDictionaryNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TDictionaryClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TDictionaryClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTDictionaryInitFLL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      sizeHint : IN Corba.Long; 
      growthRate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitFLL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         sizeHint : IN Corba.Long; 
         growthRate : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitFLL);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitFLL, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitFLL (
            Self.som_object,
            Ev,
            testfn,
            sizeHint,
            growthRate,
            somf_TDictionaryClassData.somfTDictionaryInitFLL);
      RETURN Result;
   END somfTDictionaryInitFLL; 

   FUNCTION somfTDictionaryInitFL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      sizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitFL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         sizeHint : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitFL);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitFL, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitFL (
            Self.som_object,
            Ev,
            testfn,
            sizeHint,
            somf_TDictionaryClassData.somfTDictionaryInitFL);
      RETURN Result;
   END somfTDictionaryInitFL; 

   FUNCTION somfTDictionaryInitF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitF);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitF, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitF (
            Self.som_object,
            Ev,
            testfn,
            somf_TDictionaryClassData.somfTDictionaryInitF);
      RETURN Result;
   END somfTDictionaryInitF; 

   FUNCTION somfTDictionaryInitLLF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sizeHint : IN Corba.Long; 
      growthRate : IN Corba.Long; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitLLF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sizeHint : IN Corba.Long; 
         growthRate : IN Corba.Long; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitLLF);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitLLF, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitLLF (
            Self.som_object,
            Ev,
            sizeHint,
            growthRate,
            testfn,
            somf_TDictionaryClassData.somfTDictionaryInitLLF);
      RETURN Result;
   END somfTDictionaryInitLLF; 

   FUNCTION somfTDictionaryInitLL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sizeHint : IN Corba.Long; 
      growthRate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitLL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sizeHint : IN Corba.Long; 
         growthRate : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitLL);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitLL, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitLL (
            Self.som_object,
            Ev,
            sizeHint,
            growthRate,
            somf_TDictionaryClassData.somfTDictionaryInitLL);
      RETURN Result;
   END somfTDictionaryInitLL; 

   FUNCTION somfTDictionaryInitL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sizeHint : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitL);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitL, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitL (
            Self.som_object,
            Ev,
            sizeHint,
            somf_TDictionaryClassData.somfTDictionaryInitL);
      RETURN Result;
   END somfTDictionaryInitL; 

   FUNCTION somfTDictionaryInitD (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      dictionary : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary.
      FUNCTION somf_TDictionary_somfTDictionaryInitD(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         dictionary : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfTDictionaryInitD);
      PRAGMA interface_information (somf_TDictionary_somfTDictionaryInitD, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfTDictionaryInitD (
            Self.som_object,
            Ev,
            dictionary,
            somf_TDictionaryClassData.somfTDictionaryInitD);
      RETURN Result;
   END somfTDictionaryInitD; 

   PROCEDURE somfAssign (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      source : IN SOM.SOMObjectPtr)
   IS
     
     -- Assign the instance of this equal to the instance of source.
      PROCEDURE somf_TDictionary_somfAssign(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         source : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDictionary_somfAssign);
      PRAGMA interface_information (somf_TDictionary_somfAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDictionary_somfAssign (
         Self.som_object,
         Ev,
         source,
         somf_TDictionaryClassData.somfAssign);
   END somfAssign;

   PROCEDURE somfDeleteAllKeys (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the entries in the dictionary.  Reset the count to be zero.
     -- Call the destructor on every key in the dictionary.
      PROCEDURE somf_TDictionary_somfDeleteAllKeys(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDictionary_somfDeleteAllKeys);
      PRAGMA interface_information (somf_TDictionary_somfDeleteAllKeys, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDictionary_somfDeleteAllKeys (
         Self.som_object,
         Ev,
         somf_TDictionaryClassData.somfDeleteAllKeys);
   END somfDeleteAllKeys;

   PROCEDURE somfDeleteAllValues (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Remove all of the entries in the dictionary.  Reset the count to be zero.
     -- Call the destructor on every value in the hash table.  If you have a value
     -- which appears more than once, you will be sorry you used this method because
     -- the utility classes will delete the same object more than once.  This
     -- is not good.
      PROCEDURE somf_TDictionary_somfDeleteAllValues(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDictionary_somfDeleteAllValues);
      PRAGMA interface_information (somf_TDictionary_somfDeleteAllValues, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDictionary_somfDeleteAllValues (
         Self.som_object,
         Ev,
         somf_TDictionaryClassData.somfDeleteAllValues);
   END somfDeleteAllValues;

   FUNCTION somfValueAt (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the value associated with the key.  Return SOMF_NIL if the key could not
     -- be found.
      FUNCTION somf_TDictionary_somfValueAt(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfValueAt);
      PRAGMA interface_information (somf_TDictionary_somfValueAt, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfValueAt (
            Self.som_object,
            Ev,
            key,
            somf_TDictionaryClassData.somfValueAt);
      RETURN Result;
   END somfValueAt; 

   FUNCTION somfKeyAtMF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      val : IN SOM.SOMObjectPtr; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the first key found which has val as its value.  This involves a slow
     -- search.
      FUNCTION somf_TDictionary_somfKeyAtMF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         val : IN SOM.SOMObjectPtr; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfKeyAtMF);
      PRAGMA interface_information (somf_TDictionary_somfKeyAtMF, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfKeyAtMF (
            Self.som_object,
            Ev,
            val,
            testfn,
            somf_TDictionaryClassData.somfKeyAtMF);
      RETURN Result;
   END somfKeyAtMF; 

   FUNCTION somfKeyAtM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      val : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the first key found which has val as its value.  This involves a slow
     -- search. This method uses the same compare function as specified in
     -- the constructor.
      FUNCTION somf_TDictionary_somfKeyAtM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         val : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfKeyAtM);
      PRAGMA interface_information (somf_TDictionary_somfKeyAtM, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfKeyAtM (
            Self.som_object,
            Ev,
            val,
            somf_TDictionaryClassData.somfKeyAtM);
      RETURN Result;
   END somfKeyAtM; 

   FUNCTION somfDeleteKey (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Delete the key from the key,value pair associated with key and remove the
     -- key,value pair from the dictionary.  Return the value that was removed
     -- as a result of this call.
      FUNCTION somf_TDictionary_somfDeleteKey(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfDeleteKey);
      PRAGMA interface_information (somf_TDictionary_somfDeleteKey, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfDeleteKey (
            Self.som_object,
            Ev,
            key,
            somf_TDictionaryClassData.somfDeleteKey);
      RETURN Result;
   END somfDeleteKey; 

   FUNCTION somfAddKeyValuePairMMB (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr; 
      val : IN SOM.SOMObjectPtr; 
      replace : IN Corba.Boolean)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- If replace = FALSE, then only add key,value pair to the table if there is not
     -- an existing key,value pair.  Otherwise, if replace=TRUE, add the key,value
     -- pair to the hash table.  Either way, return the key that existed (if any) in
     -- the hash table before this call.  Proper memory management may involve
     -- checking to see if the key returned is "the same" as the key passes in when
     -- replacing key,value pairs.
      FUNCTION somf_TDictionary_somfAddKeyValuePairMMB(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr; 
         val : IN SOM.SOMObjectPtr; 
         replace : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfAddKeyValuePairMMB);
      PRAGMA interface_information (somf_TDictionary_somfAddKeyValuePairMMB, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfAddKeyValuePairMMB (
            Self.som_object,
            Ev,
            key,
            val,
            replace,
            somf_TDictionaryClassData.somfAddKeyValuePairMMB);
      RETURN Result;
   END somfAddKeyValuePairMMB; 

   FUNCTION somfAddKeyValuePairMM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      key : IN SOM.SOMObjectPtr; 
      val : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Add the key,value pair to the hash table, and return the key that existed
     -- (if any) in the hash table before this call.  Proper memory management may
     -- involve checking to see if the key returned is "the same" as the key passes
     -- in when replacing key,value pairs.
      FUNCTION somf_TDictionary_somfAddKeyValuePairMM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         key : IN SOM.SOMObjectPtr; 
         val : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfAddKeyValuePairMM);
      PRAGMA interface_information (somf_TDictionary_somfAddKeyValuePairMM, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfAddKeyValuePairMM (
            Self.som_object,
            Ev,
            key,
            val,
            somf_TDictionaryClassData.somfAddKeyValuePairMM);
      RETURN Result;
   END somfAddKeyValuePairMM; 

   PROCEDURE somfSetHashFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      fn : IN somf_MCollectible.somf_MCollectibleHashFn)
   IS
     
     -- Set the hash function to fn.  By default this is set to MCollectible's Hash
     -- (which is usually overridden in the objects you are adding to the hash
     -- table).  You can use any hash function that you like as long as it has the
     -- type signature of somf_MCollectibleHashFn.  Most of the time, you won't need to
     -- do this.
      PROCEDURE somf_TDictionary_somfSetHashFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         fn : IN somf_MCollectible.somf_MCollectibleHashFn;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDictionary_somfSetHashFunction);
      PRAGMA interface_information (somf_TDictionary_somfSetHashFunction, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDictionary_somfSetHashFunction (
         Self.som_object,
         Ev,
         fn,
         somf_TDictionaryClassData.somfSetHashFunction);
   END somfSetHashFunction;

   FUNCTION somfGetHashFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleHashFn
   IS
     
     -- Return the hash function.
      FUNCTION somf_TDictionary_somfGetHashFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MCollectible.somf_MCollectibleHashFn; 
      PRAGMA interface (assembly, somf_TDictionary_somfGetHashFunction);
      PRAGMA interface_information (somf_TDictionary_somfGetHashFunction, ".xsomcall2");
      Result : ALIASED somf_MCollectible.somf_MCollectibleHashFn;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfGetHashFunction (
            Self.som_object,
            Ev,
            somf_TDictionaryClassData.somfGetHashFunction);
      RETURN Result;
   END somfGetHashFunction; 

   FUNCTION somfCreateNewImplementationFLLL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      tablesize : IN Corba.Long; 
      rate : IN Corba.Long; 
      threshold : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.
      FUNCTION somf_TDictionary_somfCreateNewImplementationFLLL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         tablesize : IN Corba.Long; 
         rate : IN Corba.Long; 
         threshold : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfCreateNewImplementationFLLL);
      PRAGMA interface_information (somf_TDictionary_somfCreateNewImplementationFLLL, ".xsomcall6");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfCreateNewImplementationFLLL (
            Self.som_object,
            Ev,
            testfn,
            tablesize,
            rate,
            threshold,
            somf_TDictionaryClassData.somfCreateNewImplementationFLLL);
      RETURN Result;
   END somfCreateNewImplementationFLLL; 

   FUNCTION somfCreateNewImplementationF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.
      FUNCTION somf_TDictionary_somfCreateNewImplementationF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfCreateNewImplementationF);
      PRAGMA interface_information (somf_TDictionary_somfCreateNewImplementationF, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfCreateNewImplementationF (
            Self.som_object,
            Ev,
            testfn,
            somf_TDictionaryClassData.somfCreateNewImplementationF);
      RETURN Result;
   END somfCreateNewImplementationF; 

   FUNCTION somfCreateNewImplementationFL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      tablesize : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.
      FUNCTION somf_TDictionary_somfCreateNewImplementationFL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         tablesize : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfCreateNewImplementationFL);
      PRAGMA interface_information (somf_TDictionary_somfCreateNewImplementationFL, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfCreateNewImplementationFL (
            Self.som_object,
            Ev,
            testfn,
            tablesize,
            somf_TDictionaryClassData.somfCreateNewImplementationFL);
      RETURN Result;
   END somfCreateNewImplementationFL; 

   FUNCTION somfCreateNewImplementationFLL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      tablesize : IN Corba.Long; 
      rate : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Create a new hash table for the dictionary.  Normally you won't have to do
     -- this.
      FUNCTION somf_TDictionary_somfCreateNewImplementationFLL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         tablesize : IN Corba.Long; 
         rate : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfCreateNewImplementationFLL);
      PRAGMA interface_information (somf_TDictionary_somfCreateNewImplementationFLL, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfCreateNewImplementationFLL (
            Self.som_object,
            Ev,
            testfn,
            tablesize,
            rate,
            somf_TDictionaryClassData.somfCreateNewImplementationFLL);
      RETURN Result;
   END somfCreateNewImplementationFLL; 

   FUNCTION somfCopyImplementation (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return a hash table that is a copy of the hash table in this.  Normally you
     -- won't have to do this.
      FUNCTION somf_TDictionary_somfCopyImplementation(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionary_somfCopyImplementation);
      PRAGMA interface_information (somf_TDictionary_somfCopyImplementation, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionary_somfCopyImplementation (
            Self.som_object,
            Ev,
            somf_TDictionaryClassData.somfCopyImplementation);
      RETURN Result;
   END somfCopyImplementation; 

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

END somf_TDictionary; 







