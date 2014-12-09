
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:16 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_MCollectible;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_MOrderableCollectible IS


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
      

   TYPE EComparisonResult IS (kLessThan, kEqual, kGreaterThan);
   FOR EComparisonResult USE (
      kLessThan => 1,
      kEqual => 2,
      kGreaterThan => 3 );

   SUBTYPE somf_MOrderableCompareFn IS SOM.somMToken;

   SUBTYPE somf_MBetterOrderableCompareFn IS SOM.somMToken;

   SUBTYPE somf_MOrderableCollectiblePtr IS SOM.voidPtr;


   FUNCTION somfIsGreaterThan (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if obj is "greater than" this.

   FUNCTION somfIsLessThan (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if obj is "less than" this.

   FUNCTION somfCompare (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN somf_MOrderableCollectible.EComparisonResult;
     
     -- This method compares obj to this.

   FUNCTION somfIsGreaterThanOrEqualTo (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if obj is "greater than" or "equal to" this.

   FUNCTION somfIsLessThanOrEqualTo (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if obj is "less than" or "equal to" this.

END somf_MOrderableCollectible; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_MOrderableCollectible IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfClone : SOM.somMToken;
      somfClonePointer : SOM.somMToken;
      somfHash : SOM.somMToken;
      somfIsEqual : SOM.somMToken;
      somfIsSame : SOM.somMToken;
      somfIsNotEqual : SOM.somMToken;
      somfIsGreaterThan : SOM.somMToken;
      somfIsLessThan : SOM.somMToken;
      somfCompare : SOM.somMToken;
      somfIsGreaterThanOrEqualTo : SOM.somMToken;
      somfIsLessThanOrEqualTo : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_MOrderableCollectibleClassData : classData;
   FOR somf_MOrderableCollectibleClassData USE AT standard.system.label("somf_MOrderableCollectibleClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_MOrderableCollectibleCClassData : CClassData;
   FOR somf_MOrderableCollectibleCClassData USE AT standard.system.label("somf_MOrderableCollectibleCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_MOrderableCollectibleClassData.classObject) 
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
      FUNCTION somf_MOrderableCollectibleNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_MOrderableCollectibleNewClass);
      PRAGMA interface_information (somf_MOrderableCollectibleNewClass, ".somf_MOrderableCollectibleNewClass");
   BEGIN
      RETURN somf_MOrderableCollectibleNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_MOrderableCollectibleClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_MOrderableCollectibleClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfIsGreaterThan (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if obj is "greater than" this.
      FUNCTION somf_MOrderableCollectible_somfIsGreaterThan(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MOrderableCollectible_somfIsGreaterThan);
      PRAGMA interface_information (somf_MOrderableCollectible_somfIsGreaterThan, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MOrderableCollectible_somfIsGreaterThan (
            Self.som_object,
            Ev,
            obj,
            somf_MOrderableCollectibleClassData.somfIsGreaterThan);
      RETURN Result;
   END somfIsGreaterThan; 

   FUNCTION somfIsLessThan (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if obj is "less than" this.
      FUNCTION somf_MOrderableCollectible_somfIsLessThan(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MOrderableCollectible_somfIsLessThan);
      PRAGMA interface_information (somf_MOrderableCollectible_somfIsLessThan, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MOrderableCollectible_somfIsLessThan (
            Self.som_object,
            Ev,
            obj,
            somf_MOrderableCollectibleClassData.somfIsLessThan);
      RETURN Result;
   END somfIsLessThan; 

   FUNCTION somfCompare (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN somf_MOrderableCollectible.EComparisonResult
   IS
     
     -- This method compares obj to this.
      FUNCTION somf_MOrderableCollectible_somfCompare(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN somf_MOrderableCollectible.EComparisonResult; 
      PRAGMA interface (assembly, somf_MOrderableCollectible_somfCompare);
      PRAGMA interface_information (somf_MOrderableCollectible_somfCompare, ".xsomcall3");
      Result : ALIASED somf_MOrderableCollectible.EComparisonResult;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MOrderableCollectible_somfCompare (
            Self.som_object,
            Ev,
            obj,
            somf_MOrderableCollectibleClassData.somfCompare);
      RETURN Result;
   END somfCompare; 

   FUNCTION somfIsGreaterThanOrEqualTo (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if obj is "greater than" or "equal to" this.
      FUNCTION somf_MOrderableCollectible_somfIsGreaterThanOrEqualTo(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MOrderableCollectible_somfIsGreaterThanOrEqualTo);
      PRAGMA interface_information (somf_MOrderableCollectible_somfIsGreaterThanOrEqualTo, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MOrderableCollectible_somfIsGreaterThanOrEqualTo (
            Self.som_object,
            Ev,
            obj,
            somf_MOrderableCollectibleClassData.somfIsGreaterThanOrEqualTo);
      RETURN Result;
   END somfIsGreaterThanOrEqualTo; 

   FUNCTION somfIsLessThanOrEqualTo (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      obj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if obj is "less than" or "equal to" this.
      FUNCTION somf_MOrderableCollectible_somfIsLessThanOrEqualTo(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_MOrderableCollectible_somfIsLessThanOrEqualTo);
      PRAGMA interface_information (somf_MOrderableCollectible_somfIsLessThanOrEqualTo, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MOrderableCollectible_somfIsLessThanOrEqualTo (
            Self.som_object,
            Ev,
            obj,
            somf_MOrderableCollectibleClassData.somfIsLessThanOrEqualTo);
      RETURN Result;
   END somfIsLessThanOrEqualTo; 

END somf_MOrderableCollectible; 







