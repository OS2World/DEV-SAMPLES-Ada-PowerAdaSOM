------------------------------------------------------------------------------
-- corba.sequences.spec : Corba sequences -- PACAKGE SPEC
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 96Jun20 swn Remove pragma PURE.   (d2777)
-- 95Dec20 swn Change CORBA type names.  (d2189)
-- 95Apr10 swn Fix capacity limit for bounded sequences.  (d1164)
--             Temp fix capacity limit for unbounded sequences. (d1164)
-- 94Dec12 swn Nested generic children here to workaround compiler.
-- 94Dec06 swn Created from mapping document.
------------------------------------------------------------------------------
--
-- Corba.Sequences is the parent of the bounded and unbounded sequence
-- packages.  Some exceptions and types common to both are declared here
-- (following the structure of Ada.Strings).
--
-- Length_Error is raised when sequence lengths are exceeded.
-- Pattern_Error is raised when a null pattern string is passed.
-- Index_Error is raised when indexes are out of range.
--
------------------------------------------------------------------------------

--WITH Ada.Finalization;

PACKAGE Corba.Sequences IS

   PRAGMA comment ("@(#) ada/runtime/som/corba.sequences.spec, ada, power95.3 1.5 6/20/96 12:45:38");

   Length_Error, Pattern_Error, Index_Error : EXCEPTION;

   TYPE Alignment  IS (Left, Right, Center);
   TYPE Truncation IS (Left, Right, Error);
   TYPE Membership IS (Inside, Outside);
   TYPE Direction  IS (Forward, Backward);

   TYPE Trim_End   IS (Left, Right, Both);


    ---------------------------------------------------------------------------
    --
    -- This package provides the definitions required by the IDL-to-Ada95
    -- mapping specification for bounded sequences.
    -- This package is instantiated for each IDL bounded sequence type.
    -- This package defines the sequence type and the operations upon it.
    -- This package is modelled after Ada.Strings.
    --
    -- Most query operations are not usable until the sequence object has
    -- been initialized through an assignment.
    --
    -- Value semantics apply to assignment, that is, assignment of a sequence
    -- value to a sequence object yields a copy of the value.
    --
    -- The exception INDEX_ERROR is raised when indexes are not in the range
    -- of the object being manipulated.
    --
    -- The exception CONSTRAINT_ERROR is raised when objects that have not 
    -- been initalized or assigned to are manipulated.
    --
    ---------------------------------------------------------------------------

    generic
    
        type Element is private;
        Max : Positive;    -- Maximum length of the bounded sequence
    
    package Bounded is
           
        Max_Length : constant Positive := Max;
    
        type Element_Array is array (Positive range <>) of Element;

       Null_Element_Array : Element_Array(1..0);
   
       type Sequence is private;
   
       Null_Sequence : constant Sequence;
   
       subtype Length_Range is Natural range 0 .. Max_Length;
   
       function Length (Source : in Sequence)
               return Length_Range;
   
       type Element_Array_Access is access all Element_Array;
       procedure Free (X : in out Element_Array_Access);
       
       --------------------------------------------------------
       -- Conversion, Concatenation, and Selection Functions --
       --------------------------------------------------------
   
       function To_Sequence
                   (Source : in Element_Array;
                    Drop   : in Truncation := Error)
               return Sequence;
   
       function To_Sequence
           (Length : in Length_Range) 
            return      Sequence;
   
       function To_Element_Array (Source : in Sequence)
               return Element_Array;
   
       function Append
           (Left, Right : in Sequence;
            Drop        : in Truncation  := Error)
            return        Sequence;
   
       function Append
           (Left  : in Sequence;
            Right : in Element_Array;
            Drop  : in Truncation := Error)
            return  Sequence;
   
       function Append
           (Left  : in Element_Array;
            Right : in Sequence;
            Drop  : in Truncation := Error)
            return  Sequence;
   
       function Append
           (Left  : in Sequence;
            Right : in Element;
            Drop  : in Truncation := Error)
            return  Sequence;
   
       function Append
           (Left  : in Element;
            Right : in Sequence;
            Drop  : in Truncation := Error)
            return  Sequence;
   
       procedure Append
                   (Source   : in out Sequence;
                    New_Item : in Sequence;
                    Drop     : in Truncation := Error);
   
       procedure Append
                   (Source   : in out Sequence;
                    New_Item : in Element_Array;
                    Drop     : in Truncation := Error);
   
       procedure Append
                   (Source   : in out Sequence;
                    New_Item : in Element;
                    Drop     : in Truncation := Error);
   
       function "&" (Left, Right : in Sequence)
               return Sequence;
   
       function "&"
                   (Left  : in Sequence;
                    Right : in Element_Array)
               return  Sequence;
   
       function "&"
                   (Left  : in Element_Array;
                    Right : in Sequence)
               return  Sequence;
   
       function "&"
                   (Left  : in Sequence;
                    Right : in Element)
               return  Sequence;
   
       function "&"
                   (Left  : in Element;
                    Right : in Sequence)
               return  Sequence;
   
       function Element_Of
                   (Source : in Sequence;
                    Index  : in Positive)
               return   Element;
   
       procedure Replace_Element
                   (Source : in out Sequence;
                    Index  : in Positive;
                    By     : in Element);
   
       function Slice
                   (Source : in Sequence;
                    Low    : in Positive;
                    High   : in Natural)
               return   Element_Array;
   
       function "=" (Left, Right : in Sequence)
               return Boolean;
   
       function "="
                   (Left  : in Sequence;
                    Right : in Element_Array)
               return  Boolean;
   
       function "="
                   (Left  : in Element_Array;
                    Right : in Sequence)
               return  Boolean;
   
       ----------------------
       -- Search functions --
       ----------------------
   
       function Index
                   (Source   : in Sequence;
                    Pattern  : in Element_Array;
                    Going    : in Direction := Forward)
               return     Natural;
   
       function Count
                   (Source  : in Sequence;
                    Pattern : in Element_Array)
               return    Natural;
   
       -----------------------------------------
       -- Sequence transformation subprograms --
       -----------------------------------------
   
       function Replace_Slice
                   (Source : in Sequence;
                    Low    : in Positive;
                    High   : in Natural;
                    By     : in Element_Array;
                    Drop   : in Truncation := Error)
               return   Sequence;
   
       procedure Replace_Slice
                   (Source   : in out Sequence;
                    Low      : in Positive;
                    High     : in Natural;
                    By       : in Element_Array;
                    Drop     : in Truncation := Error);
   
       function Insert
                   (Source   : in Sequence;
                    Before   : in Positive;
                    New_Item : in Element_Array;
                    Drop     : in Truncation := Error)
               return     Sequence;
   
       procedure Insert
                   (Source   : in out Sequence;
                    Before   : in Positive;
                    New_Item : in Element_Array;
                    Drop     : in Truncation := Error);
   
       function Overwrite
                   (Source   : in Sequence;
                    Position : in Positive;
                    New_Item : in Element_Array;
                    Drop     : in Truncation := Error)
               return     Sequence;
   
       procedure Overwrite
                   (Source    : in out Sequence;
                    Position  : in Positive;
                    New_Item  : in Element_Array;
                    Drop      : in Truncation := Error);
   
       function Delete
                   (Source  : in Sequence;
                    From    : in Positive;
                    Through : in Natural)
               return    Sequence;
   
       procedure Delete
                   (Source  : in out Sequence;
                    From    : in Positive;
                    Through : in Natural);
   
       -----------------------------------
       -- Sequence selector subprograms --
       -----------------------------------
   
       function Head
                   (Source : in Sequence;
                    Count  : in Natural;
                    Pad    : in Element;
                    Drop   : in Truncation := Error)
               return   Sequence;
   
       procedure Head
                   (Source : in out Sequence;
                    Count  : in Natural;
                    Pad    : in Element;
                    Drop   : in Truncation := Error);
   
       function Tail
                   (Source : in Sequence;
                    Count  : in Natural;
                    Pad    : in Element;
                    Drop   : in Truncation := Error)
               return   Sequence;
   
       procedure Tail
                   (Source : in out Sequence;
                    Count  : in Natural;
                    Pad    : in Element;
                    Drop   : in Truncation := Error);
   
       --------------------------------------
       -- Sequence constructor subprograms --
       --------------------------------------
   
       function "*"
                   (Left  : in Natural;
                    Right : in Element)
               return  Sequence;
   
       function "*"
                   (Left  : in Natural;
                    Right : in Element_Array)
               return  Sequence;
   
       function "*"
                   (Left  : in Natural;
                    Right : in Sequence)
               return  Sequence;
   
       function Replicate
                   (Count : in Natural;
                    Item  : in Element;
                    Drop  : in Truncation := Error)
       return  Sequence;
   
       function Replicate
                   (Count : in Natural;
                    Item  : in Element_Array;
                    Drop  : in Truncation := Error)
       return  Sequence;
   
       function Replicate
                   (Count : in Natural;
                    Item  : in Sequence;
                    Drop  : in Truncation := Error)
       return  Sequence;
    
    private
    
       -- To get the sequence type to map to the C equivalent we use
       -- a large statically sized array type (to avoid dope vectors).
       -- The index checks should be suppressed and checking should
       -- be done by hand.

       subtype Fixed is Element_Array(1..Max);
       type Fixed_Access is access Fixed;
   
        type Sequence is
    --    new Ada.Finalization.Controlled with
        record
           Maximum : Length_Range := 0;
           Length  : Length_Range := 0;
           Buffer  : Fixed_Access;
        end record;
        -- This is assumed to map onto the CORBA/SOM definition of a sequence.
    
       Null_Sequence : constant Sequence := (0, 0, null);
