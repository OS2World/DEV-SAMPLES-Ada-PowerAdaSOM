
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:03 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPEncoderDecoderAbstract IS

   
   -- This is the abstract class for an EncoderDecoder.
   --
   -- An encoder/decoder is an object which is paired with a persistent object
   -- and handles the reading/writing of that persistent object's instance
   -- data.  A class derived from this abstract class must be created and
   -- paired with a persistent object in order for that persistent object
   -- to be save/restored.
   --
   -- The derived encoder/decoder class name is bound to a persistent
   -- object with the sompSetEncoderDecoderName method (see po.sc).
   --
   -- A persistent object's encoder/decoder is instantiated by an
   -- IO Group Mgr at the moment that object is save/restored.

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
      


   PROCEDURE sompEDWrite (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisMedia : IN SOM.SOMObjectPtr;
      thisObject : IN SOM.SOMObjectPtr);
     
     -- This method is responsible for writing out the persistent data of
     -- object <thisObject> in a format that is compatible with sompEDRead.
     -- This routine should make use of the media interface that is passed in
     -- as the first argument <thisMedia>.  This method should assume that
     -- the media interface has been initialized and opened.  This method
     -- should also assume that the media interface will be closed by the
     -- caller of this method.
     --
     -- Refer to the class interface of the media interface passed in for
     -- the methods which can be used to write instance data.

   PROCEDURE sompEDRead (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      thisMedia : IN SOM.SOMObjectPtr;
      thisObject : IN SOM.SOMObjectPtr);
     
     -- This method is responsible for reading in the persistent data of
     -- object <thisObject>.  It should expect the data to be in the format
     -- of sompEDWrite.  This routine should make use of the media interface
     -- that is passed in as the first argument <thisMedia>.  This method
     -- should assume that the media interface has been initialized and
     -- opened.  This method should also assume that the media interface will
     -- be closed by the caller of this method.
     --
     -- Refer to the class interface of the media interface passed in for
     -- the methods which can be used to read instance data.

END SOMPEncoderDecoderAbstract; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPEncoderDecoderAbstract IS

   
   -- This is the abstract class for an EncoderDecoder.
   --
   -- An encoder/decoder is an object which is paired with a persistent object
   -- and handles the reading/writing of that persistent object's instance
   -- data.  A class derived from this abstract class must be created and
   -- paired with a persistent object in order for that persistent object
   -- to be save/restored.
   --
   -- The derived encoder/decoder class name is bound to a persistent
   -- object with the sompSetEncoderDecoderName method (see po.sc).
   --
   -- A persistent object's encoder/decoder is instantiated by an
   -- IO Group Mgr at the moment that object is save/restored.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompEDWrite : SOM.somMToken;
      sompEDRead : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPEncoderDecoderAbstractClassData : classData;
   FOR SOMPEncoderDecoderAbstractClassData USE AT standard.system.label("SOMPEncoderDecoderAbstractClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPEncoderDecoderAbstractCClassData : CClassData;
   FOR SOMPEncoderDecoderAbstractCClassData USE AT standard.system.label("SOMPEncoderDecoderAbstractCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPEncoderDecoderAbstractClassData.classObject) 
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
      FUNCTION SOMPEncoderDecoderAbstractNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPEncoderDecoderAbstractNewClass);
      PRAGMA interface_information (SOMPEncoderDecoderAbstractNewClass, ".SOMPEncoderDecoderAbstractNewClass");
   BEGIN
      RETURN SOMPEncoderDecoderAbstractNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPEncoderDecoderAbstractClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPEncoderDecoderAbstractClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompEDWrite (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisMedia : IN SOM.SOMObjectPtr; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
     
     -- This method is responsible for writing out the persistent data of
     -- object <thisObject> in a format that is compatible with sompEDRead.
     -- This routine should make use of the media interface that is passed in
     -- as the first argument <thisMedia>.  This method should assume that
     -- the media interface has been initialized and opened.  This method
     -- should also assume that the media interface will be closed by the
     -- caller of this method.
     --
     -- Refer to the class interface of the media interface passed in for
     -- the methods which can be used to write instance data.
      PROCEDURE SOMPEncoderDecoderAbstract_sompEDWrite(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisMedia : IN SOM.SOMObjectPtr; 
         thisObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPEncoderDecoderAbstract_sompEDWrite);
      PRAGMA interface_information (SOMPEncoderDecoderAbstract_sompEDWrite, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPEncoderDecoderAbstract_sompEDWrite (
         Self.som_object,
         Ev,
         thisMedia,
         thisObject,
         SOMPEncoderDecoderAbstractClassData.sompEDWrite);
   END sompEDWrite;

   PROCEDURE sompEDRead (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      thisMedia : IN SOM.SOMObjectPtr; 
      thisObject : IN SOM.SOMObjectPtr)
   IS
     
     -- This method is responsible for reading in the persistent data of
     -- object <thisObject>.  It should expect the data to be in the format
     -- of sompEDWrite.  This routine should make use of the media interface
     -- that is passed in as the first argument <thisMedia>.  This method
     -- should assume that the media interface has been initialized and
     -- opened.  This method should also assume that the media interface will
     -- be closed by the caller of this method.
     --
     -- Refer to the class interface of the media interface passed in for
     -- the methods which can be used to read instance data.
      PROCEDURE SOMPEncoderDecoderAbstract_sompEDRead(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         thisMedia : IN SOM.SOMObjectPtr; 
         thisObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPEncoderDecoderAbstract_sompEDRead);
      PRAGMA interface_information (SOMPEncoderDecoderAbstract_sompEDRead, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPEncoderDecoderAbstract_sompEDRead (
         Self.som_object,
         Ev,
         thisMedia,
         thisObject,
         SOMPEncoderDecoderAbstractClassData.sompEDRead);
   END sompEDRead;

END SOMPEncoderDecoderAbstract; 







