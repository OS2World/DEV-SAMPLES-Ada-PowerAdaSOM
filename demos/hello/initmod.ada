------------------------------------------------------------------------------
-- This is the main routine which is used to "bind" the Ada shared module
--  containing your SOMObject implementations.  To customize this
--  routine for any other SOM Class implemented in Ada, simply perform
--  a global substitution of the Class name for "Hello" within this
--  file.

   procedure SOMInitModule;
   pragma Export (C, SOMInitModule,"SOMInitModule");

   with Som;
   with Hello_Impl;
   with System;
   procedure SOMInitModule is
      procedure AdaInit;
      pragma Interface( C, AdaInit );
   begin
      declare
         Dummy_Class:  SOM.SOMClassPtr;
      begin
         Dummy_Class := Hello_Impl.New_Class
            ( Hello_Impl.Major_Version, Hello_Impl.Minor_Version );
      end;
   end SOMInitModule;

