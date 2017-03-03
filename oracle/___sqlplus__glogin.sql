----
---- Copyright (c) Oracle Corporation 1988, 2000.  All Rights Reserved.
----
---- NAME
----   glogin.sql
----
---- DESCRIPTION
----   SQL*Plus global login startup file.
----
----   Add any sqlplus commands here that are to be executed when a user
----   starts SQL*Plus on your system
----
---- USAGE
----   This script is automatically run when SQL*Plus starts
----
--
---- For backward compatibility
--SET PAGESIZE 14
--SET SQLPLUSCOMPATIBILITY 8.1.7

---- set trims on
---- set line 300
---- set feedback on
---- set verify on
---- set newp 1
---- set linesize 300
---- set pause off
--
set truncate off
set timing on
set time on
set pages 50
--set null "§Null§"ù
set null "__Null__"
set wrap off
set numwidth 8
--set colsep " | "
set colsep " ; "
set linesize 3000

set echo off
set serveroutput off
COLUMN X NEW_VALUE Y
SELECT LOWER(USER || '@' || instance_name) X FROM v$instance;
SET SQLPROMPT '&Y> '

set serveroutput on
set echo on
select /*+ parallel (a,4) */

