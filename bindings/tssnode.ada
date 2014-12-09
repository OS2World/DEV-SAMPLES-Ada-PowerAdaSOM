
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:10 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE somf_TSortedSequenceNode IS


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
      


   FUNCTION somfTSortedSequenceNodeInitTMT (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n1 : IN SOM.SOMObjectPtr;
      obj : IN SOM.SOMObjectPtr;
      n2 : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the new TSortedSequenceNode

   FUNCTION somfTSortedSequenceNodeInitTM (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n1 : IN SOM.SOMObjectPtr;
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the new TSortedSequenceNode

   FUNCTION somfTSortedSequenceNodeInitT (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n1 : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr;
     
     -- Initialize the new TSortedSequenceNode

   FUNCTION somfGetLeftChild (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the left child of the node.

   FUNCTION somfGetRightChild (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the right child of the node.

   FUNCTION somfGetParent (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the parent of the node.

   FUNCTION somfGetKey (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr;
     
     -- Determine the key to the node.

   FUNCTION somfGetRed (
      Self : IN Ref;
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean;
     
     -- Determine if the node is red or black.

   PROCEDURE somfSetParent (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n : IN SOM.SOMObjectPtr);
     
     -- Set the parent of the node.

   PROCEDURE somfSetLeftChild (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n : IN SOM.SOMObjectPtr);
     
     -- Set the left child of the node.

   PROCEDURE somfSetRightChild (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      n : IN SOM.SOMObjectPtr);
     
     -- Set the right child of the node.

   PROCEDURE somfSetKey (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      k : IN SOM.SOMObjectPtr);
     
     -- Set the key to the node.

   PROCEDURE somfSetRed (
      Self : IN Ref;
      Ev : IN SOM.Environment;
      on : IN Corba.Boolean);
     
     -- Set the node to red or black.

   PROCEDURE somfSetRedOn (
      Self : IN Ref;
      Ev : IN SOM.Environment);
     
     -- Set the node to red.

   PROCEDURE somInit (
      Self : IN Ref);

END somf_TSortedSequenceNode; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY somf_TSortedSequenceNode IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      somfGetLeftChild : SOM.somMToken;
      somfGetRightChild : SOM.somMToken;
      somfGetParent : SOM.somMToken;
      somfGetKey : SOM.somMToken;
      somfGetRed : SOM.somMToken;
      somfSetParent : SOM.somMToken;
      somfSetLeftChild : SOM.somMToken;
      somfSetRightChild : SOM.somMToken;
      somfSetKey : SOM.somMToken;
      somfSetRed : SOM.somMToken;
      somfSetRedOn : SOM.somMToken;
      somfTSortedSequenceNodeInitTMT : SOM.somMToken;
      somfTSortedSequenceNodeInitTM : SOM.somMToken;
      somfTSortedSequenceNodeInitT : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   somf_TSortedSequenceNodeClassData : classData;
   FOR somf_TSortedSequenceNodeClassData USE AT standard.system.label("somf_TSortedSequenceNodeClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   somf_TSortedSequenceNodeCClassData : CClassData;
   FOR somf_TSortedSequenceNodeCClassData USE AT standard.system.label("somf_TSortedSequenceNodeCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            somf_TSortedSequenceNodeClassData.classObject) 
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
      FUNCTION somf_TSortedSequenceNodeNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, somf_TSortedSequenceNodeNewClass);
      PRAGMA interface_information (somf_TSortedSequenceNodeNewClass, ".somf_TSortedSequenceNodeNewClass");
   BEGIN
      RETURN somf_TSortedSequenceNodeNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF somf_TSortedSequenceNodeClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(somf_TSortedSequenceNodeClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION somfTSortedSequenceNodeInitTMT (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n1 : IN SOM.SOMObjectPtr; 
      obj : IN SOM.SOMObjectPtr; 
      n2 : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the new TSortedSequenceNode
      FUNCTION somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTMT(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n1 : IN SOM.SOMObjectPtr; 
         obj : IN SOM.SOMObjectPtr; 
         n2 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTMT);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTMT, ".xsomcall5");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTMT (
            Self.som_object,
            Ev,
            n1,
            obj,
            n2,
            somf_TSortedSequenceNodeClassData.somfTSortedSequenceNodeInitTMT);
      RETURN Result;
   END somfTSortedSequenceNodeInitTMT; 

   FUNCTION somfTSortedSequenceNodeInitTM (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n1 : IN SOM.SOMObjectPtr; 
      obj : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the new TSortedSequenceNode
      FUNCTION somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTM(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n1 : IN SOM.SOMObjectPtr; 
         obj : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTM);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTM, ".xsomcall4");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfTSortedSequenceNodeInitTM (
            Self.som_object,
            Ev,
            n1,
            obj,
            somf_TSortedSequenceNodeClassData.somfTSortedSequenceNodeInitTM);
      RETURN Result;
   END somfTSortedSequenceNodeInitTM; 

   FUNCTION somfTSortedSequenceNodeInitT (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n1 : IN SOM.SOMObjectPtr)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Initialize the new TSortedSequenceNode
      FUNCTION somf_TSortedSequenceNode_somfTSortedSequenceNodeInitT(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n1 : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfTSortedSequenceNodeInitT);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfTSortedSequenceNodeInitT, ".xsomcall3");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfTSortedSequenceNodeInitT (
            Self.som_object,
            Ev,
            n1,
            somf_TSortedSequenceNodeClassData.somfTSortedSequenceNodeInitT);
      RETURN Result;
   END somfTSortedSequenceNodeInitT; 

   FUNCTION somfGetLeftChild (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the left child of the node.
      FUNCTION somf_TSortedSequenceNode_somfGetLeftChild(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfGetLeftChild);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfGetLeftChild, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfGetLeftChild (
            Self.som_object,
            Ev,
            somf_TSortedSequenceNodeClassData.somfGetLeftChild);
      RETURN Result;
   END somfGetLeftChild; 

   FUNCTION somfGetRightChild (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the right child of the node.
      FUNCTION somf_TSortedSequenceNode_somfGetRightChild(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfGetRightChild);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfGetRightChild, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfGetRightChild (
            Self.som_object,
            Ev,
            somf_TSortedSequenceNodeClassData.somfGetRightChild);
      RETURN Result;
   END somfGetRightChild; 

   FUNCTION somfGetParent (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the parent of the node.
      FUNCTION somf_TSortedSequenceNode_somfGetParent(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfGetParent);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfGetParent, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfGetParent (
            Self.som_object,
            Ev,
            somf_TSortedSequenceNodeClassData.somfGetParent);
      RETURN Result;
   END somfGetParent; 

   FUNCTION somfGetKey (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN SOM.SOMObjectPtr
   IS
     
     -- Determine the key to the node.
      FUNCTION somf_TSortedSequenceNode_somfGetKey(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN SOM.SOMObjectPtr; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfGetKey);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfGetKey, ".xsomcall2");
      Result : ALIASED SOM.SOMObjectPtr;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfGetKey (
            Self.som_object,
            Ev,
            somf_TSortedSequenceNodeClassData.somfGetKey);
      RETURN Result;
   END somfGetKey; 

   FUNCTION somfGetRed (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
      RETURN Corba.Boolean
   IS
     
     -- Determine if the node is red or black.
      FUNCTION somf_TSortedSequenceNode_somfGetRed(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfGetRed);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfGetRed, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         somf_TSortedSequenceNode_somfGetRed (
            Self.som_object,
            Ev,
            somf_TSortedSequenceNodeClassData.somfGetRed);
      RETURN Result;
   END somfGetRed; 

   PROCEDURE somfSetParent (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n : IN SOM.SOMObjectPtr)
   IS
     
     -- Set the parent of the node.
      PROCEDURE somf_TSortedSequenceNode_somfSetParent(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfSetParent);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfSetParent, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequenceNode_somfSetParent (
         Self.som_object,
         Ev,
         n,
         somf_TSortedSequenceNodeClassData.somfSetParent);
   END somfSetParent;

   PROCEDURE somfSetLeftChild (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n : IN SOM.SOMObjectPtr)
   IS
     
     -- Set the left child of the node.
      PROCEDURE somf_TSortedSequenceNode_somfSetLeftChild(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfSetLeftChild);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfSetLeftChild, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequenceNode_somfSetLeftChild (
         Self.som_object,
         Ev,
         n,
         somf_TSortedSequenceNodeClassData.somfSetLeftChild);
   END somfSetLeftChild;

   PROCEDURE somfSetRightChild (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      n : IN SOM.SOMObjectPtr)
   IS
     
     -- Set the right child of the node.
      PROCEDURE somf_TSortedSequenceNode_somfSetRightChild(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         n : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfSetRightChild);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfSetRightChild, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequenceNode_somfSetRightChild (
         Self.som_object,
         Ev,
         n,
         somf_TSortedSequenceNodeClassData.somfSetRightChild);
   END somfSetRightChild;

   PROCEDURE somfSetKey (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      k : IN SOM.SOMObjectPtr)
   IS
     
     -- Set the key to the node.
      PROCEDURE somf_TSortedSequenceNode_somfSetKey(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         k : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfSetKey);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfSetKey, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequenceNode_somfSetKey (
         Self.som_object,
         Ev,
         k,
         somf_TSortedSequenceNodeClassData.somfSetKey);
   END somfSetKey;

   PROCEDURE somfSetRed (
      Self : IN Ref; 
      Ev : IN SOM.Environment; 
      on : IN Corba.Boolean)
   IS
     
     -- Set the node to red or black.
      PROCEDURE somf_TSortedSequenceNode_somfSetRed(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment; 
         on : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfSetRed);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfSetRed, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequenceNode_somfSetRed (
         Self.som_object,
         Ev,
         on,
         somf_TSortedSequenceNodeClassData.somfSetRed);
   END somfSetRed;

   PROCEDURE somfSetRedOn (
      Self : IN Ref; 
      Ev : IN SOM.Environment)
   IS
     
     -- Set the node to red.
      PROCEDURE somf_TSortedSequenceNode_somfSetRedOn(
         Self : IN SOM.SOMObjectPtr; 
         Ev : IN SOM.Environment;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, somf_TSortedSequenceNode_somfSetRedOn);
      PRAGMA interface_information (somf_TSortedSequenceNode_somfSetRedOn, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      somf_TSortedSequenceNode_somfSetRedOn (
         Self.som_object,
         Ev,
         somf_TSortedSequenceNodeClassData.somfSetRedOn);
   END somfSetRedOn;

   PROCEDURE somInit (
      Self : IN Ref)
   IS
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMObject.somInit (
         SOMObject.Ref'(som_object=>Self.som_object));
   END somInit;

END somf_TSortedSequenceNode; 







