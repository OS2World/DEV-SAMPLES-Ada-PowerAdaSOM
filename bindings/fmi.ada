
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:06 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMPFileMediaAbstract;
WITH SOMPStatDef;
WITH SOMPMediaInterfaceAbstract;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPAsciiMediaInterface IS

   
   -- The AsciiMediaInterface class is responsible for providing the
   -- interface to the file system. The numeric data it writes is in
   -- ASCII format.

   TYPE Ref IS NEW SOMPFileMediaAbstract.Ref WITH NULL RECORD;

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
      

   TYPE mediaFlags_Type IS
   RECORD
      open_for_read : Corba.Octet;
        
        -- 1=read only
      open_for_readwrite : Corba.Octet;
        
        -- 1=read/write
      create_if_nonexistent : Corba.Octet;
        
        -- 1=create if file nonexistent
      share : Corba.Octet;
        
        -- 1=allow multiple readers
   END RECORD;
   PRAGMA Preserve_Layout( mediaFlags_Type );

   SUBTYPE mediaFlagsType IS SOMPAsciiMediaInterface.mediaFlags_Type;

   TYPE mediaInfo_Type IS
   RECORD
      Name : Corba.String;
        
        -- file name
      Flags : SOMPAsciiMediaInterface.mediaFlagsType;
        
        -- flags, see mediaFlagsType
      unix_file_permissions : Corba.Unsigned_Short;
        
        -- file permissions (unused on OS/2)
   END RECORD;
   PRAGMA Preserve_Layout( mediaInfo_Type );

   SUBTYPE Local_sompstat is SOMPStatDef.sompstat;

   SUBTYPE mediaInfoType IS SOMPAsciiMediaInterface.mediaInfo_Type;


   PROCEDURE sompInitSpecific (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaInfo : IN OUT SOMPAsciiMediaInterface.mediaInfoType);
     
     -- Initialize MediaInterface with specific permissions and/or flags.

   PROCEDURE sompStat (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      fileStats : IN OUT Local_sompstat);
     
     -- Fills the stat structure for the file associated with this object.

   FUNCTION sompQueryBlockSize (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;
     
     -- This method returns an optimal block size for I/O operations. This
     -- method would likely be called prior to allocating a buffer to be used
     -- for reading/writing.

   FUNCTION sompGetMediaName (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      toBuffer : IN Corba.String)
      RETURN Corba.String;
     
     -- Puts the name of the file for the fmi object into toBuffer and returns
     -- the address of the buffer.  The buffer must be allocated (and freed)
     -- by the client.

   PROCEDURE sompInitReadWrite (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaInfo : IN Corba.String);

   PROCEDURE sompInitReadOnly (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      mediaInfo : IN Corba.String);

   PROCEDURE sompOpen (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   PROCEDURE sompClose (
      Self : IN Ref;
      Ev : IN SOM.Environment);

   PROCEDURE sompSeekPosition (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      offset : IN Corba.Long);

   PROCEDURE sompSeekPositionRel (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      offset : IN Corba.Long);

   FUNCTION sompGetOffset (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;

   PROCEDURE sompReadBytes (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      byteStream : IN Corba.String;
      length : IN Corba.Long);

   PROCEDURE sompWriteBytes (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      byteStream : IN Corba.String;
      length : IN Corba.Long);

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

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

   PROCEDURE sompWriteCharacter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      c : IN Corba.Char);

   PROCEDURE sompWriteSomobject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      so : IN SOM.SOMObjectPtr;
      parentObject : IN SOM.SOMObjectPtr);

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

   PROCEDURE sompReadCharacter (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      c : IN OUT Corba.Char);

   PROCEDURE sompReadSomobject (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      so : IN OUT SOM.SOMObjectPtr);

   PROCEDURE sompReadString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      rstring : IN OUT Corba.String);

   PROCEDURE sompReadStringToBuffer (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String;
      bufsize : IN Corba.Long);

   PROCEDURE sompWriteLine (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String);

   PROCEDURE sompReadLine (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      buffer : IN Corba.String;
      bufsize : IN Corba.Long);

   PROCEDURE sompWriteTypeCode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      tc : IN Corba.TypeCode.Object);

   PROCEDURE sompReadTypeCode (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      tc : IN OUT Corba.TypeCode.Object);

