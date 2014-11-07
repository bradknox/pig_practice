athletes =
LOAD        'temp/OlympicAthletes.csv'
USING       PigStorage(',')
AS          (athlete:chararray, country:chararray, year:int, sport:chararray, gold:int, silver:int, bronze:int, total:int);




/*
athletes_grp_country =
GROUP       athletes
BY          country;

DESCRIBE    athletes_grp_country;
--DUMP        athletes_grp_country;

medals =
FOREACH     athletes_grp_country
GENERATE    group AS country,
            -- FLATTEN(athletes.athlete) AS athlete;
            SUM(athletes.total) as medal_count;

DESCRIBE    medals;
-- DUMP        medals;


ordered_medals = 
ORDER       medals
BY          medal_count DESC;

top_10_medals = 
LIMIT       ordered_medals 10;

DUMP        top_10_medals;

STORE       top_10_medals
INTO        'temp/top_10_medals';





ath_grp_country_noswim =
FILTER      athletes_grp_country
BY          sport == "Swimming"

noswim_medals =
FOREACH     ath_grp_country
            group AS country,
            SUM(athletes.total) as medal_count;

ordered_noswim_medals = 
ORDER       noswim_medals
BY          medal_count DESC;

top_10_noswim_medals = 
LIMIT       ordered_noswim_medals 10;

DUMP        top_10_noswim_medals;
*/



SPLIT       athletes
INTO        winter_athletes IF year%4 == 2,
            summer_athletes IF year%4 == 0;

summer_sports =
FOREACH     summer_athletes
GENERATE    sport;

summ_sp_dist =
DISTINCT    summer_sports;

DUMP        summ_sp_dist;

winter_sports_dist =
DISTINCT    (FOREACH winter_athletes GENERATE sport);

DUMP winter_sports_dist; 


/*
athletes_cpy =
FOREACH     athletes
GENERATE    *;

joined_athletes = 
JOIN        athletes BY athlete, athletes_cpy BY athlete;

DESCRIBE    joined_athletes;

--joined_athletes =
--FOREACH     joined_athletes_raw
--GENERATE    athletes::athlete as athA, athletes_cpy::athlete AS athB;

--DESCRIBE    joined_athletes;
--DUMP        joined_athletes;


consec_ath_same_total = 
FILTER      joined_athletes
BY          athletes::total == athletes_cpy::total
AND         athletes::year - athletes_cpy::year == 4
AND         athletes::total > 2;

DUMP consec_ath_same_total;
*/


/*
distinct_countries = 
DISTINCT    athletes_grp_country;

DESCRIBE    distinct_countries;
DUMP        distinct_countries;
DESCRIBE    athletes_grp_country;
DUMP        athletes_grp_country;
*/


/*
year_range = 
FOREACH     (GROUP athletes ALL)
GENERATE    MIN(athletes.year) as min_year,
            MAX(athletes.year) as max_year;

DUMP        year_range;
*/

