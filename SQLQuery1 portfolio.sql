-- Table Showing COVID-19 Infections and Deaths
SELECT *
FROM PortfolioProject..CovidDeaths;

-- Examining the current ratio of total deaths to total cases
-- Displaying the mortality rate following COVID-19 infection in Nigeria.
SELECT 
    location, 
    date, 
    population,
    total_cases, 
    total_deaths,
    (CONVERT(NUMERIC, total_deaths) / CONVERT(NUMERIC, total_cases) * 100) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
    AND location LIKE '%Nigeria%'
ORDER BY 1, 2;

-- Examining the current ratio of total deaths to total cases
-- Displaying the mortality rate following COVID-19 infection in the United States.
SELECT 
    location, 
    date, 
    population,
    total_cases, 
    total_deaths,
    (CONVERT(NUMERIC, total_deaths) / CONVERT(NUMERIC, total_cases) * 100) AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
    AND location LIKE '%states%'
ORDER BY 1, 2;

-- Displaying the Infection ratio following COVID-19 Outbreak in Nigeria.
SELECT 
    location, 
    date, 
    population,
    total_cases, 
    (CONVERT(NUMERIC, total_cases) / CONVERT(NUMERIC, population) * 100) AS Infection_ratio
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
    AND location LIKE '%Nigeria%'
ORDER BY 1, 2;

-- Displaying the Infection ratio following COVID-19 Outbreak in the United States.
SELECT 
    location, 
    date, 
    population,
    total_cases, 
    (CONVERT(NUMERIC, total_cases) / CONVERT(NUMERIC, population) * 100) AS Infection_ratio
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
    AND location LIKE '%states%'
ORDER BY 1, 2;

-- Displaying countries with the highest infection relative to their populations.
SELECT 
    location,  
    population,
    MAX(CAST(total_cases AS INT)), 
    (MAX(total_cases) / CONVERT(NUMERIC, population) * 100) AS Infection_ratio
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
GROUP BY population, location
ORDER BY Infection_ratio DESC;

-- Displaying countries with the highest mortality relative to their population.
SELECT 
    location,  
    population,
    MAX(CAST(total_cases AS INT)) AS Mortality,
    (MAX(total_cases) / CONVERT(NUMERIC, population) * 100) AS Mortality_ratio
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
GROUP BY population, location
ORDER BY Mortality_ratio DESC;

-- Displaying countries with the highest infection.
SELECT 
    location, 
    MAX(CAST(total_cases AS INT)) AS Infected
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
GROUP BY location
ORDER BY Infected DESC;

-- Displaying countries with the highest mortality.
SELECT 
    location, 
    MAX(CAST(total_cases AS INT)) AS Mortality
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
GROUP BY location
ORDER BY Mortality DESC;

-- Breaking things down by continent.
SELECT 
    location,  
    population,
    MAX(CAST(total_cases AS INT)) AS Total_Mortality,
    (MAX(total_cases) / CONVERT(NUMERIC, population) * 100) AS Mortality_ratio
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NULL
GROUP BY population, location
ORDER BY Mortality_ratio DESC;

-- Global numbers.
SELECT 
    date, 
    SUM(CAST(new_cases AS NUMERIC)) AS Total_cases, 
    SUM(CAST(new_deaths AS NUMERIC)) AS Total_deaths,
    SUM(CAST(new_deaths AS NUMERIC)) / SUM(CAST(new_cases AS NUMERIC)) * 100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE 
    continent IS NOT NULL
GROUP BY date
ORDER BY 1;

-- Displaying the total population vs Vaccination.
SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS NUMERIC)) OVER (PARTITION BY dea.date)
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVacsinations vac
    ON dea.location = vac.location
    AND dea.date = vac.date 
WHERE 
    dea.continent IS NOT NULL;
