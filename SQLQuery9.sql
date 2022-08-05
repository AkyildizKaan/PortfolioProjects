SELECT location,date,total_cases,new_cases,total_deaths,population
From covid_deaths$
order by 1,2

--Looking at Total Cases vs Total Deaths
SELECT location,date,total_cases,new_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From covid_deaths$
where location like 'Canada'
order by 1,2

--Looking at Total Cases vs Population
SELECT location,date,total_cases,population,new_cases,total_deaths,(total_cases/population)*100 as Percentageofpopcovid
From covid_deaths$
where location like 'Canada'
order by 1,2

----Looking at Countries with Highest Infection Rate compared to population
SELECT location,max(total_cases) as HighestInfectionCount,population,max(total_cases/population)*100 as MaxInfection
From covid_deaths$
group by location,population
order by MaxInfection desc

--Let's Break Things down by continent
SELECT continent, max(cast(total_deaths as int)) as TotalDeathCount
From covid_deaths$
where continent is  null
group by continent
order by TotalDeathCount desc


Create View PercentPopulationVaccinated as 
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
Sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location,
dea.Date) as RollingPeopleVaccinated
From covid_death dea
join vaccine vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null

select * 
from PercentPopulationVaccinated
