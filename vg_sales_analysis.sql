#Videogames Sales Analysis
#imported table from csv file
#Sales are in the millions

#The entire data
select
	*
from vgsales;

#Platform Analysis

#What platform had the most sold in the North America Region?
	#In this case, Xbox360 has sold rougly 594.33 million units
select
	platform,
    round(sum(na_sales),0) as total_na_sales
from vgsales
group by platform
order by total_na_sales desc
limit 1;

#What are the top 5 platforms by average sales per game?
	#I broke down this question in two parts: finding the name of the platforms, and average sales
	#Finding the name of the platform is simple as we just select that column
    #To find the average we first have to consider what sales are we looking at: NA, EU, JP, Other, or Global? In our case we need global sales as there was no region specified and we are looking for the top 5 platforms which have to include all regional sales.
	#This means that Global_Sales was our column.
    #Then we take the average of global_sales, and we round to 2 decimal points to get a more accurate number as doing a whole number could exclude things such as discounted prices during special sales events.
    #We now have to group by platform as we want to combine all the sales to their respective console
    #Lastly, we order by the average global_sales in desc order, and we limit the results to 5
    
	#The GameBoy, Nintendo Entertainment System, SEGA Genesis, Super Nintendo Entertainment System, and the Playstation are the top 5 performing platforms by average sales per game, with Nintendo dominating with 3/5 platforms.
select
	platform,
    round(avg(global_sales),2) as avg_gs
from vgsales
group by platform
order by avg_gs desc
limit 5;

#Which platform has the most games released?
	#We first have to find the number of games per platform. So we can start by using a count() function to count each individual game and selected it along side the platform
    #However, we know need to group by each platform to get the exact amount of games, and we do that grouping on the platform column.
    #Since we have looking for the most games released, we can order in desc by the count() of the name of the games, and limit it to 1
    
    #The DS had about 2133 games released, another win for Nintendo
select
	count(name) as num_games,
    platform
from vgsales
group by platform
order by num_games desc
limit 1;


#Publisher and Dev Insights

#Which publishers have the highest total sales globally?
	#The question can be broken up into two parts: who are the publishers, and what is the total global sales.
    #To find the publisher we simply select that column.
    #To find the total global sales, we use a sum() function, and a round() fun to 2 decimal points to get a clean but accurate result
    #Now we have to use a group function, as we are looking at highest total global sales per publisher, so we must group by the publishers
    #Lastly, we order by desc order and we set a limit of 10 just for convenience sake
select
	publisher,
    round(sum(global_sales),2) as total_gs
from vgsales
group by Publisher
order by total_gs desc
limit 10;

#Who are the top publishers in each region (NA, EU, JP)?
#We can answer this question in two ways: we can split reach region into its own seperate query and run the queries individually. In this case, we see that Nintendo dominates each region.
select
	publisher,
    round(sum(na_sales), 2) as total_na_sales
from vgsales



