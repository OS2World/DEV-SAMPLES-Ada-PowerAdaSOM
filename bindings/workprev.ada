
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:11 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMEEvent;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMEWorkProcEvent IS

   
   -- SOMEWorkProcEvent is the class for generic workProc events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMWorkProcEvent
   -- An instance of this class is initialized and passed to the callback
   -- of a workproc event.
   -- Although at present this class has no methods, its parent methods can be
   -- called to verify that the event type is EMWorkProcEvent.

   TYPE Ref IS NEW SOMEEvent.Ref WITH NULL RECORD;

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
      


   PROCEDURE somInit (
      Self : IN Ref);

END SOMEWorkProcEvent; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMEWorkProcEvent IS

   
   -- SOMEWorkProcEvent is the class for generic workProc events within the Event Manager.
   -- This class should be queried for events of the following type(s):
   --      EMWorkProcEvent
   -- An instance of this class is initialized and passed to the callback
   -- of a workproc event.
   -- Although at present this class has no methods, its parent methods can be
   -- called to verify that the event type is EMWorkProcEvent.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMEWorkProcEventClassData : classData;
   FOR SOMEWorkProcEventClassData USE AT standard.system.label("SOMEWorkProcEventClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMEWorkProcEventCClassData : CClassData;
   FOR SOMEWorkProcEventCClassData USE AT standard.system.label("SOMEWorkProcEventCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMEWorkProcEventClassData.classObject) 
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
      FUNCTION SOMEWorkProcEventNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMEWorkProcEventNewClass);
      PRAGMA interface_information (SOMEWorkProcEventNewClass, ".SOMEWorkProcEventNewClass");
   BEGIN
      RETURN SOMEWorkProcEventNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMEWorkProcEventClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMEWorkProcEventClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END SOMEWorkProcEvent; 







