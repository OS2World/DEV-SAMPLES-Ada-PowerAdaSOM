/* @(#) somx/tablet.c 2.2 6/2/93 00:37:19 [6/9/93 16:17:50] */

/*
 * 96F8647, 96F8648 (C) Copyright IBM Corp. 1992, 1993
 * All Rights Reserved
 * Licensed Materials - Property of IBM
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

#define tablet_Class_Source
#include "tablet.ih"

#include <somrerrd.h>

Environment *tabletEnv;

/*
 *===========================================================================*
 * Method: setTablet                                                         *
 *===========================================================================*
 */

SOM_Scope void  SOMLINK setTablet(tablet somSelf,
                void* clientDA)
{
    GC                  drawGC;
    GC                  clearGC;
    Pixmap              drawPixmap;
    int                 n = 0;
    Arg                 args[10];
    XGCValues           val;

    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","setTablet");

    _drawarea = clientDA;

    n = 0;
    XtSetArg (args[n], XmNwidth, &_width); n++;
    XtSetArg (args[n], XmNheight, &_height); n++;
    XtGetValues ((Widget)_drawarea, args, n);

    n = 0;
    XtSetArg (args[n], XmNforeground, &val.foreground); n++;
    XtSetArg (args[n], XmNbackground, &val.background); n++;
    XtGetValues ((Widget)_drawarea, args, n);
    val.foreground = val.foreground ^ val.background;
    val.function = GXxor;
    _xorGC = 
        XtGetGC (
            (Widget)_drawarea, 
            GCForeground | GCBackground | GCFunction, 
            &val);

    n = 0;
    XtSetArg (args[n], XmNforeground, &val.foreground); n++;
    XtSetArg (args[n], XmNbackground, &val.background); n++;
    XtGetValues ((Widget)_drawarea, args, n);
    val.foreground = val.background;
    val.function = GXcopy;
    _clearGC = 
        XtGetGC (
            (Widget)_drawarea, 
            GCForeground | GCBackground | GCFunction, 
            &val);

    n = 0;
    XtSetArg (args[n], XmNforeground, &val.foreground); n++;
    XtSetArg (args[n], XmNbackground, &val.background); n++;
    XtGetValues ((Widget)_drawarea, args, n);
    val.function = GXcopy;
    _copyGC = 
        XtGetGC (
            (Widget)_drawarea, 
            GCForeground | GCBackground | GCFunction, 
            &val);

    _drawPixmap = (void *) 
        XCreatePixmap(
            XtDisplay((Widget)_drawarea),
            RootWindowOfScreen(XtScreen((Widget)_drawarea)),
            _width,
            _height,
            DefaultDepthOfScreen(XtScreen((Widget)_drawarea)));

    XFillRectangle(XtDisplay((Widget)_drawarea),
                   (Widget)_drawPixmap, 
                   (GC)_clearGC,
                   0, 0, (int) _width, (int) _height);

}


/*
 *===========================================================================*
 * Method: beginLine                                                         *
 *===========================================================================*
 */
SOM_Scope void SOMLINK beginLine(tablet somSelf, long x, long y)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","beginLine");

    _somrLockNlogOp (somSelf, tabletEnv, "tablet", "beginLine", x, y) ;
    if (tabletEnv->_major == NO_EXCEPTION) {
        _x1 = x; _y1 = y; _x2 = x; _y2 = y;
        _somrReleaseNPropagateOperation (somSelf, tabletEnv);
    } /* endif */

}

/*
 *===========================================================================*
 * Method: drawLine                                                          *
 *===========================================================================*
 */
SOM_Scope void SOMLINK drawLine(tablet somSelf, long x, long y)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","drawLine");

    _somrLockNlogOp (somSelf, tabletEnv, "tablet", "drawLine", x, y);
    if (tabletEnv->_major == NO_EXCEPTION) {
        _x2 = x;  _y2 = y;
        XDrawLine  (XtDisplay((Widget)_drawarea), 
                    XtWindow((Widget)_drawarea),
                    (GC)_xorGC,
                    (int)_x1, (int)_y1, (int)_x2, (int)_y2);
        XDrawLine  (XtDisplay((Widget)_drawarea), 
                    (Widget)_drawPixmap, 
                    (GC)_xorGC,
                    (int)_x1, (int)_y1, (int)_x2, (int)_y2);
        XDrawPoint (XtDisplay((Widget)_drawarea), 
                    XtWindow((Widget)_drawarea), 
                    (GC)_xorGC,
                    (int) _x2, (int) _y2);
        XDrawPoint (XtDisplay((Widget)_drawarea), 
                    (Widget)_drawPixmap, 
                    (GC)_xorGC,
                    (int) _x2, (int) _y2);

        XFlush (XtDisplay((Widget)_drawarea)); 

        _x1 = _x2;  _y1 = _y2;
        _somrReleaseNPropagateOperation (somSelf, tabletEnv);
    } /* endif */
}