END SOMPAsciiMediaInterface; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMPAsciiMediaInterface IS

   
   -- The AsciiMediaInterface class is responsible for providing the
   -- interface to the file system. The numeric data it writes is in
   -- ASCII format.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      sompStat : SOM.somMToken;
      sompTruncate : SOM.somMToken;
      sompQueryBlockSize : SOM.somMToken;
      sompGetMediaName : SOM.somMToken;
      sompInitSpecific : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMPAsciiMediaInterfaceClassData : classData;
   FOR SOMPAsciiMediaInterfaceClassData USE AT standard.system.label("SOMPAsciiMediaInterfaceClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMPAsciiMediaInterfaceCClassData : CClassData;
   FOR SOMPAsciiMediaInterfaceCClassData USE AT standard.system.label("SOMPAsciiMediaInterfaceCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMPAsciiMediaInterfaceClassData.classObject) 
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
      FUNCTION SOMPAsciiMediaInterfaceNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMPAsciiMediaInterfaceNewClass);
      PRAGMA interface_information (SOMPAsciiMediaInterfaceNewClass, ".SOMPAsciiMediaInterfaceNewClass");
   BEGIN
      RETURN SOMPAsciiMediaInterfaceNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMPAsciiMediaInterfaceClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMPAsciiMediaInterfaceClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE sompInitSpecific (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaInfo : IN OUT SOMPAsciiMediaInterface.mediaInfoType)
   IS
     
     -- Initialize MediaInterface with specific permissions and/or flags.
      PROCEDURE SOMPAsciiMediaInterface_sompInitSpecific(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         mediaInfo : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPAsciiMediaInterface_sompInitSpecific);
      PRAGMA interface_information (SOMPAsciiMediaInterface_sompInitSpecific, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPAsciiMediaInterface_sompInitSpecific (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(mediaInfo'address),
         SOMPAsciiMediaInterfaceClassData.sompInitSpecific);
   END sompInitSpecific;

   PROCEDURE sompStat (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      fileStats : IN OUT Local_sompstat)
   IS
     
     -- Fills the stat structure for the file associated with this object.
      PROCEDURE SOMPAsciiMediaInterface_sompStat(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         fileStats : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMPAsciiMediaInterface_sompStat);
      PRAGMA interface_information (SOMPAsciiMediaInterface_sompStat, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPAsciiMediaInterface_sompStat (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(fileStats'address),
         SOMPAsciiMediaInterfaceClassData.sompStat);
   END sompStat;

   FUNCTION sompQueryBlockSize (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
     
     -- This method returns an optimal block size for I/O operations. This
     -- method would likely be called prior to allocating a buffer to be used
     -- for reading/writing.
      FUNCTION SOMPAsciiMediaInterface_sompQueryBlockSize(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMPAsciiMediaInterface_sompQueryBlockSize);
      PRAGMA interface_information (SOMPAsciiMediaInterface_sompQueryBlockSize, ".xsomcall2");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPAsciiMediaInterface_sompQueryBlockSize (
            Self.som_object,
            Ev,
            SOMPAsciiMediaInterfaceClassData.sompQueryBlockSize);
      RETURN Result;
   END sompQueryBlockSize; 

   FUNCTION sompGetMediaName (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      toBuffer : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Puts the name of the file for the fmi object into toBuffer and returns
     -- the address of the buffer.  The buffer must be allocated (and freed)
     -- by the client.
      FUNCTION SOMPAsciiMediaInterface_sompGetMediaName(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         toBuffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMPAsciiMediaInterface_sompGetMediaName);
      PRAGMA interface_information (SOMPAsciiMediaInterface_sompGetMediaName, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMPAsciiMediaInterface_sompGetMediaName (
            Self.som_object,
            Ev,
            toBuffer,
            SOMPAsciiMediaInterfaceClassData.sompGetMediaName);
      RETURN Result;
   END sompGetMediaName; 

   PROCEDURE sompInitReadWrite (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaInfo : IN Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompInitReadWrite (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         mediaInfo);
   END sompInitReadWrite;

   PROCEDURE sompInitReadOnly (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      mediaInfo : IN Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompInitReadOnly (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         mediaInfo);
   END sompInitReadOnly;

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

   PROCEDURE sompSeekPosition (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      offset : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompSeekPosition (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         offset);
   END sompSeekPosition;

   PROCEDURE sompSeekPositionRel (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      offset : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompSeekPositionRel (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         offset);
   END sompSeekPositionRel;

   FUNCTION sompGetOffset (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMPFileMediaAbstract.sompGetOffset (
            SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
            Ev);
   END sompGetOffset;

   PROCEDURE sompReadBytes (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      byteStream : IN Corba.String; 
      length : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadBytes (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         byteStream,
         length);
   END sompReadBytes;

   PROCEDURE sompWriteBytes (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      byteStream : IN Corba.String; 
      length : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteBytes (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         byteStream,
         length);
   END sompWriteBytes;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

   PROCEDURE somUninit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somUninit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somUninit;

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

   PROCEDURE sompWriteCharacter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      c : IN Corba.Char)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteCharacter (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         c);
   END sompWriteCharacter;

   PROCEDURE sompWriteSomobject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      so : IN SOM.SOMObjectPtr; 
      parentObject : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteSomobject (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         so,
         parentObject);
   END sompWriteSomobject;

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

   PROCEDURE sompReadCharacter (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      c : IN OUT Corba.Char)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadCharacter (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         c);
   END sompReadCharacter;

   PROCEDURE sompReadSomobject (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      so : IN OUT SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadSomobject (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         so);
   END sompReadSomobject;

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

   PROCEDURE sompWriteLine (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buffer : IN Corba.String)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteLine (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         buffer);
   END sompWriteLine;

   PROCEDURE sompReadLine (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      buffer : IN Corba.String; 
      bufsize : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadLine (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         buffer,
         bufsize);
   END sompReadLine;

   PROCEDURE sompWriteTypeCode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      tc : IN Corba.TypeCode.Object)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompWriteTypeCode (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         tc);
   END sompWriteTypeCode;

   PROCEDURE sompReadTypeCode (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      tc : IN OUT Corba.TypeCode.Object)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMPFileMediaAbstract.sompReadTypeCode (
         SOMPFileMediaAbstract.Ref'(som_object=>Self.som_object),
         Ev,
         tc);
   END sompReadTypeCode;

END SOMPAsciiMediaInterface; 







