
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:41 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMClass;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMMSingleInstance IS

   
   -- This class is a metaclass for classes which wish to enforce a
   -- single instance rule.  That is, classes which specify this class
   -- as their metaclass will only be allowed to have a single instance.
   --
   -- For example, if a class named dog specified this class as its
   -- metaclass, only one dog object could be instantiated. Repeated
   -- calls to _somNew on the dog class would simply return the same
   -- dog repeatedly.
   --
   -- There are two ways to retrieve the single intance of the using
   -- class:
   --
   --  1) Invoke sommGetSingleInstance on the class object of the using class.
   --     This is the preferred way.
   --
   --  2) Invoke somNew or somNewNoInit on the class object of the using class.
   --

   TYPE Ref IS NEW SOMClass.Ref WITH NULL RECORD;

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
      


   FUNCTION sommGetSingleInstance (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the single instance of the using class.
     -- If there isn't one, then it creates one first with somNew.

   PROCEDURE sommFreeSingleInstance (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- If there isn't one, then the method does nothing.
     -- Frees single instance of the class

END SOMMSingleInstance; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMMSingleInstance IS

   
   -- This class is a metaclass for classes which wish to enforce a
   -- single instance rule.  That is, classes which specify this class
   -- as their metaclass will only be allowed to have a single instance.
   --
   -- For example, if a class named dog specified this class as its
   -- metaclass, only one dog object could be instantiated. Repeated
   -- calls to _somNew on the dog class would simply return the same
   -- dog repeatedly.
   --
   -- There are two ways to retrieve the single intance of the using
   -- class:
   --
   --  1) Invoke sommGetSingleInstance on the class object of the using class.
   --     This is the preferred way.
   --
   --  2) Invoke somNew or somNewNoInit on the class object of the using class.
   --

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sommGetSingleInstance : SOM.somMToken;
      sommFreeSingleInstance : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMMSingleInstanceClassData : classData;
   FOR SOMMSingleInstanceClassData USE AT standard.system.label("SOMMSingleInstanceClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMMSingleInstanceCClassData : CClassData;
   FOR SOMMSingleInstanceCClassData USE AT standard.system.label("SOMMSingleInstanceCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMMSingleInstanceClassData.classObject) 
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
      FUNCTION SOMMSingleInstanceNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMMSingleInstanceNewClass);
      PRAGMA interface_information (SOMMSingleInstanceNewClass, ".SOMMSingleInstanceNewClass");
   BEGIN
      RETURN SOMMSingleInstanceNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMMSingleInstanceClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMMSingleInstanceClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sommGetSingleInstance (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the single instance of the using class.
     -- If there isn't one, then it creates one first with somNew.
      FUNCTION SOMMSingleInstance_sommGetSingleInstance(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMMSingleInstance_sommGetSingleInstance);
      PRAGMA interface_information (SOMMSingleInstance_sommGetSingleInstance, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMMSingleInstance_sommGetSingleInstance (
            Self.som_object,
            Ev,
            SOMMSingleInstanceClassData.sommGetSingleInstance);
      RETURN Result;
   END sommGetSingleInstance; 

   PROCEDURE sommFreeSingleInstance (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- If there isn't one, then the method does nothing.
     -- Frees single instance of the class
      PROCEDURE SOMMSingleInstance_sommFreeSingleInstance(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMMSingleInstance_sommFreeSingleInstance);
      PRAGMA interface_information (SOMMSingleInstance_sommFreeSingleInstance, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMMSingleInstance_sommFreeSingleInstance (
         Self.som_object,
         Ev,
         SOMMSingleInstanceClassData.sommFreeSingleInstance);
   END sommFreeSingleInstance;

END SOMMSingleInstance; 







