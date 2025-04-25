# Netflix Movies and TV shows Analysis using SQL

![Netflix Logo](https://github.com/Tusarkant05/Netflix_SQL_projt2/blob/main/Android_Collage_1920x1080__UCAN_En.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset.

## Objective
```
-- Finding the most common rating movies and TV shows.
-- Identify the longest duration on both of these.
-- Explore and categorize content based on specific criteria and keywords.
-- List and analyze content based on release years, countries, and durations.
```

## Schema

```sql
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
```

## Business problems and solutions

### 1. count the number of movies vs TV shows

```sql
select 
	type,
	count(*) as total_content
from netflix
group by type
```

### 2. find the most common rating for movies and TV shows

```sql
select
	type,
	rating
from 
(select
	type,
	rating,
	count(*),
	rank() over(partition by type order by count(*) desc) as ranking
from netflix
group by 1,2
)as t1
where
	ranking = 1
```

### 3. list all the movies release in a specific year (e.g 2000)

```sql
select * from netflix
where 
    type = 'Movie' 
	and 
	release_year = 2020
```

### 4. find the top 5 countries with the most content on netflix

```sql
select 
     unnest(STRING_TO_ARRAY(country,',')) as new_country,
     count(show_id) as total_content
from netflix
group by 1
ORDER BY 2 DESC
LIMIT 5
```

### 5. identify the longest movies or TV show duration

```sql
select 
	*
from netflix
where
	type = 'Movie' and
	duration = (select max(duration) from netflix)
```

### 6. find content added in the last 5 years

```sql
select 
	*
from netflix
where 
	to_date(date_added, 'month dd, yyyy') >= current_date - interval '5 years'
```

### 7. find all the Movies/TV shows by director 'rajiv chilaka'

```sql
select * from netflix
where director ilike '%rajiv Chilaka%'
```

### 8. list all the TV shows with more than 5 seasons

```sql
select 
	* 
from netflix
where 
	type= 'TV Show'
		and 
	split_part(duration,' ',1)::numeric >5
```

### 9. count the number of content items in each genre

```sql
select
	unnest(string_to_array(listed_in,',')) as genre,
	count(show_id) as total_content
from netflix
group by 1
```

### 10. find each year and the average number of content release by india on netflix. Return top 5 year with highest average content release

```sql
select 
	extract(year from to_date(date_added, 'month dd, yyyy')) as year,
	count(*),
	round(count(*)::numeric/(select count(*) from netflix where country= 'India') *100,2) as avg_content_per_year
from netflix
where country = 'India'
group by 1
```

### 11. list all movies that are documentaries

```sql
select 
	*
from netflix
where 
	listed_in ilike '%documentarie%'
```

### 12. find all content without a director

```sql
select 
	* 
from netflix
where 
	director is null
```

### 13. find how many movies actor 'salman khan' appeared in last 10 years

```sql
select 
	* 
from netflix
where 
	casts ilike '%salman khan%'
	and
	release_year > extract(year from current_date)-10
```

### 14. find the top 10 actors who have appeared in the highest number of movies produces in india

```sql
select 
	--casts,
	--show_id,
	unnest(string_to_array(casts,',')) as actors,
	count(*) as total_content
from netflix
where country ilike '%india'
group by 1
order by 2 desc
limit 10
```

### 15. Categorize the content based on the presence of the keywords 'kill'and 'violence' in the description field. Label content containing these keywords as 'bad' and all other content as 'Good'. count how many items fall into each category. 

```sql
with new_table
as
(
select
	*,
	case 
	when description ilike '%kill%' or 
	description ilike '%violence%'
	then 'Bad_content'
	else 'Good_content' end as category
from netflix
)
select 
	category,
	count(*) as total_content
from new_table
group by 1
```

# Findings and Conclusion
```
-- Content Distribution: The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
-- Common Ratings: Insights into the most common ratings provide an understanding of the content's target audience.
-- Geographical Insights: The top countries and the average content releases by India highlight regional content distribution.
-- Content Categorization: Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.
```

## Stay Updated and Join the Community
LinkedIn: www.linkedin.com/in/tusarkant-jena-6762b8208

Email-id: jtusarkant@gmail.com

**Thank you for your support, and I look forward to connecting with you!**







