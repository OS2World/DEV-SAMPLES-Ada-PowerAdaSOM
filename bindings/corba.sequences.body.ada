------------------------------------------------------------------------------
-- corba.sequences.body : Corba sequences -- PACAKGE BODY
------------------------------------------------------------------------------
------------------------------------------------------------------------------
-- RENAMES TO:  
------------------------------------------------------------------------------
-- Change Log
--------- ---
-- 95Dec20 swn Upgrade for new Corba type names.  (d2189)
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

WITH interfaces;
WITH unchecked_conversion;
WITH unchecked_deallocation;
WITH SOM;


PACKAGE BODY Corba.Sequences IS

   PRAGMA comment ("@(#) ada/runtime/som/corba.sequences.body, ada, power95.3 1.3 12/21/95 12:21:49");

   PACKAGE BODY bounded IS

      PRAGMA suppress (index_check, fixed);

      FUNCTION allocate (size : IN length_range)
         RETURN fixed_access
      IS
         SUBTYPE local_fixed IS element_array(1..integer(size));
         TYPE access_local_fixed IS ACCESS local_fixed;
         FUNCTION convert IS 
            NEW unchecked_conversion(access_local_fixed, fixed_access);
      BEGIN
         RETURN convert(NEW local_fixed);
      END allocate;


      PROCEDURE deallocate (seq : IN OUT sequence)
      IS
      BEGIN
         IF seq.maximum > 0 THEN
            DECLARE
               SUBTYPE local_fixed IS element_array(1..integer(seq.maximum));
               TYPE access_local_fixed IS ACCESS local_fixed;
               FUNCTION convert IS 
                  NEW unchecked_conversion(fixed_access, access_local_fixed);
               PROCEDURE free IS 
                  NEW unchecked_deallocation(local_fixed, access_local_fixed);
               buffer : access_local_fixed := convert(seq.buffer);
            BEGIN
               free(buffer);
               seq.buffer := NULL;
               seq.maximum := 0;
            END;
         END IF;
      END deallocate;


      PROCEDURE reallocate
         (seq : IN OUT sequence; size : IN length_range)
      IS
      BEGIN
         deallocate(seq);
         seq.maximum := size;
         seq.buffer := allocate(size);
      END reallocate;


      FUNCTION copy (seq : IN sequence)
         RETURN sequence
      IS
         result : sequence;
      BEGIN
         result.maximum    := seq.maximum;
         result.length     := seq.length;
         result.buffer     := allocate(seq.maximum);
         result.buffer.ALL := seq.buffer.ALL;
         RETURN result;
      END copy;

      
      PROCEDURE free (x : IN OUT element_array_access)
      IS
      BEGIN
         NULL;
      END free;
      
      
      ---------
      -- "=" --
      ---------

      FUNCTION "=" (left, right : IN sequence) RETURN boolean IS
      BEGIN
         RETURN left.length = right.length
           AND THEN left.buffer (1 .. left.length) =
                    right.buffer (1 .. right.length);
      END "=";

      FUNCTION "="  (left : IN sequence; right : IN element_array)
         RETURN boolean IS
      BEGIN
         RETURN left.length = right'length
           AND THEN left.buffer (1 .. left.length) = right (1 .. right'length);
      END "=";

      FUNCTION "="  (left : IN element_array; right : IN sequence)
         RETURN boolean IS
      BEGIN
         RETURN left'length = right.length
           AND THEN left (1 .. left'length) = right.buffer (1 .. right.length);
      END "=";

      ---------
      -- "*" --
      ---------

      FUNCTION "*"
        (left  : IN natural;
         right : IN element)
         RETURN  sequence
      IS
      BEGIN
         RETURN replicate (left, right, error);
      END "*";

      FUNCTION "*"
        (left  : IN natural;
         right : IN element_array)
         RETURN  sequence
      IS
      BEGIN
         RETURN replicate (left, right, error);
      END "*";

      FUNCTION "*"
        (left  : IN natural;
         right : IN sequence)
         RETURN  sequence
      IS
      BEGIN
         RETURN replicate (left, right, error);
      END "*";

      ---------
      -- "&" --
      ---------

      FUNCTION "&" (left, right : IN sequence)
         RETURN sequence IS
      BEGIN
         RETURN append (left, right, drop => error);
      END "&";

      FUNCTION "&" (left : IN sequence; right : IN element_array)
         RETURN sequence IS
      BEGIN
         RETURN append (left, right, drop => error);
      END "&";

      FUNCTION "&" (left : IN element_array; right : IN sequence)
         RETURN sequence IS
      BEGIN
         RETURN append (left, right, drop => error);
      END "&";

      FUNCTION "&" (left : IN sequence; right : IN element)
         RETURN sequence IS
      BEGIN
         RETURN append (left, right, drop => error);
      END "&";

      FUNCTION "&" (left : IN element; right : IN sequence)
         RETURN sequence IS
      BEGIN
         RETURN append (left, right, drop => error);
      END "&";

      ------------
      -- Append --
      ------------

      --  Case of Sequence and Sequence

      FUNCTION append
        (left, right : IN sequence;
         drop        : IN truncation  := error)
         RETURN        sequence
      IS
         result : sequence;
         llen   : CONSTANT length_range := left.length;
         rlen   : CONSTANT length_range := right.length;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF llen + rlen <= max_length THEN
            result.length := llen + rlen;
            result.buffer (1 .. llen) := left.buffer.ALL;
            result.buffer (llen + 1 .. llen + rlen) := right.buffer.ALL;

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN sequences.right =>
                  IF llen >= max_length THEN
                     result.buffer (1 .. max_length) :=
                       left.buffer (1 .. max_length);

                  ELSE
                     result.buffer (1 .. llen) := left.buffer.ALL;
                     result.buffer (llen + 1 .. max_length) :=
                       right.buffer (1 .. max_length - llen);
                  END IF;

               WHEN sequences.left =>
                  IF rlen >= max_length THEN
                     result.buffer (1 .. max_length) :=
                       right.buffer (rlen - (max_length - 1) .. rlen);

                  ELSE
                     result.buffer (1 .. max_length - rlen) :=
                       left.buffer (llen - (max_length - rlen + 1) .. llen);
                     result.buffer (max_length - rlen + 1 .. max_length) :=
                       right.buffer.ALL;
                  END IF;

               WHEN sequences.error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END append;

      PROCEDURE append
        (source   : IN OUT sequence;
         new_item : IN sequence;
         drop     : IN truncation  := error)
      IS
         llen   : CONSTANT length_range := source.length;
         rlen   : CONSTANT length_range := new_item.length;

      BEGIN
         IF llen + rlen <= max_length THEN
            source.length := llen + rlen;
            source.buffer (llen + 1 .. llen + rlen) := new_item.buffer.ALL;

         ELSE
            source.length := max_length;

            CASE drop IS
               WHEN right =>
                  IF llen < max_length THEN
                     source.buffer (llen + 1 .. max_length) :=
                       new_item.buffer (1 .. max_length - llen);
                  END IF;

               WHEN left =>
                  IF rlen >= max_length THEN
                     source.buffer (1 .. max_length) :=
                       new_item.buffer (rlen - (max_length - 1) .. rlen);

                  ELSE
                     source.buffer (1 .. max_length - rlen) :=
                       source.buffer (llen - (max_length - rlen + 1) .. llen);
                     source.buffer (max_length - rlen + 1 .. max_length) :=
                       new_item.buffer.ALL;
                  END IF;

               WHEN error =>
                  RAISE length_error;
            END CASE;
         END IF;

      END append;

      --  Case of Sequence and Element_Array

      FUNCTION append
        (left  : IN sequence;
         right : IN element_array;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
         result : sequence;
         llen   : CONSTANT length_range := left.length;
         rlen   : CONSTANT length_range := right'length;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF llen + rlen <= max_length THEN
            result.length := llen + rlen;
            result.buffer (1 .. llen) := left.buffer.ALL;
            result.buffer (llen + 1 .. llen + rlen) := right;

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN sequences.right =>
                  IF llen >= max_length THEN
                     result.buffer (1 .. max_length) :=
                       left.buffer (1 .. max_length);

                  ELSE
                     result.buffer (1 .. llen) := left.buffer.ALL;
                     result.buffer (llen + 1 .. max_length) :=
                       right (1 .. max_length - llen);
                  END IF;

               WHEN sequences.left =>
                  IF rlen >= max_length THEN
                     result.buffer (1 .. max_length) :=
                       right (rlen - (max_length - 1) .. rlen);

                  ELSE
                     result.buffer (1 .. max_length - rlen) :=
                       left.buffer (llen - (max_length - rlen + 1) .. llen);
                     result.buffer (max_length - rlen + 1 .. max_length) :=
                       right;
                  END IF;

               WHEN sequences.error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END append;

      PROCEDURE append
        (source   : IN OUT sequence;
         new_item : IN element_array;
         drop     : IN truncation  := error)
      IS
         llen   : CONSTANT length_range := source.length;
         rlen   : CONSTANT length_range := new_item'length;

      BEGIN
         IF llen + rlen <= max_length THEN
            source.length := llen + rlen;
            source.buffer (llen + 1 .. llen + rlen) := new_item;

         ELSE
            source.length := max_length;

            CASE drop IS
               WHEN right =>
                  IF llen < max_length THEN
                     source.buffer (llen + 1 .. max_length) :=
                       new_item (1 .. max_length - llen);
                  END IF;

               WHEN left =>
                  IF rlen >= max_length THEN
                     source.buffer (1 .. max_length) :=
                       new_item (rlen - (max_length - 1) .. rlen);

                  ELSE
                     source.buffer (1 .. max_length - rlen) :=
                       source.buffer (llen - (max_length - rlen + 1) .. llen);
                     source.buffer (max_length - rlen + 1 .. max_length) :=
                       new_item;
                  END IF;

               WHEN error =>
                  RAISE length_error;
            END CASE;
         END IF;

      END append;

      --  Case of Element_Array and Sequence

      FUNCTION append
        (left  : IN element_array;
         right : IN sequence;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
         result : sequence;
         llen   : CONSTANT length_range := left'length;
         rlen   : CONSTANT length_range := right.length;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF llen + rlen <= max_length THEN
            result.length := llen + rlen;
            result.buffer (1 .. llen) := left;
            result.buffer (llen + 1 .. llen + rlen) := right.buffer.ALL;

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN sequences.right =>
                  IF llen >= max_length THEN
                     result.buffer (1 .. max_length) := left (1 .. max_length);

                  ELSE
                     result.buffer (1 .. llen) := left;
                     result.buffer (llen + 1 .. max_length) :=
                       right.buffer (1 .. max_length - llen);
                  END IF;

               WHEN sequences.left =>
                  IF rlen >= max_length THEN
                     result.buffer (1 .. max_length) :=
                       right.buffer (rlen - (max_length - 1) .. rlen);

                  ELSE
                     result.buffer (1 .. max_length - rlen) :=
                       left (llen - (max_length - rlen + 1) .. llen);
                     result.buffer (max_length - rlen + 1 .. max_length) :=
                       right.buffer.ALL;
                  END IF;

               WHEN sequences.error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END append;

      --  Case of Sequence and Element

      FUNCTION append
        (left  : IN sequence;
         right : IN element;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
         result : sequence;
         llen   : CONSTANT length_range := left.length;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF llen  < max_length THEN
            result.length := llen + 1;
            result.buffer (1 .. llen) := left.buffer (1 .. llen);
            result.buffer (llen + 1) := right;

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN sequences.right =>
                  result.buffer := left.buffer;

               WHEN sequences.left =>
                  result.buffer (1 .. max_length - 1) :=
                    left.buffer (2 .. max_length);
                  result.buffer (max_length) := right;

               WHEN sequences.error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END append;

      PROCEDURE append
        (source   : IN OUT sequence;
         new_item : IN element;
         drop     : IN truncation  := error)
      IS
         llen   : CONSTANT length_range := source.length;

      BEGIN
         IF llen  < max_length THEN
            source.length := llen + 1;
            source.buffer (llen + 1) := new_item;

         ELSE
            source.length := max_length;

            CASE drop IS
               WHEN right =>
                  NULL;

               WHEN left =>
                  source.buffer (1 .. max_length - 1) :=
                    source.buffer (2 .. max_length);
                  source.buffer (max_length) := new_item;

               WHEN error =>
                  RAISE length_error;
            END CASE;
         END IF;

      END append;

      --  Case of Element and Sequence

      FUNCTION append
        (left  : IN element;
         right : IN sequence;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
         result : sequence;
         rlen   : CONSTANT length_range := right.length;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF rlen < max_length THEN
            result.length := rlen + 1;
            result.buffer (1) := left;
            result.buffer (2 .. rlen + 1) := right.buffer (1 .. rlen);

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN sequences.right =>
                  result.buffer (1) := left;
                  result.buffer (2 .. max_length) :=
                    right.buffer (1 .. max_length - 1);

               WHEN sequences.left =>
                  result.buffer (1 .. max_length) :=
                    right.buffer (rlen - (max_length - 1) .. rlen);

               WHEN sequences.error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END append;

      -----------
      -- Count --
      -----------

      FUNCTION count
        (source   : IN sequence;
         pattern  : IN element_array)
         RETURN natural
      IS
      BEGIN
         RETURN 0;
      END count;

      ------------
      -- Delete --
      ------------

      FUNCTION delete
        (source  : IN sequence;
         from    : IN positive;
         through : IN natural)
         RETURN    sequence
      IS
         slen       : CONSTANT natural := source.length;
         num_delete : CONSTANT integer := through - from + 1;
         result     : sequence;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF num_delete < 0 THEN
            result.length := slen;
            result.buffer (1 .. slen) := source.buffer (1 .. slen);

         ELSIF from > slen THEN
            RAISE index_error;

         ELSIF through >= slen THEN
            result.buffer (1 .. from - 1) := source.buffer (1 .. from - 1);
            result.length := from - 1;

         ELSE
            result.buffer (1 .. from - 1) := source.buffer (1 .. from - 1);
            result.length := slen - num_delete;
            result.buffer (from .. result.length) :=
              source.buffer (through + 1 .. slen);
         END IF;

         RETURN result;
      END delete;

      PROCEDURE delete
        (source  : IN OUT sequence;
         from    : IN positive;
         through : IN natural)
      IS
         slen       : CONSTANT natural := source.length;
         num_delete : CONSTANT integer := through - from + 1;

      BEGIN
         IF num_delete < 0 THEN
            RETURN;

         ELSIF from > slen THEN
            RAISE index_error;

         ELSIF through >= slen THEN
            source.length := from - 1;

         ELSE
            source.length := slen - num_delete;
            source.buffer (from .. source.length) :=
              source.buffer (through + 1 .. slen);
         END IF;
      END delete;

      -------------
      -- Element --
      -------------

      FUNCTION element_of
        (source : IN sequence;
         index  : IN positive)
         RETURN   element
      IS
      BEGIN
         IF index IN 1 .. source.length THEN
            RETURN source.buffer (index);
         ELSE
            RAISE index_error;
         END IF;
      END element_of;

      ----------
      -- Head --
      ----------

      FUNCTION head
        (source : IN sequence;
         count  : IN natural;
         pad    : IN element;
         drop   : IN truncation := error)
         RETURN   sequence
      IS
         result : sequence;
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF npad <= 0 THEN
            result.length := count;
            result.buffer (1 .. count) := source.buffer (1 .. count);

         ELSIF count <= max_length THEN
            result.length := count;
            result.buffer (1 .. slen) := source.buffer (1 .. slen);
            result.buffer (slen + 1 .. count) := (OTHERS => pad);

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN right =>
                  result.buffer (1 .. slen) := source.buffer (1 .. slen);
                  result.buffer (slen + 1 .. max_length) := (OTHERS => pad);

               WHEN left =>
                  IF npad > max_length THEN
                     result.buffer.ALL := (OTHERS => pad);

                  ELSE
                     result.buffer (1 .. max_length - npad) :=
                       source.buffer (count - max_length + 1 .. slen);
                     result.buffer (max_length - npad + 1 .. max_length) :=
                       (OTHERS => pad);
                  END IF;

               WHEN error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END head;

      PROCEDURE head
        (source : IN OUT sequence;
         count  : IN natural;
         pad    : IN element;
         drop   : IN truncation := error)
      IS
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;
         temp   : sequence;

      BEGIN
         temp.maximum    := max;
         temp.buffer     := allocate(max);
         temp.length := slen;
         temp.buffer (1 .. slen) := source.buffer (1 .. slen);
         IF npad <= 0 THEN
            source.length := count;

         ELSIF count <= max_length THEN
            source.length := count;
            source.buffer (slen + 1 .. count) := (OTHERS => pad);

         ELSE
            source.length := max_length;

            CASE drop IS
               WHEN right =>
                  source.buffer (slen + 1 .. max_length) := (OTHERS => pad);

               WHEN left =>
                  IF npad > max_length THEN
                     source.buffer.ALL := (OTHERS => pad);

                  ELSE
                     source.buffer (1 .. max_length - npad) :=
                       temp.buffer (count - max_length + 1 .. slen);
                     source.buffer (max_length - npad + 1 .. max_length) :=
                       (OTHERS => pad);
                  END IF;

               WHEN error =>
                  deallocate(temp);
                  RAISE length_error;
            END CASE;
         END IF;

         deallocate(temp);
      END head;

      -----------
      -- Index --
      -----------

      FUNCTION index
        (source  : IN sequence;
         pattern : IN element_array;
         going   : IN direction  := forward)
         RETURN   natural
      IS
      BEGIN
         RETURN 0;
      END index;

      ------------
      -- Insert --
      ------------

      FUNCTION insert
        (source   : IN sequence;
         before   : IN positive;
         new_item : IN element_array;
         drop     : IN truncation := error)
         RETURN     sequence
      IS
         slen    : CONSTANT natural := source.length;
         nlen    : CONSTANT natural := new_item'length;
         tlen    : CONSTANT natural := slen + nlen;
         blen    : CONSTANT natural := before - 1;
         alen    : CONSTANT integer := slen - blen;
         droplen : CONSTANT integer := tlen - max_length;
         result  : sequence;

         --  Tlen is the length of the total Element_Array before possible truncation.
         --  Blen, Alen are the lengths of the before and after pieces of the
         --  source Element_Array.

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF alen < 0 THEN
            RAISE index_error;

         ELSIF droplen <= 0 THEN
            result.length := tlen;
            result.buffer (1 .. blen) := source.buffer (1 .. blen);
            result.buffer (before .. before + nlen - 1) := new_item;
            result.buffer (before + nlen .. tlen) :=
              source.buffer (before .. slen);

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN right =>
                  result.buffer (1 .. blen) := source.buffer (1 .. blen);

                  IF droplen > alen THEN
                     result.buffer (before .. max_length) :=
                       new_item (new_item'first
                                   .. new_item'first + max_length - before);
                  ELSE
                     result.buffer (before .. before + nlen - 1) := new_item;
                     result.buffer (before + nlen .. max_length) :=
                       source.buffer (before .. slen - droplen);
                  END IF;

               WHEN left =>
                  result.buffer (max_length - (alen - 1) .. max_length) :=
                    source.buffer (before .. slen);

                  IF droplen >= blen THEN
                     result.buffer (1 .. max_length - alen) :=
                       new_item (new_item'last - (max_length - alen) + 1
                                   .. new_item'last);
                  ELSE
                     result.buffer
                       (blen - droplen + 1 .. max_length - alen) :=
                         new_item;
                     result.buffer (1 .. blen - droplen) :=
                       source.buffer (droplen + 1 .. blen);
                  END IF;

               WHEN error =>
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END insert;

      PROCEDURE insert
        (source   : IN OUT sequence;
         before   : IN positive;
         new_item : IN element_array;
         drop     : IN truncation := error)
      IS
      BEGIN
         source := insert (source, before, new_item, drop);
      END insert;

      ------------
      -- Length --
      ------------

      FUNCTION length (source : IN sequence) RETURN length_range IS
      BEGIN
         RETURN source.length;
      END length;

      ---------------
      -- Overwrite --
      ---------------

      FUNCTION overwrite
        (source    : IN sequence;
         position  : IN positive;
         new_item  : IN element_array;
         drop      : IN truncation := error)
         RETURN      sequence
      IS
         result  : sequence;
         endpos  : CONSTANT positive := position + new_item'length - 1;
         slen    : CONSTANT natural  := source.length;
         droplen : natural;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF endpos <= slen THEN
            result.buffer (1 .. position - 1) := source.buffer (1 .. position - 1);
            result.buffer (position .. endpos) := new_item;
            result.length := source.length;

         ELSIF endpos <= max_length THEN
            result.buffer (1 .. position - 1) := source.buffer (1 .. position - 1);
            result.buffer (position .. endpos) := new_item;
            result.length := endpos;

         ELSE
            result.length := max_length;
            droplen := endpos - max_length;

            CASE drop IS
               WHEN right =>
                  result.buffer (1 .. position - 1) :=
                    source.buffer (1 .. position - 1);
                  result.buffer (position .. max_length) :=
                    new_item (new_item'first .. new_item'last - droplen);

               WHEN left =>
                  IF new_item'length > max_length THEN
                     result.buffer (1 .. max_length) :=
                        new_item (new_item'last - max_length + 1 ..
                                  new_item'last);

                  ELSE
                     result.buffer (1 .. max_length - new_item'length) :=
                       source.buffer (droplen + 1 .. position - 1);
                     result.buffer
                       (max_length - new_item'length + 1 .. max_length) :=
                         new_item;
                  END IF;

               WHEN error =>
                  deallocate(result);
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END overwrite;

      PROCEDURE overwrite
        (source    : IN OUT sequence;
         position  : IN positive;
         new_item  : IN element_array;
         drop      : IN truncation := error)
      IS
         endpos  : CONSTANT positive := position + new_item'length - 1;
         slen    : CONSTANT natural  := source.length;
         droplen : natural;

      BEGIN
         IF endpos <= slen THEN
            source.buffer (position .. endpos) := new_item;

         ELSIF endpos <= max_length THEN
            source.buffer (position .. endpos) := new_item;
            source.length := endpos;

         ELSE
            source.length := max_length;
            droplen := endpos - max_length;

            CASE drop IS
               WHEN right =>
                  source.buffer (position .. max_length) :=
                    new_item (new_item'first .. new_item'last - droplen);

               WHEN left =>
                  IF new_item'length > max_length THEN
                     source.buffer (1 .. max_length) :=
                        new_item (new_item'last - max_length + 1 ..
                                  new_item'last);

                  ELSE
                     source.buffer (1 .. max_length - new_item'length) :=
                       source.buffer (droplen + 1 .. position - 1);
                     source.buffer
                       (max_length - new_item'length + 1 .. max_length) :=
                         new_item;
                  END IF;

               WHEN error =>
                  RAISE length_error;
            END CASE;
         END IF;
      END overwrite;

      ---------------------
      -- Replace_Element --
      ---------------------

      PROCEDURE replace_element
        (source : IN OUT sequence;
         index  : IN positive;
         by     : IN element)
      IS
      BEGIN
         IF index <= source.length THEN
            source.buffer (index) := by;
         ELSE
            RAISE index_error;
         END IF;
      END replace_element;

      -------------------
      -- Replace_Slice --
      -------------------

      FUNCTION replace_slice
        (source   : IN sequence;
         low      : IN positive;
         high     : IN natural;
         by       : IN element_array;
         drop     : IN truncation := error)
         RETURN     sequence
      IS
         slen : CONSTANT natural := source.length;

      BEGIN
         IF low > slen + 1 THEN
            RAISE index_error;

         ELSIF high < low THEN
            RETURN insert (source, low, by, drop);

         ELSE
            DECLARE
               blen    : CONSTANT natural := low - 1;
               alen    : CONSTANT natural := slen - high;
               tlen    : CONSTANT natural := blen + by'length + alen;
               droplen : CONSTANT integer := tlen - max_length;
               result  : sequence;

               --  Tlen is the total length of the result Element_Array before any
               --  truncation. Blen and Alen are the lengths of the pieces
               --  of the original Element_Array that end up in the result Element_Array
               --  before and after the replaced slice.

            BEGIN
               result.maximum    := max;
               result.length     := 0;
               result.buffer     := allocate(max);
               IF droplen <= 0 THEN
                  result.length := tlen;
                  result.buffer (1 .. blen) := source.buffer (1 .. blen);
                  result.buffer (low .. low + by'length - 1) := by;
                  result.buffer (low + by'length .. tlen) :=
                    source.buffer (high + 1 .. slen);

               ELSE
                  result.length := max_length;

                  CASE drop IS
                     WHEN right =>
                        result.buffer (1 .. blen) := source.buffer (1 .. blen);

                        IF droplen > alen THEN
                           result.buffer (low .. max_length) :=
                             by (by'first .. by'first + max_length - low);
                        ELSE
                           result.buffer (low .. low + by'length - 1) := by;
                           result.buffer (low + by'length .. max_length) :=
                             source.buffer (high + 1 .. slen - droplen);
                        END IF;

                     WHEN left =>
                        result.buffer (max_length - (alen - 1) .. max_length) :=
                          source.buffer (high + 1 .. slen);

                        IF droplen >= blen THEN
                           result.buffer (1 .. max_length - alen) :=
                             by (by'last - (max_length - alen) + 1 .. by'last);
                        ELSE
                           result.buffer
                             (blen - droplen + 1 .. max_length - alen) := by;
                           result.buffer (1 .. blen - droplen) :=
                             source.buffer (droplen + 1 .. blen);
                        END IF;

                     WHEN error =>
                        deallocate(result);
                        RAISE length_error;
                  END CASE;
               END IF;

               RETURN result;
            END;
         END IF;
      END replace_slice;

      PROCEDURE replace_slice
        (source   : IN OUT sequence;
         low      : IN positive;
         high     : IN natural;
         by       : IN element_array;
         drop     : IN truncation := error)
      IS
      BEGIN
         source := replace_slice (source, low, high, by, drop);
      END replace_slice;

      ---------------
      -- Replicate --
      ---------------

      FUNCTION replicate
        (count : IN natural;
         item  : IN element;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
         result : sequence;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF count <= max_length THEN
            result.length := count;

         ELSIF drop = error THEN
            RAISE length_error;

         ELSE
            result.length := max_length;
         END IF;

         result.buffer (1 .. result.length) := (OTHERS => item);
         RETURN result;
      END replicate;

      FUNCTION replicate
        (count : IN natural;
         item  : IN element_array;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
         length : CONSTANT integer := count * item'length;
         result : sequence;
         indx   : positive;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF length <= max_length THEN
            result.length := length;
            indx := 1;

            FOR j IN 1 .. count LOOP
               result.buffer (indx .. indx + item'length - 1) := item;
               indx := indx + item'length;
            END LOOP;

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN right =>
                  indx := 1;

                  WHILE indx + item'length <= max_length + 1 LOOP
                     result.buffer (indx .. indx + item'length - 1) := item;
                     indx := indx + item'length;
                  END LOOP;

                  result.buffer (indx .. max_length) :=
                    item (1 .. max_length - indx + 1);

               WHEN left =>
                  indx := max_length;

                  WHILE indx - item'length >= 1 LOOP
                     result.buffer (indx - (item'length - 1) .. indx) := item;
                     indx := indx - item'length;
                  END LOOP;

                  result.buffer (1 .. indx) :=
                    item (item'last - indx + 1 .. item'last);

               WHEN error =>
                  deallocate(result);
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END replicate;

      FUNCTION replicate
        (count : IN natural;
         item  : IN sequence;
         drop  : IN truncation := error)
         RETURN  sequence
      IS
      BEGIN
         RETURN replicate (count, item.buffer (1 .. item.length), drop);
      END replicate;

      -----------
      -- Slice --
      -----------

      FUNCTION slice
        (source : IN sequence;
         low    : IN positive;
         high   : IN natural)
         RETURN   element_array IS
      BEGIN
         RETURN source.buffer (low .. high);

      EXCEPTION
         WHEN constraint_error =>
            RAISE index_error;
      END slice;

      ----------
      -- Tail --
      ----------

      FUNCTION tail
        (source : IN sequence;
         count  : IN natural;
         pad    : IN element;
         drop   : IN truncation := error)
         RETURN   sequence
      IS
         result : sequence;
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF npad <= 0 THEN
            result.length := count;
            result.buffer (1 .. count) :=
              source.buffer (slen - (count - 1) .. slen);

         ELSIF count <= max_length THEN
            result.length := count;
            result.buffer (1 .. npad) := (OTHERS => pad);
            result.buffer (npad + 1 .. count) := source.buffer (1 .. slen);

         ELSE
            result.length := max_length;

            CASE drop IS
               WHEN right =>
                  IF npad > max_length THEN
                     result.buffer.ALL := (OTHERS => pad);

                  ELSE
                     result.buffer (1 .. npad) := (OTHERS => pad);
                     result.buffer (npad + 1 .. max_length) :=
                       source.buffer (1 .. max_length - npad);
                  END IF;

               WHEN left =>
                  result.buffer (1 .. max_length - slen) := (OTHERS => pad);
                  result.buffer (max_length - slen + 1 .. max_length) :=
                    source.buffer (1 .. slen);

               WHEN error =>
                  deallocate(result);
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END tail;

      PROCEDURE tail
        (source : IN OUT sequence;
         count  : IN natural;
         pad    : IN element;
         drop   : IN truncation := error)
      IS
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;
         temp   : sequence;

      BEGIN
         temp.maximum    := max;
         temp.buffer     := allocate(max);
         temp.length := slen;
         temp.buffer (1 .. slen) := source.buffer (1 .. slen);
         IF npad <= 0 THEN
            source.length := count;
            source.buffer (1 .. count) :=
              temp.buffer (slen - (count - 1) .. slen);

         ELSIF count <= max_length THEN
            source.length := count;
            source.buffer (1 .. npad) := (OTHERS => pad);
            source.buffer (npad + 1 .. count) := temp.buffer (1 .. slen);

         ELSE
            source.length := max_length;

            CASE drop IS
               WHEN right =>
                  IF npad > max_length THEN
                     source.buffer.ALL := (OTHERS => pad);

                  ELSE
                     source.buffer (1 .. npad) := (OTHERS => pad);
                     source.buffer (npad + 1 .. max_length) :=
                       temp.buffer (1 .. max_length - npad);
                  END IF;

               WHEN left =>
                  source.buffer (1 .. max_length - slen) := (OTHERS => pad);
                  source.buffer (max_length - slen + 1 .. max_length) :=
                    temp.buffer (1 .. slen);

               WHEN error =>
                  deallocate(temp);
                  RAISE length_error;
            END CASE;
         END IF;

         deallocate(temp);
      END tail;

      -----------------
      -- To_Sequence --
      -----------------

      FUNCTION to_sequence
        (source : IN element_array;
         drop   : IN truncation := error)
         RETURN   sequence
      IS
         slen   : CONSTANT length_range := source'length;
         result : sequence;

      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         IF slen <= max_length THEN
            result.length := slen;
            result.buffer (1 .. slen) := source;

         ELSE
            CASE drop IS
               WHEN right =>
                  result.length := max_length;
                  result.buffer (1 .. max_length) := source (1 .. max_length);

               WHEN left =>
                  result.length := max_length;
                  result.buffer (1 .. max_length) :=
                    source (slen - (max_length - 1) .. slen);

               WHEN error =>
                  deallocate(result);
                  RAISE length_error;
            END CASE;
         END IF;

         RETURN result;
      END to_sequence;

      FUNCTION to_sequence
        (length : IN length_range)
         RETURN   sequence
      IS
         result : sequence;
      BEGIN
         result.maximum    := max;
         result.length     := 0;
         result.buffer     := allocate(max);
         RETURN result;
      END to_sequence;

      ----------------------
      -- To_Element_Array --
      ----------------------

      FUNCTION to_element_array (source : IN sequence) RETURN element_array IS
      BEGIN
         RETURN source.buffer (1 .. source.length);
      END to_element_array;

   END bounded;


   PACKAGE BODY unbounded IS

      PRAGMA suppress (index_check, fixed);


      FUNCTION allocate (size : IN natural)
         RETURN fixed_access
      IS
         SUBTYPE local_fixed IS element_array(1..integer(size));
         TYPE access_local_fixed IS ACCESS local_fixed;
         FUNCTION convert IS 
            NEW unchecked_conversion(access_local_fixed, fixed_access);
      BEGIN
         RETURN convert(NEW local_fixed);
      END allocate;


      PROCEDURE deallocate (seq : IN OUT sequence)
      IS
      BEGIN
         IF seq.maximum > 0 THEN
            DECLARE
               SUBTYPE local_fixed IS element_array(1..integer(seq.maximum));
               TYPE access_local_fixed IS ACCESS local_fixed;
               FUNCTION convert IS 
                  NEW unchecked_conversion(fixed_access, access_local_fixed);
               PROCEDURE free IS 
                  NEW unchecked_deallocation(local_fixed, access_local_fixed);
               buffer : access_local_fixed := convert(seq.buffer);
            BEGIN
               free(buffer);
               seq.buffer := NULL;
               seq.maximum := 0;
            END;
         END IF;
      END deallocate;


      PROCEDURE reallocate (seq : IN OUT sequence; size : IN natural)
      IS
      BEGIN
         deallocate(seq);
         seq.maximum := size;
         seq.buffer := allocate(size);
      END reallocate;


      FUNCTION copy (seq : IN sequence)
         RETURN sequence
      IS
         result : sequence;
      BEGIN
         result.maximum := seq.maximum;
         result.length  := seq.length;
         result.buffer  := allocate(seq.maximum);
         result.buffer(result.buffer'first..result.buffer'first+seq.length-1) 
            := to_element_array(seq);
         RETURN result;
      END copy;


      PROCEDURE free (x : IN OUT element_array_access)
      IS
      BEGIN
         NULL;
      END free;
      
      ------------
      -- Length --
      ------------

      FUNCTION length (source : IN sequence) RETURN natural IS
      BEGIN
         RETURN source.length;
      END length;

      -----------------
      -- To_Sequence --
      -----------------

      FUNCTION to_sequence
        (source : IN element_array)
         RETURN   sequence
      IS
         slen   : CONSTANT natural := source'length;
         result : sequence;

      BEGIN
         result.maximum := slen;
         result.length  := slen;
         result.buffer  := allocate(slen);
         result.buffer (1 .. slen) := source;

         RETURN result;
      END to_sequence;

      FUNCTION to_sequence
        (length : IN natural)
         RETURN   sequence
      IS
         result : sequence;
      BEGIN
         result.maximum := length;
         result.length  := length;
         result.buffer  := allocate(length);
         RETURN result;
      END to_sequence;

      ----------------------
      -- To_Element_Array --
      ----------------------

      FUNCTION to_element_array (source : IN sequence) RETURN element_array IS
      BEGIN
         RETURN source.buffer (1 .. source.length);
      END to_element_array;

      ---------
      -- "&" --
      ---------

      FUNCTION "&" (left, right : IN sequence)
         RETURN sequence 
      IS
         result : sequence := copy(left);
      BEGIN
         append (result, right);
         RETURN result;
      END "&";

      FUNCTION "&" (left : IN sequence; right : IN element_array)
         RETURN sequence 
      IS
         result : sequence := copy(left);
      BEGIN
         append (result, right);
         RETURN result;
      END "&";

      FUNCTION "&" (left : IN element_array; right : IN sequence)
         RETURN sequence 
      IS
         result : sequence := to_sequence(left);
      BEGIN
         append (result, right);
         RETURN result;
      END "&";

      FUNCTION "&" (left : IN sequence; right : IN element)
         RETURN sequence 
      IS
         result : sequence := copy(left);
      BEGIN
         append (result, right);
         RETURN result;
      END "&";

      FUNCTION "&" (left : IN element; right : IN sequence)
         RETURN sequence
      IS
         result : sequence := to_sequence(element_array'(1=>left));
      BEGIN
         append (result, right);
         RETURN result;
      END "&";

      ------------
      -- Append --
      ------------

      PROCEDURE append
        (source   : IN OUT sequence;
         new_item : IN element)
      IS
         temp : element_array(1..source.length + 1) 
            := to_element_array(source) & new_item;
      BEGIN
         reallocate(source, temp'length);
         source.buffer(source.buffer'first..source.buffer'first+temp'length-1)
             := temp;
      END append;

      PROCEDURE append
        (source   : IN OUT sequence;
         new_item : IN element_array)
      IS
         temp : element_array(1..source.length + new_item'length)
            := to_element_array(source) & new_item;
      BEGIN
         reallocate(source, temp'length);
         source.buffer(source.buffer'first..source.buffer'first+temp'length-1)
             := temp;
      END append;

      PROCEDURE append
        (source   : IN OUT sequence;
         new_item : IN sequence)
      IS
         temp : element_array(1..source.length + new_item.length)
            := to_element_array(source) & to_element_array(new_item);
      BEGIN
         reallocate(source, temp'length);
         source.buffer(source.buffer'first..source.buffer'first+temp'length-1)
             := temp;
      END append;


      -------------
      -- Element --
      -------------

      FUNCTION element_of
        (source : IN sequence;
         index  : IN positive)
         RETURN   element
      IS
      BEGIN
         IF index IN 1 .. source.length THEN
            RETURN source.buffer (index);
         ELSE
            RAISE index_error;
         END IF;
      END element_of;

      ---------------------
      -- Replace_Element --
      ---------------------

      PROCEDURE replace_element
        (source : IN OUT sequence;
         index  : IN positive;
         by     : IN element)
      IS
      BEGIN
         IF index <= source.length THEN
            source.buffer (index) := by;
         ELSE
            RAISE index_error;
         END IF;
      END replace_element;

      -----------
      -- Slice --
      -----------

      FUNCTION slice
        (source : IN sequence;
         low    : IN positive;
         high   : IN natural)
         RETURN   element_array IS
      BEGIN
         RETURN source.buffer (low .. high);

      EXCEPTION
         WHEN constraint_error =>
            RAISE index_error;
      END slice;

      ---------
      -- "=" --
      ---------

      FUNCTION "=" (left, right : IN sequence) RETURN boolean IS
      BEGIN
         RETURN left.length = right.length
           AND THEN left.buffer (1 .. left.length) =
                    right.buffer (1 .. right.length);
      END "=";

      FUNCTION "="  (left : IN sequence; right : IN element_array)
         RETURN boolean IS
      BEGIN
         RETURN left.length = right'length
           AND THEN left.buffer (1 .. left.length) = right (1 .. right'length);
      END "=";

      FUNCTION "="  (left : IN element_array; right : IN sequence)
         RETURN boolean IS
      BEGIN
         RETURN left'length = right.length
           AND THEN left (1 .. left'length) = right.buffer (1 .. right.length);
      END "=";

      -----------
      -- Index --
      -----------

      FUNCTION index
        (source  : IN sequence;
         pattern : IN element_array;
         going   : IN direction  := forward)
         RETURN   natural
      IS
      BEGIN
         RETURN 0;
      END index;

      -----------
      -- Count --
      -----------

      FUNCTION count
        (source   : IN sequence;
         pattern  : IN element_array)
         RETURN natural
      IS
      BEGIN
         RETURN 0;
      END count;

      -------------------
      -- Replace_Slice --
      -------------------

      FUNCTION replace_slice
        (source   : IN sequence;
         low      : IN positive;
         high     : IN natural;
         by       : IN element_array)
         RETURN     sequence
      IS
         slen : CONSTANT natural := source.length;

      BEGIN
         IF low > slen + 1 THEN
            RAISE index_error;

         ELSIF high < low THEN
            RETURN insert (source, low, by);

         ELSE
            DECLARE
               blen    : CONSTANT natural := low - 1;
               alen    : CONSTANT natural := slen - high;
               tlen    : CONSTANT natural := blen + by'length + alen;
               result  : sequence;

               --  Tlen is the total length of the result Element_Array.
               --  Blen and Alen are the lengths of the pieces
               --  of the original Element_Array that end up in the result
               --  Element_Array before and after the replaced slice.

            BEGIN
               result.maximum := tlen;
               result.length  := tlen;
               result.buffer  := allocate(tlen);
               result.buffer (1 .. blen) := source.buffer (1 .. blen);
               result.buffer (low .. low + by'length - 1) := by;
               result.buffer (low + by'length .. tlen) :=
                    source.buffer (high + 1 .. slen);

               RETURN result;
            END;
         END IF;
      END replace_slice;

      PROCEDURE replace_slice
        (source   : IN OUT sequence;
         low      : IN positive;
         high     : IN natural;
         by       : IN element_array)
      IS
      BEGIN
         source := replace_slice (source, low, high, by);
      END replace_slice;

      ------------
      -- Insert --
      ------------

      FUNCTION insert
        (source   : IN sequence;
         before   : IN positive;
         new_item : IN element_array)
         RETURN     sequence
      IS
         slen    : CONSTANT natural := source.length;
         nlen    : CONSTANT natural := new_item'length;
         tlen    : CONSTANT natural := slen + nlen;
         blen    : CONSTANT natural := before - 1;
         alen    : CONSTANT integer := slen - blen;
         result  : sequence;

         --  Tlen is the length of the total Element_Array.
         --  Blen, Alen are the lengths of the before and after pieces of the
         --  source Element_Array.

      BEGIN
         IF alen < 0 THEN
            RAISE index_error;

         ELSE
            result.length := tlen;
            result.buffer (1 .. blen) := source.buffer (1 .. blen);
            result.buffer (before .. before + nlen - 1) := new_item;
            result.buffer (before + nlen .. tlen) :=
              source.buffer (before .. slen);
         END IF;

         RETURN result;
      END insert;

      PROCEDURE insert
        (source   : IN OUT sequence;
         before   : IN positive;
         new_item : IN element_array)
      IS
      BEGIN
         source := insert (source, before, new_item);
      END insert;

      ---------------
      -- Overwrite --
      ---------------

      FUNCTION overwrite
        (source    : IN sequence;
         position  : IN positive;
         new_item  : IN element_array)
         RETURN      sequence
      IS
         result  : sequence;
         endpos  : CONSTANT positive := position + new_item'length - 1;
         slen    : CONSTANT natural  := source.length;

      BEGIN
         IF endpos <= slen THEN
            result.buffer (1 .. position - 1) := source.buffer (1 .. position - 1);
            result.buffer (position .. endpos) := new_item;
            result.length := source.length;

         ELSE
            result.buffer (1 .. position - 1) := source.buffer (1 .. position - 1);
            result.buffer (position .. endpos) := new_item;
            result.length := endpos;

         END IF;

         RETURN result;
      END overwrite;

      PROCEDURE overwrite
        (source    : IN OUT sequence;
         position  : IN positive;
         new_item  : IN element_array)
      IS
         endpos  : CONSTANT positive := position + new_item'length - 1;
         slen    : CONSTANT natural  := source.length;

      BEGIN
         IF endpos <= slen THEN
            source.buffer (position .. endpos) := new_item;

         ELSE
            source.buffer (position .. endpos) := new_item;
            source.length := endpos;

         END IF;
      END overwrite;

      ------------
      -- Delete --
      ------------

      FUNCTION delete
        (source  : IN sequence;
         from    : IN positive;
         through : IN natural)
         RETURN    sequence
      IS
         slen       : CONSTANT natural := source.length;
         num_delete : CONSTANT integer := through - from + 1;
         result     : sequence;

      BEGIN
         RETURN result;
      END delete;

      PROCEDURE delete
        (source  : IN OUT sequence;
         from    : IN positive;
         through : IN natural)
      IS
         slen       : CONSTANT natural := source.length;
         num_delete : CONSTANT integer := through - from + 1;

      BEGIN
         NULL;
      END delete;

      ----------
      -- Head --
      ----------

      FUNCTION head
        (source : IN sequence;
         count  : IN natural;
         pad    : IN element)
         RETURN   sequence
      IS
         result : sequence;
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;

      BEGIN
         IF npad <= 0 THEN
            result.length := count;
            result.buffer (1 .. count) := source.buffer (1 .. count);

         ELSE
            result.length := count;
            result.buffer (1 .. slen) := source.buffer (1 .. slen);
            result.buffer (slen + 1 .. count) := (OTHERS => pad);

         END IF;

         RETURN result;
      END head;

      PROCEDURE head
        (source : IN OUT sequence;
         count  : IN natural;
         pad    : IN element)
      IS
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;
         temp   : sequence;

      BEGIN
         temp.length := slen;
         temp.buffer (1 .. slen) := source.buffer (1 .. slen);
         IF npad <= 0 THEN
            source.length := count;

         ELSE
            source.length := count;
            source.buffer (slen + 1 .. count) := (OTHERS => pad);

         END IF;

      END head;

      ----------
      -- Tail --
      ----------

      FUNCTION tail
        (source : IN sequence;
         count  : IN natural;
         pad    : IN element)
         RETURN   sequence
      IS
         result : sequence;
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;

      BEGIN
         IF npad <= 0 THEN
            result.length := count;
            result.buffer (1 .. count) :=
              source.buffer (slen - (count - 1) .. slen);

         ELSE
            result.length := count;
            result.buffer (1 .. npad) := (OTHERS => pad);
            result.buffer (npad + 1 .. count) := source.buffer (1 .. slen);

         END IF;

         RETURN result;
      END tail;

      PROCEDURE tail
        (source : IN OUT sequence;
         count  : IN natural;
         pad    : IN element)
      IS
         slen   : CONSTANT natural := source.length;
         npad   : CONSTANT integer := count - slen;
         temp   : sequence;

      BEGIN
         temp.length := slen;
         temp.buffer (1 .. slen) := source.buffer (1 .. slen);
         IF npad <= 0 THEN
            source.length := count;
            source.buffer (1 .. count) :=
              temp.buffer (slen - (count - 1) .. slen);

         ELSE
            source.length := count;
            source.buffer (1 .. npad) := (OTHERS => pad);
            source.buffer (npad + 1 .. count) := temp.buffer (1 .. slen);

         END IF;

      END tail;

      ---------
      -- "*" --
      ---------

      FUNCTION "*"
        (left  : IN natural;
         right : IN element)
         RETURN  sequence
      IS
         result : sequence;
      BEGIN
         result.length := left;
         result.buffer (1 .. result.length) := (OTHERS => right);
         RETURN result;
      END "*";

      FUNCTION "*"
        (left  : IN natural;
         right : IN element_array)
         RETURN  sequence
      IS
         length : CONSTANT integer := left * right'length;
         result : sequence;
         indx   : positive;
      BEGIN
         result.length := length;
         indx := 1;

         FOR j IN 1 .. left LOOP
            result.buffer (indx .. indx + right'length - 1) := right;
            indx := indx + right'length;
         END LOOP;

         RETURN result;
      END "*";

      FUNCTION "*"
        (left  : IN natural;
         right : IN sequence)
         RETURN  sequence
      IS
      BEGIN
         RETURN "*" (left, right.buffer.ALL(1..right.maximum));
      END "*";

   END unbounded;


END Corba.Sequences;
