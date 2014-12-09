
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:52 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMUTId;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMUTStringId IS

   
   -- This is the abstract base class for an ASCIIZ string (an ASCII string
   -- terminated with a zero) based ID. Refer to derived classes for details.
   --
   -- Intances of classes derived from this one should represent a string
   -- value which can be used to identify something... such as an object,
   -- a file, a network node, etc, etc...
   --

   TYPE Ref IS NEW SOMUTId.Ref WITH NULL RECORD;

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
      


   FUNCTION somutSetIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IdString : IN Corba.String)
      RETURN Corba.Long;
     
     -- Sets the ID to the given string.
     -- Returns nonzero error code if given IdString is not syntactically correct.

   FUNCTION somutGetIdString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      toBuffer : IN Corba.String)
      RETURN Corba.String;
     
     -- Stores the ID as a string into the given buffer <toBuffer> and
     -- returns the buffer <toBuffer>.
     -- Use somutGetIdStringLen to determine appropriate <toBuffer> size.

   FUNCTION somutGetIdStringLen (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Long;
     
     -- Returns the length of the ID string.

   FUNCTION somutEqualsString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IdString : IN Corba.String)
      RETURN Corba.Boolean;
     
     -- Checks to see if this object's ID is equivalent to the given string.
     -- Returns TRUE if the ID is equivalent to the string, FALSE otherwise.

   FUNCTION somutCompareString (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      IdString : IN Corba.String)
      RETURN Corba.Short;
     
     -- Performs an ordered comparison with the given string.
     -- If this ID < IdString -1 is returned.
     -- If this ID = IdString  0 is returned.
     -- If this ID > IdString  1 is returned.

   PROCEDURE somutSetIdId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr);

   FUNCTION somutEqualsId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;

   FUNCTION somutCompareId (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Short;

   FUNCTION somutHashId (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long;

END SOMUTStringId; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMUTStringId IS

   
   -- This is the abstract base class for an ASCIIZ string (an ASCII string
   -- terminated with a zero) based ID. Refer to derived classes for details.
   --
   -- Intances of classes derived from this one should represent a string
   -- value which can be used to identify something... such as an object,
   -- a file, a network node, etc, etc...
   --

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somutSetIdString : SOM.somMToken;
      somutGetIdString : SOM.somMToken;
      somutGetIdStringLen : SOM.somMToken;
      somutEqualsString : SOM.somMToken;
      somutCompareString : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMUTStringIdClassData : classData;
   FOR SOMUTStringIdClassData USE AT standard.system.label("SOMUTStringIdClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMUTStringIdCClassData : CClassData;
   FOR SOMUTStringIdCClassData USE AT standard.system.label("SOMUTStringIdCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMUTStringIdClassData.classObject) 
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
      FUNCTION SOMUTStringIdNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMUTStringIdNewClass);
      PRAGMA interface_information (SOMUTStringIdNewClass, ".SOMUTStringIdNewClass");
   BEGIN
      RETURN SOMUTStringIdNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMUTStringIdClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMUTStringIdClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somutSetIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IdString : IN Corba.String)
      RETURN Corba.Long
   IS
     
     -- Sets the ID to the given string.
     -- Returns nonzero error code if given IdString is not syntactically correct.
      FUNCTION SOMUTStringId_somutSetIdString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IdString : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMUTStringId_somutSetIdString);
      PRAGMA interface_information (SOMUTStringId_somutSetIdString, ".xsomcall3");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTStringId_somutSetIdString (
            Self.som_object,
            Ev,
            IdString,
            SOMUTStringIdClassData.somutSetIdString);
      RETURN Result;
   END somutSetIdString; 

   FUNCTION somutGetIdString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      toBuffer : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Stores the ID as a string into the given buffer <toBuffer> and
     -- returns the buffer <toBuffer>.
     -- Use somutGetIdStringLen to determine appropriate <toBuffer> size.
      FUNCTION SOMUTStringId_somutGetIdString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         toBuffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMUTStringId_somutGetIdString);
      PRAGMA interface_information (SOMUTStringId_somutGetIdString, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTStringId_somutGetIdString (
            Self.som_object,
            Ev,
            toBuffer,
            SOMUTStringIdClassData.somutGetIdString);
      RETURN Result;
   END somutGetIdString; 

   FUNCTION somutGetIdStringLen (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Long
   IS
     
     -- Returns the length of the ID string.
      FUNCTION SOMUTStringId_somutGetIdStringLen(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMUTStringId_somutGetIdStringLen);
      PRAGMA interface_information (SOMUTStringId_somutGetIdStringLen, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTStringId_somutGetIdStringLen (
            Self.som_object,
            Ev,
            SOMUTStringIdClassData.somutGetIdStringLen);
      RETURN Result;
   END somutGetIdStringLen; 

   FUNCTION somutEqualsString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IdString : IN Corba.String)
      RETURN Corba.Boolean
   IS
     
     -- Checks to see if this object's ID is equivalent to the given string.
     -- Returns TRUE if the ID is equivalent to the string, FALSE otherwise.
      FUNCTION SOMUTStringId_somutEqualsString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IdString : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMUTStringId_somutEqualsString);
      PRAGMA interface_information (SOMUTStringId_somutEqualsString, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTStringId_somutEqualsString (
            Self.som_object,
            Ev,
            IdString,
            SOMUTStringIdClassData.somutEqualsString);
      RETURN Result;
   END somutEqualsString; 

   FUNCTION somutCompareString (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      IdString : IN Corba.String)
      RETURN Corba.Short
   IS
     
     -- Performs an ordered comparison with the given string.
     -- If this ID < IdString -1 is returned.
     -- If this ID = IdString  0 is returned.
     -- If this ID > IdString  1 is returned.
      FUNCTION SOMUTStringId_somutCompareString(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         IdString : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMUTStringId_somutCompareString);
      PRAGMA interface_information (SOMUTStringId_somutCompareString, ".xsomcall3");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMUTStringId_somutCompareString (
            Self.som_object,
            Ev,
            IdString,
            SOMUTStringIdClassData.somutCompareString);
      RETURN Result;
   END somutCompareString; 

   PROCEDURE somutSetIdId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMUTId.somutSetIdId (
         SOMUTId.Ref'(som_object=>Self.som_object),
         Ev,
         otherId);
   END somutSetIdId;

   FUNCTION somutEqualsId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTId.somutEqualsId (
            SOMUTId.Ref'(som_object=>Self.som_object),
            Ev,
            otherId);
   END somutEqualsId;

   FUNCTION somutCompareId (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      otherId : IN SOM.SOMObjectPtr)
      RETURN Corba.Short
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTId.somutCompareId (
            SOMUTId.Ref'(som_object=>Self.som_object),
            Ev,
            otherId);
   END somutCompareId;

   FUNCTION somutHashId (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Unsigned_Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMUTId.somutHashId (
            SOMUTId.Ref'(som_object=>Self.som_object),
            Ev);
   END somutHashId;

END SOMUTStringId; 







