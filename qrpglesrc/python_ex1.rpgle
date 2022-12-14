**FREE
ctl-opt option (*srcstmt : *nodebugio : *nounref);
ctl-opt debug (*input);
ctl-opt dftactgrp (*no);
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//  Program : Python_ex1
//  Author  : Mike Larsen
//  Date Written: 07/04/2019
//  Purpose : This program will execute a Python script and will
//            demonstrate two concepts:
//
//            1. How to execute a Python script from RPG
//            2. How to pass parameters to a Python script from RPG
//
//====================================================================*
//   Date    Programmer  Description                                  *
//--------------------------------------------------------------------*
// 07/04/19  M.Larsen    Original code.                               *
//                                                                    *
//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *

// - - - -
// Workfields

dcl-s firstParameter  char(10) inz('lexie');
dcl-s secondParameter char(10) inz('slayer');
dcl-s thirdParameter  char(10) inz('yankees');
dcl-s fourthParameter char(10) inz('two words');

dcl-s CmdStr             char(1000);
dcl-s pathToPython       char(30);
dcl-s pythonScript       char(100);
dcl-s quotes             char(1)  inz('''');

// - - - -
// Run CL Command

dcl-pr Run     ExtPgm('QCMDEXC');
       CmdStr  Char(3000) Options(*VarSize);
       CmdLen  Packed(15:5) Const;
       CmdDbcs Char(2) Const Options(*Nopass);
end-pr;

//--------------------------------------------------------

setUp();
executePythonScript();

*Inlr = *On;
Return;

//--------------------------------------------------------
// setUp subprocedure
//--------------------------------------------------------

dcl-proc setUp;

  pathToPython = '/QOpenSys/pkgs/bin/python3';
  pythonScript = '/home/JOMUMA/python/ejemplo01/parameters.py';

end-proc setUp;

//--------------------------------------------------------
// executePythonScript subprocedure
//--------------------------------------------------------

dcl-proc executePythonScript;

   // Use Qshell to execute the Python script.
   //
   // Note: Parameters are detected by a space in Python, so the
   // the 'fourthParameter' needs to be in quotes since it has two
   // words separated by a space.  if I didn't put it in quotes,
   // Python would see them as two separate parameters.

   CmdStr = 'Qsh Cmd(' + quotes +
                         %trim(pathToPython)       + ' ' +
                         %trim(pythonScript)       + ' ' +
                         %trim(firstParameter)     + ' ' +
                         %trim(secondParameter)    + ' ' +
                         %trim(thirdParameter)     + ' ' +
                   '"' + %trim(fourthParameter)    + '"' + ''')';

   Callp Run(Cmdstr:%Size(CmdStr));

end-proc executePythonScript;

//- - - - - - - - - - - - - - 
