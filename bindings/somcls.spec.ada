
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:42 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba.Sequences;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMClass IS

   
   --
   --  This is the SOM metaclass.  That is, the instances of this class
   --  are class objects.  When the SOM environment is created an instance
   --  of SOMClass is created and a pointer to it is placed in the external
   --  data location (SOMClassClassData.classObject). Bindings provide the
   --  macro _SOMClass for this expression. _SOMClass is unique in that it
   --  is its own class object. I.e., _SOMClass == _somGetClass(_SOMClass).
   --  SOMClass can be subclassed just like any SOM class. The subclasses
   --  of SOMClass are new metaclasses and can generate class objects with
   --  different implementations than those produced by _SOMClass.
   --
   --  An important rule for metaclass programming is that no methods
   --  introduced by SOMClass should ever be overridden. While this
   --  limits the utility of metaclass programming in SOM, it guarantees
   --  that SOM will operate correctly. Special class frameworks may be
   --  available from IBM to alleviate this restriction.
   --

   TYPE Ref IS NEW SOMObject.Ref WITH NULL RECORD;

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
      

   PACKAGE somToken_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.somToken);


   SUBTYPE somTokenSequence IS SOMClass.somToken_Unbounded.Sequence;

   PACKAGE SOMClass_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);


   SUBTYPE SOMClassSequence IS SOMClass.SOMClass_Unbounded.Sequence;

   TYPE somOffsetInfo IS
   RECORD
      cls : SOM.SOMObjectPtr;
      offset : Corba.Long;
   END RECORD;
   PRAGMA Preserve_Layout( somOffsetInfo );
     
     -- a structure to describe a class-related offset

   PACKAGE somOffsetInfo_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOMClass.somOffsetInfo);


   SUBTYPE somOffsets IS SOMClass.somOffsetInfo_Unbounded.Sequence;

   PACKAGE somId_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.somId);


   SUBTYPE somIdSequence IS SOMClass.somId_Unbounded.Sequence;


   FUNCTION get_somDataAlignment (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The alignment required for the instance data structure
     -- introduced by the receiving class.

   FUNCTION get_somInstanceDataOffsets (
      Self : IN Ref)
      RETURN SOMClass.somOffsets;
     
     -- A sequence of the instance data offsets for all classes used in
     -- the derivation of the receiving class (including the receiver).

   FUNCTION get_somDirectInitClasses (
      Self : IN Ref)
      RETURN SOMClass.SOMClassSequence;
     
     -- The ancestors whose initializers the receiving
     -- class wants to directly invoke.

   PROCEDURE set_somDirectInitClasses (
      Self : IN Ref;
      somDirectInitClasses : IN SOMClass.SOMClassSequence);
     
     -- The ancestors whose initializers the receiving
     -- class wants to directly invoke.

   FUNCTION somNew (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Uses SOMMalloc to allocate storage for a new instance of the
     -- receiving class, and then calls somRenewNoInitNoZero to load the
     -- new object's method table pointer. Then somDefaultInit is called to
     -- initialize the new object.  Note: If the instance is a class object,
     -- somInitMIClass must then be invoked to declare parents and
     -- initialize the class's instance method table. Upon failure, NULL
     -- is returned.

   FUNCTION somNewNoInit (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Equivalent to somNew except that somDefaultInit is not called.

   FUNCTION somRenew (
      Self : IN Ref;
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Equivalent to somNew except that storage is not allocated.
     -- <obj> is taken as the address of the new object.

   FUNCTION somRenewNoInit (
      Self : IN Ref;
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Equivalent to somRenew except that somDefaultInit is not called.

   FUNCTION somRenewNoZero (
      Self : IN Ref;
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Equivalent to somRenew except that memory is not zeroed out.

   FUNCTION somRenewNoInitNoZero (
      Self : IN Ref;
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- The purpose of this method is to load an object's method table.
     -- The SOM API requires that somRenewNoInitNoZero always be
     -- called when creating a new object whose metaclass is not SOMClass.
     -- This is because metaclasses must be guaranteed that they can use
     -- somRenewNoInitNoZero to track object creation if this is desired.

   FUNCTION somAllocate (
      Self : IN Ref;
      size : IN Corba.Long)
      RETURN Corba.String;
     
     -- Allocates memory to hold an object and returns a pointer to this memory.
     -- This is a nonstatic method, and cannot be overridden. The default
     -- implementation calls SOMMalloc, but a class designer can specify a
     -- different implementation using the somallocate modifier in IDL. The
     -- allocator takes the same parameters as this method.

   PROCEDURE somDeallocate (
      Self : IN Ref;
      memptr : IN Corba.String);
     
     -- Zeros out the method table pointer stored in the word pointed to by
     -- memptr, and then deallocates the block of memory pointed to by memptr.
     -- This is a nonstatic method and cannot be overridden. The default
     -- deallocator called is SOMFree, but a class designer can specify a
     -- different deallocator using the somdeallocate modifier in IDL. The
     -- deallocator takes the same parameters as this method.

   FUNCTION get_somClassAllocate (
      Self : IN Ref)
      RETURN SOM.somMethodProc;
     
     -- The memory allocation routine used by somAllocate. Provided in this
     -- form to support array allocation.

   FUNCTION get_somClassDeallocate (
      Self : IN Ref)
      RETURN SOM.somMethodProc;
     
     -- The memory allocation routine called by somDeallocate. Provided in
     -- this form to support array deallocation.

   PROCEDURE somGetInstanceInitMask (
      Self : IN Ref;
      ctrl : OUT SOM.somInitCtrl;
      Result : OUT SOM.somBooleanVector);
     
     -- Loads a structure used to control calls to initializers.
     -- Computed when first requested (using the somDirectedInitClasses
     -- attribute) and then cached.

   PROCEDURE somGetInstanceDestructionMask (
      Self : IN Ref;
      ctrl : OUT SOM.somDestructCtrl;
      Result : OUT SOM.somBooleanVector);
     
     -- Loads a structure used to control calls to somDestruct.
     -- Computed at the same time as somInstanceConstructionMask

   PROCEDURE somGetInstanceAssignmentMask (
      Self : IN Ref;
      ctrl : OUT SOM.somAssignCtrl;
      Result : OUT SOM.somBooleanVector);
     
     -- Loads a structure used to control calls to assignment ops.
     -- Computed at the same time as somInstanceConstructionMask

   PROCEDURE somInitClass (
      Self : IN Ref;
      className : IN Corba.String;
      parentClass : IN SOM.SOMObjectPtr;
      dataSize : IN Corba.Long;
      maxStaticMethods : IN Corba.Long;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long);
     
     -- somInitClass is obsolete, and should no longer be used. The SOM 2.0
     -- kernel provides special handling for redispatch stubs in the case
     -- of SOM 1.0 classes, and use of this method is what tells the kernel
     -- that old-style redispatch stubs will be registered.

   PROCEDURE somInitMIClass (
      Self : IN Ref;
      inherit_vars : IN Corba.Long;
      className : IN Corba.String;
      parentClasses : IN SOMClass.SOMClassSequence;
      dataSize : IN Corba.Long;
      dataAlignment : IN Corba.Long;
      maxStaticMethods : IN Corba.Long;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long);
     
     -- somInitMIClass implements the second phase of dynamic class creation:
     -- inheritance of interface and possibly implementation (instance
     -- variables) by suitable initialization of <self> (a class object).
     --
     -- For somInitMIClass, the inherit_vars argument controls whether abstract
     -- or implementation inheritance is used. Inherit_vars is a 32 bit
     -- bit-vector. Implementation is inherited from parent i iff the bit
     -- 1<<i is on, or i>=32.
     -- On a class-by-class basis, for each class ancestor, implementation
     -- inheritance always takes precidence over abstract inheritance. This is
     -- necessary to guarantee that procedures supporting parent method calls
     -- (available on non-abstract parents) are always supported by parent
     -- instance variables.
     --
     -- <className> is a string containing the class name. A copy is made, so
     -- the string may be freed upon return to the caller if this is desired.
     --
     -- <parentClasses> is a SOMClassSequence containing pointers to the
     -- parent classes. somInitMIClass makes a copy of this, so it may
     -- be freed upon return to the caller if this is desired.
     --
     -- <dataSize> is the space needed for the instance variables
     -- introduced by this class.
     --
     -- <dataAlignment> specifies the desired byte alignment for instance
     -- data introduced by this class. A value of 0 selects a system-wide default;
     -- any other argument is taken as the desired byte alignment multiple. Thus,
     -- for example, even if a byte multiple of 8 is needed for double precision
     -- values on a given system (so 8 is the default), a class whose instance data
     -- doesn't require this can indicate otherwise. If A is the next memory
     -- address available for holding instance data, the address that will be
     -- used is A + (A mod byte-alignment).
     --
     -- <maxStaticMethods> is the maximum number of static methods that will be
     -- added to the initialized class using addStaticMethod.
     --
     -- <majorVersion> indicates the major version number for this
     -- implementation of the class definition, and <minorVersion>
     -- indicates the minor version number.

   FUNCTION somAddStaticMethod (
      Self : IN Ref;
      methodId : IN SOM.somId;
      methodDescriptor : IN SOM.somId;
      method : IN SOM.somMethodPtr;
      redispatchStub : IN SOM.somMethodPtr;
      applyStub : IN SOM.somMethodPtr)
      RETURN SOM.somMToken;
     
     -- Adds the indicated method, creating and returning a new method token.
     --
     -- <methodDescriptor> is the somId for an identifier that can be used
     -- to access signature information about the method from an interface
     -- repository.
     --
     -- <method> is the actual method procedure for this method
     --
     -- <redispatchStub> is a procedure with the same calling sequence as
     -- <method> that invokes somDispatch for the method.
     --
     -- <applyStub> is a procedure used to support somApply.

   PROCEDURE somAddDynamicMethod (
      Self : IN Ref;
      methodId : IN SOM.somId;
      methodDescriptor : IN SOM.somId;
      method : IN SOM.somMethodPtr;
      applyStub : IN SOM.somMethodPtr);
     
     -- Adds the indicated method to the class's name lookup list.
     -- If this happens to override a static method then this operation is
     -- equivalent to <somOverrideSMethod> and the <methodDescriptor> and
     -- <applyStub> arguments are ignored (the overridden method's values
     -- will be used).
     --
     -- <methodDescriptor> is the somId of a string describing the calling
     -- sequence to this method as described in <somcGetNthMethodInfo>
     -- defined in the SOMObject class definition.
     --
     -- <method> is the actual method procedure for this method
     --
     -- <applyStub> is a procedure that takes a standard variable argument
     -- list data structure applies it to its target object by calling
     -- <method> with arguments derived from the data structure.  Its
     -- calling sequence is the same as the calling sequence of the
     -- dispatch methods defined in SOMObject.  This stub is used in the
     -- support of the dispatch methods used in some classes.  In classes
     -- where the dispatch functions do not need such a function this
     -- parameter may be null.

   PROCEDURE somOverrideSMethod (
      Self : IN Ref;
      methodId : IN SOM.somId;
      method : IN SOM.somMethodPtr);
     
     -- This method can be used instead of <somAddStaticMethod> or
     -- <somAddDynamicMethod> when it is known that the class' parent
     -- class already supports this method.  This call does not require the
     -- method descriptor and stub methods that the others do.

   PROCEDURE somClassReady (
      Self : IN Ref);
     
     -- This method is invoked when all of the static initialization for
     -- the class has been finished.  The default implementation simply
     -- registers the newly constructed class with the SOMClassMgr.

   FUNCTION somGetApplyStub (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr;
     
     -- Returns the apply stub associated with the specified method,
     -- if one exists; otherwise NULL is returned. This method is obsolete,
     -- and retained for binary compatability. In SOMr2, users never access
     -- apply stubs directly; The function somApply is used to invoke apply
     -- stubs. See somApply documentation for further information on apply
     -- stubs, and see somAddStaticMethod documentation for information
     -- on how apply stubs are registered by class implementations.

   FUNCTION somGetClassData (
      Self : IN Ref)
      RETURN SOM.somClassDataStructure;

   PROCEDURE somSetClassData (
      Self : IN Ref;
      cds : IN SOM.somClassDataStructure);
     
     -- The class' pointer to the static <className>ClassData structure.

   FUNCTION somGetClassMtab (
      Self : IN Ref)
      RETURN SOM.somMethodTab;
     
     -- A pointer to the method table used by instances of this class. This
     -- method was misnamed; it should have been called somGetInstanceMtab.

   FUNCTION somGetInstanceOffset (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Returns the offset of instance data introduced by the receiver in
     -- an instance of the receiver. This method is obsolete and not useful in
     -- multiple-inheritance situations. The attribute somInstanceDataOffsets
     -- replaces this method.

   FUNCTION somGetInstancePartSize (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The size in bytes of the instance data introduced by the receiving
     -- class.

   FUNCTION somGetInstanceSize (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The total size of an instance of the receiving class.

   FUNCTION somGetInstanceToken (
      Self : IN Ref)
      RETURN SOM.somDToken;
     
     -- A data token that identifies the introduced portion of this class
     -- within itself or any derived class.  This token can be subsequently
     -- passed to the run-time somDataResolve function to locate the instance
     -- data introduced by this class in any object derived from this class.

   FUNCTION somGetMemberToken (
      Self : IN Ref;
      memberOffset : IN Corba.Long;
      instanceToken : IN SOM.somDToken)
      RETURN SOM.somDToken;
     
     -- Returns a data token that for the data member at offset
     -- "memberOffset" within the introduced portion of the class identified
     -- by instanceToken.  The instance token must have been obtained from a
     -- previous invocation of somGetInstanceToken.  The returned member
     -- token can be subsequently passed to the run-time somDataResolve
     -- function to locate the data member.

   PROCEDURE somGetMethodData (
      Self : IN Ref;
      methodId : IN SOM.somId;
      md : OUT SOM.somMethodData;
      Result : OUT Corba.Boolean);
     
     -- Sets the fields in the method descriptor block, <md>, to
     -- information about the method.  1 (true) is returned if the method is
     -- supported by this object and 0 (false) otherwise. The id field in
     -- the method descriptor block will also be set to NULL.

   FUNCTION somGetRdStub (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somMethodProc;
     
     -- Returns a redispatch stub for the indicated method, if possible.
     -- If not possible (because a valid redispatch stub has not been
     -- registered, and there is insufficient information to dynamically
     -- construct one), then a NULL is returned.

   FUNCTION somGetMethodDescriptor (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somId;
     
     -- Returns the method descriptor for the indicated method. If
     -- this object does not support the indicated method then NULL is
     -- returned.

   FUNCTION somGetMethodIndex (
      Self : IN Ref;
      id : IN SOM.somId)
      RETURN Corba.Long;
     
     -- Returns the index for the specified method. (A number that may
     -- change if any methods are added or deleted to this class object or
     -- any of its ancestors).  This number is the basis for other calls to
     -- get info about the method. Indexes start at 0. A -1 is returned if
     -- the method cannot be found.

   FUNCTION somGetMethodToken (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somMToken;
     
     -- Returns the specified method's access token. This token can then
     -- be passed to method resolution routines, which use the token
     -- to select a method pointer from a method table.

   FUNCTION somGetName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- This object's class name as a NULL terminated string.

   PROCEDURE somGetNthMethodData (
      Self : IN Ref;
      n : IN Corba.Long;
      md : OUT SOM.somMethodData;
      Result : OUT Corba.Boolean);
     
     -- loads *md with the method data associated with the the nth method,
     -- or NULL if there is no such method. Returns true is successful;
     -- false otherwise.

   PROCEDURE somGetNthMethodInfo (
      Self : IN Ref;
      n : IN Corba.Long;
      descriptor : OUT SOM.somId;
      Result : OUT SOM.somId);
     
     -- Returns the id of the <n>th method if one exists and NULL
     -- otherwise.
     --
     -- The ordering of the methods is unpredictable, but will not change
     -- unless some change is made to the class or one of its ancestor classes.
     --
     -- See CORBA documentation for info on method descriptors.

   FUNCTION somGetNumMethods (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The number of methods currently supported by this class,
     -- including inherited methods (both static and dynamic).

   FUNCTION somGetNumStaticMethods (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- The number of static methods that this class has.  Can
     -- be used by a child class when initializing its method table.

   FUNCTION somGetParent (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the parent class of self (along its "left-hand" derivation
     -- path), if one exists and NULL otherwise.

   FUNCTION somGetParents (
      Self : IN Ref)
      RETURN SOMClass.SOMClassSequence;
     
     -- The parent classes of self.

   FUNCTION somGetPClsMtab (
      Self : IN Ref)
      RETURN SOM.somMethodTabs;
     
     -- Returns a list of the method tables of this class's parent classes in the
     -- specific format required by somParentNumResolve (for making parent method
     -- calls. The first entry on the list is actually the method table of the
     -- receiving class. Because the CClassData structure contains this list, the
     -- method table for any class with a CClassData structure is statically
     -- available. This method now returns a list because older SI emitters load
     -- CClassData.parentMtab with the result of this call, and the new runtime
     -- requires a list of classes in that position.

   FUNCTION somGetPClsMtabs (
      Self : IN Ref)
      RETURN SOM.somMethodTabs;
     
     -- Returns a list of the method tables of this class's parent classes in the
     -- specific format required by somParentNumResolve (for making parent method
     -- calls. The first entry on the list is actually the method table of the
     -- receiving class. Because the CClassData structure contains this list, the
     -- method table for any class with a CClassData structure is statically
     -- available.

   PROCEDURE somGetVersionNumbers (
      Self : IN Ref;
      majorVersion : OUT Corba.Long;
      minorVersion : OUT Corba.Long);
     
     -- Returns the class' major and minor version numbers in the corresponding
     -- output parameters.

   FUNCTION somSetMethodDescriptor (
      Self : IN Ref;
      methodId : IN SOM.somId;
      descriptor : IN SOM.somId)
      RETURN Corba.Boolean;
     
     -- Sets the method descriptor given by <descriptor> for the method
     -- <methodId> into the method information kept by the receiving class.
     -- 1 (true) is returned if the method is supported by this object
     -- and 0 (false) otherwise.

   PROCEDURE somFindMethod (
      Self : IN Ref;
      methodId : IN SOM.somId;
      m : OUT SOM.somMethodPtr;
      Result : OUT Corba.Boolean);
     
     -- Finds the method procedure associated with <methodId> for this
     -- class and sets <m> to it.  1 (true) is returned when the
     -- method procedure is a static method and 0 (false) is returned
     -- when the method procedure is dynamic method.
     --
     -- If the class does not support the specified method then
     -- <m> is set to NULL and the return value is meaningless.
     --

   PROCEDURE somFindMethodOk (
      Self : IN Ref;
      methodId : IN SOM.somId;
      m : OUT SOM.somMethodPtr;
      Result : OUT Corba.Boolean);
     
     -- Just like <somFindMethod> except that if the method is not
     -- supported then an error is raised and execution is halted.

   FUNCTION somFindSMethod (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr;
     
     -- Finds the indicated method, which must be a static method supported
     -- by this class, and returns a pointer to its method procedure.
     -- If the method is not supported by the receiver (as a static method
     -- or at all) then a NULL pointer is returned.

   FUNCTION somFindSMethodOk (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr;
     
     -- Uses <somFindSMethod>, and raises an error if the result is NULL.

   FUNCTION somLookupMethod (
      Self : IN Ref;
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr;
     
     -- Like <somFindSMethodOK>, but without restriction to static methods.

   FUNCTION somCheckVersion (
      Self : IN Ref;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the implementation of this class is
     -- compatible with the specified major and minor version number and
     -- false (0) otherwise.  An implementation is compatible with the
     -- specified version numbers if it has the same major version number
     -- and a minor version number that is equal to or greater than
     -- <minorVersion>. The major, minor version number pair (0,0) is
     -- considered to match any version.  This method is usually called
     -- immediately after creating the class object to verify that a
     -- dynamically loaded class definition is compatible with a using
     -- application.

   FUNCTION somDescendedFrom (
      Self : IN Ref;
      aClassObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <self> is a descendent class of <aClassObj> and
     -- 0 (false) otherwise.  Note: a class object is considered to be
     -- descended itself for the purposes of this method.

   FUNCTION somSupportsMethod (
      Self : IN Ref;
      mId : IN SOM.somId)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the indicated method is supported by this
     -- class and 0 (false) otherwise.

   FUNCTION somDefinedMethod (
      Self : IN Ref;
      method : IN SOM.somMToken)
      RETURN SOM.somMethodPtr;
     
     -- if the receiving class either introduces or overrides the
     -- indicated method, then its somMethodPtr is returned, otherwise
     -- NULL is returned.

   PROCEDURE somOverrideMtab (
      Self : IN Ref);
     
     -- Overrides the method table pointers to point to the redispatch stubs.
     -- All the methods except somDispatch methods are overriden.

END SOMClass; 
