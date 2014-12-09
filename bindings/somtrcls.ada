
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:54 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMMBeforeAfter;
WITH SOMClass;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMMTraced IS


   TYPE Ref IS NEW SOMMBeforeAfter.Ref WITH NULL RECORD;

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
      


   FUNCTION get_sommTraceIsOn (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     --Method from the IDL attribute statement:
     --"attribute boolean sommTraceIsOn"

   PROCEDURE set_sommTraceIsOn (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      sommTraceIsOn : IN Corba.Boolean);
     
     --Method from the IDL attribute statement:
     --"attribute boolean sommTraceIsOn"

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

   FUNCTION sommBeforeMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      object : IN SOM.SOMObjectPtr;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Boolean;

   PROCEDURE sommAfterMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      object : IN SOM.SOMObjectPtr;
      methodId : IN SOM.somId;
      returnedvalue : IN SOM.somToken;
      ap : IN SOM.va_list);

END SOMMTraced; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMMTraced IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      set_sommTraceIsOn : SOM.somMToken;
      get_sommTraceIsOn : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMMTracedClassData : classData;
   FOR SOMMTracedClassData USE AT standard.system.label("SOMMTracedClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMMTracedCClassData : CClassData;
   FOR SOMMTracedCClassData USE AT standard.system.label("SOMMTracedCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMMTracedClassData.classObject) 
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
      FUNCTION SOMMTracedNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMMTracedNewClass);
      PRAGMA interface_information (SOMMTracedNewClass, ".SOMMTracedNewClass");
   BEGIN
      RETURN SOMMTracedNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMMTracedClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMMTracedClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_sommTraceIsOn (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     --Method from the IDL attribute statement:
     --"attribute boolean sommTraceIsOn"
      FUNCTION SOMMTraced_U_get_sommTraceIsOn(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMMTraced_U_get_sommTraceIsOn);
      PRAGMA interface_information (SOMMTraced_U_get_sommTraceIsOn, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMMTraced_U_get_sommTraceIsOn (
            Self.som_object,
            Ev,
            SOMMTracedClassData.get_sommTraceIsOn);
      RETURN Result;
   END get_sommTraceIsOn; 

   PROCEDURE set_sommTraceIsOn (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      sommTraceIsOn : IN Corba.Boolean)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute boolean sommTraceIsOn"
      PROCEDURE SOMMTraced_U_set_sommTraceIsOn(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         sommTraceIsOn : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMMTraced_U_set_sommTraceIsOn);
      PRAGMA interface_information (SOMMTraced_U_set_sommTraceIsOn, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMMTraced_U_set_sommTraceIsOn (
         Self.som_object,
         Ev,
         sommTraceIsOn,
         SOMMTracedClassData.set_sommTraceIsOn);
   END set_sommTraceIsOn;

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

   FUNCTION sommBeforeMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      object : IN SOM.SOMObjectPtr; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMMBeforeAfter.sommBeforeMethod (
            SOMMBeforeAfter.Ref'(som_object=>Self.som_object),
            Ev,
            object,
            methodId,
            ap);
   END sommBeforeMethod;

   PROCEDURE sommAfterMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      object : IN SOM.SOMObjectPtr; 
      methodId : IN SOM.somId; 
      returnedvalue : IN SOM.somToken; 
      ap : IN SOM.va_list)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMMBeforeAfter.sommAfterMethod (
         SOMMBeforeAfter.Ref'(som_object=>Self.som_object),
         Ev,
         object,
         methodId,
         returnedvalue,
         ap);
   END sommAfterMethod;

END SOMMTraced; 







