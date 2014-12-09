
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:13 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMTEntryC;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTClassEntryC IS

   
   -- This entry is the anchor for all information about a class
   -- definition. The part it inherits from <SOMTEntryC> concerns
   -- the actual class statement in the interface definition.  The new
   -- methods and attributes provided by the class concern the class
   -- definition as a whole.
   -- A number of the possible statements in a class definition are
   -- optional, when they are missing from the class definition then
   -- methods that would return an entry for this kind of statement, will
   -- return NULL.

   TYPE Ref IS NEW SOMTEntryC.Ref WITH NULL RECORD;

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
      


   FUNCTION get_somtSourceFileName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the name of file containing the definition of this class.

   FUNCTION get_somtMetaClassEntry (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the entry for the meta class statement in class
     -- definition or NULL if there is no meta class statement.
     -- Note: the SOM architecture requires that all classes have a meta
     -- class, however <SOMClass> is its own metaclass. Thus, any attempt
     -- to walk up the metaclass chain must terminate when it finds a
     -- class that is its own meta class, otherwise an infinite loop is
     -- possible.

   FUNCTION get_somtClassModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The module that contains this class, or NULL if there is not one.

   FUNCTION get_somtNewMethodCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns the number of new methods introduced in this class
     -- definition.

   FUNCTION get_somtLocalInclude (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Returns true if the header files associated with this class
     -- definition should be included using local search, eg, "name.h"
     -- instead of <name.h>

   FUNCTION get_somtPrivateMethodCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of new private methods in class.

   FUNCTION get_somtStaticMethodCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of new static methods in class.

   FUNCTION get_somtOverrideMethodCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of new override methods in class.

   FUNCTION get_somtProcMethodCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of procedure methods for class.

   FUNCTION get_somtVAMethodCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of VarArg methods for class.

   FUNCTION get_somtBaseCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of base classes for class.

   FUNCTION get_somtExternalDataCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of external (public or private) data members for class.

   FUNCTION get_somtPublicDataCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of public data members for class.

   FUNCTION get_somtPrivateDataCount (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns number of private data members for class.

   FUNCTION get_somtMetaclassFor (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- If this is a metaclass, the class for which it is a metaclass, else NULL.

   FUNCTION get_somtForwardRef (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Whether this is a forward reference or not.

   FUNCTION somtGetFirstBaseClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the entry for the "left most" direct base class form for
     -- this class, if it has one and NULL otherwise.  Note: <SOMObject>
     -- does not have any base classes and therefore will terminate an
     -- attempt to walk up the base class chain.

   FUNCTION somtGetNextBaseClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the entry for the next direct base class form of this
     -- class, if it has one and NULL otherwise.  The direct base classes
     -- of a derived class are ordered from "left to right".

   FUNCTION somtGetFirstReleaseName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the first name in the release order statement for this
     -- entry if it has one and NULL otherwise.

   FUNCTION somtGetNextReleaseName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Returns the next name in the release order statement for this
     -- entry if it has one and NULL otherwise.

   FUNCTION somtGetReleaseNameList (
      Self : IN Ref;
      buffer : IN Corba.String)
      RETURN Corba.Long;
     
     -- Puts all the release names in <buffer> in template output form,
     -- buffer must be large enough, no tests are made.  The number of
     -- release names is returned.

   FUNCTION somtGetFirstPassthru (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first passthru entry for this class definition if it
     -- has one and NULL otherwise.

   FUNCTION somtGetNextPassthru (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next passthru entry for this class definition if it
     -- has one and NULL otherwise.  The passthru entry will be returned
     -- in an order based on the appearence of passthru statements in the
     -- class definition.

   FUNCTION somtGetFirstData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first data entry for this class definition if it has
     -- one and NULL otherwise.

   FUNCTION somtGetNextData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next data entry for this class definition if it has
     -- one and NULL otherwise.  The data entries will be returned in an
     -- order based on the appearence data member declarations in the
     -- class definition.

   FUNCTION somtGetFirstStaticData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first static data entry for this class definition if it has
     -- one and NULL otherwise. Static data is handled specialy in SOM so a
     -- different accessor method is provided.

   FUNCTION somtGetNextStaticData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next static data entry for this class definition if it has
     -- one and NULL otherwise.  The data entries will be returned in an
     -- order based on the release order

   FUNCTION somtGetFirstMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first method entry for this class definition if it
     -- has one and NULL otherwise.  Method entries may be for new or
     -- overridden methods.

   FUNCTION somtGetNextMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next method entry for this class definition if it has
     -- one and NULL otherwise.  The method entries will be returned in an
     -- order based on the appearence method declarations in the
     -- class definition.  Method entries may be for new or overridden methods.

   FUNCTION somtGetFirstInheritedMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first inherited and not overridden method entry for
     -- this class definition if it has one and NULL otherwise.

   FUNCTION somtGetNextInheritedMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next inherited and not overridden method entry for
     -- this class definition if it has one and NULL otherwise.  The
     -- method entries will be returned in an unspecified, but constant
     -- order.

   FUNCTION somtGetFirstAttribute (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextAttribute (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetFirstPubdef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtGetNextPubdef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;

   FUNCTION somtFilterNew (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 if entry is new in the class.

   FUNCTION somtFilterOverridden (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 if entry is an overriding method of the class.

   FUNCTION somtFilterPrivOrPub (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns TRUE if entry is Private or Public.

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref;
      emitter : IN SOM.SOMObjectPtr;
      prefix : IN Corba.String)
      RETURN Corba.Long;

   PROCEDURE somtSetEntryStruct (
      Self : IN Ref;
      es : IN OUT SCTypes.IDL_Entry);

   FUNCTION get_somtCScopedName (
      Self : IN Ref)
      RETURN Corba.String;

   FUNCTION get_somtIDLScopedName (
      Self : IN Ref)
      RETURN Corba.String;

END SOMTClassEntryC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTClassEntryC IS

   
   -- This entry is the anchor for all information about a class
   -- definition. The part it inherits from <SOMTEntryC> concerns
   -- the actual class statement in the interface definition.  The new
   -- methods and attributes provided by the class concern the class
   -- definition as a whole.
   -- A number of the possible statements in a class definition are
   -- optional, when they are missing from the class definition then
   -- methods that would return an entry for this kind of statement, will
   -- return NULL.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtSourceFileName : SOM.somMToken;
      get_somtMetaClassEntry : SOM.somMToken;
      get_somtNewMethodCount : SOM.somMToken;
      get_somtLocalInclude : SOM.somMToken;
      get_somtPrivateMethodCount : SOM.somMToken;
      get_somtStaticMethodCount : SOM.somMToken;
      get_somtOverrideMethodCount : SOM.somMToken;
      get_somtProcMethodCount : SOM.somMToken;
      get_somtVAMethodCount : SOM.somMToken;
      get_somtBaseCount : SOM.somMToken;
      get_somtExternalDataCount : SOM.somMToken;
      get_somtPublicDataCount : SOM.somMToken;
      get_somtPrivateDataCount : SOM.somMToken;
      somtGetFirstBaseClass : SOM.somMToken;
      somtGetNextBaseClass : SOM.somMToken;
      somtGetFirstReleaseName : SOM.somMToken;
      somtGetNextReleaseName : SOM.somMToken;
      somtGetReleaseNameList : SOM.somMToken;
      somtGetFirstPassthru : SOM.somMToken;
      somtGetNextPassthru : SOM.somMToken;
      somtGetFirstData : SOM.somMToken;
      somtGetNextData : SOM.somMToken;
      somtGetFirstMethod : SOM.somMToken;
      somtGetNextMethod : SOM.somMToken;
      somtGetFirstInheritedMethod : SOM.somMToken;
      somtGetNextInheritedMethod : SOM.somMToken;
      somtFilterNew : SOM.somMToken;
      somtFilterOverridden : SOM.somMToken;
      somtFilterPrivOrPub : SOM.somMToken;
      get_somtMetaclassFor : SOM.somMToken;
      get_somtForwardRef : SOM.somMToken;
      somtGetFirstAttribute : SOM.somMToken;
      somtGetNextAttribute : SOM.somMToken;
      somtGetFirstStruct : SOM.somMToken;
      somtGetNextStruct : SOM.somMToken;
      somtGetFirstTypedef : SOM.somMToken;
      somtGetNextTypedef : SOM.somMToken;
      somtGetFirstUnion : SOM.somMToken;
      somtGetNextUnion : SOM.somMToken;
      somtGetFirstEnum : SOM.somMToken;
      somtGetNextEnum : SOM.somMToken;
      somtGetFirstConstant : SOM.somMToken;
      somtGetNextConstant : SOM.somMToken;
      somtGetFirstSequence : SOM.somMToken;
      somtGetNextSequence : SOM.somMToken;
      get_somtClassModule : SOM.somMToken;
      somtGetFirstPubdef : SOM.somMToken;
      somtGetNextPubdef : SOM.somMToken;
      somtGetFirstStaticData : SOM.somMToken;
      somtGetNextStaticData : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTClassEntryCClassData : classData;
   FOR SOMTClassEntryCClassData USE AT standard.system.label("SOMTClassEntryCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTClassEntryCCClassData : CClassData;
   FOR SOMTClassEntryCCClassData USE AT standard.system.label("SOMTClassEntryCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTClassEntryCClassData.classObject) 
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
      FUNCTION SOMTClassEntryCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTClassEntryCNewClass);
      PRAGMA interface_information (SOMTClassEntryCNewClass, ".SOMTClassEntryCNewClass");
   BEGIN
      RETURN SOMTClassEntryCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTClassEntryCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTClassEntryCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtSourceFileName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the name of file containing the definition of this class.
      FUNCTION SOMTClassEntryC_U_get_somtSourceFileName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtSourceFileName);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtSourceFileName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtSourceFileName (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtSourceFileName);
      RETURN Result;
   END get_somtSourceFileName; 

   FUNCTION get_somtMetaClassEntry (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the entry for the meta class statement in class
     -- definition or NULL if there is no meta class statement.
     -- Note: the SOM architecture requires that all classes have a meta
     -- class, however <SOMClass> is its own metaclass. Thus, any attempt
     -- to walk up the metaclass chain must terminate when it finds a
     -- class that is its own meta class, otherwise an infinite loop is
     -- possible.
      FUNCTION SOMTClassEntryC_U_get_somtMetaClassEntry(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtMetaClassEntry);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtMetaClassEntry, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtMetaClassEntry (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtMetaClassEntry);
      RETURN Result;
   END get_somtMetaClassEntry; 

   FUNCTION get_somtClassModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The module that contains this class, or NULL if there is not one.
      FUNCTION SOMTClassEntryC_U_get_somtClassModule(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtClassModule);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtClassModule, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtClassModule (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtClassModule);
      RETURN Result;
   END get_somtClassModule; 

   FUNCTION get_somtNewMethodCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns the number of new methods introduced in this class
     -- definition.
      FUNCTION SOMTClassEntryC_U_get_somtNewMethodCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtNewMethodCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtNewMethodCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtNewMethodCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtNewMethodCount);
      RETURN Result;
   END get_somtNewMethodCount; 

   FUNCTION get_somtLocalInclude (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Returns true if the header files associated with this class
     -- definition should be included using local search, eg, "name.h"
     -- instead of <name.h>
      FUNCTION SOMTClassEntryC_U_get_somtLocalInclude(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtLocalInclude);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtLocalInclude, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtLocalInclude (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtLocalInclude);
      RETURN Result;
   END get_somtLocalInclude; 

   FUNCTION get_somtPrivateMethodCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of new private methods in class.
      FUNCTION SOMTClassEntryC_U_get_somtPrivateMethodCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtPrivateMethodCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtPrivateMethodCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtPrivateMethodCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtPrivateMethodCount);
      RETURN Result;
   END get_somtPrivateMethodCount; 

   FUNCTION get_somtStaticMethodCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of new static methods in class.
      FUNCTION SOMTClassEntryC_U_get_somtStaticMethodCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtStaticMethodCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtStaticMethodCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtStaticMethodCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtStaticMethodCount);
      RETURN Result;
   END get_somtStaticMethodCount; 

   FUNCTION get_somtOverrideMethodCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of new override methods in class.
      FUNCTION SOMTClassEntryC_U_get_somtOverrideMethodCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtOverrideMethodCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtOverrideMethodCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtOverrideMethodCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtOverrideMethodCount);
      RETURN Result;
   END get_somtOverrideMethodCount; 

   FUNCTION get_somtProcMethodCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of procedure methods for class.
      FUNCTION SOMTClassEntryC_U_get_somtProcMethodCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtProcMethodCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtProcMethodCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtProcMethodCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtProcMethodCount);
      RETURN Result;
   END get_somtProcMethodCount; 

   FUNCTION get_somtVAMethodCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of VarArg methods for class.
      FUNCTION SOMTClassEntryC_U_get_somtVAMethodCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtVAMethodCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtVAMethodCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtVAMethodCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtVAMethodCount);
      RETURN Result;
   END get_somtVAMethodCount; 

   FUNCTION get_somtBaseCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of base classes for class.
      FUNCTION SOMTClassEntryC_U_get_somtBaseCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtBaseCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtBaseCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtBaseCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtBaseCount);
      RETURN Result;
   END get_somtBaseCount; 

   FUNCTION get_somtExternalDataCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of external (public or private) data members for class.
      FUNCTION SOMTClassEntryC_U_get_somtExternalDataCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtExternalDataCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtExternalDataCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtExternalDataCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtExternalDataCount);
      RETURN Result;
   END get_somtExternalDataCount; 

   FUNCTION get_somtPublicDataCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of public data members for class.
      FUNCTION SOMTClassEntryC_U_get_somtPublicDataCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtPublicDataCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtPublicDataCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtPublicDataCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtPublicDataCount);
      RETURN Result;
   END get_somtPublicDataCount; 

   FUNCTION get_somtPrivateDataCount (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns number of private data members for class.
      FUNCTION SOMTClassEntryC_U_get_somtPrivateDataCount(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtPrivateDataCount);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtPrivateDataCount, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtPrivateDataCount (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtPrivateDataCount);
      RETURN Result;
   END get_somtPrivateDataCount; 

   FUNCTION get_somtMetaclassFor (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- If this is a metaclass, the class for which it is a metaclass, else NULL.
      FUNCTION SOMTClassEntryC_U_get_somtMetaclassFor(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtMetaclassFor);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtMetaclassFor, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtMetaclassFor (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtMetaclassFor);
      RETURN Result;
   END get_somtMetaclassFor; 

   FUNCTION get_somtForwardRef (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Whether this is a forward reference or not.
      FUNCTION SOMTClassEntryC_U_get_somtForwardRef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTClassEntryC_U_get_somtForwardRef);
      PRAGMA interface_information (SOMTClassEntryC_U_get_somtForwardRef, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_U_get_somtForwardRef (
            Self.som_object,
            SOMTClassEntryCClassData.get_somtForwardRef);
      RETURN Result;
   END get_somtForwardRef; 

   FUNCTION somtGetFirstBaseClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the entry for the "left most" direct base class form for
     -- this class, if it has one and NULL otherwise.  Note: <SOMObject>
     -- does not have any base classes and therefore will terminate an
     -- attempt to walk up the base class chain.
      FUNCTION SOMTClassEntryC_somtGetFirstBaseClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstBaseClass);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstBaseClass, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstBaseClass (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstBaseClass);
      RETURN Result;
   END somtGetFirstBaseClass; 

   FUNCTION somtGetNextBaseClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the entry for the next direct base class form of this
     -- class, if it has one and NULL otherwise.  The direct base classes
     -- of a derived class are ordered from "left to right".
      FUNCTION SOMTClassEntryC_somtGetNextBaseClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextBaseClass);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextBaseClass, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextBaseClass (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextBaseClass);
      RETURN Result;
   END somtGetNextBaseClass; 

   FUNCTION somtGetFirstReleaseName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the first name in the release order statement for this
     -- entry if it has one and NULL otherwise.
      FUNCTION SOMTClassEntryC_somtGetFirstReleaseName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstReleaseName);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstReleaseName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstReleaseName (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstReleaseName);
      RETURN Result;
   END somtGetFirstReleaseName; 

   FUNCTION somtGetNextReleaseName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Returns the next name in the release order statement for this
     -- entry if it has one and NULL otherwise.
      FUNCTION SOMTClassEntryC_somtGetNextReleaseName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextReleaseName);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextReleaseName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextReleaseName (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextReleaseName);
      RETURN Result;
   END somtGetNextReleaseName; 

   FUNCTION somtGetReleaseNameList (
      Self : IN Ref; 
      buffer : IN Corba.String)
      RETURN Corba.Long
   IS
     
     -- Puts all the release names in <buffer> in template output form,
     -- buffer must be large enough, no tests are made.  The number of
     -- release names is returned.
      FUNCTION SOMTClassEntryC_somtGetReleaseNameList(
         Self : IN SOM.SOMObjectPtr; 
         buffer : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetReleaseNameList);
      PRAGMA interface_information (SOMTClassEntryC_somtGetReleaseNameList, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetReleaseNameList (
            Self.som_object,
            buffer,
            SOMTClassEntryCClassData.somtGetReleaseNameList);
      RETURN Result;
   END somtGetReleaseNameList; 

   FUNCTION somtGetFirstPassthru (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first passthru entry for this class definition if it
     -- has one and NULL otherwise.
      FUNCTION SOMTClassEntryC_somtGetFirstPassthru(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstPassthru);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstPassthru, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstPassthru (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstPassthru);
      RETURN Result;
   END somtGetFirstPassthru; 

   FUNCTION somtGetNextPassthru (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next passthru entry for this class definition if it
     -- has one and NULL otherwise.  The passthru entry will be returned
     -- in an order based on the appearence of passthru statements in the
     -- class definition.
      FUNCTION SOMTClassEntryC_somtGetNextPassthru(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextPassthru);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextPassthru, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextPassthru (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextPassthru);
      RETURN Result;
   END somtGetNextPassthru; 

   FUNCTION somtGetFirstData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first data entry for this class definition if it has
     -- one and NULL otherwise.
      FUNCTION SOMTClassEntryC_somtGetFirstData(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstData);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstData, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstData (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstData);
      RETURN Result;
   END somtGetFirstData; 

   FUNCTION somtGetNextData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next data entry for this class definition if it has
     -- one and NULL otherwise.  The data entries will be returned in an
     -- order based on the appearence data member declarations in the
     -- class definition.
      FUNCTION SOMTClassEntryC_somtGetNextData(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextData);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextData, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextData (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextData);
      RETURN Result;
   END somtGetNextData; 

   FUNCTION somtGetFirstStaticData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first static data entry for this class definition if it has
     -- one and NULL otherwise. Static data is handled specialy in SOM so a
     -- different accessor method is provided.
      FUNCTION SOMTClassEntryC_somtGetFirstStaticData(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstStaticData);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstStaticData, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstStaticData (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstStaticData);
      RETURN Result;
   END somtGetFirstStaticData; 

   FUNCTION somtGetNextStaticData (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next static data entry for this class definition if it has
     -- one and NULL otherwise.  The data entries will be returned in an
     -- order based on the release order
      FUNCTION SOMTClassEntryC_somtGetNextStaticData(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextStaticData);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextStaticData, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextStaticData (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextStaticData);
      RETURN Result;
   END somtGetNextStaticData; 

   FUNCTION somtGetFirstMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first method entry for this class definition if it
     -- has one and NULL otherwise.  Method entries may be for new or
     -- overridden methods.
      FUNCTION SOMTClassEntryC_somtGetFirstMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstMethod);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstMethod (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstMethod);
      RETURN Result;
   END somtGetFirstMethod; 

   FUNCTION somtGetNextMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next method entry for this class definition if it has
     -- one and NULL otherwise.  The method entries will be returned in an
     -- order based on the appearence method declarations in the
     -- class definition.  Method entries may be for new or overridden methods.
      FUNCTION SOMTClassEntryC_somtGetNextMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextMethod);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextMethod (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextMethod);
      RETURN Result;
   END somtGetNextMethod; 

   FUNCTION somtGetFirstInheritedMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first inherited and not overridden method entry for
     -- this class definition if it has one and NULL otherwise.
      FUNCTION SOMTClassEntryC_somtGetFirstInheritedMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstInheritedMethod);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstInheritedMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstInheritedMethod (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstInheritedMethod);
      RETURN Result;
   END somtGetFirstInheritedMethod; 

   FUNCTION somtGetNextInheritedMethod (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next inherited and not overridden method entry for
     -- this class definition if it has one and NULL otherwise.  The
     -- method entries will be returned in an unspecified, but constant
     -- order.
      FUNCTION SOMTClassEntryC_somtGetNextInheritedMethod(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextInheritedMethod);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextInheritedMethod, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextInheritedMethod (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextInheritedMethod);
      RETURN Result;
   END somtGetNextInheritedMethod; 

   FUNCTION somtGetFirstAttribute (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstAttribute(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstAttribute);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstAttribute, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstAttribute (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstAttribute);
      RETURN Result;
   END somtGetFirstAttribute; 

   FUNCTION somtGetNextAttribute (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextAttribute(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextAttribute);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextAttribute, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextAttribute (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextAttribute);
      RETURN Result;
   END somtGetNextAttribute; 

   FUNCTION somtGetFirstStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstStruct(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstStruct);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstStruct, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstStruct (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstStruct);
      RETURN Result;
   END somtGetFirstStruct; 

   FUNCTION somtGetNextStruct (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextStruct(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextStruct);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextStruct, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextStruct (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextStruct);
      RETURN Result;
   END somtGetNextStruct; 

   FUNCTION somtGetFirstTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstTypedef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstTypedef);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstTypedef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstTypedef (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstTypedef);
      RETURN Result;
   END somtGetFirstTypedef; 

   FUNCTION somtGetNextTypedef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextTypedef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextTypedef);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextTypedef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextTypedef (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextTypedef);
      RETURN Result;
   END somtGetNextTypedef; 

   FUNCTION somtGetFirstUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstUnion(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstUnion);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstUnion, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstUnion (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstUnion);
      RETURN Result;
   END somtGetFirstUnion; 

   FUNCTION somtGetNextUnion (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextUnion(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextUnion);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextUnion, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextUnion (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextUnion);
      RETURN Result;
   END somtGetNextUnion; 

   FUNCTION somtGetFirstEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstEnum(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstEnum);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstEnum, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstEnum (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstEnum);
      RETURN Result;
   END somtGetFirstEnum; 

   FUNCTION somtGetNextEnum (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextEnum(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextEnum);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextEnum, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextEnum (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextEnum);
      RETURN Result;
   END somtGetNextEnum; 

   FUNCTION somtGetFirstConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstConstant(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstConstant);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstConstant, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstConstant (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstConstant);
      RETURN Result;
   END somtGetFirstConstant; 

   FUNCTION somtGetNextConstant (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextConstant(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextConstant);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextConstant, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextConstant (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextConstant);
      RETURN Result;
   END somtGetNextConstant; 

   FUNCTION somtGetFirstSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstSequence(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstSequence);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstSequence, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstSequence (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstSequence);
      RETURN Result;
   END somtGetFirstSequence; 

   FUNCTION somtGetNextSequence (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextSequence(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextSequence);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextSequence, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextSequence (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextSequence);
      RETURN Result;
   END somtGetNextSequence; 

   FUNCTION somtGetFirstPubdef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetFirstPubdef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetFirstPubdef);
      PRAGMA interface_information (SOMTClassEntryC_somtGetFirstPubdef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetFirstPubdef (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetFirstPubdef);
      RETURN Result;
   END somtGetFirstPubdef; 

   FUNCTION somtGetNextPubdef (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
      FUNCTION SOMTClassEntryC_somtGetNextPubdef(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtGetNextPubdef);
      PRAGMA interface_information (SOMTClassEntryC_somtGetNextPubdef, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtGetNextPubdef (
            Self.som_object,
            SOMTClassEntryCClassData.somtGetNextPubdef);
      RETURN Result;
   END somtGetNextPubdef; 

   FUNCTION somtFilterNew (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 if entry is new in the class.
      FUNCTION SOMTClassEntryC_somtFilterNew(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtFilterNew);
      PRAGMA interface_information (SOMTClassEntryC_somtFilterNew, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtFilterNew (
            Self.som_object,
            IDL_entry,
            SOMTClassEntryCClassData.somtFilterNew);
      RETURN Result;
   END somtFilterNew; 

   FUNCTION somtFilterOverridden (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 if entry is an overriding method of the class.
      FUNCTION SOMTClassEntryC_somtFilterOverridden(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtFilterOverridden);
      PRAGMA interface_information (SOMTClassEntryC_somtFilterOverridden, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtFilterOverridden (
            Self.som_object,
            IDL_entry,
            SOMTClassEntryCClassData.somtFilterOverridden);
      RETURN Result;
   END somtFilterOverridden; 

   FUNCTION somtFilterPrivOrPub (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns TRUE if entry is Private or Public.
      FUNCTION SOMTClassEntryC_somtFilterPrivOrPub(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTClassEntryC_somtFilterPrivOrPub);
      PRAGMA interface_information (SOMTClassEntryC_somtFilterPrivOrPub, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTClassEntryC_somtFilterPrivOrPub (
            Self.som_object,
            IDL_entry,
            SOMTClassEntryCClassData.somtFilterPrivOrPub);
      RETURN Result;
   END somtFilterPrivOrPub; 

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

   FUNCTION somtSetSymbolsOnEntry (
      Self : IN Ref; 
      emitter : IN SOM.SOMObjectPtr; 
      prefix : IN Corba.String)
      RETURN Corba.Long
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMTEntryC.somtSetSymbolsOnEntry (
            SOMTEntryC.Ref'(som_object=>Self.som_object),
            emitter,
            prefix);
   END somtSetSymbolsOnEntry;

   PROCEDURE somtSetEntryStruct (
      Self : IN Ref; 
      es : IN OUT SCTypes.IDL_Entry)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEntryC.somtSetEntryStruct (
         SOMTEntryC.Ref'(som_object=>Self.som_object),
         es);
   END somtSetEntryStruct;

   FUNCTION get_somtCScopedName (
      Self : IN Ref)
      RETURN Corba.String
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMTEntryC.get_somtCScopedName (
            SOMTEntryC.Ref'(som_object=>Self.som_object));
   END get_somtCScopedName;

   FUNCTION get_somtIDLScopedName (
      Self : IN Ref)
      RETURN Corba.String
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         SOMTEntryC.get_somtIDLScopedName (
            SOMTEntryC.Ref'(som_object=>Self.som_object));
   END get_somtIDLScopedName;

END SOMTClassEntryC; 







