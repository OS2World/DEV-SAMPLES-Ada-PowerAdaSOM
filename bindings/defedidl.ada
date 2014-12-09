
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:02 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPEncoderDecoderAbstract;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPAttrEncoderDecoder IS

   
   -- This class is an EncoderDecoder which can save/restore the IDL
   -- attributes of a given persistent object.
   --
   -- NOTE: This encoder/decoder assumes structure members have been
   --       aligned. This is the default for most compilers. See your
   --       compiler's documentation for discussion of aligned structures.
   --       The encoder/decoder will also handle structures
   --       which are naturally packed (e.g. a structure containing
   --       members which are all declared "long") however, some compilers
   --       allow options which will pack all structures. This encoder/
   --       decoder will not handle these structures.
   --
   -- For example, suppose you have an IDL Interface definition with attributes:
   --
   --  attribute string   name;
   --  attribute string   food;
   --  attribute long     weight;
   --  attribute short    height;
   --
   -- You would make attributes "name" and "weight" persistent by specifying
   -- the following SOM modifiers in the SOM implementation section of the
   -- interface definition:
   --
   --  name: persistent;
   --  weight: persistent;
   --
   -- An encoder/decoder is an object which is paired with a persistent object
   -- and handles the reading/writing of that persistent object's
   -- data.
   --
   -- A persistent object's encoder/decoder is instantiated by an
   -- IO Group Mgr at the moment that object is save/restored.

   TYPE Ref IS NEW SOMPEncoderDecoderAbstract.Ref WITH NULL RECORD;

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

   PROCEDURE sompEDWrite (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisMedia : IN SOM.SOMObjectPtr;
      thisObject : IN SOM.SOMObjectPtr);

   PROCEDURE sompEDRead (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisMedia : IN SOM.SOMObjectPtr;
      thisObject : IN SOM.SOMObjectPtr);

END SOMPAttrEncoderDecoder; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPAttrEncoderDecoder IS

   
   -- This class is an EncoderDecoder which can save/restore the IDL
   -- attributes of a given persistent object.
   --
   -- NOTE: This encoder/decoder assumes structure members have been
   --       aligned. This is the default for most compilers. See your
   --       compiler's documentation for discussion of aligned structures.
   --       The encoder/decoder will also handle structures
   --       which are naturally packed (e.g. a structure containing
   --       members which are all declared "long") however, some compilers
   --       allow options which will pack all structures. This encoder/
   --       decoder will not handle these structures.
   --
   -- For example, suppose you have an IDL Interface definition with attributes:
   --
   --  attribute string   name;
   --  attribute string   food;
   --  attribute long     weight;
   --  attribute short    height;
   --
   -- You would make attributes "name" and "weight" persistent by specifying
   -- the following SOM modifiers in the SOM implementation section of the
   -- interface definition:
   --
   --  name: persistent;
   --  weight: persistent;
   --
   -- An encoder/decoder is an object which is paired with a persistent object
   -- and handles the reading/writing of that persistent object's
   -- data.
   --
   -- A persistent object's encoder/decoder is instantiated by an
   -- IO Group Mgr at the moment that object is save/restored.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompGetObjectAttributes : SOM.somMToken;
      sompGetAttribute : SOM.somMToken;
      sompSetObjectAttributes : SOM.somMToken;
      sompSetAttribute : SOM.somMToken;
      sompAttributeSize : SOM.somMToken;
      sompStoreBuffer : SOM.somMToken;
      sompRestoreBuffer : SOM.somMToken;
      sompDispatchSet : SOM.somMToken;
      sompPadSize : SOM.somMToken;
      sompCallStyleIDL : SOM.somMToken;
      sompLookupModifier : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPAttrEncoderDecoderClassData : classData;
   FOR SOMPAttrEncoderDecoderClassData USE AT standard.system.label("SOMPAttrEncoderDecoderClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPAttrEncoderDecoderCClassData : CClassData;
   FOR SOMPAttrEncoderDecoderCClassData USE AT standard.system.label("SOMPAttrEncoderDecoderCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPAttrEncoderDecoderClassData.classObject) 
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
      FUNCTION SOMPAttrEncoderDecoderNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPAttrEncoderDecoderNewClass);
      PRAGMA interface_information (SOMPAttrEncoderDecoderNewClass, ".SOMPAttrEncoderDecoderNewClass");
   BEGIN
      RETURN SOMPAttrEncoderDecoderNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPAttrEncoderDecoderClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPAttrEncoderDecoderClassData.classObject));
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

   PROCEDURE sompEDWrite (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisMedia : IN SOM.SOMObjectPtr; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPEncoderDecoderAbstract.sompEDWrite (
         SOMPEncoderDecoderAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         thisMedia,
         thisObject);
   END sompEDWrite;

   PROCEDURE sompEDRead (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisMedia : IN SOM.SOMObjectPtr; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPEncoderDecoderAbstract.sompEDRead (
         SOMPEncoderDecoderAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         thisMedia,
         thisObject);
   END sompEDRead;

END SOMPAttrEncoderDecoder; 







