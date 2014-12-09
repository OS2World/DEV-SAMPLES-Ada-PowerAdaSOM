
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:06 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPMediaInterfaceAbstract;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPFileMediaAbstract IS

   
   -- This is the abstract class definition for an interface to
   -- a file media.

   TYPE Ref IS NEW SOMPMediaInterfaceAbstract.Ref WITH NULL RECORD;

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
      


   PROCEDURE sompInitReadWrite (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaInfo : IN Corba.String);
     
     -- Initialize the media interface for read-write access.

   PROCEDURE sompInitReadOnly (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaInfo : IN Corba.String);
     
     -- Initialize the media interface for read-only access.

   PROCEDURE sompSeekPosition (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      offset : IN Corba.Long);
     
     -- Position the media to an offset.  Any further reading
     -- or writing will begin from that point.  Reading and writing
     -- implicitly repositions the file, so usually this is not needed.

   PROCEDURE sompSeekPositionRel (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      offset : IN Corba.Long);
     
     -- Like Position, but offset is relative to current.

   FUNCTION sompGetOffset (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Returns the current offset within the file.

   PROCEDURE sompReadBytes (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      byteStream : IN Corba.String;
      length : IN Corba.Long);
     
     -- Read a byte stream of the given length from the media.

   PROCEDURE sompWriteBytes (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      byteStream : IN Corba.String;
      length : IN Corba.Long);
     
     -- Write a byte stream of the given length to the media.

   PROCEDURE sompWriteOctet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i1 : IN Corba.Octet);
     
     -- Writes the given 8-bit integer

   PROCEDURE sompWriteShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i2 : IN Corba.Short);
     
     -- Writes the given short integer

   PROCEDURE sompWriteUnsignedShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      u2 : IN Corba.Unsigned_Short);
     
     -- Writes the given unsigned short integer

   PROCEDURE sompWriteLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i4 : IN Corba.Long);
     
     -- Writes the given long integer

   PROCEDURE sompWriteUnsignedLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      u4 : IN Corba.Unsigned_Long);
     
     -- Writes the given unsigned long integer

   PROCEDURE sompWriteDouble (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f8 : IN Corba.Double);
     
     -- Writes the given double-precision float

   PROCEDURE sompWriteFloat (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f4 : IN Corba.Float);
     
     -- Writes the given float

   PROCEDURE sompWriteCharacter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      c : IN Corba.Char);
     
     -- Writes the given character

   PROCEDURE sompWriteSomobject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      so : IN SOM.SOMObjectPtr;
      parentObject : IN SOM.SOMObjectPtr);
     
     -- Writes the given object.  Uses parentObject to determine whether relative
     -- Ids are used.  If object (so) has no persistent parent, client passes
     -- NULL parentObject.

   PROCEDURE sompWriteString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      wstring : IN Corba.String);
     
     -- Writes the given string to the media.
     --

   PROCEDURE sompReadOctet (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i1 : IN OUT Corba.Octet);
     
     -- Reads an 8-bit integer into memory at given the pointer

   PROCEDURE sompReadShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i2 : IN OUT Corba.Short);
     
     -- Reads a short integer into memory at given the pointer

   PROCEDURE sompReadUnsignedShort (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      u2 : IN OUT Corba.Unsigned_Short);
     
     -- Reads an unsigned short integer into memory at given the pointer

   PROCEDURE sompReadLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i4 : IN OUT Corba.Long);
     
     -- Reads a long integer into memory at given the pointer

   PROCEDURE sompReadUnsignedLong (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      i4 : IN OUT Corba.Unsigned_Long);
     
     -- Reads a long integer into memory at given the pointer

   PROCEDURE sompReadDouble (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f8 : IN OUT Corba.Double);
     
     -- Reads a float into memory at given the pointer

   PROCEDURE sompReadFloat (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      f4 : IN OUT Corba.Float);
     
     -- Reads a float into memory at given the pointer

   PROCEDURE sompReadCharacter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      c : IN OUT Corba.Char);
     
     -- Reads a character into memory at given the pointer

   PROCEDURE sompReadSomobject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      so : IN OUT SOM.SOMObjectPtr);
     
     -- Instantiates and returns a new object of the class specified in
     -- the file. Standard SOM objects are simply instantiated. Persistent
     -- objects are instantiated and marked for restoration.

   PROCEDURE sompReadString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      rstring : IN OUT Corba.String);
     
     -- Read and allocate a string. Input is a pointer to a string. The input
     -- pointer is modified to point to a newly allocated buffer which
     -- will contain the string read from the media.
     -- Callers are responsible for freeing the returned buffer with SOMFree.
     -- If you want to read a string into a predefined buffer,
     -- use sompReadStringToBuffer.
     --
     -- This method can be used to read strings which were stored by
     -- sompWriteString.

   PROCEDURE sompReadStringToBuffer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String;
      bufsize : IN Corba.Long);
     
     -- Read a string into the preallocated buffer given. The size of the
     -- buffer is given in <bufsize>. If the string read is larger than
     -- bufsize it is truncated to fit in bufsize.
     --
     -- This method can be used to read strings which were stored by
     -- sompWriteString.

   PROCEDURE sompWriteLine (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String);
     
     -- Writes the given string in <buffer> at the current position.
     -- The terminating null character (\0) is not written.
     --
     -- This method does NOT append a newline character (\n) to the
     -- given string before writing. If the user of this method intends to
     -- restore this <buffer> of data with sompReadLine, the user must
     -- put the newline character in the <buffer> before calling this
     -- method.

   PROCEDURE sompReadLine (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String;
      bufsize : IN Corba.Long);
     
     -- Read a string up to and including the first newline character (\n)
     -- into the preallocated buffer given.
     -- Use this method for reading strings stored with sompWriteLine.
     --
     -- The size of the buffer is given in <bufsize>. If the string read is
     -- larger than bufsize it is truncated to fit in bufsize.
     --
     -- The characters read are stored in <buffer>, and a null character (\0)
     -- is appended. The newline character, if read, is included in the string.

   PROCEDURE sompWriteTypeCode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      tc : IN Corba.TypeCode.Object);
     
     -- Writes a restoreable version of an IDL type code. Restore with
     -- sompReadTypeCode().

   PROCEDURE sompReadTypeCode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      tc : IN OUT Corba.TypeCode.Object);
     
     -- Restores an IDL type code that was stored with sompWriteTypeCode().

   PROCEDURE sompOpen (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   PROCEDURE sompClose (
      Self : IN Ref;
      Ev : IN SOM.Environment);

END SOMPFileMediaAbstract; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPFileMediaAbstract IS

   
   -- This is the abstract class definition for an interface to
   -- a file media.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompInitReadWrite : SOM.somMToken;
      sompInitReadOnly : SOM.somMToken;
      sompOpen : SOM.somMToken;
      sompClose : SOM.somMToken;
      sompSeekPosition : SOM.somMToken;
      sompSeekPositionRel : SOM.somMToken;
      sompGetOffset : SOM.somMToken;
      sompReadBytes : SOM.somMToken;
      sompWriteBytes : SOM.somMToken;
      sompWriteOctet : SOM.somMToken;
      sompWriteShort : SOM.somMToken;
      sompWriteUnsignedShort : SOM.somMToken;
      sompWriteInteger : SOM.somMToken;
      sompWriteLong : SOM.somMToken;
      sompWriteUnsignedLong : SOM.somMToken;
      sompWriteDouble : SOM.somMToken;
      sompWriteFloat : SOM.somMToken;
      sompWriteCharacter : SOM.somMToken;
      sompWriteSomobject : SOM.somMToken;
      sompWriteString : SOM.somMToken;
      sompReadOctet : SOM.somMToken;
      sompReadShort : SOM.somMToken;
      sompReadUnsignedShort : SOM.somMToken;
      sompReadInteger : SOM.somMToken;
      sompReadLong : SOM.somMToken;
      sompReadUnsignedLong : SOM.somMToken;
      sompReadDouble : SOM.somMToken;
      sompReadFloat : SOM.somMToken;
      sompReadCharacter : SOM.somMToken;
      sompReadSomobject : SOM.somMToken;
      sompReadString : SOM.somMToken;
      sompReadStringToBuffer : SOM.somMToken;
      sompWriteLine : SOM.somMToken;
      sompReadLine : SOM.somMToken;
      sompWriteTypeCode : SOM.somMToken;
      sompReadTypeCode : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPFileMediaAbstractClassData : classData;
   FOR SOMPFileMediaAbstractClassData USE AT standard.system.label("SOMPFileMediaAbstractClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPFileMediaAbstractCClassData : CClassData;
   FOR SOMPFileMediaAbstractCClassData USE AT standard.system.label("SOMPFileMediaAbstractCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPFileMediaAbstractClassData.classObject) 
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
      FUNCTION SOMPFileMediaAbstractNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPFileMediaAbstractNewClass);
      PRAGMA interface_information (SOMPFileMediaAbstractNewClass, ".SOMPFileMediaAbstractNewClass");
   BEGIN
      RETURN SOMPFileMediaAbstractNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPFileMediaAbstractClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPFileMediaAbstractClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompInitReadWrite (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaInfo : IN Corba.String)
   IS
     
     -- Initialize the media interface for read-write access.
      PROCEDURE SOMPFileMediaAbstract_sompInitReadWrite(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mediaInfo : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompInitReadWrite);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompInitReadWrite, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompInitReadWrite (
         Self.som_object,
         Ev,
         mediaInfo,
         SOMPFileMediaAbstractClassData.sompInitReadWrite);
   END sompInitReadWrite;

   PROCEDURE sompInitReadOnly (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaInfo : IN Corba.String)
   IS
     
     -- Initialize the media interface for read-only access.
      PROCEDURE SOMPFileMediaAbstract_sompInitReadOnly(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mediaInfo : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompInitReadOnly);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompInitReadOnly, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompInitReadOnly (
         Self.som_object,
         Ev,
         mediaInfo,
         SOMPFileMediaAbstractClassData.sompInitReadOnly);
   END sompInitReadOnly;

   PROCEDURE sompSeekPosition (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      offset : IN Corba.Long)
   IS
     
     -- Position the media to an offset.  Any further reading
     -- or writing will begin from that point.  Reading and writing
     -- implicitly repositions the file, so usually this is not needed.
      PROCEDURE SOMPFileMediaAbstract_sompSeekPosition(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         offset : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompSeekPosition);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompSeekPosition, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompSeekPosition (
         Self.som_object,
         Ev,
         offset,
         SOMPFileMediaAbstractClassData.sompSeekPosition);
   END sompSeekPosition;

   PROCEDURE sompSeekPositionRel (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      offset : IN Corba.Long)
   IS
     
     -- Like Position, but offset is relative to current.
      PROCEDURE SOMPFileMediaAbstract_sompSeekPositionRel(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         offset : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompSeekPositionRel);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompSeekPositionRel, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompSeekPositionRel (
         Self.som_object,
         Ev,
         offset,
         SOMPFileMediaAbstractClassData.sompSeekPositionRel);
   END sompSeekPositionRel;

   FUNCTION sompGetOffset (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Returns the current offset within the file.
      FUNCTION SOMPFileMediaAbstract_sompGetOffset(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompGetOffset);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompGetOffset, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPFileMediaAbstract_sompGetOffset (
            Self.som_object,
            Ev,
            SOMPFileMediaAbstractClassData.sompGetOffset);
      RETURN Result;
   END sompGetOffset; 

   PROCEDURE sompReadBytes (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      byteStream : IN Corba.String; 
      length : IN Corba.Long)
   IS
     
     -- Read a byte stream of the given length from the media.
      PROCEDURE SOMPFileMediaAbstract_sompReadBytes(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         byteStream : IN Corba.String; 
         length : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadBytes);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadBytes, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadBytes (
         Self.som_object,
         Ev,
         byteStream,
         length,
         SOMPFileMediaAbstractClassData.sompReadBytes);
   END sompReadBytes;

   PROCEDURE sompWriteBytes (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      byteStream : IN Corba.String; 
      length : IN Corba.Long)
   IS
     
     -- Write a byte stream of the given length to the media.
      PROCEDURE SOMPFileMediaAbstract_sompWriteBytes(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         byteStream : IN Corba.String; 
         length : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteBytes);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteBytes, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteBytes (
         Self.som_object,
         Ev,
         byteStream,
         length,
         SOMPFileMediaAbstractClassData.sompWriteBytes);
   END sompWriteBytes;

   PROCEDURE sompWriteOctet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i1 : IN Corba.Octet)
   IS
     
     -- Writes the given 8-bit integer
      PROCEDURE SOMPFileMediaAbstract_sompWriteOctet(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i1 : IN Corba.Octet;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteOctet);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteOctet, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteOctet (
         Self.som_object,
         Ev,
         i1,
         SOMPFileMediaAbstractClassData.sompWriteOctet);
   END sompWriteOctet;

   PROCEDURE sompWriteShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i2 : IN Corba.Short)
   IS
     
     -- Writes the given short integer
      PROCEDURE SOMPFileMediaAbstract_sompWriteShort(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i2 : IN Corba.Short;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteShort);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteShort, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteShort (
         Self.som_object,
         Ev,
         i2,
         SOMPFileMediaAbstractClassData.sompWriteShort);
   END sompWriteShort;

   PROCEDURE sompWriteUnsignedShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      u2 : IN Corba.Unsigned_Short)
   IS
     
     -- Writes the given unsigned short integer
      PROCEDURE SOMPFileMediaAbstract_sompWriteUnsignedShort(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         u2 : IN Corba.Unsigned_Short;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteUnsignedShort);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteUnsignedShort, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteUnsignedShort (
         Self.som_object,
         Ev,
         u2,
         SOMPFileMediaAbstractClassData.sompWriteUnsignedShort);
   END sompWriteUnsignedShort;

   PROCEDURE sompWriteLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i4 : IN Corba.Long)
   IS
     
     -- Writes the given long integer
      PROCEDURE SOMPFileMediaAbstract_sompWriteLong(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i4 : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteLong);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteLong, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteLong (
         Self.som_object,
         Ev,
         i4,
         SOMPFileMediaAbstractClassData.sompWriteLong);
   END sompWriteLong;

   PROCEDURE sompWriteUnsignedLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      u4 : IN Corba.Unsigned_Long)
   IS
     
     -- Writes the given unsigned long integer
      PROCEDURE SOMPFileMediaAbstract_sompWriteUnsignedLong(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         u4 : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteUnsignedLong);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteUnsignedLong, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteUnsignedLong (
         Self.som_object,
         Ev,
         u4,
         SOMPFileMediaAbstractClassData.sompWriteUnsignedLong);
   END sompWriteUnsignedLong;

   PROCEDURE sompWriteDouble (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f8 : IN Corba.Double)
   IS
     
     -- Writes the given double-precision float
      PROCEDURE SOMPFileMediaAbstract_sompWriteDouble(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         f8 : IN Corba.Double;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteDouble);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteDouble, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteDouble (
         Self.som_object,
         Ev,
         f8,
         SOMPFileMediaAbstractClassData.sompWriteDouble);
   END sompWriteDouble;

   PROCEDURE sompWriteFloat (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f4 : IN Corba.Float)
   IS
     
     -- Writes the given float
      PROCEDURE SOMPFileMediaAbstract_sompWriteFloat(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         f4 : IN Corba.Float;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteFloat);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteFloat, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteFloat (
         Self.som_object,
         Ev,
         f4,
         SOMPFileMediaAbstractClassData.sompWriteFloat);
   END sompWriteFloat;

   PROCEDURE sompWriteCharacter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      c : IN Corba.Char)
   IS
     
     -- Writes the given character
      PROCEDURE SOMPFileMediaAbstract_sompWriteCharacter(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         c : IN Corba.Char;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteCharacter);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteCharacter, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteCharacter (
         Self.som_object,
         Ev,
         c,
         SOMPFileMediaAbstractClassData.sompWriteCharacter);
   END sompWriteCharacter;

   PROCEDURE sompWriteSomobject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      so : IN SOM.SOMObjectPtr; 
      parentObject : IN SOM.SOMObjectPtr)
   IS
     
     -- Writes the given object.  Uses parentObject to determine whether relative
     -- Ids are used.  If object (so) has no persistent parent, client passes
     -- NULL parentObject.
      PROCEDURE SOMPFileMediaAbstract_sompWriteSomobject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         so : IN SOM.SOMObjectPtr; 
         parentObject : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteSomobject);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteSomobject, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteSomobject (
         Self.som_object,
         Ev,
         so,
         parentObject,
         SOMPFileMediaAbstractClassData.sompWriteSomobject);
   END sompWriteSomobject;

   PROCEDURE sompWriteString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      wstring : IN Corba.String)
   IS
     
     -- Writes the given string to the media.
     --
      PROCEDURE SOMPFileMediaAbstract_sompWriteString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         wstring : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteString);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteString, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteString (
         Self.som_object,
         Ev,
         wstring,
         SOMPFileMediaAbstractClassData.sompWriteString);
   END sompWriteString;

   PROCEDURE sompReadOctet (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i1 : IN OUT Corba.Octet)
   IS
     
     -- Reads an 8-bit integer into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadOctet(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i1 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadOctet);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadOctet, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadOctet (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(i1'address),
         SOMPFileMediaAbstractClassData.sompReadOctet);
   END sompReadOctet;

   PROCEDURE sompReadShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i2 : IN OUT Corba.Short)
   IS
     
     -- Reads a short integer into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadShort(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i2 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadShort);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadShort, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadShort (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(i2'address),
         SOMPFileMediaAbstractClassData.sompReadShort);
   END sompReadShort;

   PROCEDURE sompReadUnsignedShort (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      u2 : IN OUT Corba.Unsigned_Short)
   IS
     
     -- Reads an unsigned short integer into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadUnsignedShort(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         u2 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadUnsignedShort);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadUnsignedShort, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadUnsignedShort (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(u2'address),
         SOMPFileMediaAbstractClassData.sompReadUnsignedShort);
   END sompReadUnsignedShort;

   PROCEDURE sompReadLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i4 : IN OUT Corba.Long)
   IS
     
     -- Reads a long integer into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadLong(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i4 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadLong);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadLong, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadLong (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(i4'address),
         SOMPFileMediaAbstractClassData.sompReadLong);
   END sompReadLong;

   PROCEDURE sompReadUnsignedLong (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      i4 : IN OUT Corba.Unsigned_Long)
   IS
     
     -- Reads a long integer into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadUnsignedLong(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         i4 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadUnsignedLong);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadUnsignedLong, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadUnsignedLong (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(i4'address),
         SOMPFileMediaAbstractClassData.sompReadUnsignedLong);
   END sompReadUnsignedLong;

   PROCEDURE sompReadDouble (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f8 : IN OUT Corba.Double)
   IS
     
     -- Reads a float into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadDouble(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         f8 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadDouble);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadDouble, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadDouble (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(f8'address),
         SOMPFileMediaAbstractClassData.sompReadDouble);
   END sompReadDouble;

   PROCEDURE sompReadFloat (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      f4 : IN OUT Corba.Float)
   IS
     
     -- Reads a float into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadFloat(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         f4 : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadFloat);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadFloat, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadFloat (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(f4'address),
         SOMPFileMediaAbstractClassData.sompReadFloat);
   END sompReadFloat;

   PROCEDURE sompReadCharacter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      c : IN OUT Corba.Char)
   IS
     
     -- Reads a character into memory at given the pointer
      PROCEDURE SOMPFileMediaAbstract_sompReadCharacter(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         c : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadCharacter);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadCharacter, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadCharacter (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(c'address),
         SOMPFileMediaAbstractClassData.sompReadCharacter);
   END sompReadCharacter;

   PROCEDURE sompReadSomobject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      so : IN OUT SOM.SOMObjectPtr)
   IS
     
     -- Instantiates and returns a new object of the class specified in
     -- the file. Standard SOM objects are simply instantiated. Persistent
     -- objects are instantiated and marked for restoration.
      PROCEDURE SOMPFileMediaAbstract_sompReadSomobject(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         so : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadSomobject);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadSomobject, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadSomobject (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(so'address),
         SOMPFileMediaAbstractClassData.sompReadSomobject);
   END sompReadSomobject;

   PROCEDURE sompReadString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      rstring : IN OUT Corba.String)
   IS
     
     -- Read and allocate a string. Input is a pointer to a string. The input
     -- pointer is modified to point to a newly allocated buffer which
     -- will contain the string read from the media.
     -- Callers are responsible for freeing the returned buffer with SOMFree.
     -- If you want to read a string into a predefined buffer,
     -- use sompReadStringToBuffer.
     --
     -- This method can be used to read strings which were stored by
     -- sompWriteString.
      PROCEDURE SOMPFileMediaAbstract_sompReadString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         rstring : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadString);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadString, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadString (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(rstring'address),
         SOMPFileMediaAbstractClassData.sompReadString);
   END sompReadString;

   PROCEDURE sompReadStringToBuffer (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buffer : IN Corba.String; 
      bufsize : IN Corba.Long)
   IS
     
     -- Read a string into the preallocated buffer given. The size of the
     -- buffer is given in <bufsize>. If the string read is larger than
     -- bufsize it is truncated to fit in bufsize.
     --
     -- This method can be used to read strings which were stored by
     -- sompWriteString.
      PROCEDURE SOMPFileMediaAbstract_sompReadStringToBuffer(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         buffer : IN Corba.String; 
         bufsize : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadStringToBuffer);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadStringToBuffer, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadStringToBuffer (
         Self.som_object,
         Ev,
         buffer,
         bufsize,
         SOMPFileMediaAbstractClassData.sompReadStringToBuffer);
   END sompReadStringToBuffer;

   PROCEDURE sompWriteLine (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buffer : IN Corba.String)
   IS
     
     -- Writes the given string in <buffer> at the current position.
     -- The terminating null character (\0) is not written.
     --
     -- This method does NOT append a newline character (\n) to the
     -- given string before writing. If the user of this method intends to
     -- restore this <buffer> of data with sompReadLine, the user must
     -- put the newline character in the <buffer> before calling this
     -- method.
      PROCEDURE SOMPFileMediaAbstract_sompWriteLine(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         buffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteLine);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteLine, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteLine (
         Self.som_object,
         Ev,
         buffer,
         SOMPFileMediaAbstractClassData.sompWriteLine);
   END sompWriteLine;

   PROCEDURE sompReadLine (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buffer : IN Corba.String; 
      bufsize : IN Corba.Long)
   IS
     
     -- Read a string up to and including the first newline character (\n)
     -- into the preallocated buffer given.
     -- Use this method for reading strings stored with sompWriteLine.
     --
     -- The size of the buffer is given in <bufsize>. If the string read is
     -- larger than bufsize it is truncated to fit in bufsize.
     --
     -- The characters read are stored in <buffer>, and a null character (\0)
     -- is appended. The newline character, if read, is included in the string.
      PROCEDURE SOMPFileMediaAbstract_sompReadLine(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         buffer : IN Corba.String; 
         bufsize : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadLine);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadLine, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadLine (
         Self.som_object,
         Ev,
         buffer,
         bufsize,
         SOMPFileMediaAbstractClassData.sompReadLine);
   END sompReadLine;

   PROCEDURE sompWriteTypeCode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      tc : IN Corba.TypeCode.Object)
   IS
     
     -- Writes a restoreable version of an IDL type code. Restore with
     -- sompReadTypeCode().
      PROCEDURE SOMPFileMediaAbstract_sompWriteTypeCode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         tc : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompWriteTypeCode);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompWriteTypeCode, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompWriteTypeCode (
         Self.som_object,
         Ev,
         tc,
         SOMPFileMediaAbstractClassData.sompWriteTypeCode);
   END sompWriteTypeCode;

   PROCEDURE sompReadTypeCode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      tc : IN OUT Corba.TypeCode.Object)
   IS
     
     -- Restores an IDL type code that was stored with sompWriteTypeCode().
      PROCEDURE SOMPFileMediaAbstract_sompReadTypeCode(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         tc : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPFileMediaAbstract_sompReadTypeCode);
      PRAGMA interface_information (SOMPFileMediaAbstract_sompReadTypeCode, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract_sompReadTypeCode (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(tc'address),
         SOMPFileMediaAbstractClassData.sompReadTypeCode);
   END sompReadTypeCode;

   PROCEDURE sompOpen (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPMediaInterfaceAbstract.sompOpen (
         SOMPMediaInterfaceAbstract.Ref'(som_object=>Self.som_object),
         Ev);
   END sompOpen;

   PROCEDURE sompClose (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPMediaInterfaceAbstract.sompClose (
         SOMPMediaInterfaceAbstract.Ref'(som_object=>Self.som_object),
         Ev);
   END sompClose;

END SOMPFileMediaAbstract; 







