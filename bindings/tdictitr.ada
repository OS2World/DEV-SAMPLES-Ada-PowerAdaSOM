
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:01 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_TIterator;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TDictionaryIterator IS


   TYPE Ref IS NEW somf_TIterator.Ref WITH NULL RECORD;

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
      


   FUNCTION somfTDictionaryIteratorInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initializes the new dictionary iterator.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION somfNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somfFirst (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somfRemove (
      Self : IN Ref;
      Ev : IN SOM.Environment);

END somf_TDictionaryIterator; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TDictionaryIterator IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfTDictionaryIteratorInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TDictionaryIteratorClassData : classData;
   FOR somf_TDictionaryIteratorClassData USE AT standard.system.label("somf_TDictionaryIteratorClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TDictionaryIteratorCClassData : CClassData;
   FOR somf_TDictionaryIteratorCClassData USE AT standard.system.label("somf_TDictionaryIteratorCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TDictionaryIteratorClassData.classObject) 
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
      FUNCTION somf_TDictionaryIteratorNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TDictionaryIteratorNewClass);
      PRAGMA interface_information (somf_TDictionaryIteratorNewClass, ".somf_TDictionaryIteratorNewClass");
   BEGIN
      RETURN somf_TDictionaryIteratorNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TDictionaryIteratorClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TDictionaryIteratorClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTDictionaryIteratorInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      h : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initializes the new dictionary iterator.
      FUNCTION somf_TDictionaryIterator_somfTDictionaryIteratorInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         h : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDictionaryIterator_somfTDictionaryIteratorInit);
      PRAGMA interface_information (somf_TDictionaryIterator_somfTDictionaryIteratorInit, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDictionaryIterator_somfTDictionaryIteratorInit (
            Self.som_object,
            Ev,
            h,
            somf_TDictionaryIteratorClassData.somfTDictionaryIteratorInit);
      RETURN Result;
   END somfTDictionaryIteratorInit; 

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

   FUNCTION somfNext (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TIterator.somfNext (
            somf_TIterator.Ref'(som_object=>Self.som_object),
            Ev);
   END somfNext;

   FUNCTION somfFirst (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         somf_TIterator.somfFirst (
            somf_TIterator.Ref'(som_object=>Self.som_object),
            Ev);
   END somfFirst;

   PROCEDURE somfRemove (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TIterator.somfRemove (
         somf_TIterator.Ref'(som_object=>Self.som_object),
         Ev);
   END somfRemove;

END somf_TDictionaryIterator; 







