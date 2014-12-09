
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:15 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_MLinkable IS


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
      


   FUNCTION somfMLinkableInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n : IN SOM.SOMObjectPtr;
      p : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method initialized the somf_MLinkable object using n and p.

   FUNCTION somfGetNext (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns a pointer to the next somf_MLinkable.

   PROCEDURE somfSetNext (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      aLink : IN SOM.SOMObjectPtr);
     
     -- This method sets the pointer to the next somf_MLinkable.

   FUNCTION somfGetPrevious (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- This method returns a pointer to the previous somf_MLinkable.

   PROCEDURE somfSetPrevious (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      aLink : IN SOM.SOMObjectPtr);
     
     -- This method sets the pointer to the previous somf_MLinkable.

   PROCEDURE somInit (
      Self : IN Ref);

END somf_MLinkable; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_MLinkable IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfGetNext : SOM.somMToken;
      somfSetNext : SOM.somMToken;
      somfGetPrevious : SOM.somMToken;
      somfSetPrevious : SOM.somMToken;
      somfMLinkableInit : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_MLinkableClassData : classData;
   FOR somf_MLinkableClassData USE AT standard.system.label("somf_MLinkableClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_MLinkableCClassData : CClassData;
   FOR somf_MLinkableCClassData USE AT standard.system.label("somf_MLinkableCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_MLinkableClassData.classObject) 
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
      FUNCTION somf_MLinkableNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_MLinkableNewClass);
      PRAGMA interface_information (somf_MLinkableNewClass, ".somf_MLinkableNewClass");
   BEGIN
      RETURN somf_MLinkableNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_MLinkableClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_MLinkableClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfMLinkableInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n : IN SOM.SOMObjectPtr; 
      p : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method initialized the somf_MLinkable object using n and p.
      FUNCTION somf_MLinkable_somfMLinkableInit(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n : IN SOM.SOMObjectPtr; 
         p : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_MLinkable_somfMLinkableInit);
      PRAGMA interface_information (somf_MLinkable_somfMLinkableInit, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MLinkable_somfMLinkableInit (
            Self.som_object,
            Ev,
            n,
            p,
            somf_MLinkableClassData.somfMLinkableInit);
      RETURN Result;
   END somfMLinkableInit; 

   FUNCTION somfGetNext (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns a pointer to the next somf_MLinkable.
      FUNCTION somf_MLinkable_somfGetNext(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_MLinkable_somfGetNext);
      PRAGMA interface_information (somf_MLinkable_somfGetNext, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MLinkable_somfGetNext (
            Self.som_object,
            Ev,
            somf_MLinkableClassData.somfGetNext);
      RETURN Result;
   END somfGetNext; 

   PROCEDURE somfSetNext (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      aLink : IN SOM.SOMObjectPtr)
   IS
     
     -- This method sets the pointer to the next somf_MLinkable.
      PROCEDURE somf_MLinkable_somfSetNext(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         aLink : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_MLinkable_somfSetNext);
      PRAGMA interface_information (somf_MLinkable_somfSetNext, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_MLinkable_somfSetNext (
         Self.som_object,
         Ev,
         aLink,
         somf_MLinkableClassData.somfSetNext);
   END somfSetNext;

   FUNCTION somfGetPrevious (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method returns a pointer to the previous somf_MLinkable.
      FUNCTION somf_MLinkable_somfGetPrevious(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_MLinkable_somfGetPrevious);
      PRAGMA interface_information (somf_MLinkable_somfGetPrevious, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_MLinkable_somfGetPrevious (
            Self.som_object,
            Ev,
            somf_MLinkableClassData.somfGetPrevious);
      RETURN Result;
   END somfGetPrevious; 

   PROCEDURE somfSetPrevious (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      aLink : IN SOM.SOMObjectPtr)
   IS
     
     -- This method sets the pointer to the previous somf_MLinkable.
      PROCEDURE somf_MLinkable_somfSetPrevious(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         aLink : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_MLinkable_somfSetPrevious);
      PRAGMA interface_information (somf_MLinkable_somfSetPrevious, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_MLinkable_somfSetPrevious (
         Self.som_object,
         Ev,
         aLink,
         somf_MLinkableClassData.somfSetPrevious);
   END somfSetPrevious;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END somf_MLinkable; 







