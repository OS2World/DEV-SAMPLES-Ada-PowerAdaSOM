
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:47 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMD IS


   Version_literal : CONSTANT standard.string 
                             := "1.0";
   Version : CONSTANT Corba.String 
                     := Version_literal(Version_literal'first)'address;

END SOMD; 