/*
 *===========================================================================*
 * Method: clearAll                                                          *
 *===========================================================================*
 */
SOM_Scope void SOMLINK clearAll(tablet somSelf)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","clearAll");

    _somrLockNlogOp (somSelf, tabletEnv, "tablet", "clearAll") ;
    if (tabletEnv->_major == NO_EXCEPTION) {

        XClearWindow (XtDisplay((Widget)_drawarea), 
                      XtWindow((Widget)_drawarea));

        XFillRectangle(XtDisplay((Widget)_drawarea),
                       (Widget)_drawPixmap, 
                       (GC)_clearGC,
                       0, 0, (int) _width, (int) _height);

        XFlush (XtDisplay((Widget)_drawarea)); 

        _somrReleaseNPropagateOperation (somSelf, tabletEnv);
    } /* endif */
}


/*
 *===========================================================================*
 * Method: redraw                                                            *
 *===========================================================================*
 */
SOM_Scope void SOMLINK redraw(tablet somSelf)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","redraw");

    _somrLockNlogOp (somSelf, tabletEnv, "tablet", "redraw") ;
    if (tabletEnv->_major == NO_EXCEPTION) {

        XCopyArea(XtDisplay((Widget)_drawarea),
                  (Widget)_drawPixmap, 
                  XtWindow((Widget)_drawarea),
                  (GC)_copyGC,
                  0, 0, (int) _width, (int) _height, 0, 0);

        XFlush (XtDisplay((Widget)_drawarea)); 

        _somrReleaseLockNAbortOp (somSelf, tabletEnv);
    } /* endif */
}


/*
 *===========================================================================*
 * Method: somrApplyUpdates                                                  *
 *===========================================================================*
 */
SOM_Scope void  SOMLINK somrApplyUpdates(tablet somSelf, Environment *ev,
                string buf,
                long len,
                long ObjIntId)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","somrApplyUpdates");

    tablet_parent_SOMRReplicbl_somrApplyUpdates(somSelf,ev,buf,len,ObjIntId);
}


/*
 *===========================================================================*
 * Method: somrDoDirective                                                   *
 *===========================================================================*
 */
SOM_Scope void  SOMLINK somrDoDirective(tablet somSelf, Environment *ev,
                string str)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","somrDoDirective");

    tablet_parent_SOMRReplicbl_somrDoDirective(somSelf,ev,str);
}

/*
 *===========================================================================*
 * Method: somrGetState                                                      *
 *===========================================================================*
 */
SOM_Scope void  SOMLINK somrGetState(tablet somSelf, Environment *ev,
                string* buf)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","somrGetState");

    /* tablet_parent_SOMRReplicbl_somrGetState(somSelf,ev,buf); */
}

/*
 *===========================================================================*
 * Method: somrSetState                                                      *
 *===========================================================================*
 */

SOM_Scope void  SOMLINK somrSetState(tablet somSelf, Environment *ev,
                string buf)
{
    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","somrSetState");

    /* tablet_parent_SOMRReplicbl_somrSetState(somSelf,ev,buf);*/
}

/*
 *===========================================================================*
 *  Method: somInit                                                          *
 *  somInit is overriden to incorporate initialization of the Replication    *
 *  Framework.                                                               *
 *===========================================================================*
 */

SOM_Scope void  SOMLINK somInit(tablet somSelf)
{
    char *strname = "Tablet";

    tabletData *somThis = tabletGetData(somSelf);
    tabletMethodDebug("tablet","somInit");

    parent_somInit(somSelf);

    tabletEnv = somGetGlobalEnvironment();

    _somrSetObjName (somSelf, tabletEnv, strname);
    _somrRepInit (somSelf, tabletEnv, 'o', 'w');
}
