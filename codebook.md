---
title: "CodeBook"
author: "Cian O'Connor"
date: "2024-Jul-08"
output: html_document
---
This codebook has been created as a guide to getting the required data, cleaning
it, and merging it into one complete tidy dataset as per the instructions.

## Link to Full Dataset and Information on Variables

http://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones

## Basic explanation of the script

The script will:
- Download and read in the data from the link above.
- Merge the data to form one dataset.
- Extract the columns for mean and standard deviation only.
- Name the activities according to the 'activityLabels' file.
- Rename variables to remove certain characters, and clarify names.
- Write a new tidydataset with the average of each subject and variable.

The code assumes all data is unzipped in one folder, without names altered.

## The variables

`trainSubs`, `trainVals`, `trainAct`, `testSubs`, `testVals`, `testAct` contain the data from the downloaded files.

`allSubs`, `allVals`, `allAct`, and `allData2` contain the merged files.

`features` contains the correct names for the variables in the `allVals` dataset.

`activities` contains the names for the activities under the `allAct` dataset.
