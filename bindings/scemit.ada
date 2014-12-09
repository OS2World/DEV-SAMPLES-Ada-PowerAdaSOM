
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:15 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMObject;
WITH SOMTTemplateOutputC;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTEmitC IS

   
   -- This is the pluggable unit in the SOM emitter framework. An emitter
   -- is constructed by subclassing this class and then running the
   -- master emitter program providing the name of the subclass as one of
   -- its command line arguments.
   -- The concepts of this class are simple:
   --
   --   Emitters always consist of a set of sections
   --   The sections are in a particular order for any particular
   --   emitter, and the order does not vary with the data processed by
   --   the emitter.
   --   A number of the sections of an emitter are common (maybe with
   --   slight variation) across several (or even most) emitters.
   --   There are a number of constructs that occur in varying numbers,
   --   eg, method declarations, data declarations, and attribute
   --   declarations.
   -- Consequently, this class provides methods for:
   --   Methods for many common sections, including several that may be
   --   useful without overridding in several different emitters
   --   Sequencing through the sections of the emitter
   --   Iterating through the constructs that occur in varying numbers

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
      


   FUNCTION get_somtTemplate (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The template is to provide template output and maintains a symbol
     -- table that provides a sort of global context for the emitter.

   PROCEDURE set_somtTemplate (
      Self : IN Ref;
      somtTemplate : IN SOM.SOMObjectPtr);
     
     -- The template is to provide template output and maintains a symbol
     -- table that provides a sort of global context for the emitter.

   FUNCTION get_somtTargetFile (
      Self : IN Ref)
      RETURN SCTypes.FILE;
     
     -- The target file is the one to which all emitter output is to be
     -- directed.

   PROCEDURE set_somtTargetFile (
      Self : IN Ref;
      somtTargetFile : IN SCTypes.FILE);
     
     -- The target file is the one to which all emitter output is to be
     -- directed.

   FUNCTION get_somtTargetClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The target class is the class definition for which code is to be
     -- emitted.

   PROCEDURE set_somtTargetClass (
      Self : IN Ref;
      somtTargetClass : IN SOM.SOMObjectPtr);
     
     -- The target class is the class definition for which code is to be
     -- emitted.

   FUNCTION get_somtTargetModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- The target module is the module definition for which code is to be
     -- emitted.

   PROCEDURE set_somtTargetModule (
      Self : IN Ref;
      somtTargetModule : IN SOM.SOMObjectPtr);
     
     -- The target module is the module definition for which code is to be
     -- emitted.

   FUNCTION get_somtTargetType (
      Self : IN Ref)
      RETURN SCTypes.SOMTTargetTypeT;
     
     -- The target type indicates what type of output file is being
     -- produced, public, private, or implementation.  This allows the
     -- same emitter subclass to produce several different output files
     -- that generally differ only in how much of the class definition
     -- they cover. Eg, .csc, .sc, and .psc.
     -- This is attribute is for OIDL compatibility only.

   PROCEDURE set_somtTargetType (
      Self : IN Ref;
      somtTargetType : IN SCTypes.SOMTTargetTypeT);
     
     -- The target type indicates what type of output file is being
     -- produced, public, private, or implementation.  This allows the
     -- same emitter subclass to produce several different output files
     -- that generally differ only in how much of the class definition
     -- they cover. Eg, .csc, .sc, and .psc.
     -- This is attribute is for OIDL compatibility only.

   FUNCTION get_somtEmitterName (
      Self : IN Ref)
      RETURN Corba.String;
     
     -- The short name of the emitter (the name used to invoke it via the
     -- SOM Compiler.  Typically this is the file stem of the subclass
     -- of SOMTEmitC. This attribute should be set in the driver program
     -- that runs the emitter.  It is used to filter passthrus so that only
     -- passthrus directed to a particular emitter are seen by it.

   PROCEDURE set_somtEmitterName (
      Self : IN Ref;
      somtEmitterName : IN Corba.String);
     
     -- The short name of the emitter (the name used to invoke it via the
     -- SOM Compiler.  Typically this is the file stem of the subclass
     -- of SOMTEmitC. This attribute should be set in the driver program
     -- that runs the emitter.  It is used to filter passthrus so that only
     -- passthrus directed to a particular emitter are seen by it.

   FUNCTION somtGenerateSections (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     -- Calls each of the section methods in order.  The order is:
     --
     --   somtEmitProlog
     --   when emitting a class:
     --           somtEmitClass
     --           somtEmitBase
     --           somtEmitMeta
     --   somtEmitConstant
     --   somtEmitTypedef
     --   somtEmitStruct
     --   somtEmitUnion
     --   somtEmitEnum
     --   when emitting a class:
     --      somtEmitAttribute
     --      somtEmitMethod
     --      somtEmitRelease
     --      somtEmitPassthru
     --      somtEmitData
     --   when emitting a module:
     --       somtEmitInterface
     --       somtEmitModule
     --   somtEmitEpilog
     --
     -- This method will need to be overridden by many emitters in order
     -- to rearange the order of the sections and to add or delete
     -- sections.
     -- Note: repeating sections such as methods, data, and passthru,
     -- have a prolog and epilog method as well. The prolog method is
     -- called before the first sections is processed and the epilog method
     -- is called after the last section is processed.

   FUNCTION somtOpenSymbolsFile (
      Self : IN Ref;
      file : IN Corba.String;
      mode : IN Corba.String)
      RETURN SCTypes.FILE;
     
     -- This method attempts to open the symbols file.
     -- If file doesn't exist then it will attempt to find it in the
     -- directories specified in the SMINCLUDE environment variable.
     -- If the file can be found a FILE * pointer is returned, otherwise
     -- NULL is returned.

   PROCEDURE somtSetPredefinedSymbols (
      Self : IN Ref);
     
     -- Set predefined symbols that are used for such things as section
     -- names etc.

   PROCEDURE somtFileSymbols (
      Self : IN Ref);
     
     -- Symbols that are common to the file.  This includes the target
     -- class symbols, and the metaclass symbols, and special symbols
     -- like <timeStamp>.  IE, all symbols that have a single definition.

   PROCEDURE somtEmitProlog (
      Self : IN Ref);

   PROCEDURE somtEmitBaseIncludesProlog (
      Self : IN Ref);

   PROCEDURE somtEmitBaseIncludes (
      Self : IN Ref;
      base : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitBaseIncludesEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitMetaInclude (
      Self : IN Ref);

   PROCEDURE somtEmitClass (
      Self : IN Ref);

   PROCEDURE somtEmitMeta (
      Self : IN Ref);

   PROCEDURE somtEmitBaseProlog (
      Self : IN Ref);

   PROCEDURE somtEmitBase (
      Self : IN Ref;
      base : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitBaseEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitPassthruProlog (
      Self : IN Ref);

   PROCEDURE somtEmitPassthru (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitPassthruEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitRelease (
      Self : IN Ref);

   PROCEDURE somtEmitDataProlog (
      Self : IN Ref);

   PROCEDURE somtEmitData (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitDataEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitAttributeProlog (
      Self : IN Ref);

   PROCEDURE somtEmitAttribute (
      Self : IN Ref;
      att : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitAttributeEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitConstantProlog (
      Self : IN Ref);

   PROCEDURE somtEmitConstant (
      Self : IN Ref;
      con : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitConstantEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitTypedefProlog (
      Self : IN Ref);

   PROCEDURE somtEmitTypedef (
      Self : IN Ref;
      td : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitTypedefEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitStructProlog (
      Self : IN Ref);

   PROCEDURE somtEmitStruct (
      Self : IN Ref;
      struc : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitStructEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitUnionProlog (
      Self : IN Ref);

   PROCEDURE somtEmitUnion (
      Self : IN Ref;
      un : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitUnionEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitEnumProlog (
      Self : IN Ref);

   PROCEDURE somtEmitEnum (
      Self : IN Ref;
      en : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitEnumEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitInterfaceProlog (
      Self : IN Ref);

   PROCEDURE somtEmitInterface (
      Self : IN Ref;
      intfc : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitInterfaceEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitModuleProlog (
      Self : IN Ref);

   PROCEDURE somtEmitModule (
      Self : IN Ref;
      IDL_mod : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitModuleEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitMethodsProlog (
      Self : IN Ref);

   PROCEDURE somtEmitMethods (
      Self : IN Ref;
      method : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitMethodsEpilog (
      Self : IN Ref);

   PROCEDURE somtEmitMethod (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr);

   PROCEDURE somtEmitEpilog (
      Self : IN Ref);

   FUNCTION somtScanBases (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtCheckVisibility (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Return 1 (true) if <entry> should be visible in the current
     -- target file.  This method is used by each of the following filter
     -- methods that are concerned with visibility.
     -- The default rule for visibility is:
     --   only private methods are visible in private target files,
     --   only public methods are visibile in public target files,
     --   all methods are visibile in implementation or <somtAllE> target
     --   files.

   FUNCTION somtNew (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <entry> is a method introduced by the target
     -- class and its visibility matches <somtTargetType> (somtImplementationE
     -- matches both private and public)

   FUNCTION somtImplemented (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <entry> is a method introduced or overridden
     -- by the target class and its visibility matches <somtTargetType>
     -- (somtImplementationE matches both private and public)

   FUNCTION somtOverridden (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <entry> is an overridding method of the target class
     -- and its visibility matches <somtTargetType> (somtImplementationE
     -- matches both private and public)

   FUNCTION somtInherited (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <entry> is inherited
     -- by the target class and its visibility matches <somtTargetType>
     -- (somtImplementationE matches both private and public)

   FUNCTION somtAllVisible (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <entry> is supported by the target class and
     -- its visibility matches <somtTargetType> (somtImplementationE
     -- matches both private and public)

   FUNCTION somtAll (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if <entry> is supported by the target class.

   FUNCTION somtNewNoProc (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if somtNew does and the method
     -- IS NOT a direct call Procedure.

   FUNCTION somtPrivOrPub (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if entry is Private or Public.

   FUNCTION somtNewProc (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if somtNew does and the method
     -- IS a direct call Procedure.

   FUNCTION somtLink (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if "nolink" is not set.

   FUNCTION somtVA (
      Self : IN Ref;
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if entry is a VarArgs method.

   FUNCTION somtScanMethods (
      Self : IN Ref;
      filter : IN Corba.String;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String;
      forceProlog : IN Corba.Boolean)
      RETURN Corba.Boolean;
     
     -- Will only call <each> on methods accepted by <filter>.
     -- If <forceProlog> is not true then the prolog and epilog emiters
     -- will be called only if there is at least one method that passes
     -- the filter.

   FUNCTION somtScanConstants (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanTypedefs (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanStructs (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanUnions (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanEnums (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanData (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanAttributes (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanInterfaces (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanModules (
      Self : IN Ref;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   FUNCTION somtScanPassthru (
      Self : IN Ref;
      before : IN Corba.Boolean;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String)
      RETURN Corba.Boolean;

   PROCEDURE somtEmitFullPassthru (
      Self : IN Ref;
      before : IN Corba.Boolean;
      language : IN Corba.String);
     
     -- Emits each passthru section defined for the language and targetType,
     -- and the result of the somtIsBeforePassthru method is equal to the
     -- before parameter.  (before = 1(true), or before = 0(false), i.e. after.)

   FUNCTION somtScanDataF (
      Self : IN Ref;
      filter : IN Corba.String;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String;
      forceProlog : IN Corba.Boolean)
      RETURN Corba.Boolean;
     
     -- This method is like somtScanData but it also provides a paramater
     -- for a filter method.

   FUNCTION somtScanBasesF (
      Self : IN Ref;
      filter : IN Corba.String;
      prolog : IN Corba.String;
      each : IN Corba.String;
      epilog : IN Corba.String;
      forceProlog : IN Corba.Boolean)
      RETURN Corba.Boolean;
     
     -- This method is like somtScanBases but it also provides a paramater
     -- for a filter method.

   FUNCTION somtGetGlobalModifierValue (
      Self : IN Ref;
      modifierName : IN Corba.String)
      RETURN Corba.String;
     
     -- Returns the value of the specified global modifier.
     -- Global modifiers are specified when the SOM Compiler is invoked,
     -- via the "-a" option.  For example,
     --                       sc -a"foo=bar"  file.idl
     -- specifies to the SOM Compiler and the emitters being run that
     -- the global modifier "foo" has the value "bar."
     -- Values of global modifiers are transient; they last only for the
     -- duration of the compile for which they were specified.
     -- If a modifier is specified in the "sc" command with no value,
     -- as in
     --                       sc -afoo file.idl
     -- then the result of this method will be non-NULL.
     -- If no such modifier is specified, then the result is NULL.

   FUNCTION somtGetFirstGlobalDefinition (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the first type or constant definition that is not
     -- associated with any interface or module.
     -- These global definitions must be surrounded by the somemittypes
     -- pragmas for them to be visible via this method.
     -- E.g., #pragma somemittypes on
     --       ....
     --       #pragma someemittypes off
     -- The list of global definitions returned by this method and
     -- the somtGetNextGlobalDefinition method may include entries
     -- for forward declarations as well as typedefs and constants.
     -- Global structs and unions are also included in the list.

   FUNCTION somtGetNextGlobalDefinition (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr;
     
     -- Returns the next type or constant definition that is not
     -- associated with any interface or module, relative to a
     -- previous call to somtGetFirstGlobalDefinition or
     -- somtGetNextGlobalDefinition.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

END SOMTEmitC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTEmitC IS

   
   -- This is the pluggable unit in the SOM emitter framework. An emitter
   -- is constructed by subclassing this class and then running the
   -- master emitter program providing the name of the subclass as one of
   -- its command line arguments.
   -- The concepts of this class are simple:
   --
   --   Emitters always consist of a set of sections
   --   The sections are in a particular order for any particular
   --   emitter, and the order does not vary with the data processed by
   --   the emitter.
   --   A number of the sections of an emitter are common (maybe with
   --   slight variation) across several (or even most) emitters.
   --   There are a number of constructs that occur in varying numbers,
   --   eg, method declarations, data declarations, and attribute
   --   declarations.
   -- Consequently, this class provides methods for:
   --   Methods for many common sections, including several that may be
   --   useful without overridding in several different emitters
   --   Sequencing through the sections of the emitter
   --   Iterating through the constructs that occur in varying numbers

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtTemplate : SOM.somMToken;
      get_somtTargetFile : SOM.somMToken;
      set_somtTargetFile : SOM.somMToken;
      get_somtTargetClass : SOM.somMToken;
      set_somtTargetClass : SOM.somMToken;
      get_somtTargetModule : SOM.somMToken;
      set_somtTargetModule : SOM.somMToken;
      get_somtTargetType : SOM.somMToken;
      set_somtTargetType : SOM.somMToken;
      somtGenerateSections : SOM.somMToken;
      somtOpenSymbolsFile : SOM.somMToken;
      somtSetPredefinedSymbols : SOM.somMToken;
      somtFileSymbols : SOM.somMToken;
      somtEmitProlog : SOM.somMToken;
      somtEmitBaseIncludesProlog : SOM.somMToken;
      somtEmitBaseIncludes : SOM.somMToken;
      somtEmitBaseIncludesEpilog : SOM.somMToken;
      somtEmitMetaInclude : SOM.somMToken;
      somtEmitClass : SOM.somMToken;
      somtEmitMeta : SOM.somMToken;
      somtEmitBaseProlog : SOM.somMToken;
      somtEmitBase : SOM.somMToken;
      somtEmitBaseEpilog : SOM.somMToken;
      somtEmitPassthruProlog : SOM.somMToken;
      somtEmitPassthru : SOM.somMToken;
      somtEmitPassthruEpilog : SOM.somMToken;
      somtEmitRelease : SOM.somMToken;
      somtEmitDataProlog : SOM.somMToken;
      somtEmitData : SOM.somMToken;
      somtEmitDataEpilog : SOM.somMToken;
      somtEmitMethodsProlog : SOM.somMToken;
      somtEmitMethods : SOM.somMToken;
      somtEmitMethodsEpilog : SOM.somMToken;
      somtEmitMethod : SOM.somMToken;
      somtEmitEpilog : SOM.somMToken;
      somtScanBases : SOM.somMToken;
      somtScanConstants : SOM.somMToken;
      somtCheckVisibility : SOM.somMToken;
      somtNew : SOM.somMToken;
      somtImplemented : SOM.somMToken;
      somtOverridden : SOM.somMToken;
      somtInherited : SOM.somMToken;
      somtAllVisible : SOM.somMToken;
      somtAll : SOM.somMToken;
      somtNewNoProc : SOM.somMToken;
      somtPrivOrPub : SOM.somMToken;
      somtNewProc : SOM.somMToken;
      somtLink : SOM.somMToken;
      somtVA : SOM.somMToken;
      somtScanMethods : SOM.somMToken;
      somtScanData : SOM.somMToken;
      somtScanPassthru : SOM.somMToken;
      somtEmitFullPassthru : SOM.somMToken;
      somtScanDataF : SOM.somMToken;
      somtScanBasesF : SOM.somMToken;
      set_somtTemplate : SOM.somMToken;
      set_somtEmitterName : SOM.somMToken;
      get_somtEmitterName : SOM.somMToken;
      somtEmitAttributeProlog : SOM.somMToken;
      somtEmitAttribute : SOM.somMToken;
      somtEmitAttributeEpilog : SOM.somMToken;
      somtEmitConstantProlog : SOM.somMToken;
      somtEmitConstant : SOM.somMToken;
      somtEmitConstantEpilog : SOM.somMToken;
      somtEmitTypedefProlog : SOM.somMToken;
      somtEmitTypedef : SOM.somMToken;
      somtEmitTypedefEpilog : SOM.somMToken;
      somtEmitStructProlog : SOM.somMToken;
      somtEmitStruct : SOM.somMToken;
      somtEmitStructEpilog : SOM.somMToken;
      somtEmitUnionProlog : SOM.somMToken;
      somtEmitUnion : SOM.somMToken;
      somtEmitUnionEpilog : SOM.somMToken;
      somtEmitEnumProlog : SOM.somMToken;
      somtEmitEnum : SOM.somMToken;
      somtEmitEnumEpilog : SOM.somMToken;
      somtEmitInterfaceProlog : SOM.somMToken;
      somtEmitInterface : SOM.somMToken;
      somtEmitInterfaceEpilog : SOM.somMToken;
      somtEmitModuleProlog : SOM.somMToken;
      somtEmitModule : SOM.somMToken;
      somtEmitModuleEpilog : SOM.somMToken;
      somtScanAttributes : SOM.somMToken;
      somtScanTypedefs : SOM.somMToken;
      somtScanStructs : SOM.somMToken;
      somtScanUnions : SOM.somMToken;
      somtScanEnums : SOM.somMToken;
      somtScanInterfaces : SOM.somMToken;
      somtScanModules : SOM.somMToken;
      somtGetGlobalModifierValue : SOM.somMToken;
      somtGetFirstGlobalDefinition : SOM.somMToken;
      somtGetNextGlobalDefinition : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTEmitCClassData : classData;
   FOR SOMTEmitCClassData USE AT standard.system.label("SOMTEmitCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTEmitCCClassData : CClassData;
   FOR SOMTEmitCCClassData USE AT standard.system.label("SOMTEmitCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTEmitCClassData.classObject) 
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
      FUNCTION SOMTEmitCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTEmitCNewClass);
      PRAGMA interface_information (SOMTEmitCNewClass, ".SOMTEmitCNewClass");
   BEGIN
      RETURN SOMTEmitCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTEmitCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTEmitCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtTemplate (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The template is to provide template output and maintains a symbol
     -- table that provides a sort of global context for the emitter.
      FUNCTION SOMTEmitC_U_get_somtTemplate(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTEmitC_U_get_somtTemplate);
      PRAGMA interface_information (SOMTEmitC_U_get_somtTemplate, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_U_get_somtTemplate (
            Self.som_object,
            SOMTEmitCClassData.get_somtTemplate);
      RETURN Result;
   END get_somtTemplate; 

   PROCEDURE set_somtTemplate (
      Self : IN Ref; 
      somtTemplate : IN SOM.SOMObjectPtr)
   IS
     
     -- The template is to provide template output and maintains a symbol
     -- table that provides a sort of global context for the emitter.
      PROCEDURE SOMTEmitC_U_set_somtTemplate(
         Self : IN SOM.SOMObjectPtr; 
         somtTemplate : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_U_set_somtTemplate);
      PRAGMA interface_information (SOMTEmitC_U_set_somtTemplate, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_U_set_somtTemplate (
         Self.som_object,
         somtTemplate,
         SOMTEmitCClassData.set_somtTemplate);
   END set_somtTemplate;

   FUNCTION get_somtTargetFile (
      Self : IN Ref)
      RETURN SCTypes.FILE
   IS
     
     -- The target file is the one to which all emitter output is to be
     -- directed.
      FUNCTION SOMTEmitC_U_get_somtTargetFile(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.FILE; 
      PRAGMA interface (assembly, SOMTEmitC_U_get_somtTargetFile);
      PRAGMA interface_information (SOMTEmitC_U_get_somtTargetFile, ".xsomcall1");
      Result : ALIASED SCTypes.FILE;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_U_get_somtTargetFile (
            Self.som_object,
            SOMTEmitCClassData.get_somtTargetFile);
      RETURN Result;
   END get_somtTargetFile; 

   PROCEDURE set_somtTargetFile (
      Self : IN Ref; 
      somtTargetFile : IN SCTypes.FILE)
   IS
     
     -- The target file is the one to which all emitter output is to be
     -- directed.
      PROCEDURE SOMTEmitC_U_set_somtTargetFile(
         Self : IN SOM.SOMObjectPtr; 
         somtTargetFile : IN SCTypes.FILE;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_U_set_somtTargetFile);
      PRAGMA interface_information (SOMTEmitC_U_set_somtTargetFile, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_U_set_somtTargetFile (
         Self.som_object,
         somtTargetFile,
         SOMTEmitCClassData.set_somtTargetFile);
   END set_somtTargetFile;

   FUNCTION get_somtTargetClass (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The target class is the class definition for which code is to be
     -- emitted.
      FUNCTION SOMTEmitC_U_get_somtTargetClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTEmitC_U_get_somtTargetClass);
      PRAGMA interface_information (SOMTEmitC_U_get_somtTargetClass, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_U_get_somtTargetClass (
            Self.som_object,
            SOMTEmitCClassData.get_somtTargetClass);
      RETURN Result;
   END get_somtTargetClass; 

   PROCEDURE set_somtTargetClass (
      Self : IN Ref; 
      somtTargetClass : IN SOM.SOMObjectPtr)
   IS
     
     -- The target class is the class definition for which code is to be
     -- emitted.
      PROCEDURE SOMTEmitC_U_set_somtTargetClass(
         Self : IN SOM.SOMObjectPtr; 
         somtTargetClass : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_U_set_somtTargetClass);
      PRAGMA interface_information (SOMTEmitC_U_set_somtTargetClass, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_U_set_somtTargetClass (
         Self.som_object,
         somtTargetClass,
         SOMTEmitCClassData.set_somtTargetClass);
   END set_somtTargetClass;

   FUNCTION get_somtTargetModule (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- The target module is the module definition for which code is to be
     -- emitted.
      FUNCTION SOMTEmitC_U_get_somtTargetModule(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTEmitC_U_get_somtTargetModule);
      PRAGMA interface_information (SOMTEmitC_U_get_somtTargetModule, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_U_get_somtTargetModule (
            Self.som_object,
            SOMTEmitCClassData.get_somtTargetModule);
      RETURN Result;
   END get_somtTargetModule; 

   PROCEDURE set_somtTargetModule (
      Self : IN Ref; 
      somtTargetModule : IN SOM.SOMObjectPtr)
   IS
     
     -- The target module is the module definition for which code is to be
     -- emitted.
      PROCEDURE SOMTEmitC_U_set_somtTargetModule(
         Self : IN SOM.SOMObjectPtr; 
         somtTargetModule : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_U_set_somtTargetModule);
      PRAGMA interface_information (SOMTEmitC_U_set_somtTargetModule, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_U_set_somtTargetModule (
         Self.som_object,
         somtTargetModule,
         SOMTEmitCClassData.set_somtTargetModule);
   END set_somtTargetModule;

   FUNCTION get_somtTargetType (
      Self : IN Ref)
      RETURN SCTypes.SOMTTargetTypeT
   IS
     
     -- The target type indicates what type of output file is being
     -- produced, public, private, or implementation.  This allows the
     -- same emitter subclass to produce several different output files
     -- that generally differ only in how much of the class definition
     -- they cover. Eg, .csc, .sc, and .psc.
     -- This is attribute is for OIDL compatibility only.
      FUNCTION SOMTEmitC_U_get_somtTargetType(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.SOMTTargetTypeT; 
      PRAGMA interface (assembly, SOMTEmitC_U_get_somtTargetType);
      PRAGMA interface_information (SOMTEmitC_U_get_somtTargetType, ".xsomcall1");
      Result : ALIASED SCTypes.SOMTTargetTypeT;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_U_get_somtTargetType (
            Self.som_object,
            SOMTEmitCClassData.get_somtTargetType);
      RETURN Result;
   END get_somtTargetType; 

   PROCEDURE set_somtTargetType (
      Self : IN Ref; 
      somtTargetType : IN SCTypes.SOMTTargetTypeT)
   IS
     
     -- The target type indicates what type of output file is being
     -- produced, public, private, or implementation.  This allows the
     -- same emitter subclass to produce several different output files
     -- that generally differ only in how much of the class definition
     -- they cover. Eg, .csc, .sc, and .psc.
     -- This is attribute is for OIDL compatibility only.
      PROCEDURE SOMTEmitC_U_set_somtTargetType(
         Self : IN SOM.SOMObjectPtr; 
         somtTargetType : IN SCTypes.SOMTTargetTypeT;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_U_set_somtTargetType);
      PRAGMA interface_information (SOMTEmitC_U_set_somtTargetType, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_U_set_somtTargetType (
         Self.som_object,
         somtTargetType,
         SOMTEmitCClassData.set_somtTargetType);
   END set_somtTargetType;

   FUNCTION get_somtEmitterName (
      Self : IN Ref)
      RETURN Corba.String
   IS
     
     -- The short name of the emitter (the name used to invoke it via the
     -- SOM Compiler.  Typically this is the file stem of the subclass
     -- of SOMTEmitC. This attribute should be set in the driver program
     -- that runs the emitter.  It is used to filter passthrus so that only
     -- passthrus directed to a particular emitter are seen by it.
      FUNCTION SOMTEmitC_U_get_somtEmitterName(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEmitC_U_get_somtEmitterName);
      PRAGMA interface_information (SOMTEmitC_U_get_somtEmitterName, ".xsomcall1");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_U_get_somtEmitterName (
            Self.som_object,
            SOMTEmitCClassData.get_somtEmitterName);
      RETURN Result;
   END get_somtEmitterName; 

   PROCEDURE set_somtEmitterName (
      Self : IN Ref; 
      somtEmitterName : IN Corba.String)
   IS
     
     -- The short name of the emitter (the name used to invoke it via the
     -- SOM Compiler.  Typically this is the file stem of the subclass
     -- of SOMTEmitC. This attribute should be set in the driver program
     -- that runs the emitter.  It is used to filter passthrus so that only
     -- passthrus directed to a particular emitter are seen by it.
      PROCEDURE SOMTEmitC_U_set_somtEmitterName(
         Self : IN SOM.SOMObjectPtr; 
         somtEmitterName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_U_set_somtEmitterName);
      PRAGMA interface_information (SOMTEmitC_U_set_somtEmitterName, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_U_set_somtEmitterName (
         Self.som_object,
         somtEmitterName,
         SOMTEmitCClassData.set_somtEmitterName);
   END set_somtEmitterName;

   FUNCTION somtGenerateSections (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     -- Calls each of the section methods in order.  The order is:
     --
     --   somtEmitProlog
     --   when emitting a class:
     --           somtEmitClass
     --           somtEmitBase
     --           somtEmitMeta
     --   somtEmitConstant
     --   somtEmitTypedef
     --   somtEmitStruct
     --   somtEmitUnion
     --   somtEmitEnum
     --   when emitting a class:
     --      somtEmitAttribute
     --      somtEmitMethod
     --      somtEmitRelease
     --      somtEmitPassthru
     --      somtEmitData
     --   when emitting a module:
     --       somtEmitInterface
     --       somtEmitModule
     --   somtEmitEpilog
     --
     -- This method will need to be overridden by many emitters in order
     -- to rearange the order of the sections and to add or delete
     -- sections.
     -- Note: repeating sections such as methods, data, and passthru,
     -- have a prolog and epilog method as well. The prolog method is
     -- called before the first sections is processed and the epilog method
     -- is called after the last section is processed.
      FUNCTION SOMTEmitC_somtGenerateSections(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtGenerateSections);
      PRAGMA interface_information (SOMTEmitC_somtGenerateSections, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtGenerateSections (
            Self.som_object,
            SOMTEmitCClassData.somtGenerateSections);
      RETURN Result;
   END somtGenerateSections; 

   FUNCTION somtOpenSymbolsFile (
      Self : IN Ref; 
      file : IN Corba.String; 
      mode : IN Corba.String)
      RETURN SCTypes.FILE
   IS
     
     -- This method attempts to open the symbols file.
     -- If file doesn't exist then it will attempt to find it in the
     -- directories specified in the SMINCLUDE environment variable.
     -- If the file can be found a FILE * pointer is returned, otherwise
     -- NULL is returned.
      FUNCTION SOMTEmitC_somtOpenSymbolsFile(
         Self : IN SOM.SOMObjectPtr; 
         file : IN Corba.String; 
         mode : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.FILE; 
      PRAGMA interface (assembly, SOMTEmitC_somtOpenSymbolsFile);
      PRAGMA interface_information (SOMTEmitC_somtOpenSymbolsFile, ".xsomcall3");
      Result : ALIASED SCTypes.FILE;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtOpenSymbolsFile (
            Self.som_object,
            file,
            mode,
            SOMTEmitCClassData.somtOpenSymbolsFile);
      RETURN Result;
   END somtOpenSymbolsFile; 

   PROCEDURE somtSetPredefinedSymbols (
      Self : IN Ref)
   IS
     
     -- Set predefined symbols that are used for such things as section
     -- names etc.
      PROCEDURE SOMTEmitC_somtSetPredefinedSymbols(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtSetPredefinedSymbols);
      PRAGMA interface_information (SOMTEmitC_somtSetPredefinedSymbols, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtSetPredefinedSymbols (
         Self.som_object,
         SOMTEmitCClassData.somtSetPredefinedSymbols);
   END somtSetPredefinedSymbols;

   PROCEDURE somtFileSymbols (
      Self : IN Ref)
   IS
     
     -- Symbols that are common to the file.  This includes the target
     -- class symbols, and the metaclass symbols, and special symbols
     -- like <timeStamp>.  IE, all symbols that have a single definition.
      PROCEDURE SOMTEmitC_somtFileSymbols(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtFileSymbols);
      PRAGMA interface_information (SOMTEmitC_somtFileSymbols, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtFileSymbols (
         Self.som_object,
         SOMTEmitCClassData.somtFileSymbols);
   END somtFileSymbols;

   PROCEDURE somtEmitProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitProlog);
   END somtEmitProlog;

   PROCEDURE somtEmitBaseIncludesProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitBaseIncludesProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitBaseIncludesProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitBaseIncludesProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitBaseIncludesProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitBaseIncludesProlog);
   END somtEmitBaseIncludesProlog;

   PROCEDURE somtEmitBaseIncludes (
      Self : IN Ref; 
      base : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitBaseIncludes(
         Self : IN SOM.SOMObjectPtr; 
         base : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitBaseIncludes);
      PRAGMA interface_information (SOMTEmitC_somtEmitBaseIncludes, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitBaseIncludes (
         Self.som_object,
         base,
         SOMTEmitCClassData.somtEmitBaseIncludes);
   END somtEmitBaseIncludes;

   PROCEDURE somtEmitBaseIncludesEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitBaseIncludesEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitBaseIncludesEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitBaseIncludesEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitBaseIncludesEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitBaseIncludesEpilog);
   END somtEmitBaseIncludesEpilog;

   PROCEDURE somtEmitMetaInclude (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitMetaInclude(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitMetaInclude);
      PRAGMA interface_information (SOMTEmitC_somtEmitMetaInclude, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitMetaInclude (
         Self.som_object,
         SOMTEmitCClassData.somtEmitMetaInclude);
   END somtEmitMetaInclude;

   PROCEDURE somtEmitClass (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitClass(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitClass);
      PRAGMA interface_information (SOMTEmitC_somtEmitClass, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitClass (
         Self.som_object,
         SOMTEmitCClassData.somtEmitClass);
   END somtEmitClass;

   PROCEDURE somtEmitMeta (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitMeta(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitMeta);
      PRAGMA interface_information (SOMTEmitC_somtEmitMeta, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitMeta (
         Self.som_object,
         SOMTEmitCClassData.somtEmitMeta);
   END somtEmitMeta;

   PROCEDURE somtEmitBaseProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitBaseProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitBaseProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitBaseProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitBaseProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitBaseProlog);
   END somtEmitBaseProlog;

   PROCEDURE somtEmitBase (
      Self : IN Ref; 
      base : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitBase(
         Self : IN SOM.SOMObjectPtr; 
         base : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitBase);
      PRAGMA interface_information (SOMTEmitC_somtEmitBase, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitBase (
         Self.som_object,
         base,
         SOMTEmitCClassData.somtEmitBase);
   END somtEmitBase;

   PROCEDURE somtEmitBaseEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitBaseEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitBaseEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitBaseEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitBaseEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitBaseEpilog);
   END somtEmitBaseEpilog;

   PROCEDURE somtEmitPassthruProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitPassthruProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitPassthruProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitPassthruProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitPassthruProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitPassthruProlog);
   END somtEmitPassthruProlog;

   PROCEDURE somtEmitPassthru (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitPassthru(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitPassthru);
      PRAGMA interface_information (SOMTEmitC_somtEmitPassthru, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitPassthru (
         Self.som_object,
         IDL_entry,
         SOMTEmitCClassData.somtEmitPassthru);
   END somtEmitPassthru;

   PROCEDURE somtEmitPassthruEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitPassthruEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitPassthruEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitPassthruEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitPassthruEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitPassthruEpilog);
   END somtEmitPassthruEpilog;

   PROCEDURE somtEmitRelease (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitRelease(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitRelease);
      PRAGMA interface_information (SOMTEmitC_somtEmitRelease, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitRelease (
         Self.som_object,
         SOMTEmitCClassData.somtEmitRelease);
   END somtEmitRelease;

   PROCEDURE somtEmitDataProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitDataProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitDataProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitDataProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitDataProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitDataProlog);
   END somtEmitDataProlog;

   PROCEDURE somtEmitData (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitData(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitData);
      PRAGMA interface_information (SOMTEmitC_somtEmitData, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitData (
         Self.som_object,
         IDL_entry,
         SOMTEmitCClassData.somtEmitData);
   END somtEmitData;

   PROCEDURE somtEmitDataEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitDataEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitDataEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitDataEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitDataEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitDataEpilog);
   END somtEmitDataEpilog;

   PROCEDURE somtEmitAttributeProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitAttributeProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitAttributeProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitAttributeProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitAttributeProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitAttributeProlog);
   END somtEmitAttributeProlog;

   PROCEDURE somtEmitAttribute (
      Self : IN Ref; 
      att : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitAttribute(
         Self : IN SOM.SOMObjectPtr; 
         att : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitAttribute);
      PRAGMA interface_information (SOMTEmitC_somtEmitAttribute, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitAttribute (
         Self.som_object,
         att,
         SOMTEmitCClassData.somtEmitAttribute);
   END somtEmitAttribute;

   PROCEDURE somtEmitAttributeEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitAttributeEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitAttributeEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitAttributeEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitAttributeEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitAttributeEpilog);
   END somtEmitAttributeEpilog;

   PROCEDURE somtEmitConstantProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitConstantProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitConstantProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitConstantProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitConstantProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitConstantProlog);
   END somtEmitConstantProlog;

   PROCEDURE somtEmitConstant (
      Self : IN Ref; 
      con : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitConstant(
         Self : IN SOM.SOMObjectPtr; 
         con : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitConstant);
      PRAGMA interface_information (SOMTEmitC_somtEmitConstant, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitConstant (
         Self.som_object,
         con,
         SOMTEmitCClassData.somtEmitConstant);
   END somtEmitConstant;

   PROCEDURE somtEmitConstantEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitConstantEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitConstantEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitConstantEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitConstantEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitConstantEpilog);
   END somtEmitConstantEpilog;

   PROCEDURE somtEmitTypedefProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitTypedefProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitTypedefProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitTypedefProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitTypedefProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitTypedefProlog);
   END somtEmitTypedefProlog;

   PROCEDURE somtEmitTypedef (
      Self : IN Ref; 
      td : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitTypedef(
         Self : IN SOM.SOMObjectPtr; 
         td : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitTypedef);
      PRAGMA interface_information (SOMTEmitC_somtEmitTypedef, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitTypedef (
         Self.som_object,
         td,
         SOMTEmitCClassData.somtEmitTypedef);
   END somtEmitTypedef;

   PROCEDURE somtEmitTypedefEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitTypedefEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitTypedefEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitTypedefEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitTypedefEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitTypedefEpilog);
   END somtEmitTypedefEpilog;

   PROCEDURE somtEmitStructProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitStructProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitStructProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitStructProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitStructProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitStructProlog);
   END somtEmitStructProlog;

   PROCEDURE somtEmitStruct (
      Self : IN Ref; 
      struc : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitStruct(
         Self : IN SOM.SOMObjectPtr; 
         struc : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitStruct);
      PRAGMA interface_information (SOMTEmitC_somtEmitStruct, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitStruct (
         Self.som_object,
         struc,
         SOMTEmitCClassData.somtEmitStruct);
   END somtEmitStruct;

   PROCEDURE somtEmitStructEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitStructEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitStructEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitStructEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitStructEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitStructEpilog);
   END somtEmitStructEpilog;

   PROCEDURE somtEmitUnionProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitUnionProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitUnionProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitUnionProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitUnionProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitUnionProlog);
   END somtEmitUnionProlog;

   PROCEDURE somtEmitUnion (
      Self : IN Ref; 
      un : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitUnion(
         Self : IN SOM.SOMObjectPtr; 
         un : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitUnion);
      PRAGMA interface_information (SOMTEmitC_somtEmitUnion, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitUnion (
         Self.som_object,
         un,
         SOMTEmitCClassData.somtEmitUnion);
   END somtEmitUnion;

   PROCEDURE somtEmitUnionEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitUnionEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitUnionEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitUnionEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitUnionEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitUnionEpilog);
   END somtEmitUnionEpilog;

   PROCEDURE somtEmitEnumProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitEnumProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitEnumProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitEnumProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitEnumProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitEnumProlog);
   END somtEmitEnumProlog;

   PROCEDURE somtEmitEnum (
      Self : IN Ref; 
      en : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitEnum(
         Self : IN SOM.SOMObjectPtr; 
         en : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitEnum);
      PRAGMA interface_information (SOMTEmitC_somtEmitEnum, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitEnum (
         Self.som_object,
         en,
         SOMTEmitCClassData.somtEmitEnum);
   END somtEmitEnum;

   PROCEDURE somtEmitEnumEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitEnumEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitEnumEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitEnumEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitEnumEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitEnumEpilog);
   END somtEmitEnumEpilog;

   PROCEDURE somtEmitInterfaceProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitInterfaceProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitInterfaceProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitInterfaceProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitInterfaceProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitInterfaceProlog);
   END somtEmitInterfaceProlog;

   PROCEDURE somtEmitInterface (
      Self : IN Ref; 
      intfc : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitInterface(
         Self : IN SOM.SOMObjectPtr; 
         intfc : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitInterface);
      PRAGMA interface_information (SOMTEmitC_somtEmitInterface, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitInterface (
         Self.som_object,
         intfc,
         SOMTEmitCClassData.somtEmitInterface);
   END somtEmitInterface;

   PROCEDURE somtEmitInterfaceEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitInterfaceEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitInterfaceEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitInterfaceEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitInterfaceEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitInterfaceEpilog);
   END somtEmitInterfaceEpilog;

   PROCEDURE somtEmitModuleProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitModuleProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitModuleProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitModuleProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitModuleProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitModuleProlog);
   END somtEmitModuleProlog;

   PROCEDURE somtEmitModule (
      Self : IN Ref; 
      IDL_mod : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitModule(
         Self : IN SOM.SOMObjectPtr; 
         IDL_mod : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitModule);
      PRAGMA interface_information (SOMTEmitC_somtEmitModule, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitModule (
         Self.som_object,
         IDL_mod,
         SOMTEmitCClassData.somtEmitModule);
   END somtEmitModule;

   PROCEDURE somtEmitModuleEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitModuleEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitModuleEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitModuleEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitModuleEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitModuleEpilog);
   END somtEmitModuleEpilog;

   PROCEDURE somtEmitMethodsProlog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitMethodsProlog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitMethodsProlog);
      PRAGMA interface_information (SOMTEmitC_somtEmitMethodsProlog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitMethodsProlog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitMethodsProlog);
   END somtEmitMethodsProlog;

   PROCEDURE somtEmitMethods (
      Self : IN Ref; 
      method : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitMethods(
         Self : IN SOM.SOMObjectPtr; 
         method : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitMethods);
      PRAGMA interface_information (SOMTEmitC_somtEmitMethods, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitMethods (
         Self.som_object,
         method,
         SOMTEmitCClassData.somtEmitMethods);
   END somtEmitMethods;

   PROCEDURE somtEmitMethodsEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitMethodsEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitMethodsEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitMethodsEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitMethodsEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitMethodsEpilog);
   END somtEmitMethodsEpilog;

   PROCEDURE somtEmitMethod (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
   IS
      PROCEDURE SOMTEmitC_somtEmitMethod(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitMethod);
      PRAGMA interface_information (SOMTEmitC_somtEmitMethod, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitMethod (
         Self.som_object,
         IDL_entry,
         SOMTEmitCClassData.somtEmitMethod);
   END somtEmitMethod;

   PROCEDURE somtEmitEpilog (
      Self : IN Ref)
   IS
      PROCEDURE SOMTEmitC_somtEmitEpilog(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitEpilog);
      PRAGMA interface_information (SOMTEmitC_somtEmitEpilog, ".xsomcall1");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitEpilog (
         Self.som_object,
         SOMTEmitCClassData.somtEmitEpilog);
   END somtEmitEpilog;

   FUNCTION somtScanBases (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanBases(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanBases);
      PRAGMA interface_information (SOMTEmitC_somtScanBases, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanBases (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanBases);
      RETURN Result;
   END somtScanBases; 

   FUNCTION somtCheckVisibility (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Return 1 (true) if <entry> should be visible in the current
     -- target file.  This method is used by each of the following filter
     -- methods that are concerned with visibility.
     -- The default rule for visibility is:
     --   only private methods are visible in private target files,
     --   only public methods are visibile in public target files,
     --   all methods are visibile in implementation or <somtAllE> target
     --   files.
      FUNCTION SOMTEmitC_somtCheckVisibility(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtCheckVisibility);
      PRAGMA interface_information (SOMTEmitC_somtCheckVisibility, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtCheckVisibility (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtCheckVisibility);
      RETURN Result;
   END somtCheckVisibility; 

   FUNCTION somtNew (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <entry> is a method introduced by the target
     -- class and its visibility matches <somtTargetType> (somtImplementationE
     -- matches both private and public)
      FUNCTION SOMTEmitC_somtNew(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtNew);
      PRAGMA interface_information (SOMTEmitC_somtNew, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtNew (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtNew);
      RETURN Result;
   END somtNew; 

   FUNCTION somtImplemented (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <entry> is a method introduced or overridden
     -- by the target class and its visibility matches <somtTargetType>
     -- (somtImplementationE matches both private and public)
      FUNCTION SOMTEmitC_somtImplemented(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtImplemented);
      PRAGMA interface_information (SOMTEmitC_somtImplemented, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtImplemented (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtImplemented);
      RETURN Result;
   END somtImplemented; 

   FUNCTION somtOverridden (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <entry> is an overridding method of the target class
     -- and its visibility matches <somtTargetType> (somtImplementationE
     -- matches both private and public)
      FUNCTION SOMTEmitC_somtOverridden(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtOverridden);
      PRAGMA interface_information (SOMTEmitC_somtOverridden, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtOverridden (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtOverridden);
      RETURN Result;
   END somtOverridden; 

   FUNCTION somtInherited (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <entry> is inherited
     -- by the target class and its visibility matches <somtTargetType>
     -- (somtImplementationE matches both private and public)
      FUNCTION SOMTEmitC_somtInherited(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtInherited);
      PRAGMA interface_information (SOMTEmitC_somtInherited, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtInherited (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtInherited);
      RETURN Result;
   END somtInherited; 

   FUNCTION somtAllVisible (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <entry> is supported by the target class and
     -- its visibility matches <somtTargetType> (somtImplementationE
     -- matches both private and public)
      FUNCTION SOMTEmitC_somtAllVisible(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtAllVisible);
      PRAGMA interface_information (SOMTEmitC_somtAllVisible, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtAllVisible (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtAllVisible);
      RETURN Result;
   END somtAllVisible; 

   FUNCTION somtAll (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if <entry> is supported by the target class.
      FUNCTION SOMTEmitC_somtAll(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtAll);
      PRAGMA interface_information (SOMTEmitC_somtAll, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtAll (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtAll);
      RETURN Result;
   END somtAll; 

   FUNCTION somtNewNoProc (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if somtNew does and the method
     -- IS NOT a direct call Procedure.
      FUNCTION SOMTEmitC_somtNewNoProc(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtNewNoProc);
      PRAGMA interface_information (SOMTEmitC_somtNewNoProc, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtNewNoProc (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtNewNoProc);
      RETURN Result;
   END somtNewNoProc; 

   FUNCTION somtPrivOrPub (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if entry is Private or Public.
      FUNCTION SOMTEmitC_somtPrivOrPub(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtPrivOrPub);
      PRAGMA interface_information (SOMTEmitC_somtPrivOrPub, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtPrivOrPub (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtPrivOrPub);
      RETURN Result;
   END somtPrivOrPub; 

   FUNCTION somtNewProc (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if somtNew does and the method
     -- IS a direct call Procedure.
      FUNCTION SOMTEmitC_somtNewProc(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtNewProc);
      PRAGMA interface_information (SOMTEmitC_somtNewProc, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtNewProc (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtNewProc);
      RETURN Result;
   END somtNewProc; 

   FUNCTION somtLink (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if "nolink" is not set.
      FUNCTION SOMTEmitC_somtLink(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtLink);
      PRAGMA interface_information (SOMTEmitC_somtLink, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtLink (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtLink);
      RETURN Result;
   END somtLink; 

   FUNCTION somtVA (
      Self : IN Ref; 
      IDL_entry : IN SOM.SOMObjectPtr)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if entry is a VarArgs method.
      FUNCTION SOMTEmitC_somtVA(
         Self : IN SOM.SOMObjectPtr; 
         IDL_entry : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtVA);
      PRAGMA interface_information (SOMTEmitC_somtVA, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtVA (
            Self.som_object,
            IDL_entry,
            SOMTEmitCClassData.somtVA);
      RETURN Result;
   END somtVA; 

   FUNCTION somtScanMethods (
      Self : IN Ref; 
      filter : IN Corba.String; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String; 
      forceProlog : IN Corba.Boolean)
      RETURN Corba.Boolean
   IS
     
     -- Will only call <each> on methods accepted by <filter>.
     -- If <forceProlog> is not true then the prolog and epilog emiters
     -- will be called only if there is at least one method that passes
     -- the filter.
      FUNCTION SOMTEmitC_somtScanMethods(
         Self : IN SOM.SOMObjectPtr; 
         filter : IN Corba.String; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String; 
         forceProlog : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanMethods);
      PRAGMA interface_information (SOMTEmitC_somtScanMethods, ".xsomcall6");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanMethods (
            Self.som_object,
            filter,
            prolog,
            each,
            epilog,
            forceProlog,
            SOMTEmitCClassData.somtScanMethods);
      RETURN Result;
   END somtScanMethods; 

   FUNCTION somtScanConstants (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanConstants(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanConstants);
      PRAGMA interface_information (SOMTEmitC_somtScanConstants, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanConstants (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanConstants);
      RETURN Result;
   END somtScanConstants; 

   FUNCTION somtScanTypedefs (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanTypedefs(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanTypedefs);
      PRAGMA interface_information (SOMTEmitC_somtScanTypedefs, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanTypedefs (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanTypedefs);
      RETURN Result;
   END somtScanTypedefs; 

   FUNCTION somtScanStructs (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanStructs(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanStructs);
      PRAGMA interface_information (SOMTEmitC_somtScanStructs, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanStructs (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanStructs);
      RETURN Result;
   END somtScanStructs; 

   FUNCTION somtScanUnions (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanUnions(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanUnions);
      PRAGMA interface_information (SOMTEmitC_somtScanUnions, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanUnions (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanUnions);
      RETURN Result;
   END somtScanUnions; 

   FUNCTION somtScanEnums (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanEnums(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanEnums);
      PRAGMA interface_information (SOMTEmitC_somtScanEnums, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanEnums (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanEnums);
      RETURN Result;
   END somtScanEnums; 

   FUNCTION somtScanData (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanData(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanData);
      PRAGMA interface_information (SOMTEmitC_somtScanData, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanData (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanData);
      RETURN Result;
   END somtScanData; 

   FUNCTION somtScanAttributes (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanAttributes(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanAttributes);
      PRAGMA interface_information (SOMTEmitC_somtScanAttributes, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanAttributes (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanAttributes);
      RETURN Result;
   END somtScanAttributes; 

   FUNCTION somtScanInterfaces (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanInterfaces(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanInterfaces);
      PRAGMA interface_information (SOMTEmitC_somtScanInterfaces, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanInterfaces (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanInterfaces);
      RETURN Result;
   END somtScanInterfaces; 

   FUNCTION somtScanModules (
      Self : IN Ref; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanModules(
         Self : IN SOM.SOMObjectPtr; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanModules);
      PRAGMA interface_information (SOMTEmitC_somtScanModules, ".xsomcall4");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanModules (
            Self.som_object,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanModules);
      RETURN Result;
   END somtScanModules; 

   FUNCTION somtScanPassthru (
      Self : IN Ref; 
      before : IN Corba.Boolean; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String)
      RETURN Corba.Boolean
   IS
      FUNCTION SOMTEmitC_somtScanPassthru(
         Self : IN SOM.SOMObjectPtr; 
         before : IN Corba.Boolean; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanPassthru);
      PRAGMA interface_information (SOMTEmitC_somtScanPassthru, ".xsomcall5");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanPassthru (
            Self.som_object,
            before,
            prolog,
            each,
            epilog,
            SOMTEmitCClassData.somtScanPassthru);
      RETURN Result;
   END somtScanPassthru; 

   PROCEDURE somtEmitFullPassthru (
      Self : IN Ref; 
      before : IN Corba.Boolean; 
      language : IN Corba.String)
   IS
     
     -- Emits each passthru section defined for the language and targetType,
     -- and the result of the somtIsBeforePassthru method is equal to the
     -- before parameter.  (before = 1(true), or before = 0(false), i.e. after.)
      PROCEDURE SOMTEmitC_somtEmitFullPassthru(
         Self : IN SOM.SOMObjectPtr; 
         before : IN Corba.Boolean; 
         language : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTEmitC_somtEmitFullPassthru);
      PRAGMA interface_information (SOMTEmitC_somtEmitFullPassthru, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTEmitC_somtEmitFullPassthru (
         Self.som_object,
         before,
         language,
         SOMTEmitCClassData.somtEmitFullPassthru);
   END somtEmitFullPassthru;

   FUNCTION somtScanDataF (
      Self : IN Ref; 
      filter : IN Corba.String; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String; 
      forceProlog : IN Corba.Boolean)
      RETURN Corba.Boolean
   IS
     
     -- This method is like somtScanData but it also provides a paramater
     -- for a filter method.
      FUNCTION SOMTEmitC_somtScanDataF(
         Self : IN SOM.SOMObjectPtr; 
         filter : IN Corba.String; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String; 
         forceProlog : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanDataF);
      PRAGMA interface_information (SOMTEmitC_somtScanDataF, ".xsomcall6");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanDataF (
            Self.som_object,
            filter,
            prolog,
            each,
            epilog,
            forceProlog,
            SOMTEmitCClassData.somtScanDataF);
      RETURN Result;
   END somtScanDataF; 

   FUNCTION somtScanBasesF (
      Self : IN Ref; 
      filter : IN Corba.String; 
      prolog : IN Corba.String; 
      each : IN Corba.String; 
      epilog : IN Corba.String; 
      forceProlog : IN Corba.Boolean)
      RETURN Corba.Boolean
   IS
     
     -- This method is like somtScanBases but it also provides a paramater
     -- for a filter method.
      FUNCTION SOMTEmitC_somtScanBasesF(
         Self : IN SOM.SOMObjectPtr; 
         filter : IN Corba.String; 
         prolog : IN Corba.String; 
         each : IN Corba.String; 
         epilog : IN Corba.String; 
         forceProlog : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTEmitC_somtScanBasesF);
      PRAGMA interface_information (SOMTEmitC_somtScanBasesF, ".xsomcall6");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtScanBasesF (
            Self.som_object,
            filter,
            prolog,
            each,
            epilog,
            forceProlog,
            SOMTEmitCClassData.somtScanBasesF);
      RETURN Result;
   END somtScanBasesF; 

   FUNCTION somtGetGlobalModifierValue (
      Self : IN Ref; 
      modifierName : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Returns the value of the specified global modifier.
     -- Global modifiers are specified when the SOM Compiler is invoked,
     -- via the "-a" option.  For example,
     --                       sc -a"foo=bar"  file.idl
     -- specifies to the SOM Compiler and the emitters being run that
     -- the global modifier "foo" has the value "bar."
     -- Values of global modifiers are transient; they last only for the
     -- duration of the compile for which they were specified.
     -- If a modifier is specified in the "sc" command with no value,
     -- as in
     --                       sc -afoo file.idl
     -- then the result of this method will be non-NULL.
     -- If no such modifier is specified, then the result is NULL.
      FUNCTION SOMTEmitC_somtGetGlobalModifierValue(
         Self : IN SOM.SOMObjectPtr; 
         modifierName : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTEmitC_somtGetGlobalModifierValue);
      PRAGMA interface_information (SOMTEmitC_somtGetGlobalModifierValue, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtGetGlobalModifierValue (
            Self.som_object,
            modifierName,
            SOMTEmitCClassData.somtGetGlobalModifierValue);
      RETURN Result;
   END somtGetGlobalModifierValue; 

   FUNCTION somtGetFirstGlobalDefinition (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the first type or constant definition that is not
     -- associated with any interface or module.
     -- These global definitions must be surrounded by the somemittypes
     -- pragmas for them to be visible via this method.
     -- E.g., #pragma somemittypes on
     --       ....
     --       #pragma someemittypes off
     -- The list of global definitions returned by this method and
     -- the somtGetNextGlobalDefinition method may include entries
     -- for forward declarations as well as typedefs and constants.
     -- Global structs and unions are also included in the list.
      FUNCTION SOMTEmitC_somtGetFirstGlobalDefinition(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTEmitC_somtGetFirstGlobalDefinition);
      PRAGMA interface_information (SOMTEmitC_somtGetFirstGlobalDefinition, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtGetFirstGlobalDefinition (
            Self.som_object,
            SOMTEmitCClassData.somtGetFirstGlobalDefinition);
      RETURN Result;
   END somtGetFirstGlobalDefinition; 

   FUNCTION somtGetNextGlobalDefinition (
      Self : IN Ref)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Returns the next type or constant definition that is not
     -- associated with any interface or module, relative to a
     -- previous call to somtGetFirstGlobalDefinition or
     -- somtGetNextGlobalDefinition.
      FUNCTION SOMTEmitC_somtGetNextGlobalDefinition(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, SOMTEmitC_somtGetNextGlobalDefinition);
      PRAGMA interface_information (SOMTEmitC_somtGetNextGlobalDefinition, ".xsomcall1");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTEmitC_somtGetNextGlobalDefinition (
            Self.som_object,
            SOMTEmitCClassData.somtGetNextGlobalDefinition);
      RETURN Result;
   END somtGetNextGlobalDefinition; 

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

END SOMTEmitC; 







