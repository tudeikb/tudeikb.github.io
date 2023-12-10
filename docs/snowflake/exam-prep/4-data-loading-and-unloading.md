---
layout: default
title: "Domain 4.0: Data Loading and Unloading"
parent: Snowpro Core Certification
grand_parent: Snowflake
nav_order: 1
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## 4.1 Define concepts and best practices that should be considered when loading data
### Stages and stage types

### File size and formats

### Folder structures

### Ad hoc/bulk loading

### Snowpipe

### 4.1: Practice Questions

************************************************************************************

## 4.2 Outline different commands used to load data and when they should be used.

### CREATE STAGE

### CREATE FILE FORMAT

### CREATE PIPE

### CREATE EXTERNAL TABLE

### COPY INTO

### INSERT/INSERT OVERWRITE

### PUT

### VALIDATE

### 4.2: Practice Questions

************************************************************************************

## 4.3 Define concepts and best practices that should be considered when unloading data

### File size and formats, overview of compression methods

### Empty strings and NULL values

### Unloading to a single file

### Unloading relational tables

### 4.3: Practice Questions

Which semi-structured file formats are supported when unloading data from a table? (Select TWO)

> A. ORC
>
> B. XML
>
> C. Avro
>
> D. <u>Parquet</u>
>
> E. <u>JSON</u>


************************************************************************************

## 4.4 Outline the different commands used to unload data and when they should be used

### GET 
The correct syntax for the GET command in Snowflake to download files from an internal stage to a local directory on a Windows client machine should use forward slashes (/) in the file path and also handle spaces in directory names properly. 

GET @%TBL_EMPLOYEE 'file://C:/folder with space/';

This command specifies the path using forward slashes, which is the preferred way in Snowflake's context, even on Windows systems. The space in the directory name 'folder with space' is handled correctly in this format.

Commands that use backslashes (\), which are typical in Windows file paths, are not the standard in Snowflake's GET command. If you ever need to use backslashes in such a context, they should be escaped (e.g., \\), but in this case, it's simpler and more appropriate to use forward slashes.

### LIST

### COPY INTO

### CREATE STAGE

### CREATE FILE FORMAT

### 4.4: Practice Questions
