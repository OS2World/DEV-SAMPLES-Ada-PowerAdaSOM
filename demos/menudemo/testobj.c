/*
 *   COMPONENT_NAME: somx
 *
 *   ORIGINS: 27
 *
 *
 *   10H9767, 10H9769  (C) COPYRIGHT International Business Machines Corp. 1992,1994
 *   All Rights Reserved
 *   Licensed Materials - Property of IBM
 *   US Government Users Restricted Rights - Use, duplication or
 *   disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */
/* @(#) somx/testobj.c 2.5 9/20/94 15:13:23 [10/20/94 10:54:26] */

/*
 *
 * DISCLAIMER OF WARRANTIES.
 * The following [enclosed] code is sample code created by IBM
 * Corporation. This sample code is not part of any standard or IBM
 * product and is provided to you solely for the purpose of assisting
 * you in the development of your applications.  The code is provided
 * "AS IS". IBM MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT
 * NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE, REGARDING THE FUNCTION OR PERFORMANCE OF
 * THIS CODE.  IBM shall not be liable for any damages arising out of
 * your use of the sample code, even if they have been advised of the
 * possibility of such damages.
 *
 * DISTRIBUTION.
 * This sample code can be freely distributed, copied, altered, and
 * incorporated into other software, provided that it bears the above
 * Copyright notice and DISCLAIMER intact.
 */

#include <stdlib.h>
#include <string.h>

#define REPTestObj_Class_Source
#include "testobj.ih"

char *myname = "TESTOBJ";                /* Name of the object.    */
extern long  value_logging;              /* Set in client program. */


void printError(Environment *ev)
{

  char *exId;
  StExcep *params;

   if (ev->_major != NO_EXCEPTION) {
      exId = somExceptionId(ev);
      params = somExceptionValue(ev);

      printf("Error Occurred\n");
      printf("exception string: %s\n", exId);
      printf("major error code: %u\n", ev->_major);
      printf("primary error code: %u\n", params->minor);
      printf("secondary error code: %u\n", params->completed);
      somExceptionFree(ev);
   }
 }


/*===========================================================================*
 *  Method:                                                                  *
 * Purpose: Relink object to its peers after it has been unlinked            *
 *          by RepblUninit                                                   *
 *===========================================================================*/

SOM_Scope void  SOMLINK somrPerformRepblInit(REPTestObj somSelf,
                                                Environment *ev)
{
long rc;

    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrPerformRepblInit");


    rc = _somrRepInit(somSelf,ev,  'o', 'w');   /* Replication Initialization (Writer) */
    if (ev->_major == NO_EXCEPTION) /* no error */
        somPrintf("Successfully initialized for replication. rc = %d\n", rc);
    else {
        somPrintf("Initialization for replication failed: rc= %d \n", rc);
        printError(ev);
    }
}


/*===========================================================================*
 *  Method: RepblUnInit                                                      *
 * Purpose: Unlink object from its peers.                                    *
 *===========================================================================*/

SOM_Scope void  SOMLINK somrPerformRepblUnInit(REPTestObj somSelf,
                                                Environment *ev)
{

    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrPerformRepblUnInit");

    _somrRepUninit(somSelf, ev);  /* unlink this replica from its peers */
           printError(ev);
}

/*===========================================================================*
 *  Method: Init                                                             *
 * Purpose: Object Initialization                                            *
 *===========================================================================*/

SOM_Scope void  SOMLINK somInit(REPTestObj somSelf)
{
   long rc;
   Environment *testobjEnv;


    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somInit");
    parent_SOMRReplicbl_somInit(somSelf);                          /* Initialize parent */
    _mydata = NULL;

    testobjEnv = SOM_CreateLocalEnvironment();        /* Create Environment */
    _somrSetObjName(somSelf, testobjEnv, myname);     /* Set the Name value */

}

/*===========================================================================*
 *  Method: SetData                                                          *
 * Purpose: Assign client-passed value to instance variable.                 *
 *===========================================================================*/