#Which regions domiate sales for different genres?
select
	sum(
group by publisher
order by total_na_sales desc
limit 5;

select
	publisher,
    round(sum(eu_sales), 2) as total_eu_sales
from vgsales
group by publisher
order by total_eu_sales desc
limit 5;

select
	publisher,
    round(sum(jp_sales), 2) as total_jp_sales
from vgsales
group by publisher
order by total_jp_sales desc
limit 5;

#However, the second way to answer this, is by using a CTE

# We create a CTE for the sales of regions and combined them all under one cte called 'regionlsales'.

with regionalsales as (
	select
		publisher,
		'NA' as region,
		round(sum(na_sales), 2) as sales
    from vgsales
    group by publisher
    
	union all
    
    select
		publisher,
        'EU' as region,
        round(sum(eu_sales), 2) as sales
	from vgsales
    group by publisher
    
    union all
    
    select
		publisher,
        'JP' as region,
        round(sum(jp_sales), 2) as sales
	from vgsales
    group by publisher
),
# We then create a second CTE to establish the ranking of the publishers based on the sales in descending order
# We use the rank() function to give our rows a rank.
# We then use the window function over() to specify what group over which the ranking would be calculated on
	#The partition by portion will let us split the data into separate groups for each region in our dataset (NA,EU,JP)
    #With all this in mind, we then order by the sales in descending order by each region and alias it as region_rank
rankedsales as (
	select
		publisher,
		region,
		sales,
		rank() over (partition by region order by sales desc) as region_rank
	from regionalsales
)

#Lastly, we call everything and set the limit to the top 5 publishers for each region, and order by the region, and then the region_rank

select *
from rankedsales
where region_rank <= 5
order by region, region_rank;

#Which regions dominate sales for different genres?
#This question can be solve in two ways:
	#1. Creating separate queries for each region
    #2. Creating CTEs
#1. We call in the sum of the NA_sales and round it with 2 decimal points to get us a clean total sum of na_sales
#1. Since we are looking for genres, we call it in and we group by the different genres
#1. Lastly, we order by the total sum of na_sales, and we get our list of genres that dominate the NA region
#1. In this case, it seems that Action is the leading genre in NA, with EU coming in second, however, in JP it seems to be role-playing games or RPGs
# which makes sense given the success of Pokemon, Final Fantasy, Persona, and many more great RPGs from JP
select
	round(sum(na_sales), 2) as total_nasales,
    genre
from vgsales
group by genre
order by total_nasales desc;

select
	round(sum(eu_sales), 2) as total_nasales,
    genre
from vgsales
group by genre
order by total_nasales desc;

select
	round(sum(jp_sales), 2) as total_nasales,
    genre
from vgsales
group by genre
order by total_nasales desc;

#2. Creating the CTE
#2. Just like the last question, we can combine all the region into a single CTE with the union all func

with GenreRegionSales as (
	select
		genre,
        'NA' as region,
		round(sum(na_sales), 2) as sales
	from vgsales
	group by genre
    
    union all
    
    select
		genre,
        'EU' as region,
		round(sum(eu_sales), 2) as sales
	from vgsales
	group by genre
    
    union all
    
    select
		genre,
        'JP' as region,
		round(sum(jp_sales), 2) as sales
	from vgsales
	group by genre
    
    union all
    
    select
		genre,
        'Other' as region,
		round(sum(other_sales), 2) as sales
	from vgsales
	group by genre
),

RankedRegionSales as (
  select 
    genre,
    region,
    sales,
    rank() over (partition by genre order by Sales desc) as Region_Rank
  from GenreRegionSales
)

select genre, region AS Dominant_Region, Sales
from RankedRegionSales
where Region_Rank = 1
order by genre;


#Genre Trends

#Which genre has the highest total global sales?
#For this question, we can use a simple round and sum func to find the total number of global sales
#and group by the genre, with a descending ordering, and limit it to 1 result, so we can see the highest genre being sold globablly
#Action is the highest selling genre globally with other 1722.88 million units or 1.722 billion units or 1,722,880,000 units
select
	genre,
    round(sum(global_sales), 2) as total_gb_sales
from vgsales
group by genre
order by total_gb_sales desc
limit 1;

#What is the average sales per genre?
select
	genre,
    round(avg(global_sales), 2) as avg_sales
from vgsales
group by genre;

#How does genre popularity vary across regions?

with GenreRegionSales as (
  select 
    Genre,
    sum(na_Sales) as NA_Total,
    sum(eu_Sales) as EU_Total,
    sum(jp_Sales) as JP_Total,
    sum(other_Sales) as Other_Total
  from vgsales
  group by Genre
),

GenreRegionPercentages as (
  select 
    Genre,
    NA_Total,
    EU_Total,
    JP_Total,
    Other_Total,
    round((NA_Total + EU_Total + JP_Total + Other_Total), 2) AS Global_Total,
    ROUND(100 * NA_Total / (NA_Total + EU_Total + JP_Total + Other_Total), 2) AS NA_Pct,
    ROUND(100 * EU_Total / (NA_Total + EU_Total + JP_Total + Other_Total), 2) AS EU_Pct,
    ROUND(100 * JP_Total / (NA_Total + EU_Total + JP_Total + Other_Total), 2) AS JP_Pct,
    ROUND(100 * Other_Total / (NA_Total + EU_Total + JP_Total + Other_Total), 2) AS Other_Pct
  from GenreRegionSales
)

select 
  Genre, Global_Total, 
  NA_Pct, EU_Pct, JP_Pct, Other_Pct
from GenreRegionPercentages
order by Global_Total desc;

#Time Series & Performance

#What is the trend of sales by genre over the years?
#To solve this question, we first had to identify the 3 items of interest: year, genre, and global sales
#Since the question is not specifying a region we can assume that global sales will be used to find the total sales
#we can then group by both year and genre, which means that year will be duplicated for however many genres were in that year.
#Lastly, we can order by the year is ascending order, and total_sales

#At quick glance, we see that the Shooter genre has been popular since the 1980s
select
	year,
    genre,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by year, genre
order by year asc, total_sales;


#How has the number of games released changed over time?
#To solve this we can first list out the items of interest: the number of games, and years. I included platform because I felt as if it was more representative of change in technology with different generations of consoles taking over per couple of years
#We can count all the games released by counting everything, as every row has a game title/name, and we can call for year and platform as well
#We then need to group by both the year and the platform
#Lastly, we order by year in ascending order so we start at our earliest date, and by games_released so we start with the platform with the least amount of games

#Around the 2000s-mid 2000s we see a big spike in games, with it slowing down as we reach the end of the second half of the 2010s. This could be for a number of reasons such as the dataset not taking digital sales into consideration, or the dataset itself being incomplete of all physical sales
select
	year,
    platform,
    count(*) as games_released
from vgsales
group by year, platform
order by year, games_released;

#Are there any genres that have grown or declined significantly?
# From a quick glance, we can notice a pattern in which the Puzzle genre begins to decline as the decades go by, with other genres such as Shooter gaining more and more popularity. Guess people really do like Medal of Honor
select
	year,
    genre,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by year, genre
order by year, genre, total_sales desc;

#OR

select
	year,
    genre,
    count(*) as game_released
from vgsales
group by year, genre
order by year, game_released;

#Comparative Questions
#Do certain publishers perform better on specific platforms?
#From this that Certain Publishers such as Activition did exceptionally well on Xbox 360, and PS3. Atari did really well on the PS2 and the Atari 2600 which makes sense given its own console and the PS2 being the best console of its generation. Obviously Nintendo seems to do better on their own consoles given that they
#only release their first party games on their consoles
select
	publisher,
    platform,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by publisher, platform
order by publisher, total_sales;

#Are there differences in average sales between games released before and after 2010?
# To solve this question, we first start by a case statement, to label games before 2010 and games after 2010 and after. This way we'll be able to see our two release periods.
# Then we can count the amount of games created, and take the average and sum of global sales to see the differences between the two time periods.
# In this case, we see that more games were released prior to 2010 leading to higher total sales and a higher average, however, we must keep in mind that this may be an incomplete dataset
select
	case
    when year < 2010 then 'Before 2010'
    else '2010 and After'
    end as release_period,
	count(*) as game_count,
    round(avg(global_sales), 2) as avg_global_sales,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by release_period;

#Which combination of genre and platform has the highest average global sales?
select
	genre,
    platform,
    count(*) as game_count,
    round(avg(global_sales), 2) as avg_sales
from vgsales
group by genre, platform
having count(*) >= 5
order by avg_sales desc
limit 10;

#General Sales Trends
#What are the top 10 best-selling video games globally?
select
	name,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by name
order by total_sales desc
limit 10;

#Which year had the highest total global sales?
select
	year,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by year
order by total_sales desc
limit 1;


#How have global video game sales changed over time (per year)?
select
	year,
    round(sum(global_sales), 2) as total_sales
from vgsales
group by year
order by year;
