
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:00 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_MLinkable;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TDequeLinkable IS


   TYPE Ref IS NEW somf_MLinkable.Ref WITH NULL RECORD;

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
      


   FUNCTION somfTDequeLinkableInitDDM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      previous : IN SOM.SOMObjectPtr;
      next : IN SOM.SOMObjectPtr;
      v : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method initializes the somf_TDequeLinkable object.

   FUNCTION somfTDequeLinkableInitDD (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      previous : IN SOM.SOMObjectPtr;
      next : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- This method initializes the somf_TDequeLinkable object.

   FUNCTION somfGetValue (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- This method gets the value of the somf_TDequeLinkable.

   PROCEDURE somfSetValue (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      v : IN SOM.SOMObjectPtr);
     
     -- This method sets the value of the somf_TDequeLinkable.

   PROCEDURE somInit (
      Self : IN Ref);

END somf_TDequeLinkable; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TDequeLinkable IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfGetValue : SOM.somMToken;
      somfSetValue : SOM.somMToken;
      somfTDequeLinkableInitDDM : SOM.somMToken;
      somfTDequeLinkableInitDD : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TDequeLinkableClassData : classData;
   FOR somf_TDequeLinkableClassData USE AT standard.system.label("somf_TDequeLinkableClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TDequeLinkableCClassData : CClassData;
   FOR somf_TDequeLinkableCClassData USE AT standard.system.label("somf_TDequeLinkableCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TDequeLinkableClassData.classObject) 
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
      FUNCTION somf_TDequeLinkableNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TDequeLinkableNewClass);
      PRAGMA interface_information (somf_TDequeLinkableNewClass, ".somf_TDequeLinkableNewClass");
   BEGIN
      RETURN somf_TDequeLinkableNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TDequeLinkableClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TDequeLinkableClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTDequeLinkableInitDDM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      previous : IN SOM.SOMObjectPtr; 
      next : IN SOM.SOMObjectPtr; 
      v : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method initializes the somf_TDequeLinkable object.
      FUNCTION somf_TDequeLinkable_somfTDequeLinkableInitDDM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         previous : IN SOM.SOMObjectPtr; 
         next : IN SOM.SOMObjectPtr; 
         v : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDequeLinkable_somfTDequeLinkableInitDDM);
      PRAGMA interface_information (somf_TDequeLinkable_somfTDequeLinkableInitDDM, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDequeLinkable_somfTDequeLinkableInitDDM (
            Self.som_object,
            Ev,
            previous,
            next,
            v,
            somf_TDequeLinkableClassData.somfTDequeLinkableInitDDM);
      RETURN Result;
   END somfTDequeLinkableInitDDM; 

   FUNCTION somfTDequeLinkableInitDD (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      previous : IN SOM.SOMObjectPtr; 
      next : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method initializes the somf_TDequeLinkable object.
      FUNCTION somf_TDequeLinkable_somfTDequeLinkableInitDD(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         previous : IN SOM.SOMObjectPtr; 
         next : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDequeLinkable_somfTDequeLinkableInitDD);
      PRAGMA interface_information (somf_TDequeLinkable_somfTDequeLinkableInitDD, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDequeLinkable_somfTDequeLinkableInitDD (
            Self.som_object,
            Ev,
            previous,
            next,
            somf_TDequeLinkableClassData.somfTDequeLinkableInitDD);
      RETURN Result;
   END somfTDequeLinkableInitDD; 

   FUNCTION somfGetValue (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- This method gets the value of the somf_TDequeLinkable.
      FUNCTION somf_TDequeLinkable_somfGetValue(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TDequeLinkable_somfGetValue);
      PRAGMA interface_information (somf_TDequeLinkable_somfGetValue, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TDequeLinkable_somfGetValue (
            Self.som_object,
            Ev,
            somf_TDequeLinkableClassData.somfGetValue);
      RETURN Result;
   END somfGetValue; 

   PROCEDURE somfSetValue (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      v : IN SOM.SOMObjectPtr)
   IS
     
     -- This method sets the value of the somf_TDequeLinkable.
      PROCEDURE somf_TDequeLinkable_somfSetValue(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         v : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TDequeLinkable_somfSetValue);
      PRAGMA interface_information (somf_TDequeLinkable_somfSetValue, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TDequeLinkable_somfSetValue (
         Self.som_object,
         Ev,
         v,
         somf_TDequeLinkableClassData.somfSetValue);
   END somfSetValue;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END somf_TDequeLinkable; 







