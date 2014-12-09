
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:43 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba.Sequences;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMClassMgr IS


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
      

   SUBTYPE SOMClassArray IS SOM.voidPtr;

   PACKAGE SOMClass_Unbounded IS 
      NEW Corba.Sequences.Unbounded(SOM.SOMObjectPtr);



   FUNCTION somLoadClassFile (
      Self : IN Ref;
      classId : IN SOM.somId;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long;
      file : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Loads the class' code and initializes the class object.

   FUNCTION somLocateClassFile (
      Self : IN Ref;
      classId : IN SOM.somId;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long)
      RETURN Corba.String;
     
     -- Real implementation supplied by subclasses.  Default implementation
     -- will lookup the class name in the Interface Repository (if one is
     -- available) to determine the implementation file name (ie, DLL name).
     -- If this information is not available, the class name itself is
     -- returned as the file name.   Subclasses may use version number
     -- info to assist in deriving the file name.

   PROCEDURE somRegisterClass (
      Self : IN Ref;
      classObj : IN SOM.SOMObjectPtr);
     
     -- Lets the class manager know that the specified class is installed
     -- and tells it where the class object is.

   PROCEDURE somRegisterClassLibrary (
      Self : IN Ref;
      libraryName : IN Corba.String;
      libraryInitRtn : IN SOM.somMethodPtr);
     
     -- Informs the class manager that a class library has been loaded.
     -- "libraryName" is the name associated with the file containing the
     -- implementation(s) of the class(es) in the class library.
     -- "libraryInitRtn" is the entry point of a SOMInitModule function
     -- that can be used to initialize the class library.  For platforms
     -- that have the capability to automatically invoke a library
     -- initialization function whenever a library is loaded, a call
     -- to this method should occur within the library's automatic init
     -- function.

   FUNCTION somUnloadClassFile (
      Self : IN Ref;
      classObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long;
     
     -- Releases the class' code and unregisters all classes in the
     -- same affinity group (see somGetRelatedClasses below).

   FUNCTION somUnregisterClass (
      Self : IN Ref;
      classObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long;
     
     -- Free the class object and removes the class from the SOM registry.
     -- If the class caused dynamic loading to occur, it is also unloaded
     -- (causing its entire affinity group to be unregistered as well).

   PROCEDURE somBeginPersistentClasses (
      Self : IN Ref);
     
     -- Starts a bracket for the current thread wherein all classes
     -- that are registered are marked as permanant and cannot be
     -- unregistered or unloaded.  Persistent classes brackets may be
     -- nested.

   PROCEDURE somEndPersistentClasses (
      Self : IN Ref);
     
     -- Ends a persistent classes bracket for the current thread.

   FUNCTION somJoinAffinityGroup (
      Self : IN Ref;
      newClass : IN SOM.SOMObjectPtr;
      affClass : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- If <affClass> is a member of an affinity group, and <newClass> is not a
     -- member of any affinity group, this method adds <newClass> to the
     -- same affinity group as <affClass>.  If the method succeeds it returns
     -- TRUE, otherwise it returns FALSE.  Adding a class to an affinity group
     -- effectively equates its lifetime with that of the other members of
     -- the affinity group.
     -- [Access Group]

   FUNCTION somGetInitFunction (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The name of the initialization function in the class' code file.
     -- Default implementation returns (*SOMClassInitFuncName)().

   FUNCTION get_somInterfaceRepository (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The Repository object that provides access to the Interface Repository,
     -- If no Interface Repository has yet been assigned to this attribute,
     -- and the SOMClassMgr is unable to load and instantiate it, the attribute
     -- will have the value NULL.  When finished using the Repository object
     -- you should release your reference using the somDestruct method with
     -- a non-zero <doFree> parameter.

   PROCEDURE set_somInterfaceRepository (
      Self : IN Ref;
      somInterfaceRepository : IN SOM.SOMObjectPtr);
     
     -- The Repository object that provides access to the Interface Repository,
     -- If no Interface Repository has yet been assigned to this attribute,
     -- and the SOMClassMgr is unable to load and instantiate it, the attribute
     -- will have the value NULL.  When finished using the Repository object
     -- you should release your reference using the somDestruct method with
     -- a non-zero <doFree> parameter.

   FUNCTION get_somRegisteredClasses (
      Self : IN Ref)
      RETURN SOMClassMgr.SOMClass_Unbounded.Sequence;
     
     -- A list of all classes currently registered in this process.

   FUNCTION somGetRelatedClasses (
      Self : IN Ref;
      classObj : IN SOM.SOMObjectPtr)
      RETURN SOMClassMgr.SOMClassArray;
     
     -- Returns an array of class objects that were all registered during
     -- the dynamic loading of a class. These classes are considered to
     -- define an affinity group.  Any class is a member of at most one
     -- affinity group. The affinity group returned by this call is the
     -- one containing the class identified by classObj.  The first element
     -- in the array is the class that caused the group to be loaded, or the
     -- special value -1 which means that the SOMClassMgr is currently in the
     -- process of unregistering and deleting the affinity group (only
     -- SOMClassMgr subclasses would ever see this value).
     -- The remainder of the array (elements one thru n) consists of
     -- pointers to class objects ordered in reverse chronological sequence
     -- to that in which they were originally registered.  This list includes
     -- the given argument, classObj, as one of its elements, as well as the
     -- class, if any, returned as element[0] above.  The array is terminated
     -- by a NULL pointer as the last element.  Use SOMFree to release the
     -- array when it is no longer needed.  If the supplied class was not
     -- dynamically loaded, it is not a member of any affinity
     -- group and NULL is returned.
     -- [Dynamic Group]

   FUNCTION somClassFromId (
      Self : IN Ref;
      classId : IN SOM.somId)
      RETURN SOM.SOMObjectPtr;
     
     -- Finds the class object, given its Id, if it already exists.
     -- Does not load the class.  Returns NULL if the class object does
     -- not yet exist.

   FUNCTION somFindClass (
      Self : IN Ref;
      classId : IN SOM.somId;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the class object for the specified class.  This may result
     -- in dynamic loading.  Uses somLocateClassFile to obtain the name of
     -- the file where the class' code resides, then uses somFindClsInFile.

   FUNCTION somFindClsInFile (
      Self : IN Ref;
      classId : IN SOM.somId;
      majorVersion : IN Corba.Long;
      minorVersion : IN Corba.Long;
      file : IN Corba.String)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the class object for the specified class.  This may result
     -- in dynamic loading.  If the class already exists <file> is ignored,
     -- otherwise it is used to locate and dynamically load the class.
     -- Values of 0 for major and minor version numbers bypass version checking.

   PROCEDURE somMergeInto (
      Self : IN Ref;
      targetObj : IN SOM.SOMObjectPtr);
     
     -- Merges the SOMClassMgr registry information from the receiver to
     -- <targetObj>.  <targetObj> is required to be an instance of SOMClassMgr
     -- or one of its subclasses.  At the completion of this operation,
     -- the <targetObj> should be able to function as a replacement for the
     -- receiver.  At the end of the operation the receiver object (which is
     -- then in a newly uninitialized state) is freed.  Subclasses that
     -- override this method should similarly transfer their sections of
     -- the object and pass this method to their parent as the final step.
     -- If the receiving object is the distinguished instance pointed to
     -- from the global variable SOMClassMgrObject, SOMCLassMgrObject is
     -- then reassigned to point to <targetObj>.

   FUNCTION somSubstituteClass (
      Self : IN Ref;
      origClassName : IN Corba.String;
      newClassName : IN Corba.String)
      RETURN Corba.Long;
     
     -- This method causes the somFindClass, somFindClsInFile, and
     -- somClassFromId methods to return the class named newClassName
     -- whenever they would have normally returned the class named
     -- origClassName.  This effectively results in class <newClassName>
     -- replacing or substituting itself for class <origClassName>.
     -- Some restrictions are enforced to insure that this works well.
     -- Both class <origClassName> and class <newClassName> must
     -- have been already registered before issuing this method, and newClass
     -- must be an immediate child of origClass.  In addition (although not
     -- enforceable), no instances should exist of either class at the time
     -- this method is invoked. A return value of zero indicates success;
     -- a non-zero value indicates an error was detected.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMClassMgr; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMClassMgr IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somFindClsInFile : SOM.somMToken;
      somFindClass : SOM.somMToken;
      somClassFromId : SOM.somMToken;
      somRegisterClass : SOM.somMToken;
      somUnregisterClass : SOM.somMToken;
      somLocateClassFile : SOM.somMToken;
      somLoadClassFile : SOM.somMToken;
      somUnloadClassFile : SOM.somMToken;
      somGetInitFunction : SOM.somMToken;
      somMergeInto : SOM.somMToken;
      somGetRelatedClasses : SOM.somMToken;
      somSubstituteClass : SOM.somMToken;
      get_somInterfaceRepository : SOM.somMToken;
      set_somInterfaceRepository : SOM.somMToken;
      get_somRegisteredClasses : SOM.somMToken;
      somBeginPersistentClasses : SOM.somMToken;
      somEndPersistentClasses : SOM.somMToken;
      somcmPrivate1 : SOM.somMToken;
      somcmPrivate2 : SOM.somMToken;
      somRegisterClassLibrary : SOM.somMToken;
      somJoinAffinityGroup : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMClassMgrClassData : classData;
   FOR SOMClassMgrClassData USE AT standard.system.label("SOMClassMgrClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMClassMgrCClassData : CClassData;
   FOR SOMClassMgrCClassData USE AT standard.system.label("SOMClassMgrCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMClassMgrClassData.classObject) 
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
      FUNCTION SOMClassMgrNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMClassMgrNewClass);
      PRAGMA interface_information (SOMClassMgrNewClass, ".SOMClassMgrNewClass");
   BEGIN
      RETURN SOMClassMgrNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMClassMgrClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMClassMgrClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somLoadClassFile (
      Self : IN Ref; 
      classId : IN SOM.somId; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long; 
      file : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Loads the class' code and initializes the class object.
      FUNCTION SOMClassMgr_somLoadClassFile(
         Self : IN SOM.SOMObjectPtr; 
         classId : IN SOM.somId; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long; 
         file : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClassMgr_somLoadClassFile);
      PRAGMA interface_information (SOMClassMgr_somLoadClassFile, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somLoadClassFile (
            Self.som_object,
            classId,
            majorVersion,
            minorVersion,
            file,
            SOMClassMgrClassData.somLoadClassFile);
      RETURN Result;
   END somLoadClassFile; 

   FUNCTION somLocateClassFile (
      Self : IN Ref; 
      classId : IN SOM.somId; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long)
      RETURN Corba.String
   IS
     
     -- Real implementation supplied by subclasses.  Default implementation
     -- will lookup the class name in the Interface Repository (if one is
     -- available) to determine the implementation file name (ie, DLL name).
     -- If this information is not available, the class name itself is
     -- returned as the file name.   Subclasses may use version number
     -- info to assist in deriving the file name.
      FUNCTION SOMClassMgr_somLocateClassFile(
         Self : IN SOM.SOMObjectPtr; 
         classId : IN SOM.somId; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMClassMgr_somLocateClassFile);
      PRAGMA interface_information (SOMClassMgr_somLocateClassFile, ".xsomcall4");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somLocateClassFile (
            Self.som_object,
            classId,
            majorVersion,
            minorVersion,
            SOMClassMgrClassData.somLocateClassFile);
      RETURN Result;
   END somLocateClassFile; 

   PROCEDURE somRegisterClass (
      Self : IN Ref; 
      classObj : IN SOM.SOMObjectPtr)
   IS
     
     -- Lets the class manager know that the specified class is installed
     -- and tells it where the class object is.
      PROCEDURE SOMClassMgr_somRegisterClass(
         Self : IN SOM.SOMObjectPtr; 
         classObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_somRegisterClass);
      PRAGMA interface_information (SOMClassMgr_somRegisterClass, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_somRegisterClass (
         Self.som_object,
         classObj,
         SOMClassMgrClassData.somRegisterClass);
   END somRegisterClass;

   PROCEDURE somRegisterClassLibrary (
      Self : IN Ref; 
      libraryName : IN Corba.String; 
      libraryInitRtn : IN SOM.somMethodPtr)
   IS
     
     -- Informs the class manager that a class library has been loaded.
     -- "libraryName" is the name associated with the file containing the
     -- implementation(s) of the class(es) in the class library.
     -- "libraryInitRtn" is the entry point of a SOMInitModule function
     -- that can be used to initialize the class library.  For platforms
     -- that have the capability to automatically invoke a library
     -- initialization function whenever a library is loaded, a call
     -- to this method should occur within the library's automatic init
     -- function.
      PROCEDURE SOMClassMgr_somRegisterClassLibrary(
         Self : IN SOM.SOMObjectPtr; 
         libraryName : IN Corba.String; 
         libraryInitRtn : IN SOM.somMethodPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_somRegisterClassLibrary);
      PRAGMA interface_information (SOMClassMgr_somRegisterClassLibrary, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_somRegisterClassLibrary (
         Self.som_object,
         libraryName,
         libraryInitRtn,
         SOMClassMgrClassData.somRegisterClassLibrary);
   END somRegisterClassLibrary;

   FUNCTION somUnloadClassFile (
      Self : IN Ref; 
      classObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long
   IS
     
     -- Releases the class' code and unregisters all classes in the
     -- same affinity group (see somGetRelatedClasses below).
      FUNCTION SOMClassMgr_somUnloadClassFile(
         Self : IN SOM.SOMObjectPtr; 
         classObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClassMgr_somUnloadClassFile);
      PRAGMA interface_information (SOMClassMgr_somUnloadClassFile, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somUnloadClassFile (
            Self.som_object,
            classObj,
            SOMClassMgrClassData.somUnloadClassFile);
      RETURN Result;
   END somUnloadClassFile; 

   FUNCTION somUnregisterClass (
      Self : IN Ref; 
      classObj : IN SOM.SOMObjectPtr)
      RETURN Corba.Long
   IS
     
     -- Free the class object and removes the class from the SOM registry.
     -- If the class caused dynamic loading to occur, it is also unloaded
     -- (causing its entire affinity group to be unregistered as well).
      FUNCTION SOMClassMgr_somUnregisterClass(
         Self : IN SOM.SOMObjectPtr; 
         classObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClassMgr_somUnregisterClass);
      PRAGMA interface_information (SOMClassMgr_somUnregisterClass, ".xsomcall2");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somUnregisterClass (
            Self.som_object,
            classObj,
            SOMClassMgrClassData.somUnregisterClass);
      RETURN Result;
   END somUnregisterClass; 

   PROCEDURE somBeginPersistentClasses (
      Self : IN Ref)
   IS
     
     -- Starts a bracket for the current thread wherein all classes
     -- that are registered are marked as permanant and cannot be
     -- unregistered or unloaded.  Persistent classes brackets may be
     -- nested.
      PROCEDURE SOMClassMgr_somBeginPersistentClasses(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_somBeginPersistentClasses);
      PRAGMA interface_information (SOMClassMgr_somBeginPersistentClasses, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_somBeginPersistentClasses (
         Self.som_object,
         SOMClassMgrClassData.somBeginPersistentClasses);
   END somBeginPersistentClasses;

   PROCEDURE somEndPersistentClasses (
      Self : IN Ref)
   IS
     
     -- Ends a persistent classes bracket for the current thread.
      PROCEDURE SOMClassMgr_somEndPersistentClasses(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_somEndPersistentClasses);
      PRAGMA interface_information (SOMClassMgr_somEndPersistentClasses, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_somEndPersistentClasses (
         Self.som_object,
         SOMClassMgrClassData.somEndPersistentClasses);
   END somEndPersistentClasses;

   FUNCTION somJoinAffinityGroup (
      Self : IN Ref; 
      newClass : IN SOM.SOMObjectPtr; 
      affClass : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- If <affClass> is a member of an affinity group, and <newClass> is not a
     -- member of any affinity group, this method adds <newClass> to the
     -- same affinity group as <affClass>.  If the method succeeds it returns
     -- TRUE, otherwise it returns FALSE.  Adding a class to an affinity group
     -- effectively equates its lifetime with that of the other members of
     -- the affinity group.
     -- [Access Group]
      FUNCTION SOMClassMgr_somJoinAffinityGroup(
         Self : IN SOM.SOMObjectPtr; 
         newClass : IN SOM.SOMObjectPtr; 
         affClass : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMClassMgr_somJoinAffinityGroup);
      PRAGMA interface_information (SOMClassMgr_somJoinAffinityGroup, ".xsomcall3");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somJoinAffinityGroup (
            Self.som_object,
            newClass,
            affClass,
            SOMClassMgrClassData.somJoinAffinityGroup);
      RETURN Result;
   END somJoinAffinityGroup; 

   FUNCTION somGetInitFunction (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The name of the initialization function in the class' code file.
     -- Default implementation returns (*SOMClassInitFuncName)().
      FUNCTION SOMClassMgr_somGetInitFunction(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMClassMgr_somGetInitFunction);
      PRAGMA interface_information (SOMClassMgr_somGetInitFunction, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somGetInitFunction (
            Self.som_object,
            SOMClassMgrClassData.somGetInitFunction);
      RETURN Result;
   END somGetInitFunction; 

   FUNCTION get_somInterfaceRepository (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The Repository object that provides access to the Interface Repository,
     -- If no Interface Repository has yet been assigned to this attribute,
     -- and the SOMClassMgr is unable to load and instantiate it, the attribute
     -- will have the value NULL.  When finished using the Repository object
     -- you should release your reference using the somDestruct method with
     -- a non-zero <doFree> parameter.
      FUNCTION SOMClassMgr_U_get_somInterfaceRepository(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClassMgr_U_get_somInterfaceRepository);
      PRAGMA interface_information (SOMClassMgr_U_get_somInterfaceRepository, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_U_get_somInterfaceRepository (
            Self.som_object,
            SOMClassMgrClassData.get_somInterfaceRepository);
      RETURN Result;
   END get_somInterfaceRepository; 

   PROCEDURE set_somInterfaceRepository (
      Self : IN Ref; 
      somInterfaceRepository : IN SOM.SOMObjectPtr)
   IS
     
     -- The Repository object that provides access to the Interface Repository,
     -- If no Interface Repository has yet been assigned to this attribute,
     -- and the SOMClassMgr is unable to load and instantiate it, the attribute
     -- will have the value NULL.  When finished using the Repository object
     -- you should release your reference using the somDestruct method with
     -- a non-zero <doFree> parameter.
      PROCEDURE SOMClassMgr_U_set_somInterfaceRepository(
         Self : IN SOM.SOMObjectPtr; 
         somInterfaceRepository : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_U_set_somInterfaceRepository);
      PRAGMA interface_information (SOMClassMgr_U_set_somInterfaceRepository, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_U_set_somInterfaceRepository (
         Self.som_object,
         somInterfaceRepository,
         SOMClassMgrClassData.set_somInterfaceRepository);
   END set_somInterfaceRepository;

   FUNCTION get_somRegisteredClasses (
      Self : IN Ref)
      RETURN SOMClassMgr.SOMClass_Unbounded.Sequence
   IS
     
     -- A list of all classes currently registered in this process.
      PROCEDURE SOMClassMgr_U_get_somRegisteredClasses(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_U_get_somRegisteredClasses);
      PRAGMA interface_information (SOMClassMgr_U_get_somRegisteredClasses, ".xsomcall2");
      Result : ALIASED SOMClassMgr.SOMClass_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_U_get_somRegisteredClasses (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         SOMClassMgrClassData.get_somRegisteredClasses);
      RETURN Result;
   END get_somRegisteredClasses; 

   FUNCTION somGetRelatedClasses (
      Self : IN Ref; 
      classObj : IN SOM.SOMObjectPtr)
      RETURN SOMClassMgr.SOMClassArray
   IS
     
     -- Returns an array of class objects that were all registered during
     -- the dynamic loading of a class. These classes are considered to
     -- define an affinity group.  Any class is a member of at most one
     -- affinity group. The affinity group returned by this call is the
     -- one containing the class identified by classObj.  The first element
     -- in the array is the class that caused the group to be loaded, or the
     -- special value -1 which means that the SOMClassMgr is currently in the
     -- process of unregistering and deleting the affinity group (only
     -- SOMClassMgr subclasses would ever see this value).
     -- The remainder of the array (elements one thru n) consists of
     -- pointers to class objects ordered in reverse chronological sequence
     -- to that in which they were originally registered.  This list includes
     -- the given argument, classObj, as one of its elements, as well as the
     -- class, if any, returned as element[0] above.  The array is terminated
     -- by a NULL pointer as the last element.  Use SOMFree to release the
     -- array when it is no longer needed.  If the supplied class was not
     -- dynamically loaded, it is not a member of any affinity
     -- group and NULL is returned.
     -- [Dynamic Group]
      FUNCTION SOMClassMgr_somGetRelatedClasses(
         Self : IN SOM.SOMObjectPtr; 
         classObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOMClassMgr.SOMClassArray; 
      PRAGMA interface (assembly, SOMClassMgr_somGetRelatedClasses);
      PRAGMA interface_information (SOMClassMgr_somGetRelatedClasses, ".xsomcall2");
      Result : ALIASED SOMClassMgr.SOMClassArray;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somGetRelatedClasses (
            Self.som_object,
            classObj,
            SOMClassMgrClassData.somGetRelatedClasses);
      RETURN Result;
   END somGetRelatedClasses; 

   FUNCTION somClassFromId (
      Self : IN Ref; 
      classId : IN SOM.somId)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Finds the class object, given its Id, if it already exists.
     -- Does not load the class.  Returns NULL if the class object does
     -- not yet exist.
      FUNCTION SOMClassMgr_somClassFromId(
         Self : IN SOM.SOMObjectPtr; 
         classId : IN SOM.somId;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClassMgr_somClassFromId);
      PRAGMA interface_information (SOMClassMgr_somClassFromId, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somClassFromId (
            Self.som_object,
            classId,
            SOMClassMgrClassData.somClassFromId);
      RETURN Result;
   END somClassFromId; 

   FUNCTION somFindClass (
      Self : IN Ref; 
      classId : IN SOM.somId; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the class object for the specified class.  This may result
     -- in dynamic loading.  Uses somLocateClassFile to obtain the name of
     -- the file where the class' code resides, then uses somFindClsInFile.
      FUNCTION SOMClassMgr_somFindClass(
         Self : IN SOM.SOMObjectPtr; 
         classId : IN SOM.somId; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClassMgr_somFindClass);
      PRAGMA interface_information (SOMClassMgr_somFindClass, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somFindClass (
            Self.som_object,
            classId,
            majorVersion,
            minorVersion,
            SOMClassMgrClassData.somFindClass);
      RETURN Result;
   END somFindClass; 

   FUNCTION somFindClsInFile (
      Self : IN Ref; 
      classId : IN SOM.somId; 
      majorVersion : IN Corba.Long; 
      minorVersion : IN Corba.Long; 
      file : IN Corba.String)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the class object for the specified class.  This may result
     -- in dynamic loading.  If the class already exists <file> is ignored,
     -- otherwise it is used to locate and dynamically load the class.
     -- Values of 0 for major and minor version numbers bypass version checking.
      FUNCTION SOMClassMgr_somFindClsInFile(
         Self : IN SOM.SOMObjectPtr; 
         classId : IN SOM.somId; 
         majorVersion : IN Corba.Long; 
         minorVersion : IN Corba.Long; 
         file : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMClassMgr_somFindClsInFile);
      PRAGMA interface_information (SOMClassMgr_somFindClsInFile, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somFindClsInFile (
            Self.som_object,
            classId,
            majorVersion,
            minorVersion,
            file,
            SOMClassMgrClassData.somFindClsInFile);
      RETURN Result;
   END somFindClsInFile; 

   PROCEDURE somMergeInto (
      Self : IN Ref; 
      targetObj : IN SOM.SOMObjectPtr)
   IS
     
     -- Merges the SOMClassMgr registry information from the receiver to
     -- <targetObj>.  <targetObj> is required to be an instance of SOMClassMgr
     -- or one of its subclasses.  At the completion of this operation,
     -- the <targetObj> should be able to function as a replacement for the
     -- receiver.  At the end of the operation the receiver object (which is
     -- then in a newly uninitialized state) is freed.  Subclasses that
     -- override this method should similarly transfer their sections of
     -- the object and pass this method to their parent as the final step.
     -- If the receiving object is the distinguished instance pointed to
     -- from the global variable SOMClassMgrObject, SOMCLassMgrObject is
     -- then reassigned to point to <targetObj>.
      PROCEDURE SOMClassMgr_somMergeInto(
         Self : IN SOM.SOMObjectPtr; 
         targetObj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMClassMgr_somMergeInto);
      PRAGMA interface_information (SOMClassMgr_somMergeInto, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMClassMgr_somMergeInto (
         Self.som_object,
         targetObj,
         SOMClassMgrClassData.somMergeInto);
   END somMergeInto;

   FUNCTION somSubstituteClass (
      Self : IN Ref; 
      origClassName : IN Corba.String; 
      newClassName : IN Corba.String)
      RETURN Corba.Long
   IS
     
     -- This method causes the somFindClass, somFindClsInFile, and
     -- somClassFromId methods to return the class named newClassName
     -- whenever they would have normally returned the class named
     -- origClassName.  This effectively results in class <newClassName>
     -- replacing or substituting itself for class <origClassName>.
     -- Some restrictions are enforced to insure that this works well.
     -- Both class <origClassName> and class <newClassName> must
     -- have been already registered before issuing this method, and newClass
     -- must be an immediate child of origClass.  In addition (although not
     -- enforceable), no instances should exist of either class at the time
     -- this method is invoked. A return value of zero indicates success;
     -- a non-zero value indicates an error was detected.
      FUNCTION SOMClassMgr_somSubstituteClass(
         Self : IN SOM.SOMObjectPtr; 
         origClassName : IN Corba.String; 
         newClassName : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMClassMgr_somSubstituteClass);
      PRAGMA interface_information (SOMClassMgr_somSubstituteClass, ".xsomcall3");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMClassMgr_somSubstituteClass (
            Self.som_object,
            origClassName,
            newClassName,
            SOMClassMgrClassData.somSubstituteClass);
      RETURN Result;
   END somSubstituteClass; 

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

END SOMClassMgr; 







