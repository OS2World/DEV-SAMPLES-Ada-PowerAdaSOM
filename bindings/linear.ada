
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:13 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMRLinearizable IS

   
   --This is a mixin class which defines the property "linearizable".
   --Any object that supports the two methods "somrGetState" and
   --"somrSetState" is linearizable.  This is an abstract base class
   --and hence any derived class MUST OVERRIDE these two methods.

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
      


   PROCEDURE somrGetState (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buf : IN OUT Corba.String);
     
     -- Converts its internal state into a linear string and returns a
     -- pointer to the string (the length of the string is in the
     -- first sizeof(int) bytes of this string).   The implementer of this
     -- method should allocate the necessary memory for the string.
     -- The OWNERSHIP of this string is transferred to the caller of this method.

   PROCEDURE somrSetState (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buf : IN Corba.String);
     
     -- The reverse of Get State. It converts the given linear string into
     -- its internal state.  The ownership of buf stays with the caller.

END SOMRLinearizable; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMRLinearizable IS

   
   --This is a mixin class which defines the property "linearizable".
   --Any object that supports the two methods "somrGetState" and
   --"somrSetState" is linearizable.  This is an abstract base class
   --and hence any derived class MUST OVERRIDE these two methods.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somrGetState : SOM.somMToken;
      somrSetState : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMRLinearizableClassData : classData;
   FOR SOMRLinearizableClassData USE AT standard.system.label("SOMRLinearizableClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMRLinearizableCClassData : CClassData;
   FOR SOMRLinearizableCClassData USE AT standard.system.label("SOMRLinearizableCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMRLinearizableClassData.classObject) 
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
      FUNCTION SOMRLinearizableNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMRLinearizableNewClass);
      PRAGMA interface_information (SOMRLinearizableNewClass, ".SOMRLinearizableNewClass");
   BEGIN
      RETURN SOMRLinearizableNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMRLinearizableClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMRLinearizableClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somrGetState (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buf : IN OUT Corba.String)
   IS
     
     -- Converts its internal state into a linear string and returns a
     -- pointer to the string (the length of the string is in the
     -- first sizeof(int) bytes of this string).   The implementer of this
     -- method should allocate the necessary memory for the string.
     -- The OWNERSHIP of this string is transferred to the caller of this method.
      PROCEDURE SOMRLinearizable_somrGetState(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         buf : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRLinearizable_somrGetState);
      PRAGMA interface_information (SOMRLinearizable_somrGetState, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRLinearizable_somrGetState (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(buf'address),
         SOMRLinearizableClassData.somrGetState);
   END somrGetState;

   PROCEDURE somrSetState (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buf : IN Corba.String)
   IS
     
     -- The reverse of Get State. It converts the given linear string into
     -- its internal state.  The ownership of buf stays with the caller.
      PROCEDURE SOMRLinearizable_somrSetState(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         buf : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMRLinearizable_somrSetState);
      PRAGMA interface_information (SOMRLinearizable_somrSetState, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRLinearizable_somrSetState (
         Self.som_object,
         Ev,
         buf,
         SOMRLinearizableClassData.somrSetState);
   END somrSetState;

END SOMRLinearizable; 







