
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

PACKAGE SOMMBeforeAfter IS


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
      


   FUNCTION sommBeforeMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      object : IN SOM.SOMObjectPtr;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Boolean;
     
     -- returns one of the following values:
     --      TRUE  --  continue Before/After processing
     --      FALSE --  skip to executing the corresponding After method
     --                (this includes skipping the requested method)

   PROCEDURE sommAfterMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      object : IN SOM.SOMObjectPtr;
      methodId : IN SOM.somId;
      returnedvalue : IN SOM.somToken;
      ap : IN SOM.va_list);

   PROCEDURE somDefaultInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl);

   PROCEDURE somInitMIClass (
      Self : IN Ref;
      inherit_vars : IN Corba.Long;
      className : IN Corba.String;
      parentClasses : IN SOMClass.SOMClassSequence;
      dataSize : IN Corba.Long;
      dataAlignment : IN Corba.Long;
      maxStaticMethods : IN Corba.Long;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long);

END SOMMBeforeAfter; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMMBeforeAfter IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sommBeforeMethod : SOM.somMToken;
      sommAfterMethod : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMMBeforeAfterClassData : classData;
   FOR SOMMBeforeAfterClassData USE AT standard.system.label("SOMMBeforeAfterClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMMBeforeAfterCClassData : CClassData;
   FOR SOMMBeforeAfterCClassData USE AT standard.system.label("SOMMBeforeAfterCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMMBeforeAfterClassData.classObject) 
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
      FUNCTION SOMMBeforeAfterNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMMBeforeAfterNewClass);
      PRAGMA interface_information (SOMMBeforeAfterNewClass, ".SOMMBeforeAfterNewClass");
   BEGIN
      RETURN SOMMBeforeAfterNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMMBeforeAfterClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMMBeforeAfterClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION sommBeforeMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      object : IN SOM.SOMObjectPtr; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Boolean
   IS
     
     -- returns one of the following values:
     --      TRUE  --  continue Before/After processing
     --      FALSE --  skip to executing the corresponding After method
     --                (this includes skipping the requested method)
      FUNCTION SOMMBeforeAfter_sommBeforeMethod(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         object : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMMBeforeAfter_sommBeforeMethod);
      PRAGMA interface_information (SOMMBeforeAfter_sommBeforeMethod, ".xsomcall5");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMMBeforeAfter_sommBeforeMethod (
            Self.som_object,
            Ev,
            object,
            methodId,
            ap,
            SOMMBeforeAfterClassData.sommBeforeMethod);
      RETURN Result;
   END sommBeforeMethod; 

   PROCEDURE sommAfterMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      object : IN SOM.SOMObjectPtr; 
      methodId : IN SOM.somId; 
      returnedvalue : IN SOM.somToken; 
      ap : IN SOM.va_list)
   IS
      PROCEDURE SOMMBeforeAfter_sommAfterMethod(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         object : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         returnedvalue : IN SOM.somToken; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMMBeforeAfter_sommAfterMethod);
      PRAGMA interface_information (SOMMBeforeAfter_sommAfterMethod, ".xsomcall6");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMMBeforeAfter_sommAfterMethod (
         Self.som_object,
         Ev,
         object,
         methodId,
         returnedvalue,
         ap,
         SOMMBeforeAfterClassData.sommAfterMethod);
   END sommAfterMethod;

   PROCEDURE somDefaultInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDefaultInit (
         SOMObject.Ref'(som_object=>Self.som_object),
         ctrl);
   END somDefaultInit;

   PROCEDURE somInitMIClass (
      Self : IN Ref; 
      inherit_vars : IN Corba.Long; 
      className : IN Corba.String; 
      parentClasses : IN SOMClass.SOMClassSequence; 
      dataSize : IN Corba.Long; 
      dataAlignment : IN Corba.Long; 
      maxStaticMethods : IN Corba.Long; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass.somInitMIClass (
         SOMClass.Ref'(som_object=>Self.som_object),
         inherit_vars,
         className,
         parentClasses,
         dataSize,
         dataAlignment,
         maxStaticMethods,
         majorVersion,
         minorVersion);
   END somInitMIClass;

END SOMMBeforeAfter; 







