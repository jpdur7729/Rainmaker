# Overview

Set of tools in order to

1.  process the files received from LDC
2.  Store the structure of datapoints into an SQL DB
3.  Extract the stored data from the SQL DB

# Old/New version

-   OldRaimaker director is a frozen version of the different
    scripts/items used in the 1st stage of development and relies on the
    TEST database
-   Rainmaker is a .git set of directories which will be reorganised
    accordingly and relies on the DIA database

# Setup

Using a specific DIA database with 2 set of tables:

1.  RM\_ prefixed table are the official ones used into the DIA database
    a subset of the actual database
2.  More generally RM\_ prefixed object is an official one So all the
    objetc created by JPD are NOT prefixed. It also goes with the Stored
    Procedures

## Directory Structure

| Directory        | Git | Description                                     |
|------------------|-----|-------------------------------------------------|
| DIA Structure DB | Y   | The scripts provided by Kumar                   |
|                  |     | To create the DIA Tables                        |
|                  |     | Documentation related to DIA Data Model         |
| LDCCSVDownloads  | Y   | CSV as received from LDC                        |
|                  |     | With processing scripts to transform into XLSX  |
| LDCDownloads     | Y   | The place where the key scripts are written and |
|                  |     | tested accordingly                              |
| SQL              | Y   | The key SQL files                               |
|                  |     | 1\) Create Tables T<sub>XXX</sub>.sql           |
|                  |     | 2\) Stored Procedures S<sub>XXX</sub>.sql       |
|                  |     | 3\) Other SQL files                             |
| LDC Templates    |     | No sure of the contents                         |
| Data - JPD       |     |                                                 |
| Ref Files        |     | ?? Useful ??                                    |
| CSV - Feb 22nd   | N   | Files sent by LDC for test                      |
|                  |     | Not to be processed                             |
