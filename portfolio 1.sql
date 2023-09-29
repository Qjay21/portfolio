SELECT * FROM coviddeaths
where continent is not null
order by 3,4;

-- SELECT *
-- FROM covidvaccinations
-- ORDER BY 3,4 

SELECT 
location,
date,
population,
total_cases,
new_cases,
total_deaths
	FROM coviddeaths
    order by 1,2;
    
# TOTAL CASES VS TOTAL DEATHS

SELECT 
location,
date,
population,
total_cases,
total_deaths,
(total_deaths/total_cases) * 100 As Death_percentage
	FROM coviddeaths
    where location like '%nigeria%'
    order by 1,2;
    
# TOTAL CASES VS POPULATION

SELECT 
location,
date ,
population,
total_cases,
population,
(total_cases/population) * 100 As Percentage_of_populated_cases
	FROM coviddeaths
    # where location like '%nigeria%'
    order by 1,2;

# COUNTRY WITH THE HIGHEST INFECTION RATE 
SELECT 
location,
population,
MAX(total_cases) as Highest_total_case,
population,
MAX((total_cases/population)) * 100 As Percentagepopulated
	FROM coviddeaths
    # where location like '%nigeria%'
	Group by location, population
    order by Percentagepopulated desc; 
    
    # HIGHEST DEATH PER POPULATION 
    
SELECT continent, (total_deaths) as Totaldeathcounts
FROM coviddeaths
Where continent is not nulL
Group by continent
order by TotalDeathCount desc ; 
# where location like '%nigeria%'
#Group by location, population
#order by Percentagepopulated desc;

-- Global number  

SELECT 
date, 
(new_cases),
sum(new_deaths) as total_cases,
sum(total_deaths/total_cases) * 100 As Death_percentage
-- (total_deaths/total_cases) * 100 As Death_percentage
	FROM coviddeaths
    where continent is not null
    Group by date
    order by 1,2;
     
     # Total population vs Total vaccination with Rolling count
    select cdd.continent,
    cdd.location, 
    cdd.date,
    cdd.population,
    cdv.new_vaccinations, 
    SUM( cdv.new_vaccinations)  OVER (partition by cdd.location order by cdd.location, cdd.date) As rollingpeople_vaccinated
    from coviddeaths cdd
    join covidvaccinations cdv
    on cdd.location = cdv.location
    and cdd.date = cdv.date
    where cdv.continent is not null
    order by 2,3;
    
    