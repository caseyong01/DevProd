---
title       : Developing Data Product Course Assignment
subtitle    : 23 May 2015
author      : Casey Ong
job         : Student
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## 2) Introduction

This is a simple Shiny program that aims to demostrate the requirement below.
- Use of widgets for user input 
- Operation on the ui input in sever.R
- Some reactive output displayed as a result of server calculations

The datasets used in the program are downloaded from the Department of Statistics of Singapore. 

URL : http://www.singstat.gov.sg/

--- .class #id 

## 3) User Interface (ui.R)
The following wigets are used to capture user input

- Droplist  
- Checkbox 

Tab panels are used to display the results from the server.
These include plots and summary of linear model.

--- .class #id 

## 4) Server Operation (server.R)
The following are the main functions at the server end.

1) Load datasets from working directory

2) Clean up the datasets

3) Listen for user input

4) Generate the "Divorce Trend" plot according to the ethnic group selected by user.

5) Formulate the linear model of divorce number according to the predictors selected by user. 

6) Generate the linear model plot and the summary.


--- .class #id


## 5) Challenges (server.R)
For this assignment, I spent most of my time in the two items below.
 
1) Thinking and deciding what application to create.

2) Searching and finding the right or relevant datasets.

---

