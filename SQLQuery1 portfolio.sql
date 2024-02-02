--Table Showing COVID-19 Infections and Deaths
select *
from PortfolioProject..CovidDeaths

-----------
--Examining the current ratio of total deaths to total cases
--Displaying the mortality rate following COVID-19 infection in, Nigeria.
select location, date, population,total_cases, total_deaths,
(convert(numeric, total_deaths)/ convert(numeric, total_cases) * 100) as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
and location like '%Nigeria%'
order by 1,2

------------
--Examining the current ratio of total deaths to total cases
--Displaying the mortality rate following COVID-19 infection in, United States.
select location, date, population,total_cases, total_deaths,
(convert(numeric, total_deaths)/ convert(numeric, total_cases) * 100) as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
and location like '%states%'
order by 1,2

---------------
--Displaying the Infection ratio following COVID-19 Outbrake in Nigeria.
select location, date, population,total_cases, 
(convert(numeric, total_cases)/convert(numeric, population) * 100) as Infection_ratio
from PortfolioProject..CovidDeaths
where continent is not null
and location like '%Nigeria%'
order by 1,2

--Displaying the Infection ratio following COVID-19 Outbrake in United states.
select location, date, population,total_cases, 
(convert(numeric, total_cases)/convert(numeric, population) * 100) as Infection_ratio
from PortfolioProject..CovidDeaths
where continent is not null
and location like '%states%'
order by 1,2

-------------
--Displaying countries with the highest infection relative to their populations.
select location,  population,MAX(cast(total_cases as int)), 
(MAX(total_cases)/convert(numeric, population) * 100) as Infection_ratio
from PortfolioProject..CovidDeaths
where continent is not null
--and location like '%states%'
group by population, location
order by Infection_ratio desc

-------------
--Dispalying countries with the highest mortality relative to their population
select location,  population,MAX(cast(total_cases as int)) as Mortality,
(MAX(total_cases)/convert(numeric, population) * 100) as Mortality_ratio
from PortfolioProject..CovidDeaths
where continent is not null
--and location like '%states%'
group by population, location
order by Mortality_ratio desc


--Displaying countries with the highest infection
select location, MAX(cast(total_cases as int)) as Infected
from PortfolioProject..CovidDeaths
where continent is not null
--and location like '%states%'
group by location
order by Infected desc


--Dispalying countries with the highest mortality 
select location, MAX(cast(total_cases as int)) as Mortality
from PortfolioProject..CovidDeaths
where continent is not null
--and location like '%states%'
group by location
order by Mortality desc

-----------
--BREAKING THINGS DOWN TO CONTINENT

select location,  population,MAX(cast(total_cases as int)) as Total_Mortality,
(MAX(total_cases)/convert(numeric, population) * 100) as Mortality_ratio
from PortfolioProject..CovidDeaths
where continent is null
--and location like '%states%'
group by population, location
order by Mortality_ratio desc

------------
--GLOBAL NUMBERS
select date, SUM(cast(new_cases as numeric))Total_cases, SUM(cast(new_deaths as numeric)) Total_deaths,
SUM(cast(new_deaths as numeric))/SUM(cast(new_cases as numeric))*100 death_percentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by 1

--Displaying the total population vs Vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as numeric)) over (partition by dea.date)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVacsinations vac
on dea.location = vac.location
and dea.date = vac.date 
where dea.continent is not null