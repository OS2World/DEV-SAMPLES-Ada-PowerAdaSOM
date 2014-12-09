
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:07 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPAsciiMediaInterface;
WITH SOMPFileMediaAbstract;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPBinaryFileMedia IS

   
   -- The SOMPBinaryFileMedia class provides an interface to the file
   -- system which writes numbers in binary.

   TYPE Ref IS NEW SOMPAsciiMediaInterface.Ref WITH NULL RECORD;

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
      


   PROCEDURE sompWriteOctet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i1 : IN Corba.Octet);

   PROCEDURE sompWriteShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i2 : IN Corba.Short);

   PROCEDURE sompWriteUnsignedShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      u2 : IN Corba.Unsigned_Short);

   PROCEDURE sompWriteLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i4 : IN Corba.Long);

   PROCEDURE sompWriteUnsignedLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      u4 : IN Corba.Unsigned_Long);

   PROCEDURE sompWriteDouble (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f8 : IN Corba.Double);

   PROCEDURE sompWriteFloat (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f4 : IN Corba.Float);

   PROCEDURE sompWriteString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      wstring : IN Corba.String);

   PROCEDURE sompReadOctet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i1 : IN OUT Corba.Octet);

   PROCEDURE sompReadShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i2 : IN OUT Corba.Short);

   PROCEDURE sompReadUnsignedShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      u2 : IN OUT Corba.Unsigned_Short);

   PROCEDURE sompReadLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i4 : IN OUT Corba.Long);

   PROCEDURE sompReadUnsignedLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i4 : IN OUT Corba.Unsigned_Long);

   PROCEDURE sompReadDouble (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f8 : IN OUT Corba.Double);

   PROCEDURE sompReadFloat (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f4 : IN OUT Corba.Float);

   PROCEDURE sompReadString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      rstring : IN OUT Corba.String);

   PROCEDURE sompReadStringToBuffer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String;
      bufsize : IN Corba.Long);

END SOMPBinaryFileMedia; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPBinaryFileMedia IS

   
   -- The SOMPBinaryFileMedia class provides an interface to the file
   -- system which writes numbers in binary.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPBinaryFileMediaClassData : classData;
   FOR SOMPBinaryFileMediaClassData USE AT standard.system.label("SOMPBinaryFileMediaClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPBinaryFileMediaCClassData : CClassData;
   FOR SOMPBinaryFileMediaCClassData USE AT standard.system.label("SOMPBinaryFileMediaCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPBinaryFileMediaClassData.classObject) 
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
      FUNCTION SOMPBinaryFileMediaNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPBinaryFileMediaNewClass);
      PRAGMA interface_information (SOMPBinaryFileMediaNewClass, ".SOMPBinaryFileMediaNewClass");
   BEGIN
      RETURN SOMPBinaryFileMediaNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPBinaryFileMediaClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPBinaryFileMediaClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompWriteOctet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i1 : IN Corba.Octet)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteOctet (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i1);
   END sompWriteOctet;

   PROCEDURE sompWriteShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i2 : IN Corba.Short)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteShort (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i2);
   END sompWriteShort;

   PROCEDURE sompWriteUnsignedShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      u2 : IN Corba.Unsigned_Short)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteUnsignedShort (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         u2);
   END sompWriteUnsignedShort;

   PROCEDURE sompWriteLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i4 : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteLong (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i4);
   END sompWriteLong;

   PROCEDURE sompWriteUnsignedLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      u4 : IN Corba.Unsigned_Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteUnsignedLong (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         u4);
   END sompWriteUnsignedLong;

   PROCEDURE sompWriteDouble (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f8 : IN Corba.Double)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteDouble (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         f8);
   END sompWriteDouble;

   PROCEDURE sompWriteFloat (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f4 : IN Corba.Float)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteFloat (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         f4);
   END sompWriteFloat;

   PROCEDURE sompWriteString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      wstring : IN Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteString (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         wstring);
   END sompWriteString;

   PROCEDURE sompReadOctet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i1 : IN OUT Corba.Octet)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadOctet (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i1);
   END sompReadOctet;

   PROCEDURE sompReadShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i2 : IN OUT Corba.Short)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadShort (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i2);
   END sompReadShort;

   PROCEDURE sompReadUnsignedShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      u2 : IN OUT Corba.Unsigned_Short)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadUnsignedShort (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         u2);
   END sompReadUnsignedShort;

   PROCEDURE sompReadLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i4 : IN OUT Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadLong (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i4);
   END sompReadLong;

   PROCEDURE sompReadUnsignedLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i4 : IN OUT Corba.Unsigned_Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadUnsignedLong (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         i4);
   END sompReadUnsignedLong;

   PROCEDURE sompReadDouble (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f8 : IN OUT Corba.Double)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadDouble (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         f8);
   END sompReadDouble;

   PROCEDURE sompReadFloat (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f4 : IN OUT Corba.Float)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadFloat (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         f4);
   END sompReadFloat;

   PROCEDURE sompReadString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      rstring : IN OUT Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadString (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         rstring);
   END sompReadString;

   PROCEDURE sompReadStringToBuffer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buffer : IN Corba.String; 
      bufsize : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadStringToBuffer (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         buffer,
         bufsize);
   END sompReadStringToBuffer;

END SOMPBinaryFileMedia; 







