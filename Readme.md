# Overview

Set of tools in order to

1.  process the files received from LDC
2.  Store the structure/hierarchy of datapoints into an SQL DB
3.  Store the datapoints into an SQL DB
4.  Extract the stored data from the SQL DB

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

| Directory        | Git | Description                                             |
|------------------|-----|---------------------------------------------------------|
| DIA Structure DB | Y   | The scripts provided by Kumar                           |
|                  |     | To create the DIA Tables                                |
|                  |     | Documentation related to DIA Data Model                 |
| LDCCSVDownloads  | Y   | CSV as received from LDC                                |
|                  |     | With processing scripts to transform into XLSX          |
| LDCDownloads     | Y   | The place where the XLSX spreadsheets are processed     |
|                  |     | i.e. entered into the STAGING Tables                    |
|                  |     | The PS scripts are found in that directory              |
| SQL              | Y   | The key SQL files for Staging Tables                    |
|                  |     | 1\) Create Tables T<sub>XXX</sub>.sql                   |
|                  |     | 2\) Stored Procedures SP<sub>XXX</sub>.sql              |
|                  |     | 3\) Views V<sub>XXX</sub>.sql                           |
|                  |     | 4\) Other SQL files                                     |
| STG2DIA          | Y   | All the SQL Scripts to move data from STAGING to DIA    |
| STGDisplay       | Y   | All the SQL Scripts to display uploaded data using only |
|                  |     | the STAGING tables                                      |
| LDC Templates    |     | No sure of the contents                                 |
| Data - JPD       |     |                                                         |
| Ref Files        |     | ?? Useful ??                                            |
| CSV - Feb 22nd   | N   | Files sent by LDC for test                              |
|                  |     | Not to be processed                                     |

# Principles

## Structure Capture

Data provided by the customer is provided in 2 steps

1.  Data -&gt; Stage Tables = Staging
2.  Stage Tables -&gt; Actual Tables = Processing

### Staging

1.  Preparing the Staging Tables

    Tables need to be created =&gt; T<sub>\*</sub>.sql files in SQL
    directory These tables have minimum referential integrity. Can be
    created easily in pretty much any order by contract to the DIA
    Tables in a test environment. [Deployment
    Staging](SQL/StagingDeployment.org)

2.  Process the CSV files received

    Convert the CSV Files received to XLSX and copy them to LDCDownloads
    directory The name is kept as received as it contains information
    about the contents

    1.  <span class="todo TODO">TODO</span> Improvement

        The csv2xlsx script has some hardcoded assumptions about the
        directories being used

3.  Process the XSLX files received

    The processing takes place in LDCDownloads The script is
    Normalise.ps1

    1.  <span class="todo TODO">TODO</span> Improvement

        Systematic access to DB … i.e assuming that access is granted
        via Windows Authentication Parametrisation to indicate the name
        of the file to be processed Potentially a makefile to process
        all files in 1 go

    2.  <span class="todo TODO">TODO</span> Stop execution if result
        File blocked

### Processing the Data

Once in the staging tables, then the data is copied into the
RM<sub>XXX</sub> tables by running PS<sub>RUN</sub>.SQL

## DataPoint Capture

Reading the test spreadsheet it is possible to generate only the script
to be executed in order to upload the DataPoint values in the STG tables
(i.e. DataPointValues and DataPointMapping)

In order to do that ./Normalise -Scope "DataPointOnly" -Action
GenerateSQLScript generates a SQL script ready to be deployed in a file
called /Results.sql

### <span class="todo TODO">TODO</span> Parameters of CLI Commands

Detailing the parameters used in order to generate the scripts and/or
execute them immediately

## Displaying Results

Generate a spreadsheet in order to verify - based on the Staging Tables
- the contents of what has been uploaded
