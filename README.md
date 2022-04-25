# Pewlett-Hackard-Analysis
SQL work for module 7

## Overview
The purpose of this analysis was to use PostgreSQL and pgAdmin to assist Bobby and Pewlett-Hackard in preparing for the oncoming wave of retirements across the company.

## Results
Our analysis allowed us to find out how many people holding each title will be retiring soon.

![retiring_titles](https://user-images.githubusercontent.com/100380226/165006552-2cef81c3-6eb7-4751-bc2b-090f028be8ed.png)

* At 25,916 oncoming retirees, Senior Engineer will be retiring more employees than any other title
* Two department managers will be retiring
* Leadership positions (Manager, Senior Engineer, Senior Staff, and Technique Leader) will be retiring over 54,000 employees
* There are 1,549 mentorship-eligible retirement-ready employees at Pewlett-Hackard across all departments

## Summary
We are able to use CTRL+DOWN in Excel in unique_titles.csv or a select count() statement in Postgres on unique_titles to find that Pewlett-Hackard will potentially need to fill 72,458 roles.  We are able to do the same in titles.csv while filtering for only current employees to see that the current company staff numbers 240,124.  30.17% of Pewlett-Hackard's workforce is very close to retirement, so the company needs to quickly look to recruit.  We are able to use another select count statement to show that 54,447 leadership positions will be opening up.  Another area of interest is engineering.

    select count(title)
    from unique_titles
    where title in ('Senior Engineer', 'Engineer', 'Assistant Engineer');
    
The above query tells us that 36,291 engineering positions will need to be filled across the company.  After we used the select distinct on() statement to build the table of eligible mentors, we are able to count how many potential mentors we have for each position in the table.  From there we can select all engineering titles since the mentorship program is position-specific.

![mentor_count](https://user-images.githubusercontent.com/100380226/165010029-d9bbca70-4d27-4f66-a5c2-d9d5a6c922f4.png)

    select count(title)
    from mentorship_eligibility
    where title in ('Senior Engineer', 'Engineer', 'Assistant Engineer');

We see a relatively low number of potential mentors for the large number of potential roles to fill.  We should not assume that every employee that is eligibile will want to mentor younger employees.  Many may prefer to continue not to change their role so late in their career and others still  may prefer to retire outright and enjoy their time.  We are able to use another select count() query to count 748 potential engineering mentors.  Our potential retiring engineers outnumber our potential engineering mentors by over a factor of forty-eight.  This is not nearly enough qualified potential mentors to address the company's future needs.  This pattern holds consistent for the company as a whole.  A total of 1,549 potential mentors is not enough to address 72,458 forthcoming openings.
