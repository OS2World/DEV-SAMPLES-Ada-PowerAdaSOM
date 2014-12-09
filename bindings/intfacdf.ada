
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:11 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Contained;
WITH Container;
WITH Corba.Sequences;
WITH OperationDef;
WITH AttributeDef;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE InterfaceDef IS


   TYPE Ref IS NEW Contained.Ref WITH NULL RECORD;

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
      

   PACKAGE RepositoryId_Unbounded IS
      NEW Corba.Sequences.Unbounded(SOM.RepositoryId);


   PACKAGE OperationDescription_Unbounded IS 
      NEW Corba.Sequences.Unbounded(OperationDef.OperationDescription);


   PACKAGE AttributeDescription_Unbounded IS 
      NEW Corba.Sequences.Unbounded(AttributeDef.AttributeDescription);


   TYPE FullInterfaceDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
      operation : OperationDescription_Unbounded.Sequence;
      attributes : AttributeDescription_Unbounded.Sequence;
   END RECORD;
   PRAGMA Preserve_Layout( FullInterfaceDescription );

   TYPE InterfaceDescription IS
   RECORD
      name : SOM.Identifier;
      id : SOM.RepositoryId;
      defined_in : SOM.RepositoryId;
   END RECORD;
   PRAGMA Preserve_Layout( InterfaceDescription );
     
     -- The inherited describe method returns an instance of this
     -- (InterfaceDescription) structure in the "value" member of the
     -- Description structure defined in the Contained interface.
     -- The inherited describe_contents method in the Container
     -- interface returns a sequence of these Description structures
     -- each carrying a reference to an InterfaceDescription structure
     -- in its "value" member.


   FUNCTION get_base_interfaces (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN RepositoryId_Unbounded.Sequence;
     
     -- The sequence of RepositoryIds for all of the interfaces that the
     -- receiving interface inherits.  Do not free the buffer,
     -- its storage is still owned by the InterfaceDef object.

   PROCEDURE set_base_interfaces (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      base_interfaces : IN RepositoryId_Unbounded.Sequence);
     
     -- The sequence of RepositoryIds for all of the interfaces that the
     -- receiving interface inherits.  Do not free the buffer,
     -- its storage is still owned by the InterfaceDef object.

   FUNCTION describe_interface (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN InterfaceDef.FullInterfaceDescription;
     
     -- Returns a description of all the operations and attributes in
     -- an interface.

   FUNCTION get_instanceData (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.TypeCode.Object;
     
     -- [SOM-unique extension]
     --
     -- The instance data members (if any) described in the SOM
     -- implementation section of the IDL source file.

   PROCEDURE set_instanceData (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      instanceData : IN Corba.TypeCode.Object);
     
     -- [SOM-unique extension]
     --
     -- The instance data members (if any) described in the SOM
     -- implementation section of the IDL source file.

   PROCEDURE somInit (
      Self : IN Ref);

   PROCEDURE somUninit (
      Self : IN Ref);

   PROCEDURE somDumpSelf (
      Self : IN Ref;
      level : IN Corba.Long);

   PROCEDURE somDumpSelfInt (
      Self : IN Ref;
      level : IN Corba.Long);

   FUNCTION within (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Contained.Container_Unbounded.Sequence;

   FUNCTION describe (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Contained.Description;

END InterfaceDef; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY InterfaceDef IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      describe_interface : SOM.somMToken;
      get_base_interfaces : SOM.somMToken;
      set_base_interfaces : SOM.somMToken;
      get_instanceData : SOM.somMToken;
      set_instanceData : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   InterfaceDefClassData : classData;
   FOR InterfaceDefClassData USE AT standard.system.label("InterfaceDefClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   InterfaceDefCClassData : CClassData;
   FOR InterfaceDefCClassData USE AT standard.system.label("InterfaceDefCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            InterfaceDefClassData.classObject) 
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
      FUNCTION InterfaceDefNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, InterfaceDefNewClass);
      PRAGMA interface_information (InterfaceDefNewClass, ".InterfaceDefNewClass");
   BEGIN
      RETURN InterfaceDefNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF InterfaceDefClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(InterfaceDefClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_base_interfaces (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN RepositoryId_Unbounded.Sequence
   IS
     
     -- The sequence of RepositoryIds for all of the interfaces that the
     -- receiving interface inherits.  Do not free the buffer,
     -- its storage is still owned by the InterfaceDef object.
      PROCEDURE InterfaceDef_U_get_base_interfaces(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, InterfaceDef_U_get_base_interfaces);
      PRAGMA interface_information (InterfaceDef_U_get_base_interfaces, ".xsomcall3");
      Result : ALIASED RepositoryId_Unbounded.Sequence;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      InterfaceDef_U_get_base_interfaces (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         InterfaceDefClassData.get_base_interfaces);
      RETURN Result;
   END get_base_interfaces; 

   PROCEDURE set_base_interfaces (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      base_interfaces : IN RepositoryId_Unbounded.Sequence)
   IS
     
     -- The sequence of RepositoryIds for all of the interfaces that the
     -- receiving interface inherits.  Do not free the buffer,
     -- its storage is still owned by the InterfaceDef object.
      PROCEDURE InterfaceDef_U_set_base_interfaces(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         base_interfaces : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, InterfaceDef_U_set_base_interfaces);
      PRAGMA interface_information (InterfaceDef_U_set_base_interfaces, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      InterfaceDef_U_set_base_interfaces (
         Self.som_object,
         Ev,
         SOM.To_SOM_Address(base_interfaces'address),
         InterfaceDefClassData.set_base_interfaces);
   END set_base_interfaces;

   FUNCTION describe_interface (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN InterfaceDef.FullInterfaceDescription
   IS
     
     -- Returns a description of all the operations and attributes in
     -- an interface.
      PROCEDURE InterfaceDef_describe_interface(
         Result_Address : IN SOM.address; 
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, InterfaceDef_describe_interface);
      PRAGMA interface_information (InterfaceDef_describe_interface, ".xsomcall3");
      Result : ALIASED InterfaceDef.FullInterfaceDescription;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      InterfaceDef_describe_interface (
         SOM.To_SOM_Address(Result'address),
         Self.som_object,
         Ev,
         InterfaceDefClassData.describe_interface);
      RETURN Result;
   END describe_interface; 

   FUNCTION get_instanceData (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.TypeCode.Object
   IS
     
     -- [SOM-unique extension]
     --
     -- The instance data members (if any) described in the SOM
     -- implementation section of the IDL source file.
      FUNCTION InterfaceDef_U_get_instanceData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.TypeCode.Object; 
      PRAGMA interface (assembly, InterfaceDef_U_get_instanceData);
      PRAGMA interface_information (InterfaceDef_U_get_instanceData, ".xsomcall2");
      Result : ALIASED Corba.TypeCode.Object;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         InterfaceDef_U_get_instanceData (
            Self.som_object,
            Ev,
            InterfaceDefClassData.get_instanceData);
      RETURN Result;
   END get_instanceData; 

   PROCEDURE set_instanceData (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      instanceData : IN Corba.TypeCode.Object)
   IS
     
     -- [SOM-unique extension]
     --
     -- The instance data members (if any) described in the SOM
     -- implementation section of the IDL source file.
      PROCEDURE InterfaceDef_U_set_instanceData(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         instanceData : IN Corba.TypeCode.Object;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, InterfaceDef_U_set_instanceData);
      PRAGMA interface_information (InterfaceDef_U_set_instanceData, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      InterfaceDef_U_set_instanceData (
         Self.som_object,
         Ev,
         instanceData,
         InterfaceDefClassData.set_instanceData);
   END set_instanceData;

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

   PROCEDURE somDumpSelf (
      Self : IN Ref; 
      level : IN Corba.Long)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somDumpSelf (
         SOMObject.Ref'(som_object=>Self.som_object),
         level);
   END somDumpSelf;

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

   FUNCTION within (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Contained.Container_Unbounded.Sequence
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Contained.within (
            Contained.Ref'(som_object=>Self.som_object),
            Ev);
   END within;

   FUNCTION describe (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Contained.Description
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      RETURN 
         Contained.describe (
            Contained.Ref'(som_object=>Self.som_object),
            Ev);
   END describe;

END InterfaceDef; 







