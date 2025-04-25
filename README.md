# Netflix Movies and TV shows Analysis using SQL

![Netflix Logo](https://github.com/Tusarkant05/Netflix_SQL_projt2/blob/main/Android_Collage_1920x1080__UCAN_En.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset.

## Objective
-- Finding the most common rating movies and TV shows.
-- Identify the longest duration on both of these.
-- Explore and categorize content based on specific criteria and keywords.
-- List and analyze content based on release years, countries, and durations.

## Schema

drop table if exists netflix;
create table netflix
(
	show_id	     varchar(6),
	type         varchar(10),	
	title        varchar(150),
	director     varchar(208),	
	casts        varchar(1000),	
	country	     varchar(150),
	date_added	 varchar(70),
	release_year int,	
	rating	     varchar(10),
	duration     varchar(15),	
	listed_in	 varchar(100),
	description  varchar(260)

);
