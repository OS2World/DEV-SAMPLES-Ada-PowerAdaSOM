
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:56 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH somf_MCollectible;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TAssoc IS


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
      


   FUNCTION somfTAssocInitMM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      k : IN SOM.SOMObjectPtr;
      v : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize somf_TAssoc to an existing key (k) and value (v).

   FUNCTION somfTAssocInitM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      k : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize somf_TAssoc to an existing key (k).  The value is set to SOMF_NIL.

   FUNCTION somfGetKey (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Get the key (fKey) to the associated pair.

   FUNCTION somfGetValue (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Get the value (fValue) to the associated pair.

   PROCEDURE somfSetKey (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      k : IN SOM.SOMObjectPtr);
     
     -- Set the key (fKey) to the associated pair.

   PROCEDURE somfSetValue (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      v : IN SOM.SOMObjectPtr);
     
     -- Set the value (fValue) to the associated pair.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

END somf_TAssoc; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TAssoc IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfGetKey : SOM.somMToken;
      somfGetValue : SOM.somMToken;
      somfSetKey : SOM.somMToken;
      somfSetValue : SOM.somMToken;
      somfTAssocInitMM : SOM.somMToken;
      somfTAssocInitM : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TAssocClassData : classData;
   FOR somf_TAssocClassData USE AT standard.system.label("somf_TAssocClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TAssocCClassData : CClassData;
   FOR somf_TAssocCClassData USE AT standard.system.label("somf_TAssocCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TAssocClassData.classObject) 
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
      FUNCTION somf_TAssocNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TAssocNewClass);
      PRAGMA interface_information (somf_TAssocNewClass, ".somf_TAssocNewClass");
   BEGIN
      RETURN somf_TAssocNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TAssocClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TAssocClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTAssocInitMM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      k : IN SOM.SOMObjectPtr; 
      v : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize somf_TAssoc to an existing key (k) and value (v).
      FUNCTION somf_TAssoc_somfTAssocInitMM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         k : IN SOM.SOMObjectPtr; 
         v : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TAssoc_somfTAssocInitMM);
      PRAGMA interface_information (somf_TAssoc_somfTAssocInitMM, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TAssoc_somfTAssocInitMM (
            Self.som_object,
            Ev,
            k,
            v,
            somf_TAssocClassData.somfTAssocInitMM);
      RETURN Result;
   END somfTAssocInitMM; 

   FUNCTION somfTAssocInitM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      k : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize somf_TAssoc to an existing key (k).  The value is set to SOMF_NIL.
      FUNCTION somf_TAssoc_somfTAssocInitM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         k : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TAssoc_somfTAssocInitM);
      PRAGMA interface_information (somf_TAssoc_somfTAssocInitM, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TAssoc_somfTAssocInitM (
            Self.som_object,
            Ev,
            k,
            somf_TAssocClassData.somfTAssocInitM);
      RETURN Result;
   END somfTAssocInitM; 

   FUNCTION somfGetKey (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Get the key (fKey) to the associated pair.
      FUNCTION somf_TAssoc_somfGetKey(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TAssoc_somfGetKey);
      PRAGMA interface_information (somf_TAssoc_somfGetKey, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TAssoc_somfGetKey (
            Self.som_object,
            Ev,
            somf_TAssocClassData.somfGetKey);
      RETURN Result;
   END somfGetKey; 

   FUNCTION somfGetValue (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Get the value (fValue) to the associated pair.
      FUNCTION somf_TAssoc_somfGetValue(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TAssoc_somfGetValue);
      PRAGMA interface_information (somf_TAssoc_somfGetValue, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TAssoc_somfGetValue (
            Self.som_object,
            Ev,
            somf_TAssocClassData.somfGetValue);
      RETURN Result;
   END somfGetValue; 

   PROCEDURE somfSetKey (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      k : IN SOM.SOMObjectPtr)
   IS
     
     -- Set the key (fKey) to the associated pair.
      PROCEDURE somf_TAssoc_somfSetKey(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         k : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TAssoc_somfSetKey);
      PRAGMA interface_information (somf_TAssoc_somfSetKey, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TAssoc_somfSetKey (
         Self.som_object,
         Ev,
         k,
         somf_TAssocClassData.somfSetKey);
   END somfSetKey;

   PROCEDURE somfSetValue (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      v : IN SOM.SOMObjectPtr)
   IS
     
     -- Set the value (fValue) to the associated pair.
      PROCEDURE somf_TAssoc_somfSetValue(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         v : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TAssoc_somfSetValue);
      PRAGMA interface_information (somf_TAssoc_somfSetValue, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TAssoc_somfSetValue (
         Self.som_object,
         Ev,
         v,
         somf_TAssocClassData.somfSetValue);
   END somfSetValue;

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

END somf_TAssoc; 







