-- Netflix project
drop table if exists netflix;
create table netflix
(
	show_id	varchar(6),
	type varchar(10),	
	title varchar(150),
	director varchar(208),	
	casts varchar(1000),	
	country	varchar(150),
	date_added	varchar(70),
	release_year int,	
	rating	varchar(10),
	duration varchar(15),	
	listed_in	varchar(100),
	description varchar(260)

);
select * from netflix;

select 
	count(*) as total_content
from netflix;

select 
	distinct type
from netflix;


select *from netflix
--1 count the number of movies vs TV shows

select 
	type,
	count(*) as total_content
from netflix
group by type

--2 find the most common rating for movies and TV shows

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

--3 list all the movies release in a specific year (e.g 2000)

select * from netflix
where 
    type = 'Movie' 
	and 
	release_year = 2020

--4 find the top 5 countries with the most content on netflix

select 
     unnest(STRING_TO_ARRAY(country,',')) as new_country,
     count(show_id) as total_content
from netflix
group by 1
ORDER BY 2 DESC
LIMIT 5

--5 identify the longest movies or TV show duration

select 
	*
from netflix
where
	type = 'Movie' and
	duration = (select max(duration) from netflix)

--6 find content added in the last 5 years

select 
	*
from netflix
where 
	to_date(date_added, 'month dd, yyyy') >= current_date - interval '5 years'

--7 find all the Movies/TV shows by director 'rajiv chilaka'

select * from netflix
where director ilike '%rajiv Chilaka%'

--8 list all the TV shows with more than 5 seasons

select 
	* 
from netflix
where 
	type= 'TV Show'
		and 
	split_part(duration,' ',1)::numeric >5

--9 count the number of content items in each genre

select
	unnest(string_to_array(listed_in,',')) as genre,
	count(show_id) as total_content
from netflix
group by 1

--10  find each year and the average number of content release by india on netflix. Return top 5 year with highest 
--    average content release

select 
	extract(year from to_date(date_added, 'month dd, yyyy')) as year,
	count(*),
	round(count(*)::numeric/(select count(*) from netflix where country= 'India') *100,2) as avg_content_per_year
from netflix
where country = 'India'
group by 1

--11 list all movies that are documentaries

select 
	*
from netflix
where 
	listed_in ilike '%documentarie%'

--12 find all content without a director

select 
	* 
from netflix
where 
	director is null

--13- find how many movies actor 'salman khan' appeared in last 10 years

select 
	* 
from netflix
where 
	casts ilike '%salman khan%'
	and
	release_year > extract(year from current_date)-10


--14- find the top 10 actors who have appeared in the highest number of movies produces in ......

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

--15- Categorize the content based on the presence of the keywords 'kill'and 'violence' in the description field. Label content containing 
       --these keywords as 'bad' and all other content as 'Good'. count how many items fall into each category. 

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





