
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:51 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMRReplicbl;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMRReplicableObject IS


   TYPE Ref IS NEW SOMRReplicbl.Ref WITH NULL RECORD;

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
      


   FUNCTION somrLoggingType (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Char;

   FUNCTION somrReplicableExemptMethod (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      methodId : IN SOM.somId)
      RETURN Corba.Boolean;

   FUNCTION somrRepInit (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      lType : IN Corba.Char;
      mode : IN Corba.Char)
      RETURN Corba.Long;

   PROCEDURE somrApplyUpdates (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buf : IN Corba.String;
      len : IN Corba.Long;
      ObjIntId : IN Corba.Long);

END SOMRReplicableObject; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMRReplicableObject IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somrLoggingType : SOM.somMToken;
      somrReplicableExemptMethod : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMRReplicableObjectClassData : classData;
   FOR SOMRReplicableObjectClassData USE AT standard.system.label("SOMRReplicableObjectClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMRReplicableObjectCClassData : CClassData;
   FOR SOMRReplicableObjectCClassData USE AT standard.system.label("SOMRReplicableObjectCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMRReplicableObjectClassData.classObject) 
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
      FUNCTION SOMRReplicableObjectNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMRReplicableObjectNewClass);
      PRAGMA interface_information (SOMRReplicableObjectNewClass, ".SOMRReplicableObjectNewClass");
   BEGIN
      RETURN SOMRReplicableObjectNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMRReplicableObjectClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMRReplicableObjectClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somrLoggingType (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Char
   IS
      FUNCTION SOMRReplicableObject_somrLoggingType(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Char; 
      PRAGMA interface (assembly, SOMRReplicableObject_somrLoggingType);
      PRAGMA interface_information (SOMRReplicableObject_somrLoggingType, ".xsomcall2");
      Result : ALIASED Corba.Char;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMRReplicableObject_somrLoggingType (
            Self.som_object,
            Ev,
            SOMRReplicableObjectClassData.somrLoggingType);
      RETURN Result;
   END somrLoggingType; 

   FUNCTION somrReplicableExemptMethod (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      methodId : IN SOM.somId)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMRReplicableObject_somrReplicableExemptMethod(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMRReplicableObject_somrReplicableExemptMethod);
      PRAGMA interface_information (SOMRReplicableObject_somrReplicableExemptMethod, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMRReplicableObject_somrReplicableExemptMethod (
            Self.som_object,
            Ev,
            methodId,
            SOMRReplicableObjectClassData.somrReplicableExemptMethod);
      RETURN Result;
   END somrReplicableExemptMethod; 

   FUNCTION somrRepInit (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      lType : IN Corba.Char; 
      mode : IN Corba.Char)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMRReplicbl.somrRepInit (
            SOMRReplicbl.Ref'(som_object=>Self.som_object),
            Ev,
            lType,
            mode);
   END somrRepInit;

   PROCEDURE somrApplyUpdates (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buf : IN Corba.String; 
      len : IN Corba.Long; 
      ObjIntId : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMRReplicbl.somrApplyUpdates (
         SOMRReplicbl.Ref'(som_object=>Self.som_object),
         Ev,
         buf,
         len,
         ObjIntId);
   END somrApplyUpdates;

END SOMRReplicableObject; 







