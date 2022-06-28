Select location, date, total_cases, total_deaths, (total_deaths/Total_cases)*100 as Death_percentage
From [Portfolio Poject]..Covid_deaths
Where location like '%Ind%'
order by 1,2
-- Looking at total cases Vs Populations
--Show what percentage of population get covid
Select location, date, total_cases, (total_cases/population)*100 as Covid_percentage
From [Portfolio Poject]..Covid_deaths
Where location like '%Ind%'
order by 1,2


--looking at countries with highest covid cases
Select Location, population, MAX(total_cases) as HighestInfectioncount, MAX((total_cases/population))*100 as Population_infected_percentage
From [Portfolio Poject]..Covid_deaths
Group by  Location, population
order by Population_infected_percentage desc

--showing the countries with higjhest death counts

Select Location, population, MAX(cast(Total_deaths as int)) as Total_Deathcounts
From [Portfolio Poject]..Covid_deaths
where continent is not null
Group by  Location, population
order by Total_Deathcounts desc

--Lets break down by continents
Select continent, MAX(cast(Total_deaths as int)) as Total_Deathcounts
From [Portfolio Poject]..Covid_deaths
where continent is not null
Group by continent
order by Total_Deathcounts desc

--showing the continent with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as Total_Deathcounts
From [Portfolio Poject]..Covid_deaths
where continent is not null
Group by continent
order by Total_Deathcounts desc


--Global numbers

Select  SUM(new_cases), SUM(cast(new_deaths as int)), SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From [Portfolio Poject]..Covid_deaths
Where continent is not null
--Group by date
order by 1,2


--Lookinng at Total population

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int, vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location)
From [Portfolio Poject]..Covid_deaths dea
Join [Portfolio Poject]..Covid_Vaccination vac

   On dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null
order by 2,3
