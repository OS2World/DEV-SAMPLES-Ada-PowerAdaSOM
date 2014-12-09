
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:07:22 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SCTypes;
WITH SOMObject;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMTTemplateOutputC IS


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
      

   MAX_INPUT_LINE_LENGTH : CONSTANT Corba.Long := 1024;

   MAX_OUTPUT_LINE_LENGTH : CONSTANT Corba.Long := 4096;


   FUNCTION get_somtCommentStyle (
      Self : IN Ref)
      RETURN SCTypes.somtCommentStyleT;
     
     -- Controls the style in which comments are wrtten as follows:
     --   somtDashesE: "--" at the start of each line
     --   somtCPPE: C++ style, "//" at the start of each line
     --   somtCSimpleE: simple C style, each line wrapped in / * and * /
     --   somtCBlockE: block C style, block style, ie leading / * then a * on each
     --              line and then a final * /

   PROCEDURE set_somtCommentStyle (
      Self : IN Ref;
      somtCommentStyle : IN SCTypes.somtCommentStyleT);
     
     -- Controls the style in which comments are wrtten as follows:
     --   somtDashesE: "--" at the start of each line
     --   somtCPPE: C++ style, "//" at the start of each line
     --   somtCSimpleE: simple C style, each line wrapped in / * and * /
     --   somtCBlockE: block C style, block style, ie leading / * then a * on each
     --              line and then a final * /

   FUNCTION get_somtLineLength (
      Self : IN Ref)
      RETURN Corba.Long;
     
     -- Controls list output only.  Default is 72.
     -- At least one list item will be output on each line, so making
     -- this value very short will cause list items to be placed on
     -- separate lines.

   PROCEDURE set_somtLineLength (
      Self : IN Ref;
      somtLineLength : IN Corba.Long);
     
     -- Controls list output only.  Default is 72.
     -- At least one list item will be output on each line, so making
     -- this value very short will cause list items to be placed on
     -- separate lines.

   FUNCTION get_somtCommentNewline (
      Self : IN Ref)
      RETURN Corba.Boolean;
     
     --Method from the IDL attribute statement:
     --"attribute boolean somtCommentNewline"

   PROCEDURE set_somtCommentNewline (
      Self : IN Ref;
      somtCommentNewline : IN Corba.Boolean);
     
     --Method from the IDL attribute statement:
     --"attribute boolean somtCommentNewline"

   FUNCTION somtGetSymbol (
      Self : IN Ref;
      name : IN Corba.String)
      RETURN Corba.String;
     
     -- Returns the value associated with <name>.  If no value is
     -- associated with <name> then NULL is returned

   PROCEDURE somtSetSymbol (
      Self : IN Ref;
      name : IN Corba.String;
      value : IN Corba.String);
     
     -- Makes the symbol with name <name> have value <value>.  This will
     -- overwrite any previous value the symbol had, and add the symbol
     -- if necessary.
     -- Takes over ownership of both name and value.

   PROCEDURE somtSetSymbolCopyName (
      Self : IN Ref;
      name : IN Corba.String;
      value : IN Corba.String);
     
     -- See somtSetSymbol
     -- Only takes over ownership of value.

   PROCEDURE somtSetSymbolCopyValue (
      Self : IN Ref;
      name : IN Corba.String;
      value : IN Corba.String);
     
     -- See somtSetSymbol
     -- Only takes over ownership of name.

   PROCEDURE somtSetSymbolCopyBoth (
      Self : IN Ref;
      name : IN Corba.String;
      value : IN Corba.String);
     
     -- See somtSetSymbol
     -- Does not take over ownership of either <name> or <value>

   FUNCTION somtCheckSymbol (
      Self : IN Ref;
      name : IN Corba.String)
      RETURN Corba.Boolean;
     
     -- Returns 1 (true) if the indicated symbol has non-null, non-zero
     -- length value, and 0 (false) otherwise.

   PROCEDURE somtSetOutputFile (
      Self : IN Ref;
      fp : IN OUT SCTypes.FILE);
     
     -- All template output will be directed to <fp>. Default is <stdout>.

   PROCEDURE somto (
      Self : IN Ref;
      tmplt : IN Corba.String);
     
     -- Outputs a template, <tmplt>, after substitution for any symbols
     -- that occur in it.  Five substitutions are supported: simple,
     -- list, comment, tab, and conditional.
     -- Substitutable items in the template are bracketed with angle
     -- brackets. (Backslash can be used to escape an angle bracket.)
     -- Simple substitutions just replace a symbol with its value. If
     -- the symbol has no value in this template object then the symbol
     -- is replaced error string but no error is raised.
     -- List substitution assumes that the symbol has a value in output
     -- template list form. This is a newline separated string of
     -- values. The list substitution specification consists of four
     -- parts, a prefix, a symbol, a separator, and a list indicator.
     -- prefixes and separators can only be composed of blanks, comma,
     -- colons, and semi-colons.  The list indicator is "..." (three
     -- periods).  For example, the list substitution
     -- specification "<, name, ...> has a prefix of ", ", a symbol of
     -- "name" and a separator of ", ".  The prefix will be used
     -- whenever there is at least one item in the list and the separator
     -- will be used between any two list items.  After the first items
     -- of a list is placed each additional item is evaluated to see if
     -- it would begin after the line length limit (set by
     -- _set_somtLineLength), if it would then a new line is begun and the
     -- value is placed directly under the first item.
     -- Comment substitution assumes that the symbol has a value in
     -- output template list form.  A comment specification consists of
     -- a comment indicator followed by a symbol name. The comment
     -- indicator is "--".  Eg, <-- classComment> is a valid comment
     -- substitution specification.  The lines of the comment are output
     -- according to the current comment style (see <somtCommentStyle>)
     -- and alined with the starting column of the comment
     -- specification.
     -- Tab substitution is specified by <@dd> where "dd" is a valid
     -- positive integer. Blanks will be inserted into the output stream
     -- if necessary to position the next character of output at the
     -- column indicated by "dd".
     -- Conditional substitution is specified by puting a question mark,
     -- "?", in column one of the template line.  The line will not be
     -- output at all unless at least one valid, non-blank,  symbol
     -- substitution  occurs on the line.

   PROCEDURE somtOutputComment (
      Self : IN Ref;
      comment : IN Corba.String);
     
     -- Inserts a comment into the output stream.  <comment> must be a
     -- string containing the comment with lines in the comment
     -- seperated by newlines.
     -- The style of output is controlled by <somtCommentStyle>

   PROCEDURE somtOutputSection (
      Self : IN Ref;
      sectionName : IN Corba.String);
     
     -- Just like <somto> above, except <sectionName> must be a symbol
     -- whose value will be used as the template.

   PROCEDURE somtAddSectionDefinitions (
      Self : IN Ref;
      defString : IN Corba.String);
     
     -- <defString> must be a string of the form:
     -- :section1
     -- value 1 line 1
     -- value 1 line 2
     -- :section2
     -- value 2 line 1
     -- :section3
     -- value 3 line 1
     -- Where the lines that contain a ":" in column 1 immediately followed
     -- by a single name are used to intro the start of a new section.
     -- The section is named by the name on the colon line.  A backslash
     -- can be used to escape a colon in column one that is not supposed
     -- to start a new section.
     -- Adds the indicated section definitions to this template.

   PROCEDURE somtReadSectionDefinitions (
      Self : IN Ref;
      fp : IN OUT SCTypes.FILE);
     
     -- Reads section definitions from the indicated file.  The section
     -- definitions must be in the form defined above in
     -- <somtAddSectionDefinitions>.

   FUNCTION somtExpandSymbol (
      Self : IN Ref;
      s : IN Corba.String;
      buf : IN Corba.String)
      RETURN Corba.String;
     
     -- Expands simple symbols in an already expanded string.  Thus if you
     -- have a symbol which is itself a Section in a template file, and this
     -- section could have other sections in it then you should call this
     -- method.

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

