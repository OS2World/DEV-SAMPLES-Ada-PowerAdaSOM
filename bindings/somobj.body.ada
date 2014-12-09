
WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMObject IS

   
   -- This is the SOM root class, all SOM classes must be descended from
   -- <SOMObject>. <SOMObject> has no instance data so there is no
   -- per-instance cost to to being descended from it.

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somInit : SOM.somMToken;
      somUninit : SOM.somMToken;
      somFree : SOM.somMToken;
      somDefaultVCopyInit : SOM.somMToken;
      somGetClassName : SOM.somMToken;
      somGetClass : SOM.somMToken;
      somIsA : SOM.somMToken;
      somRespondsTo : SOM.somMToken;
      somIsInstanceOf : SOM.somMToken;
      somGetSize : SOM.somMToken;
      somDumpSelf : SOM.somMToken;
      somDumpSelfInt : SOM.somMToken;
      somPrintSelf : SOM.somMToken;
      somDefaultConstVCopyInit : SOM.somMToken;
      somDispatchV : SOM.somMToken;
      somDispatchL : SOM.somMToken;
      somDispatchA : SOM.somMToken;
      somDispatchD : SOM.somMToken;
      somDispatch : SOM.somMToken;
      somClassDispatch : SOM.somMToken;
      somCastObj : SOM.somMToken;
      somResetObj : SOM.somMToken;
      somDefaultInit : SOM.somMToken;
      somDestruct : SOM.somMToken;
      somPrivate1 : SOM.somMToken;
      somPrivate2 : SOM.somMToken;
      somDefaultCopyInit : SOM.somMToken;
      somDefaultConstCopyInit : SOM.somMToken;
      somDefaultAssign : SOM.somMToken;
      somDefaultConstAssign : SOM.somMToken;
      somDefaultVAssign : SOM.somMToken;
      somDefaultConstVAssign : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMObjectClassData : classData;
   FOR SOMObjectClassData USE AT standard.system.label("SOMObjectClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMObjectCClassData : CClassData;
   FOR SOMObjectCClassData USE AT standard.system.label("SOMObjectCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMObjectClassData.classObject) 
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
      FUNCTION SOMObjectNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMObjectNewClass);
      PRAGMA interface_information (SOMObjectNewClass, ".SOMObjectNewClass");
   BEGIN
      RETURN SOMObjectNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMObjectClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMObjectClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   PROCEDURE somDefaultInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl)
   IS
     
     -- A default initializer for a SOM object. Passing a null ctrl
     -- indicates to the receiver that its class is the class of the
     -- object being initialized, whereby the initializer will determine
     -- an appropriate control structure.
      PROCEDURE SOMObject_somDefaultInit(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDefaultInit);
      PRAGMA interface_information (SOMObject_somDefaultInit, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDefaultInit (
         Self.som_object,
         SOM.To_SOM_Address(ctrl'address),
         SOMObjectClassData.somDefaultInit);
   END somDefaultInit;

   PROCEDURE somDestruct (
      Self : IN Ref; 
      doFree : IN Corba.Octet; 
      ctrl : IN OUT SOM.somDestructCtrl)
   IS
     
     -- The default destructor for a SOM object. A nonzero <doFree>
     -- indicates that the object storage should be freed by the
     -- object's class (via somDeallocate) after uninitialization.
     -- As with somDefaultInit, a null ctrl can be passed.
      PROCEDURE SOMObject_somDestruct(
         Self : IN SOM.SOMObjectPtr; 
         doFree : IN Corba.Octet; 
         ctrl : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDestruct);
      PRAGMA interface_information (SOMObject_somDestruct, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDestruct (
         Self.som_object,
         doFree,
         SOM.To_SOM_Address(ctrl'address),
         SOMObjectClassData.somDestruct);
   END somDestruct;

   PROCEDURE somDefaultCopyInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl; 
      fromObj : IN SOM.SOMObjectPtr)
   IS
     
     -- A default copy constructor. Use this to make copies of objects for
     -- calling methods with "by-value" argument semantics.
      PROCEDURE SOMObject_somDefaultCopyInit(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDefaultCopyInit);
      PRAGMA interface_information (SOMObject_somDefaultCopyInit, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDefaultCopyInit (
         Self.som_object,
         SOM.To_SOM_Address(ctrl'address),
         fromObj,
         SOMObjectClassData.somDefaultCopyInit);
   END somDefaultCopyInit;

   PROCEDURE somDefaultAssign (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somAssignCtrl; 
      fromObj : IN SOM.SOMObjectPtr; 
      Result : OUT SOM.SOMObjectPtr)
   IS
     
     -- A default assignment operator. Use this to "assign" the state of one
     -- object to another.
      FUNCTION SOMObject_somDefaultAssign(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMObject_somDefaultAssign);
      PRAGMA interface_information (SOMObject_somDefaultAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDefaultAssign (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            fromObj,
            SOMObjectClassData.somDefaultAssign);
   END somDefaultAssign;

   PROCEDURE somDefaultConstCopyInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl; 
      fromObj : IN SOM.SOMObjectPtr)
   IS
     
     -- A default copy constructor that uses a const fromObj.
      PROCEDURE SOMObject_somDefaultConstCopyInit(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDefaultConstCopyInit);
      PRAGMA interface_information (SOMObject_somDefaultConstCopyInit, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDefaultConstCopyInit (
         Self.som_object,
         SOM.To_SOM_Address(ctrl'address),
         fromObj,
         SOMObjectClassData.somDefaultConstCopyInit);
   END somDefaultConstCopyInit;

   PROCEDURE somDefaultVCopyInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl; 
      fromObj : IN SOM.SOMObjectPtr)
   IS
     
     -- A default copy constructor that uses a volatile fromObj.
      PROCEDURE SOMObject_somDefaultVCopyInit(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDefaultVCopyInit);
      PRAGMA interface_information (SOMObject_somDefaultVCopyInit, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDefaultVCopyInit (
         Self.som_object,
         SOM.To_SOM_Address(ctrl'address),
         fromObj,
         SOMObjectClassData.somDefaultVCopyInit);
   END somDefaultVCopyInit;

   PROCEDURE somDefaultConstVCopyInit (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somInitCtrl; 
      fromObj : IN SOM.SOMObjectPtr)
   IS
     
     -- A default copy constructor that uses a const volatile fromObj.
      PROCEDURE SOMObject_somDefaultConstVCopyInit(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDefaultConstVCopyInit);
      PRAGMA interface_information (SOMObject_somDefaultConstVCopyInit, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDefaultConstVCopyInit (
         Self.som_object,
         SOM.To_SOM_Address(ctrl'address),
         fromObj,
         SOMObjectClassData.somDefaultConstVCopyInit);
   END somDefaultConstVCopyInit;

   PROCEDURE somDefaultConstAssign (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somAssignCtrl; 
      fromObj : IN SOM.SOMObjectPtr; 
      Result : OUT SOM.SOMObjectPtr)
   IS
     
     -- A default assignment operator that uses a const fromObj.
      FUNCTION SOMObject_somDefaultConstAssign(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMObject_somDefaultConstAssign);
      PRAGMA interface_information (SOMObject_somDefaultConstAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDefaultConstAssign (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            fromObj,
            SOMObjectClassData.somDefaultConstAssign);
   END somDefaultConstAssign;

   PROCEDURE somDefaultVAssign (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somAssignCtrl; 
      fromObj : IN SOM.SOMObjectPtr; 
      Result : OUT SOM.SOMObjectPtr)
   IS
     
     -- A default assignment operator that uses a volatile fromObj.
      FUNCTION SOMObject_somDefaultVAssign(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMObject_somDefaultVAssign);
      PRAGMA interface_information (SOMObject_somDefaultVAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDefaultVAssign (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            fromObj,
            SOMObjectClassData.somDefaultVAssign);
   END somDefaultVAssign;

   PROCEDURE somDefaultConstVAssign (
      Self : IN Ref; 
      ctrl : IN OUT SOM.somAssignCtrl; 
      fromObj : IN SOM.SOMObjectPtr; 
      Result : OUT SOM.SOMObjectPtr)
   IS
     
     -- A default assignment operator that uses a const volatile fromObj.
      FUNCTION SOMObject_somDefaultConstVAssign(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address; 
         fromObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMObject_somDefaultConstVAssign);
      PRAGMA interface_information (SOMObject_somDefaultConstVAssign, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDefaultConstVAssign (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            fromObj,
            SOMObjectClassData.somDefaultConstVAssign);
   END somDefaultConstVAssign;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
     
     -- Obsolete but still supported. Override somDefaultInit instead of somInit.
      PROCEDURE SOMObject_somInit(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somInit);
      PRAGMA interface_information (SOMObject_somInit, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somInit (
         Self.som_object,
         SOMObjectClassData.somInit);
   END somInit;

   PROCEDURE somFree (
      Self : IN Ref)
   IS
     
     -- Obsolete but still supported. Use somDestruct with a nonzero
     -- <doFree> instead.
      PROCEDURE SOMObject_somFree(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somFree);
      PRAGMA interface_information (SOMObject_somFree, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somFree (
         Self.som_object,
         SOMObjectClassData.somFree);
   END somFree;

   PROCEDURE somUninit (
      Self : IN Ref)
   IS
     
     -- Obsolete but still supported. Override somDestruct instead of somUninit.
      PROCEDURE SOMObject_somUninit(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somUninit);
      PRAGMA interface_information (SOMObject_somUninit, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somUninit (
         Self.som_object,
         SOMObjectClassData.somUninit);
   END somUninit;

   FUNCTION somGetClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Return the receiver's class.
      FUNCTION SOMObject_somGetClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMObject_somGetClass);
      PRAGMA interface_information (SOMObject_somGetClass, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somGetClass (
            Self.som_object,
            SOMObjectClassData.somGetClass);
      RETURN Result;
   END somGetClass; 

   FUNCTION somGetClassName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- Return the name of the receiver's class.
      FUNCTION SOMObject_somGetClassName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMObject_somGetClassName);
      PRAGMA interface_information (SOMObject_somGetClassName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somGetClassName (
            Self.som_object,
            SOMObjectClassData.somGetClassName);
      RETURN Result;
   END somGetClassName; 

   FUNCTION somGetSize (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Return the size of the receiver.
      FUNCTION SOMObject_somGetSize(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMObject_somGetSize);
      PRAGMA interface_information (SOMObject_somGetSize, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somGetSize (
            Self.som_object,
            SOMObjectClassData.somGetSize);
      RETURN Result;
   END somGetSize; 

   FUNCTION somIsA (
      Self : IN Ref; 
      aClassObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if the receiver responds to methods
     -- introduced by <aClassObj>, and 0 (false) otherwise.
      FUNCTION SOMObject_somIsA(
         Self : IN SOM.SOMObjectPtr; 
         aClassObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somIsA);
      PRAGMA interface_information (SOMObject_somIsA, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somIsA (
            Self.som_object,
            aClassObj,
            SOMObjectClassData.somIsA);
      RETURN Result;
   END somIsA; 

   FUNCTION somIsInstanceOf (
      Self : IN Ref; 
      aClassObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if the receiver is an instance of
     -- <aClassObj> and 0 (false) otherwise.
      FUNCTION SOMObject_somIsInstanceOf(
         Self : IN SOM.SOMObjectPtr; 
         aClassObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somIsInstanceOf);
      PRAGMA interface_information (SOMObject_somIsInstanceOf, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somIsInstanceOf (
            Self.som_object,
            aClassObj,
            SOMObjectClassData.somIsInstanceOf);
      RETURN Result;
   END somIsInstanceOf; 

   FUNCTION somRespondsTo (
      Self : IN Ref; 
      mId : IN SOM.somId)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if the indicated method can be invoked
     -- on the receiver and 0 (false) otherwise.
      FUNCTION SOMObject_somRespondsTo(
         Self : IN SOM.SOMObjectPtr; 
         mId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somRespondsTo);
      PRAGMA interface_information (SOMObject_somRespondsTo, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somRespondsTo (
            Self.som_object,
            mId,
            SOMObjectClassData.somRespondsTo);
      RETURN Result;
   END somRespondsTo; 

   PROCEDURE somDispatch (
      Self : IN Ref; 
      retValue : OUT SOM.somToken; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list; 
      Result : OUT Corba.Boolean)
   IS
     
     -- This method provides a generic, class-specific dispatch mechanism.
     -- It accepts as input <retValue> a pointer to the memory area to be
     -- loaded with the result of dispatching the method indicated by
     -- <methodId> using the arguments in <ap>. <ap> contains the object
     -- on which the method is to be invoked as the first argument.
      FUNCTION SOMObject_somDispatch(
         Self : IN SOM.SOMObjectPtr; 
         retValue : IN SOM.address; 
         methodId : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somDispatch);
      PRAGMA interface_information (SOMObject_somDispatch, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDispatch (
            Self.som_object,
            SOM.To_SOM_Address(retValue'address),
            methodId,
            ap,
            SOMObjectClassData.somDispatch);
   END somDispatch;

   PROCEDURE somClassDispatch (
      Self : IN Ref; 
      clsObj : IN SOM.SOMObjectPtr; 
      retValue : OUT SOM.somToken; 
      methodId : IN SOM.somId; 
      ap : IN SOM.va_list; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Like somDispatch, but method resolution for static methods is done
     -- according to the clsObj instance method table.
      FUNCTION SOMObject_somClassDispatch(
         Self : IN SOM.SOMObjectPtr; 
         clsObj : IN SOM.SOMObjectPtr; 
         retValue : IN SOM.address; 
         methodId : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somClassDispatch);
      PRAGMA interface_information (SOMObject_somClassDispatch, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somClassDispatch (
            Self.som_object,
            clsObj,
            SOM.To_SOM_Address(retValue'address),
            methodId,
            ap,
            SOMObjectClassData.somClassDispatch);
   END somClassDispatch;

   FUNCTION somCastObj (
      Self : IN Ref; 
      cls : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- cast the receiving object to cls (which must be an ancestor of the
     -- objects true class. Returns true on success.
      FUNCTION SOMObject_somCastObj(
         Self : IN SOM.SOMObjectPtr; 
         cls : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somCastObj);
      PRAGMA interface_information (SOMObject_somCastObj, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somCastObj (
            Self.som_object,
            cls,
            SOMObjectClassData.somCastObj);
      RETURN Result;
   END somCastObj; 

   FUNCTION somResetObj (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- reset an object to its true class. Returns true always.
      FUNCTION SOMObject_somResetObj(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMObject_somResetObj);
      PRAGMA interface_information (SOMObject_somResetObj, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somResetObj (
            Self.som_object,
            SOMObjectClassData.somResetObj);
      RETURN Result;
   END somResetObj; 

   PROCEDURE somDispatchV (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
   IS
     
     -- Obsolete. Use somDispatch instead.
      PROCEDURE SOMObject_somDispatchV(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         descriptor : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDispatchV);
      PRAGMA interface_information (SOMObject_somDispatchV, ".xsomcall4");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDispatchV (
         Self.som_object,
         methodId,
         descriptor,
         ap,
         SOMObjectClassData.somDispatchV);
   END somDispatchV;

   FUNCTION somDispatchL (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Long
   IS
     
     -- Obsolete. Use somDispatch instead.
      FUNCTION SOMObject_somDispatchL(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         descriptor : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMObject_somDispatchL);
      PRAGMA interface_information (SOMObject_somDispatchL, ".xsomcall4");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDispatchL (
            Self.som_object,
            methodId,
            descriptor,
            ap,
            SOMObjectClassData.somDispatchL);
      RETURN Result;
   END somDispatchL; 

   FUNCTION somDispatchA (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN SOM.VoidPtr
   IS
     
     -- Obsolete. Use somDispatch instead.
      FUNCTION SOMObject_somDispatchA(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         descriptor : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.VoidPtr; 
      PRAGMA interface (assembly, SOMObject_somDispatchA);
      PRAGMA interface_information (SOMObject_somDispatchA, ".xsomcall4");
      Result : ALIASED SOM.VoidPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDispatchA (
            Self.som_object,
            methodId,
            descriptor,
            ap,
            SOMObjectClassData.somDispatchA);
      RETURN Result;
   END somDispatchA; 

   FUNCTION somDispatchD (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId; 
      ap : IN SOM.va_list)
      RETURN Corba.Double
   IS
     
     -- Obsolete. Use somDispatch instead.
      FUNCTION SOMObject_somDispatchD(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         descriptor : IN SOM.somId; 
         ap : IN SOM.va_list;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Double; 
      PRAGMA interface (assembly, SOMObject_somDispatchD);
      PRAGMA interface_information (SOMObject_somDispatchD, ".xsomcall4");
      Result : ALIASED Corba.Double;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somDispatchD (
            Self.som_object,
            methodId,
            descriptor,
            ap,
            SOMObjectClassData.somDispatchD);
      RETURN Result;
   END somDispatchD; 

   FUNCTION somPrintSelf (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Uses <SOMOutCharRoutine> to write a brief string with identifying
     -- information about this object.  The default implementation just gives
     -- the object's class name and its address in memory.
     -- <self> is returned.
      FUNCTION SOMObject_somPrintSelf(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMObject_somPrintSelf);
      PRAGMA interface_information (SOMObject_somPrintSelf, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMObject_somPrintSelf (
            Self.som_object,
            SOMObjectClassData.somPrintSelf);
      RETURN Result;
   END somPrintSelf; 

   PROCEDURE somDumpSelf (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
     
     -- Uses <SOMOutCharRoutine> to write a detailed description of this object
     -- and its current state.
     --
     -- <level> indicates the nesting level for describing compound objects
     -- it must be greater than or equal to zero.  All lines in the
     -- description will be preceeded by <2*level> spaces.
     --
     -- This routine only actually writes the data that concerns the object
     -- as a whole, such as class, and uses <somDumpSelfInt> to describe
     -- the object's current state.  This approach allows readable
     -- descriptions of compound objects to be constructed.
     --
     -- Generally it is not necessary to override this method, if it is
     -- overriden it generally must be completely replaced.
      PROCEDURE SOMObject_somDumpSelf(
         Self : IN SOM.SOMObjectPtr; 
         level : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDumpSelf);
      PRAGMA interface_information (SOMObject_somDumpSelf, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDumpSelf (
         Self.som_object,
         level,
         SOMObjectClassData.somDumpSelf);
   END somDumpSelf;

   PROCEDURE somDumpSelfInt (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
     
     -- Uses <SOMOutCharRoutine> to write in the current state of this object.
     -- Generally this method will need to be overridden.  When overriding
     -- it, begin by calling the parent class form of this method and then
     -- write in a description of your class's instance data. This will
     -- result in a description of all the object's instance data going
     -- from its root ancestor class to its specific class.
      PROCEDURE SOMObject_somDumpSelfInt(
         Self : IN SOM.SOMObjectPtr; 
         level : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMObject_somDumpSelfInt);
      PRAGMA interface_information (SOMObject_somDumpSelfInt, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject_somDumpSelfInt (
         Self.som_object,
         level,
         SOMObjectClassData.somDumpSelfInt);
   END somDumpSelfInt;

END SOMObject; 







