-- Looking Total Cases Vs Total Deaths

select location,date,total_cases,total_deaths,
cast(total_deaths as float) *100 / cast(total_cases as float) as Death_percentage
from PortfolioProject.dbo.CovidDeaths 
where continent <>''
order by 1,2 


--ALTER TABLE PortfolioProject.dbo.CovidDeaths  
--ALTER COLUMN population nvarchar(200)

--Looking Total Cases Vs Population

select location,date,total_cases,population,
cast(total_cases as float) *100 / cast(population as float) as Death_percentage
from PortfolioProject.dbo.CovidDeaths 
where continent <>''
order by 1,2 



-- Looking at countries with Highest Infection Rate compared to population


select location,population,max(total_cases) as HighestInfectionRate ,
max(cast(total_cases as float) *100 / cast(population as float)) as PercentagePopulationInfected
from PortfolioProject.dbo.CovidDeaths 
where continent <>''
group by location,population
order by 4 desc 


-- Showing countries with Highest Death count Vs Population


select location,population,max(total_deaths) as HighestDwathsRate ,
max(cast(total_deaths as float) *100 / cast(population as float)) as PercentagePopulationDeaths
from PortfolioProject.dbo.CovidDeaths 
where continent <>''
group by location,population
order by 4 desc 


--- Showing continent with the highest death per population

 select continent ,max(total_deaths) as TotalDeathCount 
 from PortfolioProject.dbo.CovidDeaths 
 where continent <>''
 group by continent


 ---Showing Global Number 

select 
--date,
sum(nullif(new_cases ,0)) as Total_Cases,
sum(nullif(new_deaths,0)) as Total_Death,
cast(sum(nullif(new_deaths,0)) as float) *100 / cast(sum(nullif(new_cases ,0)) as float) as Death_Percentage
from PortfolioProject.dbo.CovidDeaths 
where continent <>''
--group by date
order by 1,2


------ Looking Total Population Vs Vaccination 

select 
D.Continent,D.location,D.date,D.population,V.new_vaccinations,
sum(cast(V.new_vaccinations as int)) over(partition by D.location order by D.location,D.date)  as RollingPeopleVaccinated
into #temp
from PortfolioProject.dbo.CovidDeaths as D
join PortfolioProject.dbo.CovidVaccination as V
on D.date=V.date and D.location=V.location
where D.continent <>''
order by 2,3


select continent,location ,date,population,new_vaccinations,RollingPeopleVaccinated,
cast(RollingPeopleVaccinated as float)*100/cast(population as float) PercentagePoepleVaccinated
 from #temp
 --where location ='India'
 order by 2 ,3


 -- Creating a View to store data for later visualizations

create view PercentPopulationVaccinated as 
select D.Continent,D.location,D.date,D.population,V.new_vaccinations,
sum(cast(V.new_vaccinations as int)) over(partition by D.location order by D.location,D.date)  as RollingPeopleVaccinated
from PortfolioProject.dbo.CovidDeaths as D
join PortfolioProject.dbo.CovidVaccination as V
on D.date=V.date and D.location=V.location
where D.continent <>''

	
select * from dbo.PercentPopulationVaccinated















