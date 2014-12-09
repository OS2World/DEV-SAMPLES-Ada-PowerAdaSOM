
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:54 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMStringTableC IS

   
   -- Objects of the SOMStringTableC class are symbol tables that map null
   -- terminated strings to null terminated strings.  While any instance
   -- of this class can hold an indefinite number of sysbols, performance
   -- will be inproved if the instance is created with an appropriate
   -- maximum target capacity.

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
      


   FUNCTION get_somstTargetCapacity (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- The expected maximum number of associations for this table.
     -- Accuracy can result in improved performance.  A low target may
     -- result in some storage saving, but at the cost of performance.
     -- Note: this attribute must be set before any strings are added to
     -- the string table or it will not be setable.

   PROCEDURE set_somstTargetCapacity (
      Self : IN Ref;
      somstTargetCapacity : IN Corba.Unsigned_Long);
     
     -- The expected maximum number of associations for this table.
     -- Accuracy can result in improved performance.  A low target may
     -- result in some storage saving, but at the cost of performance.
     -- Note: this attribute must be set before any strings are added to
     -- the string table or it will not be setable.

   FUNCTION get_somstAssociationsCount (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long;
     
     -- The number of associations currently in this table

   FUNCTION somstAssociate (
      Self : IN Ref;
      key : IN Corba.String;
      value : IN Corba.String)
      RETURN Corba.Short;
     
     -- Associates <key> and <value>.  After this call, whenever <key> is
     -- lookedup, <value> will be returned.
     -- Zero will be returned if the association cannot be accomplished
     -- (<key> is null, or memory is not available), -1 will be returned
     -- if the association suceeds, but <key> had a previous association,
     -- and 1 is returned if the association suceeds and <key> had no
     -- previous association.
     -- Note: the string table takes over ownership of both <key> and
     -- <value>.

   FUNCTION somstAssociateCopyKey (
      Self : IN Ref;
      key : IN Corba.String;
      value : IN Corba.String)
      RETURN Corba.Short;
     
     -- Same as <somstAssociate> except don't take ownership of <key>.

   FUNCTION somstAssociateCopyValue (
      Self : IN Ref;
      key : IN Corba.String;
      value : IN Corba.String)
      RETURN Corba.Short;
     
     -- Same as <somstAssociate> except don't take ownership of <value>.

   FUNCTION somstAssociateCopyBoth (
      Self : IN Ref;
      key : IN Corba.String;
      value : IN Corba.String)
      RETURN Corba.Short;
     
     -- Same as <somstAssociate> except don't take ownership of <key> or
     -- <value>.

   FUNCTION somstGetAssociation (
      Self : IN Ref;
      key : IN Corba.String)
      RETURN Corba.String;
     
     -- The string associated with <key> is returned if there is one and
     -- NULL is returned if <key> has no association.
     -- The string table will maintain ownership of any returned value.

   FUNCTION somstClearAssociation (
      Self : IN Ref;
      key : IN Corba.String)
      RETURN Corba.Boolean;
     
     -- The association for <key>, if any, is removed.
     -- 1 is returned if <key> had an association, and 0 is returned if
     -- it did not.

   FUNCTION somstGetIthKey (
      Self : IN Ref;
      i : IN Corba.Unsigned_Long)
      RETURN Corba.String;
     
     -- Returns the key part of the <i> association in this string table
     -- if there is one and null otherwise.
     -- The order of associations in a string table is not specified, but
     -- will not change unless changes are made in the table.
     -- Ownership of the key is retained, the pointer returned is valid
     -- until any changes are made in the table.

   FUNCTION somstGetIthValue (
      Self : IN Ref;
      i : IN Corba.Unsigned_Long)
      RETURN Corba.String;
     
     -- Returns the value part of the <i> association in this string table
     -- if there is one and null otherwise.
     -- The order of associations in a string table is not specified, but
     -- will not change unless changes are made in the table.
     -- Ownership of the value is retained, the pointer returned is valid
     -- until any changes are made in the table.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   FUNCTION somPrintSelf (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMStringTableC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMStringTableC IS

   
   -- Objects of the SOMStringTableC class are symbol tables that map null
   -- terminated strings to null terminated strings.  While any instance
   -- of this class can hold an indefinite number of sysbols, performance
   -- will be inproved if the instance is created with an appropriate
   -- maximum target capacity.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somstTargetCapacity : SOM.somMToken;
      set_somstTargetCapacity : SOM.somMToken;
      get_somstAssociationsCount : SOM.somMToken;
      somstAssociate : SOM.somMToken;
      somstAssociateCopyKey : SOM.somMToken;
      somstAssociateCopyValue : SOM.somMToken;
      somstAssociateCopyBoth : SOM.somMToken;
      somstGetAssociation : SOM.somMToken;
      somstClearAssociation : SOM.somMToken;
      somstGetIthKey : SOM.somMToken;
      somstGetIthValue : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMStringTableCClassData : classData;
   FOR SOMStringTableCClassData USE AT standard.system.label("SOMStringTableCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMStringTableCCClassData : CClassData;
   FOR SOMStringTableCCClassData USE AT standard.system.label("SOMStringTableCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMStringTableCClassData.classObject) 
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
      FUNCTION SOMStringTableCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMStringTableCNewClass);
      PRAGMA interface_information (SOMStringTableCNewClass, ".SOMStringTableCNewClass");
   BEGIN
      RETURN SOMStringTableCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMStringTableCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMStringTableCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somstTargetCapacity (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- The expected maximum number of associations for this table.
     -- Accuracy can result in improved performance.  A low target may
     -- result in some storage saving, but at the cost of performance.
     -- Note: this attribute must be set before any strings are added to
     -- the string table or it will not be setable.
      FUNCTION SOMStringTableC_U_get_somstTargetCapacity(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMStringTableC_U_get_somstTargetCapacity);
      PRAGMA interface_information (SOMStringTableC_U_get_somstTargetCapacity, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_U_get_somstTargetCapacity (
            Self.som_object,
            SOMStringTableCClassData.get_somstTargetCapacity);
      RETURN Result;
   END get_somstTargetCapacity; 

   PROCEDURE set_somstTargetCapacity (
      Self : IN Ref; 
      somstTargetCapacity : IN Corba.Unsigned_Long)
   IS
     
     -- The expected maximum number of associations for this table.
     -- Accuracy can result in improved performance.  A low target may
     -- result in some storage saving, but at the cost of performance.
     -- Note: this attribute must be set before any strings are added to
     -- the string table or it will not be setable.
      PROCEDURE SOMStringTableC_U_set_somstTargetCapacity(
         Self : IN SOM.SOMObjectPtr; 
         somstTargetCapacity : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMStringTableC_U_set_somstTargetCapacity);
      PRAGMA interface_information (SOMStringTableC_U_set_somstTargetCapacity, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMStringTableC_U_set_somstTargetCapacity (
         Self.som_object,
         somstTargetCapacity,
         SOMStringTableCClassData.set_somstTargetCapacity);
   END set_somstTargetCapacity;

   FUNCTION get_somstAssociationsCount (
      Self : IN Ref)
      RETURN Corba.Unsigned_Long
   IS
     
     -- The number of associations currently in this table
      FUNCTION SOMStringTableC_U_get_somstAssociationsCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Unsigned_Long; 
      PRAGMA interface (assembly, SOMStringTableC_U_get_somstAssociationsCount);
      PRAGMA interface_information (SOMStringTableC_U_get_somstAssociationsCount, ".xsomcall1");
      Result : ALIASED Corba.Unsigned_Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_U_get_somstAssociationsCount (
            Self.som_object,
            SOMStringTableCClassData.get_somstAssociationsCount);
      RETURN Result;
   END get_somstAssociationsCount; 

   FUNCTION somstAssociate (
      Self : IN Ref; 
      key : IN Corba.String; 
      value : IN Corba.String)
      RETURN Corba.Short
   IS
     
     -- Associates <key> and <value>.  After this call, whenever <key> is
     -- lookedup, <value> will be returned.
     -- Zero will be returned if the association cannot be accomplished
     -- (<key> is null, or memory is not available), -1 will be returned
     -- if the association suceeds, but <key> had a previous association,
     -- and 1 is returned if the association suceeds and <key> had no
     -- previous association.
     -- Note: the string table takes over ownership of both <key> and
     -- <value>.
      FUNCTION SOMStringTableC_somstAssociate(
         Self : IN SOM.SOMObjectPtr; 
         key : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMStringTableC_somstAssociate);
      PRAGMA interface_information (SOMStringTableC_somstAssociate, ".xsomcall3");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstAssociate (
            Self.som_object,
            key,
            value,
            SOMStringTableCClassData.somstAssociate);
      RETURN Result;
   END somstAssociate; 

   FUNCTION somstAssociateCopyKey (
      Self : IN Ref; 
      key : IN Corba.String; 
      value : IN Corba.String)
      RETURN Corba.Short
   IS
     
     -- Same as <somstAssociate> except don't take ownership of <key>.
      FUNCTION SOMStringTableC_somstAssociateCopyKey(
         Self : IN SOM.SOMObjectPtr; 
         key : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMStringTableC_somstAssociateCopyKey);
      PRAGMA interface_information (SOMStringTableC_somstAssociateCopyKey, ".xsomcall3");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstAssociateCopyKey (
            Self.som_object,
            key,
            value,
            SOMStringTableCClassData.somstAssociateCopyKey);
      RETURN Result;
   END somstAssociateCopyKey; 

   FUNCTION somstAssociateCopyValue (
      Self : IN Ref; 
      key : IN Corba.String; 
      value : IN Corba.String)
      RETURN Corba.Short
   IS
     
     -- Same as <somstAssociate> except don't take ownership of <value>.
      FUNCTION SOMStringTableC_somstAssociateCopyValue(
         Self : IN SOM.SOMObjectPtr; 
         key : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMStringTableC_somstAssociateCopyValue);
      PRAGMA interface_information (SOMStringTableC_somstAssociateCopyValue, ".xsomcall3");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstAssociateCopyValue (
            Self.som_object,
            key,
            value,
            SOMStringTableCClassData.somstAssociateCopyValue);
      RETURN Result;
   END somstAssociateCopyValue; 

   FUNCTION somstAssociateCopyBoth (
      Self : IN Ref; 
      key : IN Corba.String; 
      value : IN Corba.String)
      RETURN Corba.Short
   IS
     
     -- Same as <somstAssociate> except don't take ownership of <key> or
     -- <value>.
      FUNCTION SOMStringTableC_somstAssociateCopyBoth(
         Self : IN SOM.SOMObjectPtr; 
         key : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Short; 
      PRAGMA interface (assembly, SOMStringTableC_somstAssociateCopyBoth);
      PRAGMA interface_information (SOMStringTableC_somstAssociateCopyBoth, ".xsomcall3");
      Result : ALIASED Corba.Short;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstAssociateCopyBoth (
            Self.som_object,
            key,
            value,
            SOMStringTableCClassData.somstAssociateCopyBoth);
      RETURN Result;
   END somstAssociateCopyBoth; 

   FUNCTION somstGetAssociation (
      Self : IN Ref; 
      key : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- The string associated with <key> is returned if there is one and
     -- NULL is returned if <key> has no association.
     -- The string table will maintain ownership of any returned value.
      FUNCTION SOMStringTableC_somstGetAssociation(
         Self : IN SOM.SOMObjectPtr; 
         key : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMStringTableC_somstGetAssociation);
      PRAGMA interface_information (SOMStringTableC_somstGetAssociation, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstGetAssociation (
            Self.som_object,
            key,
            SOMStringTableCClassData.somstGetAssociation);
      RETURN Result;
   END somstGetAssociation; 

   FUNCTION somstClearAssociation (
      Self : IN Ref; 
      key : IN Corba.String)
      RETURN Corba.Boolean
   IS
     
     -- The association for <key>, if any, is removed.
     -- 1 is returned if <key> had an association, and 0 is returned if
     -- it did not.
      FUNCTION SOMStringTableC_somstClearAssociation(
         Self : IN SOM.SOMObjectPtr; 
         key : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMStringTableC_somstClearAssociation);
      PRAGMA interface_information (SOMStringTableC_somstClearAssociation, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstClearAssociation (
            Self.som_object,
            key,
            SOMStringTableCClassData.somstClearAssociation);
      RETURN Result;
   END somstClearAssociation; 

   FUNCTION somstGetIthKey (
      Self : IN Ref; 
      i : IN Corba.Unsigned_Long)
      RETURN Corba.String
   IS
     
     -- Returns the key part of the <i> association in this string table
     -- if there is one and null otherwise.
     -- The order of associations in a string table is not specified, but
     -- will not change unless changes are made in the table.
     -- Ownership of the key is retained, the pointer returned is valid
     -- until any changes are made in the table.
      FUNCTION SOMStringTableC_somstGetIthKey(
         Self : IN SOM.SOMObjectPtr; 
         i : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMStringTableC_somstGetIthKey);
      PRAGMA interface_information (SOMStringTableC_somstGetIthKey, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstGetIthKey (
            Self.som_object,
            i,
            SOMStringTableCClassData.somstGetIthKey);
      RETURN Result;
   END somstGetIthKey; 

   FUNCTION somstGetIthValue (
      Self : IN Ref; 
      i : IN Corba.Unsigned_Long)
      RETURN Corba.String
   IS
     
     -- Returns the value part of the <i> association in this string table
     -- if there is one and null otherwise.
     -- The order of associations in a string table is not specified, but
     -- will not change unless changes are made in the table.
     -- Ownership of the value is retained, the pointer returned is valid
     -- until any changes are made in the table.
      FUNCTION SOMStringTableC_somstGetIthValue(
         Self : IN SOM.SOMObjectPtr; 
         i : IN Corba.Unsigned_Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMStringTableC_somstGetIthValue);
      PRAGMA interface_information (SOMStringTableC_somstGetIthValue, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMStringTableC_somstGetIthValue (
            Self.som_object,
            i,
            SOMStringTableCClassData.somstGetIthValue);
      RETURN Result;
   END somstGetIthValue; 

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

   FUNCTION somPrintSelf (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMObject.somPrintSelf (
            SOMObject.Ref'(som_object=>Self.som_object));
   END somPrintSelf;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDumpSelfInt (
         SOMObject.Ref'(som_object=>Self.som_object),
         level);
   END somDumpSelfInt;

END SOMStringTableC; 







