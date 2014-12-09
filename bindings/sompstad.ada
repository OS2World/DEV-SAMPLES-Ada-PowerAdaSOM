
-------------------------------------------------------------------------------
-- Emitted on: Tue Jun 24 05:06:49 1997
-- Emitted by: OC Systems SOM IDL to Ada95 Interface Stub Emitter.
-------------------------------------------------------------------------------

WITH SOM;
WITH Corba;  USE Corba;
WITH Corba.Object;
WITH SOM;
WITH System;

PACKAGE SOMPStatDef IS


   TYPE somp_stat IS
   RECORD
      st_dev : Corba.Unsigned_Long;
        
        -- ID of device containing a directory
        --   entry for this file.  File serial
        --   no + device ID uniquely identify
        --   the file within the system
      st_ino : Corba.Unsigned_Long;
        
        -- File serial number
      st_mode : Corba.Unsigned_Long;
        
        -- File mode; see #define's below
      st_nlink : Corba.Short;
        
        -- Number of links
      st_uid : Corba.Unsigned_Long;
        
        -- User ID of the file's owner
      st_gid : Corba.Unsigned_Long;
        
        -- Group ID of the file's group
      st_rdev : Corba.Unsigned_Long;
        
        -- ID of device
        --   This entry is defined only for
        --   character or block special files
      st_size : Corba.Long;
        
        -- File size in bytes
      st_atime : Corba.Long;
        
        -- Time of last access
      st_spare1 : Corba.Long;
      st_mtime : Corba.Long;
        
        -- Time of last data modification
      st_spare2 : Corba.Long;
      st_ctime : Corba.Long;
        
        -- Time of last file status change
      st_spare3 : Corba.Long;
        
        -- Time measured in seconds since
        --   00:00:00 GMT, Jan. 1, 1970
      st_blksize : Corba.Unsigned_Long;
        
        -- Optimal blocksize for file system
        --                                     i/o ops
      st_blocks : Corba.Unsigned_Long;
        
        -- Actual number of blocks allocated
        --                                     in DEV_BSIZE blocks
      st_vfstype : Corba.Unsigned_Long;
        
        -- Type of fs (see vnode.h)
      st_vfs : Corba.Unsigned_Long;
        
        -- Vfs number
      st_type : Corba.Unsigned_Long;
        
        -- Vnode type
   END RECORD;
   PRAGMA Preserve_Layout( somp_stat );

   SUBTYPE sompstat IS SOMPStatDef.somp_stat;

END SOMPStatDef; 



