
-------------------------------------------------------------------------------
-- Modified:   added pragma linker_options
-- Emitted on: Tue Jun 24 05:06:48 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Corba.Sequences;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMObject IS

   PRAGMA Linker_Options("/usr/lpp/som/lib/libsomtk.a");
   PRAGMA Linker_Options("$POWERADA/contrib/som/xsomcall.o");
   
   -- This is the SOM root class, all SOM classes must be descended from
   -- <SOMObject>. <SOMObject> has no instance data so there is no
   -- per-instance cost to to being descended from it.

   TYPE Ref IS NEW Corba.Object.Ref WITH NULL RECORD;

   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref;

   Major_Version : CONSTANT SOM.integer4 := 1;
   Minor_Version : CONSTANT SOM.integer4 := 4;

   FUNCTION New_Class (
      Major_Version : IN SOM.integer4;
      Minor_Version : IN SOM.integer4)
      RETURN             SOM.SOMClassPtr;

   FUNCTION New_Instance
      RETURN Ref;

   PROCEDURE Free_Instance(
      Instance : IN OUT Ref);
      

   PACKAGE SOMObject_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);


   SUBTYPE SOMObjectSequence IS SOMObject.SOMObject_Unbounded.Sequence;

   PACKAGE octet_Unbounded IS 
      NEW Corba.Sequences.Unbounded(Corba.Octet);


   SUBTYPE BooleanSequence IS SOMObject.octet_Unbounded.Sequence;

   TYPE somObjectOffset IS
   RECORD
      obj : SOM.SOMObjectPtr;
      offset : Corba.Long;
   END RECORD;
   PRAGMA Preserve_Layout( somObjectOffset );

   PACKAGE somObjectOffset_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOMObject.somObjectOffset);


   SUBTYPE somObjectOffsets IS SOMObject.somObjectOffset_Unbounded.Sequence;


   PROCEDURE somDefaultInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl);
     
     -- A default initializer for a SOM object. Passing a null ctrl
     -- indicates to the receiver that its class is the class of the
     -- object being initialized, whereby the initializer will determine
     -- an appropriate control structure.

   PROCEDURE somDestruct (
      Self : IN Ref;
      doFree : IN Corba.Octet;
      ctrl : IN OUT SOM.somDestructCtrl);
     
     -- The default destructor for a SOM object. A nonzero <doFree>
     -- indicates that the object storage should be freed by the
     -- object's class (via somDeallocate) after uninitialization.
     -- As with somDefaultInit, a null ctrl can be passed.

   PROCEDURE somDefaultCopyInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl;
      fromObj : IN SOM.SOMObjectPtr);
     
     -- A default copy constructor. Use this to make copies of objects for
     -- calling methods with "by-value" argument semantics.

   PROCEDURE somDefaultAssign (
      Self : IN Ref;
      ctrl : IN OUT SOM.somAssignCtrl;
      fromObj : IN SOM.SOMObjectPtr;
      Result : OUT SOM.SOMObjectPtr);
     
     -- A default assignment operator. Use this to "assign" the state of one
     -- object to another.

   PROCEDURE somDefaultConstCopyInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl;
      fromObj : IN SOM.SOMObjectPtr);
     
     -- A default copy constructor that uses a const fromObj.

   PROCEDURE somDefaultVCopyInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl;
      fromObj : IN SOM.SOMObjectPtr);
     
     -- A default copy constructor that uses a volatile fromObj.

   PROCEDURE somDefaultConstVCopyInit (
      Self : IN Ref;
      ctrl : IN OUT SOM.somInitCtrl;
      fromObj : IN SOM.SOMObjectPtr);
     
     -- A default copy constructor that uses a const volatile fromObj.

   PROCEDURE somDefaultConstAssign (
      Self : IN Ref;
      ctrl : IN OUT SOM.somAssignCtrl;
      fromObj : IN SOM.SOMObjectPtr;
      Result : OUT SOM.SOMObjectPtr);
     
     -- A default assignment operator that uses a const fromObj.

   PROCEDURE somDefaultVAssign (
      Self : IN Ref;
      ctrl : IN OUT SOM.somAssignCtrl;
      fromObj : IN SOM.SOMObjectPtr;
      Result : OUT SOM.SOMObjectPtr);
     
     -- A default assignment operator that uses a volatile fromObj.

   PROCEDURE somDefaultConstVAssign (
      Self : IN Ref;
      ctrl : IN OUT SOM.somAssignCtrl;
      fromObj : IN SOM.SOMObjectPtr;
      Result : OUT SOM.SOMObjectPtr);
     
     -- A default assignment operator that uses a const volatile fromObj.

   PROCEDURE somInit (
      Self : IN Ref);
     
     -- Obsolete but still supported. Override somDefaultInit instead of somInit.

   PROCEDURE somFree (
      Self : IN Ref);
     
     -- Obsolete but still supported. Use somDestruct with a nonzero
     -- <doFree> instead.

   PROCEDURE somUninit (
      Self : IN Ref);
     
     -- Obsolete but still supported. Override somDestruct instead of somUninit.

   FUNCTION somGetClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Return the receiver's class.

   FUNCTION somGetClassName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- Return the name of the receiver's class.

   FUNCTION somGetSize (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Return the size of the receiver.

   FUNCTION somIsA (
      Self : IN Ref;
      aClassObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the receiver responds to methods
     -- introduced by <aClassObj>, and 0 (false) otherwise.

   FUNCTION somIsInstanceOf (
      Self : IN Ref;
      aClassObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the receiver is an instance of
     -- <aClassObj> and 0 (false) otherwise.

   FUNCTION somRespondsTo (
      Self : IN Ref;
      mId : IN SOM.somId)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the indicated method can be invoked
     -- on the receiver and 0 (false) otherwise.

   PROCEDURE somDispatch (
      Self : IN Ref;
      retValue : OUT SOM.somToken;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list;
      Result : OUT Corba.Boolean);
     
     -- This method provides a generic, class-specific dispatch mechanism.
     -- It accepts as input <retValue> a pointer to the memory area to be
     -- loaded with the result of dispatching the method indicated by
     -- <methodId> using the arguments in <ap>. <ap> contains the object
     -- on which the method is to be invoked as the first argument.

   PROCEDURE somClassDispatch (
      Self : IN Ref;
      clsObj : IN SOM.SOMObjectPtr;
      retValue : OUT SOM.somToken;
      methodId : IN SOM.somId;
      ap : IN SOM.va_list;
      Result : OUT Corba.Boolean);
     
     -- Like somDispatch, but method resolution for static methods is done
     -- according to the clsObj instance method table.

   FUNCTION somCastObj (
      Self : IN Ref;
      cls : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- cast the receiving object to cls (which must be an ancestor of the
     -- objects true class. Returns true on success.

   FUNCTION somResetObj (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- reset an object to its true class. Returns true always.

   PROCEDURE somDispatchV (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list);
     
     -- Obsolete. Use somDispatch instead.

   FUNCTION somDispatchL (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Long;
     
     -- Obsolete. Use somDispatch instead.

   FUNCTION somDispatchA (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN SOM.VoidPtr;
     
     -- Obsolete. Use somDispatch instead.

   FUNCTION somDispatchD (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId;
      ap : IN SOM.va_list)
      RETURN Corba.Double;
     
     -- Obsolete. Use somDispatch instead.

   FUNCTION somPrintSelf (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Uses <SOMOutCharRoutine> to write a brief string with identifying
     -- information about this object.  The default implementation just gives
     -- the object's class name and its address in memory.
     -- <self> is returned.

   PROCEDURE somDumpSelf (
      Self : IN Ref;
      level : IN Corba.Long);
     
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

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);
     
     -- Uses <SOMOutCharRoutine> to write in the current state of this object.
     -- Generally this method will need to be overridden.  When overriding
     -- it, begin by calling the parent class form of this method and then
     -- write in a description of your class's instance data. This will
     -- result in a description of all the object's instance data going
     -- from its root ancestor class to its specific class.

END SOMObject; 
