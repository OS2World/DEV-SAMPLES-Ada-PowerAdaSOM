
WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMClass IS

   
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

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somNew : SOM.somMToken;
      somRenew : SOM.somMToken;
      somInitClass : SOM.somMToken;
      somClassReady : SOM.somMToken;
      somGetName : SOM.somMToken;
      somGetParent : SOM.somMToken;
      somDescendedFrom : SOM.somMToken;
      somCheckVersion : SOM.somMToken;
      somFindMethod : SOM.somMToken;
      somFindMethodOk : SOM.somMToken;
      somSupportsMethod : SOM.somMToken;
      somGetNumMethods : SOM.somMToken;
      somGetInstanceSize : SOM.somMToken;
      somGetInstanceOffset : SOM.somMToken;
      somGetInstancePartSize : SOM.somMToken;
      somGetMethodIndex : SOM.somMToken;
      somGetNumStaticMethods : SOM.somMToken;
      somGetPClsMtab : SOM.somMToken;
      somGetClassMtab : SOM.somMToken;
      somAddStaticMethod : SOM.somMToken;
      somOverrideSMethod : SOM.somMToken;
      somAddDynamicMethod : SOM.somMToken;
      somcPrivate0 : SOM.somMToken;
      somGetApplyStub : SOM.somMToken;
      somFindSMethod : SOM.somMToken;
      somFindSMethodOk : SOM.somMToken;
      somGetMethodDescriptor : SOM.somMToken;
      somGetNthMethodInfo : SOM.somMToken;
      somSetClassData : SOM.somMToken;
      somGetClassData : SOM.somMToken;
      somNewNoInit : SOM.somMToken;
      somRenewNoInit : SOM.somMToken;
      somGetInstanceToken : SOM.somMToken;
      somGetMemberToken : SOM.somMToken;
      somSetMethodDescriptor : SOM.somMToken;
      somGetMethodData : SOM.somMToken;
      somOverrideMtab : SOM.somMToken;
      somGetMethodToken : SOM.somMToken;
      somGetParents : SOM.somMToken;
      somGetPClsMtabs : SOM.somMToken;
      somInitMIClass : SOM.somMToken;
      somGetVersionNumbers : SOM.somMToken;
      somLookupMethod : SOM.somMToken;
      get_somInstanceDataOffsets : SOM.somMToken;
      somRenewNoZero : SOM.somMToken;
      somRenewNoInitNoZero : SOM.somMToken;
      somAllocate : SOM.somMToken;
      somDeallocate : SOM.somMToken;
      somGetRdStub : SOM.somMToken;
      somGetNthMethodData : SOM.somMToken;
      somcPrivate1 : SOM.somMToken;
      somcPrivate2 : SOM.somMToken;
      get_somDirectInitClasses : SOM.somMToken;
      set_somDirectInitClasses : SOM.somMToken;
      somGetInstanceInitMask : SOM.somMToken;
      somGetInstanceDestructionMask : SOM.somMToken;
      somcPrivate3 : SOM.somMToken;
      somcPrivate4 : SOM.somMToken;
      somcPrivate5 : SOM.somMToken;
      somcPrivate6 : SOM.somMToken;
      somcPrivate7 : SOM.somMToken;
      somDefinedMethod : SOM.somMToken;
      somcPrivate8 : SOM.somMToken;
      somcPrivate9 : SOM.somMToken;
      somcPrivate10 : SOM.somMToken;
      somcPrivate11 : SOM.somMToken;
      somcPrivate12 : SOM.somMToken;
      somcPrivate13 : SOM.somMToken;
      somcPrivate14 : SOM.somMToken;
      somcPrivate15 : SOM.somMToken;
      get_somDataAlignment : SOM.somMToken;
      somGetInstanceAssignmentMask : SOM.somMToken;
      somcPrivate16 : SOM.somMToken;
      somcPrivate17 : SOM.somMToken;
      get_somClassAllocate : SOM.somMToken;
      get_somClassDeallocate : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMClassClassData : classData;
   FOR SOMClassClassData USE AT standard.system.label("SOMClassClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMClassCClassData : CClassData;
   FOR SOMClassCClassData USE AT standard.system.label("SOMClassCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMClassClassData.classObject) 
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
      FUNCTION SOMClassNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMClassNewClass);
      PRAGMA interface_information (SOMClassNewClass, ".SOMClassNewClass");
   BEGIN
      RETURN SOMClassNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMClassClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMClassClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somDataAlignment (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The alignment required for the instance data structure
     -- introduced by the receiving class.
      FUNCTION SOMClass_U_get_somDataAlignment(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_U_get_somDataAlignment);
      PRAGMA interface_information (SOMClass_U_get_somDataAlignment, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_U_get_somDataAlignment (
            Self.som_object,
            SOMClassClassData.get_somDataAlignment);
      RETURN Result;
   END get_somDataAlignment; 

   FUNCTION get_somInstanceDataOffsets (
      Self : IN Ref)
      RETURN SOMClass.somOffsets
   IS
     
     -- A sequence of the instance data offsets for all classes used in
     -- the derivation of the receiving class (including the receiver).
      PROCEDURE SOMClass_U_get_somInstanceDataOffsets(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_U_get_somInstanceDataOffsets);
      PRAGMA interface_information (SOMClass_U_get_somInstanceDataOffsets, ".xsomcall2");
      Result : ALIASED SOMClass.somOffsets;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_U_get_somInstanceDataOffsets (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         SOMClassClassData.get_somInstanceDataOffsets);
      RETURN Result;
   END get_somInstanceDataOffsets; 

   FUNCTION get_somDirectInitClasses (
      Self : IN Ref)
      RETURN SOMClass.SOMClassSequence
   IS
     
     -- The ancestors whose initializers the receiving
     -- class wants to directly invoke.
      PROCEDURE SOMClass_U_get_somDirectInitClasses(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_U_get_somDirectInitClasses);
      PRAGMA interface_information (SOMClass_U_get_somDirectInitClasses, ".xsomcall2");
      Result : ALIASED SOMClass.SOMClassSequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_U_get_somDirectInitClasses (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         SOMClassClassData.get_somDirectInitClasses);
      RETURN Result;
   END get_somDirectInitClasses; 

   PROCEDURE set_somDirectInitClasses (
      Self : IN Ref; 
      somDirectInitClasses : IN SOMClass.SOMClassSequence)
   IS
     
     -- The ancestors whose initializers the receiving
     -- class wants to directly invoke.
      PROCEDURE SOMClass_U_set_somDirectInitClasses(
         Self : IN SOM.SOMObjectPtr; 
         somDirectInitClasses : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_U_set_somDirectInitClasses);
      PRAGMA interface_information (SOMClass_U_set_somDirectInitClasses, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_U_set_somDirectInitClasses (
         Self.som_object,
         SOM.To_SOM_Address(somDirectInitClasses'address),
         SOMClassClassData.set_somDirectInitClasses);
   END set_somDirectInitClasses;

   FUNCTION somNew (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Uses SOMMalloc to allocate storage for a new instance of the
     -- receiving class, and then calls somRenewNoInitNoZero to load the
     -- new object's method table pointer. Then somDefaultInit is called to
     -- initialize the new object.  Note: If the instance is a class object,
     -- somInitMIClass must then be invoked to declare parents and
     -- initialize the class's instance method table. Upon failure, NULL
     -- is returned.
      FUNCTION SOMClass_somNew(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somNew);
      PRAGMA interface_information (SOMClass_somNew, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somNew (
            Self.som_object,
            SOMClassClassData.somNew);
      RETURN Result;
   END somNew; 

   FUNCTION somNewNoInit (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Equivalent to somNew except that somDefaultInit is not called.
      FUNCTION SOMClass_somNewNoInit(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somNewNoInit);
      PRAGMA interface_information (SOMClass_somNewNoInit, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somNewNoInit (
            Self.som_object,
            SOMClassClassData.somNewNoInit);
      RETURN Result;
   END somNewNoInit; 

   FUNCTION somRenew (
      Self : IN Ref; 
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Equivalent to somNew except that storage is not allocated.
     -- <obj> is taken as the address of the new object.
      FUNCTION SOMClass_somRenew(
         Self : IN SOM.SOMObjectPtr; 
         obj : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somRenew);
      PRAGMA interface_information (SOMClass_somRenew, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somRenew (
            Self.som_object,
            obj,
            SOMClassClassData.somRenew);
      RETURN Result;
   END somRenew; 

   FUNCTION somRenewNoInit (
      Self : IN Ref; 
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Equivalent to somRenew except that somDefaultInit is not called.
      FUNCTION SOMClass_somRenewNoInit(
         Self : IN SOM.SOMObjectPtr; 
         obj : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somRenewNoInit);
      PRAGMA interface_information (SOMClass_somRenewNoInit, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somRenewNoInit (
            Self.som_object,
            obj,
            SOMClassClassData.somRenewNoInit);
      RETURN Result;
   END somRenewNoInit; 

   FUNCTION somRenewNoZero (
      Self : IN Ref; 
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Equivalent to somRenew except that memory is not zeroed out.
      FUNCTION SOMClass_somRenewNoZero(
         Self : IN SOM.SOMObjectPtr; 
         obj : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somRenewNoZero);
      PRAGMA interface_information (SOMClass_somRenewNoZero, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somRenewNoZero (
            Self.som_object,
            obj,
            SOMClassClassData.somRenewNoZero);
      RETURN Result;
   END somRenewNoZero; 

   FUNCTION somRenewNoInitNoZero (
      Self : IN Ref; 
      obj : IN SOM.VoidPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The purpose of this method is to load an object's method table.
     -- The SOM API requires that somRenewNoInitNoZero always be
     -- called when creating a new object whose metaclass is not SOMClass.
     -- This is because metaclasses must be guaranteed that they can use
     -- somRenewNoInitNoZero to track object creation if this is desired.
      FUNCTION SOMClass_somRenewNoInitNoZero(
         Self : IN SOM.SOMObjectPtr; 
         obj : IN SOM.VoidPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somRenewNoInitNoZero);
      PRAGMA interface_information (SOMClass_somRenewNoInitNoZero, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somRenewNoInitNoZero (
            Self.som_object,
            obj,
            SOMClassClassData.somRenewNoInitNoZero);
      RETURN Result;
   END somRenewNoInitNoZero; 

   FUNCTION somAllocate (
      Self : IN Ref; 
      size : IN Corba.Long)
      RETURN Corba.String
   IS
     
     -- Allocates memory to hold an object and returns a pointer to this memory.
     -- This is a nonstatic method, and cannot be overridden. The default
     -- implementation calls SOMMalloc, but a class designer can specify a
     -- different implementation using the somallocate modifier in IDL. The
     -- allocator takes the same parameters as this method.
      FUNCTION SOMClass_somAllocate(
         Self : IN SOM.SOMObjectPtr; 
         size : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMClass_somAllocate);
      PRAGMA interface_information (SOMClass_somAllocate, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somAllocate (
            Self.som_object,
            size,
            SOMClassClassData.somAllocate);
      RETURN Result;
   END somAllocate; 

   PROCEDURE somDeallocate (
      Self : IN Ref; 
      memptr : IN Corba.String)
   IS
     
     -- Zeros out the method table pointer stored in the word pointed to by
     -- memptr, and then deallocates the block of memory pointed to by memptr.
     -- This is a nonstatic method and cannot be overridden. The default
     -- deallocator called is SOMFree, but a class designer can specify a
     -- different deallocator using the somdeallocate modifier in IDL. The
     -- deallocator takes the same parameters as this method.
      PROCEDURE SOMClass_somDeallocate(
         Self : IN SOM.SOMObjectPtr; 
         memptr : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somDeallocate);
      PRAGMA interface_information (SOMClass_somDeallocate, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somDeallocate (
         Self.som_object,
         memptr,
         SOMClassClassData.somDeallocate);
   END somDeallocate;

   FUNCTION get_somClassAllocate (
      Self : IN Ref)
      RETURN SOM.somMethodProc
   IS
     
     -- The memory allocation routine used by somAllocate. Provided in this
     -- form to support array allocation.
      FUNCTION SOMClass_U_get_somClassAllocate(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodProc; 
      PRAGMA interface (assembly, SOMClass_U_get_somClassAllocate);
      PRAGMA interface_information (SOMClass_U_get_somClassAllocate, ".xsomcall1");
      Result : ALIASED SOM.somMethodProc;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_U_get_somClassAllocate (
            Self.som_object,
            SOMClassClassData.get_somClassAllocate);
      RETURN Result;
   END get_somClassAllocate; 

   FUNCTION get_somClassDeallocate (
      Self : IN Ref)
      RETURN SOM.somMethodProc
   IS
     
     -- The memory allocation routine called by somDeallocate. Provided in
     -- this form to support array deallocation.
      FUNCTION SOMClass_U_get_somClassDeallocate(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodProc; 
      PRAGMA interface (assembly, SOMClass_U_get_somClassDeallocate);
      PRAGMA interface_information (SOMClass_U_get_somClassDeallocate, ".xsomcall1");
      Result : ALIASED SOM.somMethodProc;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_U_get_somClassDeallocate (
            Self.som_object,
            SOMClassClassData.get_somClassDeallocate);
      RETURN Result;
   END get_somClassDeallocate; 

   PROCEDURE somGetInstanceInitMask (
      Self : IN Ref; 
      ctrl : OUT SOM.somInitCtrl; 
      Result : OUT SOM.somBooleanVector)
   IS
     
     -- Loads a structure used to control calls to initializers.
     -- Computed when first requested (using the somDirectedInitClasses
     -- attribute) and then cached.
      FUNCTION SOMClass_somGetInstanceInitMask(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somBooleanVector; 
      PRAGMA interface (assembly, SOMClass_somGetInstanceInitMask);
      PRAGMA interface_information (SOMClass_somGetInstanceInitMask, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstanceInitMask (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            SOMClassClassData.somGetInstanceInitMask);
   END somGetInstanceInitMask;

   PROCEDURE somGetInstanceDestructionMask (
      Self : IN Ref; 
      ctrl : OUT SOM.somDestructCtrl; 
      Result : OUT SOM.somBooleanVector)
   IS
     
     -- Loads a structure used to control calls to somDestruct.
     -- Computed at the same time as somInstanceConstructionMask
      FUNCTION SOMClass_somGetInstanceDestructionMask(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somBooleanVector; 
      PRAGMA interface (assembly, SOMClass_somGetInstanceDestructionMask);
      PRAGMA interface_information (SOMClass_somGetInstanceDestructionMask, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstanceDestructionMask (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            SOMClassClassData.somGetInstanceDestructionMask);
   END somGetInstanceDestructionMask;

   PROCEDURE somGetInstanceAssignmentMask (
      Self : IN Ref; 
      ctrl : OUT SOM.somAssignCtrl; 
      Result : OUT SOM.somBooleanVector)
   IS
     
     -- Loads a structure used to control calls to assignment ops.
     -- Computed at the same time as somInstanceConstructionMask
      FUNCTION SOMClass_somGetInstanceAssignmentMask(
         Self : IN SOM.SOMObjectPtr; 
         ctrl : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somBooleanVector; 
      PRAGMA interface (assembly, SOMClass_somGetInstanceAssignmentMask);
      PRAGMA interface_information (SOMClass_somGetInstanceAssignmentMask, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstanceAssignmentMask (
            Self.som_object,
            SOM.To_SOM_Address(ctrl'address),
            SOMClassClassData.somGetInstanceAssignmentMask);
   END somGetInstanceAssignmentMask;

   PROCEDURE somInitClass (
      Self : IN Ref; 
      className : IN Corba.String; 
      parentClass : IN SOM.SOMObjectPtr; 
      dataSize : IN Corba.Long; 
      maxStaticMethods : IN Corba.Long; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long)
   IS
     
     -- somInitClass is obsolete, and should no longer be used. The SOM 2.0
     -- kernel provides special handling for redispatch stubs in the case
     -- of SOM 1.0 classes, and use of this method is what tells the kernel
     -- that old-style redispatch stubs will be registered.
      PROCEDURE SOMClass_somInitClass(
         Self : IN SOM.SOMObjectPtr; 
         className : IN Corba.String; 
         parentClass : IN SOM.SOMObjectPtr; 
         dataSize : IN Corba.Long; 
         maxStaticMethods : IN Corba.Long; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somInitClass);
      PRAGMA interface_information (SOMClass_somInitClass, ".xsomcall7");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somInitClass (
         Self.som_object,
         className,
         parentClass,
         dataSize,
         maxStaticMethods,
         majorVersion,
         minorVersion,
         SOMClassClassData.somInitClass);
   END somInitClass;

   PROCEDURE somInitMIClass (
      Self : IN Ref; 
      inherit_vars : IN Corba.Long; 
      className : IN Corba.String; 
      parentClasses : IN SOMClass.SOMClassSequence; 
      dataSize : IN Corba.Long; 
      dataAlignment : IN Corba.Long; 
      maxStaticMethods : IN Corba.Long; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long)
   IS
     
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
      PROCEDURE SOMClass_somInitMIClass(
         Self : IN SOM.SOMObjectPtr; 
         inherit_vars : IN Corba.Long; 
         className : IN Corba.String; 
         parentClasses : IN SOM.address; 
         dataSize : IN Corba.Long; 
         dataAlignment : IN Corba.Long; 
         maxStaticMethods : IN Corba.Long; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somInitMIClass);
      PRAGMA interface_information (SOMClass_somInitMIClass, ".xsomcall9");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somInitMIClass (
         Self.som_object,
         inherit_vars,
         className,
         SOM.To_SOM_Address(parentClasses'address),
         dataSize,
         dataAlignment,
         maxStaticMethods,
         majorVersion,
         minorVersion,
         SOMClassClassData.somInitMIClass);
   END somInitMIClass;

   FUNCTION somAddStaticMethod (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      methodDescriptor : IN SOM.somId; 
      method : IN SOM.somMethodPtr; 
      redispatchStub : IN SOM.somMethodPtr; 
      applyStub : IN SOM.somMethodPtr)
      RETURN SOM.somMToken
   IS
     
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
      FUNCTION SOMClass_somAddStaticMethod(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         methodDescriptor : IN SOM.somId; 
         method : IN SOM.somMethodPtr; 
         redispatchStub : IN SOM.somMethodPtr; 
         applyStub : IN SOM.somMethodPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMToken; 
      PRAGMA interface (assembly, SOMClass_somAddStaticMethod);
      PRAGMA interface_information (SOMClass_somAddStaticMethod, ".xsomcall6");
      Result : ALIASED SOM.somMToken;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somAddStaticMethod (
            Self.som_object,
            methodId,
            methodDescriptor,
            method,
            redispatchStub,
            applyStub,
            SOMClassClassData.somAddStaticMethod);
      RETURN Result;
   END somAddStaticMethod; 

   PROCEDURE somAddDynamicMethod (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      methodDescriptor : IN SOM.somId; 
      method : IN SOM.somMethodPtr; 
      applyStub : IN SOM.somMethodPtr)
   IS
     
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
      PROCEDURE SOMClass_somAddDynamicMethod(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         methodDescriptor : IN SOM.somId; 
         method : IN SOM.somMethodPtr; 
         applyStub : IN SOM.somMethodPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somAddDynamicMethod);
      PRAGMA interface_information (SOMClass_somAddDynamicMethod, ".xsomcall5");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somAddDynamicMethod (
         Self.som_object,
         methodId,
         methodDescriptor,
         method,
         applyStub,
         SOMClassClassData.somAddDynamicMethod);
   END somAddDynamicMethod;

   PROCEDURE somOverrideSMethod (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      method : IN SOM.somMethodPtr)
   IS
     
     -- This method can be used instead of <somAddStaticMethod> or
     -- <somAddDynamicMethod> when it is known that the class' parent
     -- class already supports this method.  This call does not require the
     -- method descriptor and stub methods that the others do.
      PROCEDURE SOMClass_somOverrideSMethod(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         method : IN SOM.somMethodPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somOverrideSMethod);
      PRAGMA interface_information (SOMClass_somOverrideSMethod, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somOverrideSMethod (
         Self.som_object,
         methodId,
         method,
         SOMClassClassData.somOverrideSMethod);
   END somOverrideSMethod;

   PROCEDURE somClassReady (
      Self : IN Ref)
   IS
     
     -- This method is invoked when all of the static initialization for
     -- the class has been finished.  The default implementation simply
     -- registers the newly constructed class with the SOMClassMgr.
      PROCEDURE SOMClass_somClassReady(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somClassReady);
      PRAGMA interface_information (SOMClass_somClassReady, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somClassReady (
         Self.som_object,
         SOMClassClassData.somClassReady);
   END somClassReady;

   FUNCTION somGetApplyStub (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr
   IS
     
     -- Returns the apply stub associated with the specified method,
     -- if one exists; otherwise NULL is returned. This method is obsolete,
     -- and retained for binary compatability. In SOMr2, users never access
     -- apply stubs directly; The function somApply is used to invoke apply
     -- stubs. See somApply documentation for further information on apply
     -- stubs, and see somAddStaticMethod documentation for information
     -- on how apply stubs are registered by class implementations.
      FUNCTION SOMClass_somGetApplyStub(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodPtr; 
      PRAGMA interface (assembly, SOMClass_somGetApplyStub);
      PRAGMA interface_information (SOMClass_somGetApplyStub, ".xsomcall2");
      Result : ALIASED SOM.somMethodPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetApplyStub (
            Self.som_object,
            methodId,
            SOMClassClassData.somGetApplyStub);
      RETURN Result;
   END somGetApplyStub; 

   FUNCTION somGetClassData (
      Self : IN Ref)
      RETURN SOM.somClassDataStructure
   IS
      FUNCTION SOMClass_somGetClassData(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somClassDataStructure; 
      PRAGMA interface (assembly, SOMClass_somGetClassData);
      PRAGMA interface_information (SOMClass_somGetClassData, ".xsomcall1");
      Result : ALIASED SOM.somClassDataStructure;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetClassData (
            Self.som_object,
            SOMClassClassData.somGetClassData);
      RETURN Result;
   END somGetClassData; 

   PROCEDURE somSetClassData (
      Self : IN Ref; 
      cds : IN SOM.somClassDataStructure)
   IS
     
     -- The class' pointer to the static <className>ClassData structure.
      PROCEDURE SOMClass_somSetClassData(
         Self : IN SOM.SOMObjectPtr; 
         cds : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somSetClassData);
      PRAGMA interface_information (SOMClass_somSetClassData, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somSetClassData (
         Self.som_object,
         SOM.To_SOM_Address(cds'address),
         SOMClassClassData.somSetClassData);
   END somSetClassData;

   FUNCTION somGetClassMtab (
      Self : IN Ref)
      RETURN SOM.somMethodTab
   IS
     
     -- A pointer to the method table used by instances of this class. This
     -- method was misnamed; it should have been called somGetInstanceMtab.
      FUNCTION SOMClass_somGetClassMtab(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodTab; 
      PRAGMA interface (assembly, SOMClass_somGetClassMtab);
      PRAGMA interface_information (SOMClass_somGetClassMtab, ".xsomcall1");
      Result : ALIASED SOM.somMethodTab;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetClassMtab (
            Self.som_object,
            SOMClassClassData.somGetClassMtab);
      RETURN Result;
   END somGetClassMtab; 

   FUNCTION somGetInstanceOffset (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Returns the offset of instance data introduced by the receiver in
     -- an instance of the receiver. This method is obsolete and not useful in
     -- multiple-inheritance situations. The attribute somInstanceDataOffsets
     -- replaces this method.
      FUNCTION SOMClass_somGetInstanceOffset(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_somGetInstanceOffset);
      PRAGMA interface_information (SOMClass_somGetInstanceOffset, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstanceOffset (
            Self.som_object,
            SOMClassClassData.somGetInstanceOffset);
      RETURN Result;
   END somGetInstanceOffset; 

   FUNCTION somGetInstancePartSize (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The size in bytes of the instance data introduced by the receiving
     -- class.
      FUNCTION SOMClass_somGetInstancePartSize(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_somGetInstancePartSize);
      PRAGMA interface_information (SOMClass_somGetInstancePartSize, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstancePartSize (
            Self.som_object,
            SOMClassClassData.somGetInstancePartSize);
      RETURN Result;
   END somGetInstancePartSize; 

   FUNCTION somGetInstanceSize (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The total size of an instance of the receiving class.
      FUNCTION SOMClass_somGetInstanceSize(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_somGetInstanceSize);
      PRAGMA interface_information (SOMClass_somGetInstanceSize, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstanceSize (
            Self.som_object,
            SOMClassClassData.somGetInstanceSize);
      RETURN Result;
   END somGetInstanceSize; 

   FUNCTION somGetInstanceToken (
      Self : IN Ref)
      RETURN SOM.somDToken
   IS
     
     -- A data token that identifies the introduced portion of this class
     -- within itself or any derived class.  This token can be subsequently
     -- passed to the run-time somDataResolve function to locate the instance
     -- data introduced by this class in any object derived from this class.
      FUNCTION SOMClass_somGetInstanceToken(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somDToken; 
      PRAGMA interface (assembly, SOMClass_somGetInstanceToken);
      PRAGMA interface_information (SOMClass_somGetInstanceToken, ".xsomcall1");
      Result : ALIASED SOM.somDToken;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetInstanceToken (
            Self.som_object,
            SOMClassClassData.somGetInstanceToken);
      RETURN Result;
   END somGetInstanceToken; 

   FUNCTION somGetMemberToken (
      Self : IN Ref; 
      memberOffset : IN Corba.Long; 
      instanceToken : IN SOM.somDToken)
      RETURN SOM.somDToken
   IS
     
     -- Returns a data token that for the data member at offset
     -- "memberOffset" within the introduced portion of the class identified
     -- by instanceToken.  The instance token must have been obtained from a
     -- previous invocation of somGetInstanceToken.  The returned member
     -- token can be subsequently passed to the run-time somDataResolve
     -- function to locate the data member.
      FUNCTION SOMClass_somGetMemberToken(
         Self : IN SOM.SOMObjectPtr; 
         memberOffset : IN Corba.Long; 
         instanceToken : IN SOM.somDToken;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somDToken; 
      PRAGMA interface (assembly, SOMClass_somGetMemberToken);
      PRAGMA interface_information (SOMClass_somGetMemberToken, ".xsomcall3");
      Result : ALIASED SOM.somDToken;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetMemberToken (
            Self.som_object,
            memberOffset,
            instanceToken,
            SOMClassClassData.somGetMemberToken);
      RETURN Result;
   END somGetMemberToken; 

   PROCEDURE somGetMethodData (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      md : OUT SOM.somMethodData; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Sets the fields in the method descriptor block, <md>, to
     -- information about the method.  1 (true) is returned if the method is
     -- supported by this object and 0 (false) otherwise. The id field in
     -- the method descriptor block will also be set to NULL.
      FUNCTION SOMClass_somGetMethodData(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         md : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somGetMethodData);
      PRAGMA interface_information (SOMClass_somGetMethodData, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetMethodData (
            Self.som_object,
            methodId,
            SOM.To_SOM_Address(md'address),
            SOMClassClassData.somGetMethodData);
   END somGetMethodData;

   FUNCTION somGetRdStub (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somMethodProc
   IS
     
     -- Returns a redispatch stub for the indicated method, if possible.
     -- If not possible (because a valid redispatch stub has not been
     -- registered, and there is insufficient information to dynamically
     -- construct one), then a NULL is returned.
      FUNCTION SOMClass_somGetRdStub(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodProc; 
      PRAGMA interface (assembly, SOMClass_somGetRdStub);
      PRAGMA interface_information (SOMClass_somGetRdStub, ".xsomcall2");
      Result : ALIASED SOM.somMethodProc;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetRdStub (
            Self.som_object,
            methodId,
            SOMClassClassData.somGetRdStub);
      RETURN Result;
   END somGetRdStub; 

   FUNCTION somGetMethodDescriptor (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somId
   IS
     
     -- Returns the method descriptor for the indicated method. If
     -- this object does not support the indicated method then NULL is
     -- returned.
      FUNCTION SOMClass_somGetMethodDescriptor(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somId; 
      PRAGMA interface (assembly, SOMClass_somGetMethodDescriptor);
      PRAGMA interface_information (SOMClass_somGetMethodDescriptor, ".xsomcall2");
      Result : ALIASED SOM.somId;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetMethodDescriptor (
            Self.som_object,
            methodId,
            SOMClassClassData.somGetMethodDescriptor);
      RETURN Result;
   END somGetMethodDescriptor; 

   FUNCTION somGetMethodIndex (
      Self : IN Ref; 
      id : IN SOM.somId)
      RETURN Corba.Long
   IS
     
     -- Returns the index for the specified method. (A number that may
     -- change if any methods are added or deleted to this class object or
     -- any of its ancestors).  This number is the basis for other calls to
     -- get info about the method. Indexes start at 0. A -1 is returned if
     -- the method cannot be found.
      FUNCTION SOMClass_somGetMethodIndex(
         Self : IN SOM.SOMObjectPtr; 
         id : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_somGetMethodIndex);
      PRAGMA interface_information (SOMClass_somGetMethodIndex, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetMethodIndex (
            Self.som_object,
            id,
            SOMClassClassData.somGetMethodIndex);
      RETURN Result;
   END somGetMethodIndex; 

   FUNCTION somGetMethodToken (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somMToken
   IS
     
     -- Returns the specified method's access token. This token can then
     -- be passed to method resolution routines, which use the token
     -- to select a method pointer from a method table.
      FUNCTION SOMClass_somGetMethodToken(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMToken; 
      PRAGMA interface (assembly, SOMClass_somGetMethodToken);
      PRAGMA interface_information (SOMClass_somGetMethodToken, ".xsomcall2");
      Result : ALIASED SOM.somMToken;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetMethodToken (
            Self.som_object,
            methodId,
            SOMClassClassData.somGetMethodToken);
      RETURN Result;
   END somGetMethodToken; 

   FUNCTION somGetName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- This object's class name as a NULL terminated string.
      FUNCTION SOMClass_somGetName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMClass_somGetName);
      PRAGMA interface_information (SOMClass_somGetName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetName (
            Self.som_object,
            SOMClassClassData.somGetName);
      RETURN Result;
   END somGetName; 

   PROCEDURE somGetNthMethodData (
      Self : IN Ref; 
      n : IN Corba.Long; 
      md : OUT SOM.somMethodData; 
      Result : OUT Corba.Boolean)
   IS
     
     -- loads *md with the method data associated with the the nth method,
     -- or NULL if there is no such method. Returns true is successful;
     -- false otherwise.
      FUNCTION SOMClass_somGetNthMethodData(
         Self : IN SOM.SOMObjectPtr; 
         n : IN Corba.Long; 
         md : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somGetNthMethodData);
      PRAGMA interface_information (SOMClass_somGetNthMethodData, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetNthMethodData (
            Self.som_object,
            n,
            SOM.To_SOM_Address(md'address),
            SOMClassClassData.somGetNthMethodData);
   END somGetNthMethodData;

   PROCEDURE somGetNthMethodInfo (
      Self : IN Ref; 
      n : IN Corba.Long; 
      descriptor : OUT SOM.somId; 
      Result : OUT SOM.somId)
   IS
     
     -- Returns the id of the <n>th method if one exists and NULL
     -- otherwise.
     --
     -- The ordering of the methods is unpredictable, but will not change
     -- unless some change is made to the class or one of its ancestor classes.
     --
     -- See CORBA documentation for info on method descriptors.
      FUNCTION SOMClass_somGetNthMethodInfo(
         Self : IN SOM.SOMObjectPtr; 
         n : IN Corba.Long; 
         descriptor : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somId; 
      PRAGMA interface (assembly, SOMClass_somGetNthMethodInfo);
      PRAGMA interface_information (SOMClass_somGetNthMethodInfo, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetNthMethodInfo (
            Self.som_object,
            n,
            SOM.To_SOM_Address(descriptor'address),
            SOMClassClassData.somGetNthMethodInfo);
   END somGetNthMethodInfo;

   FUNCTION somGetNumMethods (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The number of methods currently supported by this class,
     -- including inherited methods (both static and dynamic).
      FUNCTION SOMClass_somGetNumMethods(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_somGetNumMethods);
      PRAGMA interface_information (SOMClass_somGetNumMethods, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetNumMethods (
            Self.som_object,
            SOMClassClassData.somGetNumMethods);
      RETURN Result;
   END somGetNumMethods; 

   FUNCTION somGetNumStaticMethods (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- The number of static methods that this class has.  Can
     -- be used by a child class when initializing its method table.
      FUNCTION SOMClass_somGetNumStaticMethods(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClass_somGetNumStaticMethods);
      PRAGMA interface_information (SOMClass_somGetNumStaticMethods, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetNumStaticMethods (
            Self.som_object,
            SOMClassClassData.somGetNumStaticMethods);
      RETURN Result;
   END somGetNumStaticMethods; 

   FUNCTION somGetParent (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the parent class of self (along its "left-hand" derivation
     -- path), if one exists and NULL otherwise.
      FUNCTION SOMClass_somGetParent(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClass_somGetParent);
      PRAGMA interface_information (SOMClass_somGetParent, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somGetParent (
            Self.som_object,
            SOMClassClassData.somGetParent);
      RETURN Result;
   END somGetParent; 

   FUNCTION somGetParents (
      Self : IN Ref)
      RETURN SOMClass.SOMClassSequence
   IS
     
     -- The parent classes of self.
      PROCEDURE SOMClass_somGetParents(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somGetParents);
      PRAGMA interface_information (SOMClass_somGetParents, ".xsomcall2");
      Result : ALIASED SOMClass.SOMClassSequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somGetParents (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         SOMClassClassData.somGetParents);
      RETURN Result;
   END somGetParents; 

   FUNCTION somGetPClsMtab (
      Self : IN Ref)
      RETURN SOM.somMethodTabs
   IS
     
     -- Returns a list of the method tables of this class's parent classes in the
     -- specific format required by somParentNumResolve (for making parent method
     -- calls. The first entry on the list is actually the method table of the
     -- receiving class. Because the CClassData structure contains this list, the
     -- method table for any class with a CClassData structure is statically
     -- available. This method now returns a list because older SI emitters load
     -- CClassData.parentMtab with the result of this call, and the new runtime
     -- requires a list of classes in that position.
      PROCEDURE SOMClass_somGetPClsMtab(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somGetPClsMtab);
      PRAGMA interface_information (SOMClass_somGetPClsMtab, ".xsomcall2");
      Result : ALIASED SOM.somMethodTabs;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somGetPClsMtab (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         SOMClassClassData.somGetPClsMtab);
      RETURN Result;
   END somGetPClsMtab; 

   FUNCTION somGetPClsMtabs (
      Self : IN Ref)
      RETURN SOM.somMethodTabs
   IS
     
     -- Returns a list of the method tables of this class's parent classes in the
     -- specific format required by somParentNumResolve (for making parent method
     -- calls. The first entry on the list is actually the method table of the
     -- receiving class. Because the CClassData structure contains this list, the
     -- method table for any class with a CClassData structure is statically
     -- available.
      PROCEDURE SOMClass_somGetPClsMtabs(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somGetPClsMtabs);
      PRAGMA interface_information (SOMClass_somGetPClsMtabs, ".xsomcall2");
      Result : ALIASED SOM.somMethodTabs;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somGetPClsMtabs (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         SOMClassClassData.somGetPClsMtabs);
      RETURN Result;
   END somGetPClsMtabs; 

   PROCEDURE somGetVersionNumbers (
      Self : IN Ref; 
      majorVersion : OUT Corba.Long; 
      minorVersion : OUT Corba.Long)
   IS
     
     -- Returns the class' major and minor version numbers in the corresponding
     -- output parameters.
      PROCEDURE SOMClass_somGetVersionNumbers(
         Self : IN SOM.SOMObjectPtr; 
         majorVersion : IN SOM.address; 
         minorVersion : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somGetVersionNumbers);
      PRAGMA interface_information (SOMClass_somGetVersionNumbers, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somGetVersionNumbers (
         Self.som_object,
         SOM.To_SOM_Address(majorVersion'address),
         SOM.To_SOM_Address(minorVersion'address),
         SOMClassClassData.somGetVersionNumbers);
   END somGetVersionNumbers;

   FUNCTION somSetMethodDescriptor (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      descriptor : IN SOM.somId)
      RETURN Corba.Boolean
   IS
     
     -- Sets the method descriptor given by <descriptor> for the method
     -- <methodId> into the method information kept by the receiving class.
     -- 1 (true) is returned if the method is supported by this object
     -- and 0 (false) otherwise.
      FUNCTION SOMClass_somSetMethodDescriptor(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         descriptor : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somSetMethodDescriptor);
      PRAGMA interface_information (SOMClass_somSetMethodDescriptor, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somSetMethodDescriptor (
            Self.som_object,
            methodId,
            descriptor,
            SOMClassClassData.somSetMethodDescriptor);
      RETURN Result;
   END somSetMethodDescriptor; 

   PROCEDURE somFindMethod (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      m : OUT SOM.somMethodPtr; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Finds the method procedure associated with <methodId> for this
     -- class and sets <m> to it.  1 (true) is returned when the
     -- method procedure is a static method and 0 (false) is returned
     -- when the method procedure is dynamic method.
     --
     -- If the class does not support the specified method then
     -- <m> is set to NULL and the return value is meaningless.
     --
      FUNCTION SOMClass_somFindMethod(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         m : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somFindMethod);
      PRAGMA interface_information (SOMClass_somFindMethod, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somFindMethod (
            Self.som_object,
            methodId,
            SOM.To_SOM_Address(m'address),
            SOMClassClassData.somFindMethod);
   END somFindMethod;

   PROCEDURE somFindMethodOk (
      Self : IN Ref; 
      methodId : IN SOM.somId; 
      m : OUT SOM.somMethodPtr; 
      Result : OUT Corba.Boolean)
   IS
     
     -- Just like <somFindMethod> except that if the method is not
     -- supported then an error is raised and execution is halted.
      FUNCTION SOMClass_somFindMethodOk(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId; 
         m : IN SOM.address;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somFindMethodOk);
      PRAGMA interface_information (SOMClass_somFindMethodOk, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somFindMethodOk (
            Self.som_object,
            methodId,
            SOM.To_SOM_Address(m'address),
            SOMClassClassData.somFindMethodOk);
   END somFindMethodOk;

   FUNCTION somFindSMethod (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr
   IS
     
     -- Finds the indicated method, which must be a static method supported
     -- by this class, and returns a pointer to its method procedure.
     -- If the method is not supported by the receiver (as a static method
     -- or at all) then a NULL pointer is returned.
      FUNCTION SOMClass_somFindSMethod(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodPtr; 
      PRAGMA interface (assembly, SOMClass_somFindSMethod);
      PRAGMA interface_information (SOMClass_somFindSMethod, ".xsomcall2");
      Result : ALIASED SOM.somMethodPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somFindSMethod (
            Self.som_object,
            methodId,
            SOMClassClassData.somFindSMethod);
      RETURN Result;
   END somFindSMethod; 

   FUNCTION somFindSMethodOk (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr
   IS
     
     -- Uses <somFindSMethod>, and raises an error if the result is NULL.
      FUNCTION SOMClass_somFindSMethodOk(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodPtr; 
      PRAGMA interface (assembly, SOMClass_somFindSMethodOk);
      PRAGMA interface_information (SOMClass_somFindSMethodOk, ".xsomcall2");
      Result : ALIASED SOM.somMethodPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somFindSMethodOk (
            Self.som_object,
            methodId,
            SOMClassClassData.somFindSMethodOk);
      RETURN Result;
   END somFindSMethodOk; 

   FUNCTION somLookupMethod (
      Self : IN Ref; 
      methodId : IN SOM.somId)
      RETURN SOM.somMethodPtr
   IS
     
     -- Like <somFindSMethodOK>, but without restriction to static methods.
      FUNCTION SOMClass_somLookupMethod(
         Self : IN SOM.SOMObjectPtr; 
         methodId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodPtr; 
      PRAGMA interface (assembly, SOMClass_somLookupMethod);
      PRAGMA interface_information (SOMClass_somLookupMethod, ".xsomcall2");
      Result : ALIASED SOM.somMethodPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somLookupMethod (
            Self.som_object,
            methodId,
            SOMClassClassData.somLookupMethod);
      RETURN Result;
   END somLookupMethod; 

   FUNCTION somCheckVersion (
      Self : IN Ref; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long)
      RETURN Corba.Boolean
   IS
     
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
      FUNCTION SOMClass_somCheckVersion(
         Self : IN SOM.SOMObjectPtr; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somCheckVersion);
      PRAGMA interface_information (SOMClass_somCheckVersion, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somCheckVersion (
            Self.som_object,
            majorVersion,
            minorVersion,
            SOMClassClassData.somCheckVersion);
      RETURN Result;
   END somCheckVersion; 

   FUNCTION somDescendedFrom (
      Self : IN Ref; 
      aClassObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <self> is a descendent class of <aClassObj> and
     -- 0 (false) otherwise.  Note: a class object is considered to be
     -- descended itself for the purposes of this method.
      FUNCTION SOMClass_somDescendedFrom(
         Self : IN SOM.SOMObjectPtr; 
         aClassObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somDescendedFrom);
      PRAGMA interface_information (SOMClass_somDescendedFrom, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somDescendedFrom (
            Self.som_object,
            aClassObj,
            SOMClassClassData.somDescendedFrom);
      RETURN Result;
   END somDescendedFrom; 

   FUNCTION somSupportsMethod (
      Self : IN Ref; 
      mId : IN SOM.somId)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if the indicated method is supported by this
     -- class and 0 (false) otherwise.
      FUNCTION SOMClass_somSupportsMethod(
         Self : IN SOM.SOMObjectPtr; 
         mId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClass_somSupportsMethod);
      PRAGMA interface_information (SOMClass_somSupportsMethod, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somSupportsMethod (
            Self.som_object,
            mId,
            SOMClassClassData.somSupportsMethod);
      RETURN Result;
   END somSupportsMethod; 

   FUNCTION somDefinedMethod (
      Self : IN Ref; 
      method : IN SOM.somMToken)
      RETURN SOM.somMethodPtr
   IS
     
     -- if the receiving class either introduces or overrides the
     -- indicated method, then its somMethodPtr is returned, otherwise
     -- NULL is returned.
      FUNCTION SOMClass_somDefinedMethod(
         Self : IN SOM.SOMObjectPtr; 
         method : IN SOM.somMToken;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.somMethodPtr; 
      PRAGMA interface (assembly, SOMClass_somDefinedMethod);
      PRAGMA interface_information (SOMClass_somDefinedMethod, ".xsomcall2");
      Result : ALIASED SOM.somMethodPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClass_somDefinedMethod (
            Self.som_object,
            method,
            SOMClassClassData.somDefinedMethod);
      RETURN Result;
   END somDefinedMethod; 

   PROCEDURE somOverrideMtab (
      Self : IN Ref)
   IS
     
     -- Overrides the method table pointers to point to the redispatch stubs.
     -- All the methods except somDispatch methods are overriden.
      PROCEDURE SOMClass_somOverrideMtab(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClass_somOverrideMtab);
      PRAGMA interface_information (SOMClass_somOverrideMtab, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClass_somOverrideMtab (
         Self.som_object,
         SOMClassClassData.somOverrideMtab);
   END somOverrideMtab;

END SOMClass; 