--                       (Ada.Finalization.Controlled with 0, 0, null);
    
    end Bounded;


    ---------------------------------------------------------------------------
    --
    -- This package provides the definitions required by the IDL-to-Ada95
    -- mapping specification for unbounded sequences.
    -- This package is instantiated for each IDL bunounded sequence type.
    -- This package defines the sequence type and the operations upon it.
    -- This package is modelled after Ada.Strings.
    --
    -- Most query operations are not usable until the sequence object has
    -- been initialized through an assignment.
    --
    -- Value semantics apply to assignment, that is, assignment of a sequence
    -- value to a sequence object yields a copy of the value.
    --
    -- The exception INDEX_ERROR is raised when indexes are not in the range
    -- of the object being manipulated.
    --
    -- The exception CONSTRAINT_ERROR is raised when objects that have not 
    -- been initalized or assigned to are manipulated.
    --
    ---------------------------------------------------------------------------

    generic
   
       type Element is private;
   
    package Unbounded is
      
       type Element_Array is array (Integer range <>) of Element;
   
       Null_Element_Array : Element_Array(1..0);
   
       type Sequence is private;
   
       Null_Sequence : constant Sequence;
   
       function Length (Source : in Sequence)
               return Natural;
   
       type Element_Array_Access is access all Element_Array;
       procedure Free (X : in out Element_Array_Access);
   
       --------------------------------------------------------
       -- Conversion, Concatenation, and Selection Functions --
       --------------------------------------------------------
   
       function To_Sequence
                   (Source : in Element_Array)
               return Sequence;
   
       function To_Sequence
           (Length : in Natural) 
            return      Sequence;
   
       function To_Element_Array (Source : in Sequence)
               return Element_Array;
   
       procedure Append
                   (Source   : in out Sequence;
                    New_Item : in Sequence);
   
       procedure Append
                   (Source   : in out Sequence;
                    New_Item : in Element_Array);
   
       procedure Append
                   (Source   : in out Sequence;
                    New_Item : in Element);
   
       function "&" (Left, Right : in Sequence)
               return Sequence;
   
       function "&"
                   (Left  : in Sequence;
                    Right : in Element_Array)
               return  Sequence;
   
       function "&"
                   (Left  : in Element_Array;
                    Right : in Sequence)
               return  Sequence;
   
       function "&"
                   (Left  : in Sequence;
                    Right : in Element)
               return  Sequence;
   
       function "&"
                   (Left  : in Element;
                    Right : in Sequence)
               return  Sequence;
   
       function Element_Of
                   (Source : in Sequence;
                    Index  : in Positive)
               return   Element;
   
       procedure Replace_Element
                   (Source : in out Sequence;
                    Index  : in Positive;
                    By     : in Element);
   
       function Slice
                   (Source : in Sequence;
                    Low    : in Positive;
                    High   : in Natural)
               return   Element_Array;
   
       function "=" (Left, Right : in Sequence)
               return Boolean;
   
       function "="
                   (Left  : in Element_Array;
                    Right : in Sequence)
               return  Boolean;
   
       function "="
                   (Left  : in Sequence;
                    Right : in Element_Array)
               return  Boolean;
   
       ----------------------
       -- Search functions --
       ----------------------
   
       function Index
                   (Source   : in Sequence;
                    Pattern  : in Element_Array;
                    Going    : in Direction := Forward)
               return     Natural;
   
       function Count
                   (Source  : in Sequence;
                    Pattern : in Element_Array)
               return    Natural;
   
       -----------------------------------------
       -- Sequence transformation subprograms --
       -----------------------------------------
   
       function Replace_Slice
                   (Source : in Sequence;
                    Low    : in Positive;
                    High   : in Natural;
                    By     : in Element_Array)
               return   Sequence;
   
       procedure Replace_Slice
                   (Source   : in out Sequence;
                    Low      : in Positive;
                    High     : in Natural;
                    By       : in Element_Array);
   
       function Insert
                   (Source   : in Sequence;
                    Before   : in Positive;
                    New_Item : in Element_Array)
               return     Sequence;
   
       procedure Insert
                   (Source   : in out Sequence;
                    Before   : in Positive;
                    New_Item : in Element_Array);
   
       function Overwrite
                   (Source   : in Sequence;
                    Position : in Positive;
                    New_Item : in Element_Array)
               return     Sequence;
   
       procedure Overwrite
                   (Source    : in out Sequence;
                    Position  : in Positive;
                    New_Item  : in Element_Array);
   
       function Delete
                   (Source  : in Sequence;
                    From    : in Positive;
                    Through : in Natural)
               return    Sequence;
   
       procedure Delete
                   (Source  : in out Sequence;
                    From    : in Positive;
                    Through : in Natural);
   
       -----------------------------------
       -- Sequence selector subprograms --
       -----------------------------------
   
       function Head
                   (Source : in Sequence;
                    Count  : in Natural;
                    Pad    : in Element)
               return   Sequence;
   
       procedure Head
                   (Source : in out Sequence;
                    Count  : in Natural;
                    Pad    : in Element);
   
       function Tail
                   (Source : in Sequence;
                    Count  : in Natural;
                    Pad    : in Element)
               return   Sequence;
   
       procedure Tail
                   (Source : in out Sequence;
                    Count  : in Natural;
                    Pad    : in Element);
   
       --------------------------------------
       -- Sequence constructor subprograms --
       --------------------------------------
   
       function "*"
                   (Left  : in Natural;
                    Right : in Element)
               return  Sequence;
   
       function "*"
                   (Left  : in Natural;
                    Right : in Element_Array)
               return  Sequence;
   
       function "*"
                   (Left  : in Natural;
                    Right : in Sequence)
               return  Sequence;
   
   
    private
   
       -- To get the sequence type to map to the C equivalent we use
       -- a large stically sized array type (to avoid dope vectors).
       -- The index checks should be suppressed and checking should
       -- be done by hand.
   
       subtype Fixed is Element_Array(1..Integer'Last);
       type Fixed_Access is access Fixed;
   
       type Sequence is
--        new Ada.Finalization.Controlled with
       record
          Maximum : Natural := 0;
          Length  : Natural := 0;
          Buffer  : Fixed_Access;
       end record;
   
       Null_Sequence : constant Sequence := (0, 0, null);
--                       (Ada.Finalization.Controlled with 0, 0, null);
   
    end Unbounded;


END Corba.Sequences;