SOM_Scope long  SOMLINK somrTestSetData(REPTestObj somSelf,  Environment *ev,
                                        string s)
{

    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrTestSetData");

    if (_mydata) SOMFree(_mydata);  /* free up existing string */

    _mydata = (char*)malloc( strlen(s)+1 );
    if ( _mydata ) {

        if ( !value_logging ) {
           _somrLockNlogOp (somSelf, ev, "REPTestObj", "somrTestSetData", ev, s);
           if (ev->_major == NO_EXCEPTION) {
               strcpy( _mydata, s );
               _somrReleaseNPropagateOperation (somSelf, ev);
               return 0;
           }
           else {
           somPrintf("Set Data Failed: LockNlogOp was not successful\n");
           printError(ev);
	   return -1;
	   }
        }
        else {
            _somrLock( somSelf, ev );
           if (ev->_major == NO_EXCEPTION) {
               strcpy( _mydata, s );

               _somrReleaseNPropagateUpdate( somSelf, ev, "REPTestObj", _mydata, strlen(_mydata)+1, 0 );
               return 0;
           } /* endif */
           else  { 
           somPrintf("Set Data Failed: Lock was not successful\n");
           printError(ev);
	   return -1;
	   }
       }
    }
somPrintf("Set Data Failed: Unable to allocate memory\n");
return -1;
}


/*===========================================================================*
 *  Method: TestGetData                                                      *
 * Purpose: Return value of instance variable to client.                     *
 *===========================================================================*/

SOM_Scope string  SOMLINK somrTestGetData(REPTestObj somSelf,
                                           Environment *ev)
{
    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrTestGetData");
    return (char*) _mydata;
}


/*===========================================================================*
 *  Method: Uninit                                                           *
 * Purpose: Object destructor.                                               *
 *===========================================================================*/

SOM_Scope void  SOMLINK somUninit(REPTestObj somSelf)
{
    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somUninit");

    if(_mydata) SOMFree(_mydata);  /* free any memory occupied by this object. */

    parent_SOMRReplicbl_somUninit(somSelf);
}


/*===========================================================================*
 *  Method: DoDirective                                                      *
 * Purpose: Process directives from the replication framework.               *
 *===========================================================================*/

SOM_Scope void  SOMLINK somrDoDirective(REPTestObj somSelf, Environment *ev,
                string str)
{
    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrDoDirective");

    somPrintf("Directive: %s\n",str);
    parent_SOMRReplicbl_somrDoDirective(somSelf,ev, str);
}

/*===========================================================================*
 *  Method: ApplyUpdates                                                     *
 * Purpose: Propagate state changes when value logging is used.              *
 *===========================================================================*/

SOM_Scope void  SOMLINK somrApplyUpdates(REPTestObj somSelf, Environment *ev,
                string buf,
                long len,
                long ObjIntId)
{
    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug( "REPTestObj", "somrApplyUpdates" );


    if (_mydata) SOMFree(_mydata);
    _mydata = (char *)SOMMalloc(len);
    memcpy(_mydata,buf,len);
}

/*===========================================================================*
 *  Method: GetState                                                         *
 * Purpose: Publish current state of master to new shadow objects            *
 *===========================================================================*/

SOM_Scope void  SOMLINK somrGetState(REPTestObj somSelf, Environment *ev,
                string* buf)
{
    long bufsize;
    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrGetState");
    bufsize = strlen( _mydata ) + 1 + sizeof( long );
    *buf = SOMMalloc( bufsize );
    strcpy( (char*)(*buf + sizeof( long )), _mydata );
    memcpy( *buf, &bufsize, sizeof( long ) );
}

/*===========================================================================*
 *  Method: SetState                                                         *
 * Purpose: Initialize a shadow object with current state of master.         *
 *===========================================================================*/

SOM_Scope void  SOMLINK somrSetState(REPTestObj somSelf, Environment *ev,
                string buf)
{
long len;
    REPTestObjData *somThis = REPTestObjGetData(somSelf);
    REPTestObjMethodDebug("REPTestObj","somrSetState");
    if(_mydata) SOMFree(_mydata);
    len = *(long *)buf;
    buf += sizeof(long);
    _mydata = (char *)SOMMalloc(len -sizeof(long));
    memcpy(_mydata,buf,len-sizeof(long));
}
