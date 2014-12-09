
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:08 1997
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

PACKAGE somf_TSet IS


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
      

   TYPE ESetClassification IS (kUnchecked, kNormal, kFast);
   FOR ESetClassification USE (
      kUnchecked => 1,
      kNormal => 2,
      kFast => 3 );


   FUNCTION somfTSetInitFL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
      setSizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new set.

   FUNCTION somfTSetInitF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new set.

   FUNCTION somfTSetInitLF (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      setSizeHint : IN Corba.Long;
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new set.

   FUNCTION somfTSetInitL (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      setSizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new set.

   FUNCTION somfTSetInitS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      s : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new set.

   PROCEDURE somfAssign (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      source : IN SOM.SOMObjectPtr);
     
     -- Assign the instance of this equal to the instance of source.

   PROCEDURE somfDifferenceS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr);
     
     -- Destructively modify this to contain a set of elements of this that do not
     -- appear in set1

   PROCEDURE somfDifferenceSS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr;
      resultSet : IN SOM.SOMObjectPtr);
     
     -- After this function is called, resultSet will contain a set of elements of
     -- this that do not appear in set1

   PROCEDURE somfIntersectionS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr);
     
     -- Destructively modify this to contain everything that is an element of set1
     -- and this.

   PROCEDURE somfIntersectionSS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr;
      resultSet : IN SOM.SOMObjectPtr);
     
     -- After this function is called, resultSet will contain everything that is an
     -- element of set1 and this.

   PROCEDURE somfUnionS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr);
     
     -- Destructively modify this to contain everything that is an element of either
     -- set1 or this.

   PROCEDURE somfUnionSS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr;
      resultSet : IN SOM.SOMObjectPtr);
     
     -- After this function is called, resultSet will contain everything that is an
     -- element of either set1 or this.

   PROCEDURE somfXorS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr);
     
     -- Destructively modify this to contain everything that is an element of either
     -- set1 or this, but not both.

   PROCEDURE somfXorSS (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      set1 : IN SOM.SOMObjectPtr;
      resultSet : IN SOM.SOMObjectPtr);
     
     -- After this function is called, resultSet will contain everything that is an
     -- element of either set1 or this, but not both.

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

   PROCEDURE somfRehash (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Rehash the set, cleaning up for any entries marked for deletion.

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

END somf_TSet; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSet IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfDifferenceS : SOM.somMToken;
      somfDifferenceSS : SOM.somMToken;
      somfIntersectionS : SOM.somMToken;
      somfIntersectionSS : SOM.somMToken;
      somfUnionS : SOM.somMToken;
      somfUnionSS : SOM.somMToken;
      somfXorS : SOM.somMToken;
      somfXorSS : SOM.somMToken;
      somfSetHashFunction : SOM.somMToken;
      somfGetHashFunction : SOM.somMToken;
      somfRehash : SOM.somMToken;
      somfFind : SOM.somMToken;
      somfMakeNewTable : SOM.somMToken;
      somfCopyIn : SOM.somMToken;
      somfGrow : SOM.somMToken;
      somfAssign : SOM.somMToken;
      somfTSetInitFL : SOM.somMToken;
      somfTSetInitF : SOM.somMToken;
      somfTSetInitLF : SOM.somMToken;
      somfTSetInitL : SOM.somMToken;
      somfTSetInitS : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSetClassData : classData;
   FOR somf_TSetClassData USE AT standard.system.label("somf_TSetClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSetCClassData : CClassData;
   FOR somf_TSetCClassData USE AT standard.system.label("somf_TSetCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSetClassData.classObject) 
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
      FUNCTION somf_TSetNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSetNewClass);
      PRAGMA interface_information (somf_TSetNewClass, ".somf_TSetNewClass");
   BEGIN
      RETURN somf_TSetNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSetClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSetClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTSetInitFL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
      setSizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new set.
      FUNCTION somf_TSet_somfTSetInitFL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn; 
         setSizeHint : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSet_somfTSetInitFL);
      PRAGMA interface_information (somf_TSet_somfTSetInitFL, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSet_somfTSetInitFL (
            Self.som_object,
            Ev,
            testfn,
            setSizeHint,
            somf_TSetClassData.somfTSetInitFL);
      RETURN Result;
   END somfTSetInitFL; 

   FUNCTION somfTSetInitF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new set.
      FUNCTION somf_TSet_somfTSetInitF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSet_somfTSetInitF);
      PRAGMA interface_information (somf_TSet_somfTSetInitF, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSet_somfTSetInitF (
            Self.som_object,
            Ev,
            testfn,
            somf_TSetClassData.somfTSetInitF);
      RETURN Result;
   END somfTSetInitF; 

   FUNCTION somfTSetInitLF (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      setSizeHint : IN Corba.Long; 
      testfn : IN somf_MCollectible.somf_MCollectibleCompareFn)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new set.
      FUNCTION somf_TSet_somfTSetInitLF(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         setSizeHint : IN Corba.Long; 
         testfn : IN somf_MCollectible.somf_MCollectibleCompareFn;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSet_somfTSetInitLF);
      PRAGMA interface_information (somf_TSet_somfTSetInitLF, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSet_somfTSetInitLF (
            Self.som_object,
            Ev,
            setSizeHint,
            testfn,
            somf_TSetClassData.somfTSetInitLF);
      RETURN Result;
   END somfTSetInitLF; 

   FUNCTION somfTSetInitL (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      setSizeHint : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new set.
      FUNCTION somf_TSet_somfTSetInitL(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         setSizeHint : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSet_somfTSetInitL);
      PRAGMA interface_information (somf_TSet_somfTSetInitL, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSet_somfTSetInitL (
            Self.som_object,
            Ev,
            setSizeHint,
            somf_TSetClassData.somfTSetInitL);
      RETURN Result;
   END somfTSetInitL; 

   FUNCTION somfTSetInitS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      s : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new set.
      FUNCTION somf_TSet_somfTSetInitS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         s : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSet_somfTSetInitS);
      PRAGMA interface_information (somf_TSet_somfTSetInitS, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSet_somfTSetInitS (
            Self.som_object,
            Ev,
            s,
            somf_TSetClassData.somfTSetInitS);
      RETURN Result;
   END somfTSetInitS; 

   PROCEDURE somfAssign (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      source : IN SOM.SOMObjectPtr)
   IS
     
     -- Assign the instance of this equal to the instance of source.
      PROCEDURE somf_TSet_somfAssign(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         source : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfAssign);
      PRAGMA interface_information (somf_TSet_somfAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfAssign (
         Self.som_object,
         Ev,
         source,
         somf_TSetClassData.somfAssign);
   END somfAssign;

   PROCEDURE somfDifferenceS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr)
   IS
     
     -- Destructively modify this to contain a set of elements of this that do not
     -- appear in set1
      PROCEDURE somf_TSet_somfDifferenceS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfDifferenceS);
      PRAGMA interface_information (somf_TSet_somfDifferenceS, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfDifferenceS (
         Self.som_object,
         Ev,
         set1,
         somf_TSetClassData.somfDifferenceS);
   END somfDifferenceS;

   PROCEDURE somfDifferenceSS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr; 
      resultSet : IN SOM.SOMObjectPtr)
   IS
     
     -- After this function is called, resultSet will contain a set of elements of
     -- this that do not appear in set1
      PROCEDURE somf_TSet_somfDifferenceSS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr; 
         resultSet : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfDifferenceSS);
      PRAGMA interface_information (somf_TSet_somfDifferenceSS, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfDifferenceSS (
         Self.som_object,
         Ev,
         set1,
         resultSet,
         somf_TSetClassData.somfDifferenceSS);
   END somfDifferenceSS;

   PROCEDURE somfIntersectionS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr)
   IS
     
     -- Destructively modify this to contain everything that is an element of set1
     -- and this.
      PROCEDURE somf_TSet_somfIntersectionS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfIntersectionS);
      PRAGMA interface_information (somf_TSet_somfIntersectionS, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfIntersectionS (
         Self.som_object,
         Ev,
         set1,
         somf_TSetClassData.somfIntersectionS);
   END somfIntersectionS;

   PROCEDURE somfIntersectionSS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr; 
      resultSet : IN SOM.SOMObjectPtr)
   IS
     
     -- After this function is called, resultSet will contain everything that is an
     -- element of set1 and this.
      PROCEDURE somf_TSet_somfIntersectionSS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr; 
         resultSet : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfIntersectionSS);
      PRAGMA interface_information (somf_TSet_somfIntersectionSS, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfIntersectionSS (
         Self.som_object,
         Ev,
         set1,
         resultSet,
         somf_TSetClassData.somfIntersectionSS);
   END somfIntersectionSS;

   PROCEDURE somfUnionS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr)
   IS
     
     -- Destructively modify this to contain everything that is an element of either
     -- set1 or this.
      PROCEDURE somf_TSet_somfUnionS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfUnionS);
      PRAGMA interface_information (somf_TSet_somfUnionS, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfUnionS (
         Self.som_object,
         Ev,
         set1,
         somf_TSetClassData.somfUnionS);
   END somfUnionS;

   PROCEDURE somfUnionSS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr; 
      resultSet : IN SOM.SOMObjectPtr)
   IS
     
     -- After this function is called, resultSet will contain everything that is an
     -- element of either set1 or this.
      PROCEDURE somf_TSet_somfUnionSS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr; 
         resultSet : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfUnionSS);
      PRAGMA interface_information (somf_TSet_somfUnionSS, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfUnionSS (
         Self.som_object,
         Ev,
         set1,
         resultSet,
         somf_TSetClassData.somfUnionSS);
   END somfUnionSS;

   PROCEDURE somfXorS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr)
   IS
     
     -- Destructively modify this to contain everything that is an element of either
     -- set1 or this, but not both.
      PROCEDURE somf_TSet_somfXorS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfXorS);
      PRAGMA interface_information (somf_TSet_somfXorS, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfXorS (
         Self.som_object,
         Ev,
         set1,
         somf_TSetClassData.somfXorS);
   END somfXorS;

   PROCEDURE somfXorSS (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      set1 : IN SOM.SOMObjectPtr; 
      resultSet : IN SOM.SOMObjectPtr)
   IS
     
     -- After this function is called, resultSet will contain everything that is an
     -- element of either set1 or this, but not both.
      PROCEDURE somf_TSet_somfXorSS(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         set1 : IN SOM.SOMObjectPtr; 
         resultSet : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfXorSS);
      PRAGMA interface_information (somf_TSet_somfXorSS, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfXorSS (
         Self.som_object,
         Ev,
         set1,
         resultSet,
         somf_TSetClassData.somfXorSS);
   END somfXorSS;

   PROCEDURE somfSetHashFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      fn : IN somf_MCollectible.somf_MCollectibleHashFn)
   IS
     
     -- Set the hash function to fn.
      PROCEDURE somf_TSet_somfSetHashFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         fn : IN somf_MCollectible.somf_MCollectibleHashFn;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfSetHashFunction);
      PRAGMA interface_information (somf_TSet_somfSetHashFunction, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfSetHashFunction (
         Self.som_object,
         Ev,
         fn,
         somf_TSetClassData.somfSetHashFunction);
   END somfSetHashFunction;

   FUNCTION somfGetHashFunction (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN somf_MCollectible.somf_MCollectibleHashFn
   IS
     
     -- Return the hash function.
      FUNCTION somf_TSet_somfGetHashFunction(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MCollectible.somf_MCollectibleHashFn; 
      PRAGMA interface (assembly, somf_TSet_somfGetHashFunction);
      PRAGMA interface_information (somf_TSet_somfGetHashFunction, ".xsomcall2");
      Result : ALIASED somf_MCollectible.somf_MCollectibleHashFn;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSet_somfGetHashFunction (
            Self.som_object,
            Ev,
            somf_TSetClassData.somfGetHashFunction);
      RETURN Result;
   END somfGetHashFunction; 

   PROCEDURE somfRehash (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Rehash the set, cleaning up for any entries marked for deletion.
      PROCEDURE somf_TSet_somfRehash(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSet_somfRehash);
      PRAGMA interface_information (somf_TSet_somfRehash, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSet_somfRehash (
         Self.som_object,
         Ev,
         somf_TSetClassData.somfRehash);
   END somfRehash;

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

END somf_TSet; 