END SOMTTemplateOutputC; 

WITH SOMObject;
WITH SOMClass;

PACKAGE BODY SOMTTemplateOutputC IS

   

   FUNCTION "="(l,r : IN SOM.address) RETURN boolean RENAMES SOM."=";

 
   -- Class data structure.
   TYPE classData IS
   RECORD
      classObject : SOM.SOMAnyPtr;
      get_somtCommentStyle : SOM.somMToken;
      set_somtCommentStyle : SOM.somMToken;
      get_somtLineLength : SOM.somMToken;
      set_somtLineLength : SOM.somMToken;
      set_somtCommentNewline : SOM.somMToken;
      get_somtCommentNewline : SOM.somMToken;
      somtGetSymbol : SOM.somMToken;
      somtSetSymbol : SOM.somMToken;
      somtSetSymbolCopyName : SOM.somMToken;
      somtSetSymbolCopyValue : SOM.somMToken;
      somtSetSymbolCopyBoth : SOM.somMToken;
      somtCheckSymbol : SOM.somMToken;
      somtSetOutputFile : SOM.somMToken;
      somto : SOM.somMToken;
      somtOutputComment : SOM.somMToken;
      somtOutputSection : SOM.somMToken;
      somtAddSectionDefinitions : SOM.somMToken;
      somtReadSectionDefinitions : SOM.somMToken;
      somtExpandSymbol : SOM.somMToken;
   END RECORD;
   PRAGMA Preserve_Layout( classData );

   SOMTTemplateOutputCClassData : classData;
   FOR SOMTTemplateOutputCClassData USE AT standard.system.label("SOMTTemplateOutputCClassData");

   
   -- Auxilary class data structure.
   TYPE CClassData IS
   RECORD
      parentMtab        : SOM.somMethodTabs;
      instanceDataToken : SOM.somDToken;
   END RECORD;
   PRAGMA Preserve_Layout( CClassData );

   SOMTTemplateOutputCCClassData : CClassData;
   FOR SOMTTemplateOutputCCClassData USE AT standard.system.label("SOMTTemplateOutputCCClassData");
   -- Documentation indicates that this is not needed.


   FUNCTION To_Ref (
      som_object : IN SOM.SOMObjectPtr)
      RETURN          Ref
   IS
   BEGIN
      IF 
         SOMObject.somIsA(
            SOMObject.Ref'(som_object => som_object), 
            SOMTTemplateOutputCClassData.classObject) 
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
      FUNCTION SOMTTemplateOutputCNewClass (
         Major_Version : IN SOM.integer4;
         Minor_Version : IN SOM.integer4)
         RETURN             SOM.SOMClassPtr;
      PRAGMA interface (C, SOMTTemplateOutputCNewClass);
      PRAGMA interface_information (SOMTTemplateOutputCNewClass, ".SOMTTemplateOutputCNewClass");
   BEGIN
      RETURN SOMTTemplateOutputCNewClass(major_version, minor_version);
   END New_Class;

   FUNCTION New_Instance
      RETURN Ref
   IS
      Result : Ref;
      Dummy  : SOM.SOMClassPtr;
   BEGIN
      IF SOMTTemplateOutputCClassData.classObject = SOM.null_address THEN
         Dummy := New_Class(Major_Version, Minor_Version);
      END IF;
      Result.som_object := 
         SOMClass.somNew(
            SOMClass.To_Ref(SOMTTemplateOutputCClassData.classObject));
      RETURN Result;
   END New_Instance;


   PROCEDURE Free_Instance(
      Instance : IN OUT Ref)
   IS
   BEGIN
      SOMObject.somFree(SOMObject.To_Ref(Instance.som_object));
   END Free_Instance;


   FUNCTION get_somtCommentStyle (
      Self : IN Ref)
      RETURN SCTypes.somtCommentStyleT
   IS
     
     -- Controls the style in which comments are wrtten as follows:
     --   somtDashesE: "--" at the start of each line
     --   somtCPPE: C++ style, "//" at the start of each line
     --   somtCSimpleE: simple C style, each line wrapped in / * and * /
     --   somtCBlockE: block C style, block style, ie leading / * then a * on each
     --              line and then a final * /
      FUNCTION SOMTTemplateOutputC_U_get_somtCommentStyle(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN SCTypes.somtCommentStyleT; 
      PRAGMA interface (assembly, SOMTTemplateOutputC_U_get_somtCommentStyle);
      PRAGMA interface_information (SOMTTemplateOutputC_U_get_somtCommentStyle, ".xsomcall1");
      Result : ALIASED SCTypes.somtCommentStyleT;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTemplateOutputC_U_get_somtCommentStyle (
            Self.som_object,
            SOMTTemplateOutputCClassData.get_somtCommentStyle);
      RETURN Result;
   END get_somtCommentStyle; 

   PROCEDURE set_somtCommentStyle (
      Self : IN Ref; 
      somtCommentStyle : IN SCTypes.somtCommentStyleT)
   IS
     
     -- Controls the style in which comments are wrtten as follows:
     --   somtDashesE: "--" at the start of each line
     --   somtCPPE: C++ style, "//" at the start of each line
     --   somtCSimpleE: simple C style, each line wrapped in / * and * /
     --   somtCBlockE: block C style, block style, ie leading / * then a * on each
     --              line and then a final * /
      PROCEDURE SOMTTemplateOutputC_U_set_somtCommentStyle(
         Self : IN SOM.SOMObjectPtr; 
         somtCommentStyle : IN SCTypes.somtCommentStyleT;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_U_set_somtCommentStyle);
      PRAGMA interface_information (SOMTTemplateOutputC_U_set_somtCommentStyle, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_U_set_somtCommentStyle (
         Self.som_object,
         somtCommentStyle,
         SOMTTemplateOutputCClassData.set_somtCommentStyle);
   END set_somtCommentStyle;

   FUNCTION get_somtLineLength (
      Self : IN Ref)
      RETURN Corba.Long
   IS
     
     -- Controls list output only.  Default is 72.
     -- At least one list item will be output on each line, so making
     -- this value very short will cause list items to be placed on
     -- separate lines.
      FUNCTION SOMTTemplateOutputC_U_get_somtLineLength(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Long; 
      PRAGMA interface (assembly, SOMTTemplateOutputC_U_get_somtLineLength);
      PRAGMA interface_information (SOMTTemplateOutputC_U_get_somtLineLength, ".xsomcall1");
      Result : ALIASED Corba.Long;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTemplateOutputC_U_get_somtLineLength (
            Self.som_object,
            SOMTTemplateOutputCClassData.get_somtLineLength);
      RETURN Result;
   END get_somtLineLength; 

   PROCEDURE set_somtLineLength (
      Self : IN Ref; 
      somtLineLength : IN Corba.Long)
   IS
     
     -- Controls list output only.  Default is 72.
     -- At least one list item will be output on each line, so making
     -- this value very short will cause list items to be placed on
     -- separate lines.
      PROCEDURE SOMTTemplateOutputC_U_set_somtLineLength(
         Self : IN SOM.SOMObjectPtr; 
         somtLineLength : IN Corba.Long;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_U_set_somtLineLength);
      PRAGMA interface_information (SOMTTemplateOutputC_U_set_somtLineLength, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_U_set_somtLineLength (
         Self.som_object,
         somtLineLength,
         SOMTTemplateOutputCClassData.set_somtLineLength);
   END set_somtLineLength;

   FUNCTION get_somtCommentNewline (
      Self : IN Ref)
      RETURN Corba.Boolean
   IS
     
     --Method from the IDL attribute statement:
     --"attribute boolean somtCommentNewline"
      FUNCTION SOMTTemplateOutputC_U_get_somtCommentNewline(
         Self : IN SOM.SOMObjectPtr;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTTemplateOutputC_U_get_somtCommentNewline);
      PRAGMA interface_information (SOMTTemplateOutputC_U_get_somtCommentNewline, ".xsomcall1");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTemplateOutputC_U_get_somtCommentNewline (
            Self.som_object,
            SOMTTemplateOutputCClassData.get_somtCommentNewline);
      RETURN Result;
   END get_somtCommentNewline; 

   PROCEDURE set_somtCommentNewline (
      Self : IN Ref; 
      somtCommentNewline : IN Corba.Boolean)
   IS
     
     --Method from the IDL attribute statement:
     --"attribute boolean somtCommentNewline"
      PROCEDURE SOMTTemplateOutputC_U_set_somtCommentNewline(
         Self : IN SOM.SOMObjectPtr; 
         somtCommentNewline : IN Corba.Boolean;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_U_set_somtCommentNewline);
      PRAGMA interface_information (SOMTTemplateOutputC_U_set_somtCommentNewline, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_U_set_somtCommentNewline (
         Self.som_object,
         somtCommentNewline,
         SOMTTemplateOutputCClassData.set_somtCommentNewline);
   END set_somtCommentNewline;

   FUNCTION somtGetSymbol (
      Self : IN Ref; 
      name : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Returns the value associated with <name>.  If no value is
     -- associated with <name> then NULL is returned
      FUNCTION SOMTTemplateOutputC_somtGetSymbol(
         Self : IN SOM.SOMObjectPtr; 
         name : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtGetSymbol);
      PRAGMA interface_information (SOMTTemplateOutputC_somtGetSymbol, ".xsomcall2");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTemplateOutputC_somtGetSymbol (
            Self.som_object,
            name,
            SOMTTemplateOutputCClassData.somtGetSymbol);
      RETURN Result;
   END somtGetSymbol; 

   PROCEDURE somtSetSymbol (
      Self : IN Ref; 
      name : IN Corba.String; 
      value : IN Corba.String)
   IS
     
     -- Makes the symbol with name <name> have value <value>.  This will
     -- overwrite any previous value the symbol had, and add the symbol
     -- if necessary.
     -- Takes over ownership of both name and value.
      PROCEDURE SOMTTemplateOutputC_somtSetSymbol(
         Self : IN SOM.SOMObjectPtr; 
         name : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtSetSymbol);
      PRAGMA interface_information (SOMTTemplateOutputC_somtSetSymbol, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtSetSymbol (
         Self.som_object,
         name,
         value,
         SOMTTemplateOutputCClassData.somtSetSymbol);
   END somtSetSymbol;

   PROCEDURE somtSetSymbolCopyName (
      Self : IN Ref; 
      name : IN Corba.String; 
      value : IN Corba.String)
   IS
     
     -- See somtSetSymbol
     -- Only takes over ownership of value.
      PROCEDURE SOMTTemplateOutputC_somtSetSymbolCopyName(
         Self : IN SOM.SOMObjectPtr; 
         name : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtSetSymbolCopyName);
      PRAGMA interface_information (SOMTTemplateOutputC_somtSetSymbolCopyName, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtSetSymbolCopyName (
         Self.som_object,
         name,
         value,
         SOMTTemplateOutputCClassData.somtSetSymbolCopyName);
   END somtSetSymbolCopyName;

   PROCEDURE somtSetSymbolCopyValue (
      Self : IN Ref; 
      name : IN Corba.String; 
      value : IN Corba.String)
   IS
     
     -- See somtSetSymbol
     -- Only takes over ownership of name.
      PROCEDURE SOMTTemplateOutputC_somtSetSymbolCopyValue(
         Self : IN SOM.SOMObjectPtr; 
         name : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtSetSymbolCopyValue);
      PRAGMA interface_information (SOMTTemplateOutputC_somtSetSymbolCopyValue, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtSetSymbolCopyValue (
         Self.som_object,
         name,
         value,
         SOMTTemplateOutputCClassData.somtSetSymbolCopyValue);
   END somtSetSymbolCopyValue;

   PROCEDURE somtSetSymbolCopyBoth (
      Self : IN Ref; 
      name : IN Corba.String; 
      value : IN Corba.String)
   IS
     
     -- See somtSetSymbol
     -- Does not take over ownership of either <name> or <value>
      PROCEDURE SOMTTemplateOutputC_somtSetSymbolCopyBoth(
         Self : IN SOM.SOMObjectPtr; 
         name : IN Corba.String; 
         value : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtSetSymbolCopyBoth);
      PRAGMA interface_information (SOMTTemplateOutputC_somtSetSymbolCopyBoth, ".xsomcall3");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtSetSymbolCopyBoth (
         Self.som_object,
         name,
         value,
         SOMTTemplateOutputCClassData.somtSetSymbolCopyBoth);
   END somtSetSymbolCopyBoth;

   FUNCTION somtCheckSymbol (
      Self : IN Ref; 
      name : IN Corba.String)
      RETURN Corba.Boolean
   IS
     
     -- Returns 1 (true) if the indicated symbol has non-null, non-zero
     -- length value, and 0 (false) otherwise.
      FUNCTION SOMTTemplateOutputC_somtCheckSymbol(
         Self : IN SOM.SOMObjectPtr; 
         name : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.Boolean; 
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtCheckSymbol);
      PRAGMA interface_information (SOMTTemplateOutputC_somtCheckSymbol, ".xsomcall2");
      Result : ALIASED Corba.Boolean;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTemplateOutputC_somtCheckSymbol (
            Self.som_object,
            name,
            SOMTTemplateOutputCClassData.somtCheckSymbol);
      RETURN Result;
   END somtCheckSymbol; 

   PROCEDURE somtSetOutputFile (
      Self : IN Ref; 
      fp : IN OUT SCTypes.FILE)
   IS
     
     -- All template output will be directed to <fp>. Default is <stdout>.
      PROCEDURE SOMTTemplateOutputC_somtSetOutputFile(
         Self : IN SOM.SOMObjectPtr; 
         fp : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtSetOutputFile);
      PRAGMA interface_information (SOMTTemplateOutputC_somtSetOutputFile, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtSetOutputFile (
         Self.som_object,
         SOM.To_SOM_Address(fp'address),
         SOMTTemplateOutputCClassData.somtSetOutputFile);
   END somtSetOutputFile;

   PROCEDURE somto (
      Self : IN Ref; 
      tmplt : IN Corba.String)
   IS
     
     -- Outputs a template, <tmplt>, after substitution for any symbols
     -- that occur in it.  Five substitutions are supported: simple,
     -- list, comment, tab, and conditional.
     -- Substitutable items in the template are bracketed with angle
     -- brackets. (Backslash can be used to escape an angle bracket.)
     -- Simple substitutions just replace a symbol with its value. If
     -- the symbol has no value in this template object then the symbol
     -- is replaced error string but no error is raised.
     -- List substitution assumes that the symbol has a value in output
     -- template list form. This is a newline separated string of
     -- values. The list substitution specification consists of four
     -- parts, a prefix, a symbol, a separator, and a list indicator.
     -- prefixes and separators can only be composed of blanks, comma,
     -- colons, and semi-colons.  The list indicator is "..." (three
     -- periods).  For example, the list substitution
     -- specification "<, name, ...> has a prefix of ", ", a symbol of
     -- "name" and a separator of ", ".  The prefix will be used
     -- whenever there is at least one item in the list and the separator
     -- will be used between any two list items.  After the first items
     -- of a list is placed each additional item is evaluated to see if
     -- it would begin after the line length limit (set by
     -- _set_somtLineLength), if it would then a new line is begun and the
     -- value is placed directly under the first item.
     -- Comment substitution assumes that the symbol has a value in
     -- output template list form.  A comment specification consists of
     -- a comment indicator followed by a symbol name. The comment
     -- indicator is "--".  Eg, <-- classComment> is a valid comment
     -- substitution specification.  The lines of the comment are output
     -- according to the current comment style (see <somtCommentStyle>)
     -- and alined with the starting column of the comment
     -- specification.
     -- Tab substitution is specified by <@dd> where "dd" is a valid
     -- positive integer. Blanks will be inserted into the output stream
     -- if necessary to position the next character of output at the
     -- column indicated by "dd".
     -- Conditional substitution is specified by puting a question mark,
     -- "?", in column one of the template line.  The line will not be
     -- output at all unless at least one valid, non-blank,  symbol
     -- substitution  occurs on the line.
      PROCEDURE SOMTTemplateOutputC_somto(
         Self : IN SOM.SOMObjectPtr; 
         tmplt : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somto);
      PRAGMA interface_information (SOMTTemplateOutputC_somto, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somto (
         Self.som_object,
         tmplt,
         SOMTTemplateOutputCClassData.somto);
   END somto;

   PROCEDURE somtOutputComment (
      Self : IN Ref; 
      comment : IN Corba.String)
   IS
     
     -- Inserts a comment into the output stream.  <comment> must be a
     -- string containing the comment with lines in the comment
     -- seperated by newlines.
     -- The style of output is controlled by <somtCommentStyle>
      PROCEDURE SOMTTemplateOutputC_somtOutputComment(
         Self : IN SOM.SOMObjectPtr; 
         comment : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtOutputComment);
      PRAGMA interface_information (SOMTTemplateOutputC_somtOutputComment, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtOutputComment (
         Self.som_object,
         comment,
         SOMTTemplateOutputCClassData.somtOutputComment);
   END somtOutputComment;

   PROCEDURE somtOutputSection (
      Self : IN Ref; 
      sectionName : IN Corba.String)
   IS
     
     -- Just like <somto> above, except <sectionName> must be a symbol
     -- whose value will be used as the template.
      PROCEDURE SOMTTemplateOutputC_somtOutputSection(
         Self : IN SOM.SOMObjectPtr; 
         sectionName : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtOutputSection);
      PRAGMA interface_information (SOMTTemplateOutputC_somtOutputSection, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtOutputSection (
         Self.som_object,
         sectionName,
         SOMTTemplateOutputCClassData.somtOutputSection);
   END somtOutputSection;

   PROCEDURE somtAddSectionDefinitions (
      Self : IN Ref; 
      defString : IN Corba.String)
   IS
     
     -- <defString> must be a string of the form:
     -- :section1
     -- value 1 line 1
     -- value 1 line 2
     -- :section2
     -- value 2 line 1
     -- :section3
     -- value 3 line 1
     -- Where the lines that contain a ":" in column 1 immediately followed
     -- by a single name are used to intro the start of a new section.
     -- The section is named by the name on the colon line.  A backslash
     -- can be used to escape a colon in column one that is not supposed
     -- to start a new section.
     -- Adds the indicated section definitions to this template.
      PROCEDURE SOMTTemplateOutputC_somtAddSectionDefinitions(
         Self : IN SOM.SOMObjectPtr; 
         defString : IN Corba.String;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtAddSectionDefinitions);
      PRAGMA interface_information (SOMTTemplateOutputC_somtAddSectionDefinitions, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtAddSectionDefinitions (
         Self.som_object,
         defString,
         SOMTTemplateOutputCClassData.somtAddSectionDefinitions);
   END somtAddSectionDefinitions;

   PROCEDURE somtReadSectionDefinitions (
      Self : IN Ref; 
      fp : IN OUT SCTypes.FILE)
   IS
     
     -- Reads section definitions from the indicated file.  The section
     -- definitions must be in the form defined above in
     -- <somtAddSectionDefinitions>.
      PROCEDURE SOMTTemplateOutputC_somtReadSectionDefinitions(
         Self : IN SOM.SOMObjectPtr; 
         fp : IN SOM.address;
         subprogram_value : IN SOM.somMToken);
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtReadSectionDefinitions);
      PRAGMA interface_information (SOMTTemplateOutputC_somtReadSectionDefinitions, ".xsomcall2");

   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      SOMTTemplateOutputC_somtReadSectionDefinitions (
         Self.som_object,
         SOM.To_SOM_Address(fp'address),
         SOMTTemplateOutputCClassData.somtReadSectionDefinitions);
   END somtReadSectionDefinitions;

   FUNCTION somtExpandSymbol (
      Self : IN Ref; 
      s : IN Corba.String; 
      buf : IN Corba.String)
      RETURN Corba.String
   IS
     
     -- Expands simple symbols in an already expanded string.  Thus if you
     -- have a symbol which is itself a Section in a template file, and this
     -- section could have other sections in it then you should call this
     -- method.
      FUNCTION SOMTTemplateOutputC_somtExpandSymbol(
         Self : IN SOM.SOMObjectPtr; 
         s : IN Corba.String; 
         buf : IN Corba.String;
         subprogram_value : IN SOM.somMToken)
         RETURN Corba.String; 
      PRAGMA interface (assembly, SOMTTemplateOutputC_somtExpandSymbol);
      PRAGMA interface_information (SOMTTemplateOutputC_somtExpandSymbol, ".xsomcall3");
      Result : ALIASED Corba.String;
   BEGIN
      IF NOT SOM.somIsObj(Self.som_object) THEN RAISE program_error; END IF;
      Result :=
         SOMTTemplateOutputC_somtExpandSymbol (
            Self.som_object,
            s,
            buf,
            SOMTTemplateOutputCClassData.somtExpandSymbol);
      RETURN Result;
   END somtExpandSymbol; 

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

END SOMTTemplateOutputC; 







