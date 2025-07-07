CREATE TABLE largest_companies (
    rank INTEGER,
    name TEXT,
    sales NUMERIC,
    profit NUMERIC,
    assets NUMERIC,
    market_value NUMERIC,
    industry TEXT,
    founded INTEGER,
    headquarters TEXT,
    country TEXT,
    ceo TEXT,
    employees NUMERIC
);

select * from largest_companies;

--please note that sales, profit, assets, and market values are all in billions.

--1. Which are the top 10 most profitable companies?
select * 
from largest_companies
order by profit desc
limit 10;

--2. What is the average number of employees per country?
select cast(avg(employees) as integer) as average_employees
from largest_companies;

--3. List all companies from the "United States" that were founded before 1950.
select * 
from largest_companies
where country = 'United States' and founded < 1950;

--4. What are the distinct industries in the dataset?
select distinct industry
from largest_companies
where industry is not null;

--5. Which companies have the word "Bank" in their name?
select name
from largest_companies
where name ilike '%bank%';

--6. Which industry has the highest total assets?
select industry, sum(assets) as total_assets
from largest_companies
group by industry
order by sum(assets) desc
limit 1;

--7. Count the number of companies per country.
select country, count(*) as number_of_comps_per_country
from largest_companies
group by country
order by count(*) desc;

--8. What is the average market value by industry, only for industries with more than 3 companies?
select industry, cast(avg(market_value) as int) as average_market_value 
from largest_companies
group by industry
having count(*) > 3
order by average_market_value desc
;

--9. What is the total profit by country, sorted from highest to lowest?
select country, cast(sum(profit) as int) as total_profit_by_country
from largest_companies
group by country
order by total_profit_by_country desc;

--10. List all pairs of companies in the same country but different industries.
select c1.name, c1.country, c1.industry, c2.name, c2.country, c2.industry
from largest_companies c1
join largest_companies c2
on c1.name < c2.name and c1.industry <> c2.industry and c1.country = c2.country;

--11. Join each company to the average sales of companies in the same industry.
select name, c1.industry, c1.sales, average_sales_per_industry 
from largest_companies c1
join (select industry, cast(avg(sales) as int) as average_sales_per_industry 
		from largest_companies c2
		group by industry) d1
on c1.industry = d1.industry
order by industry;

--12. Compare each company’s assets to the average assets of its country.
select name, a1.country, a1.assets, average_assets_pet_country
from largest_companies a1
join (select country, cast(avg(assets) as int) as average_assets_pet_country
		from largest_companies
		group by country) c
on a1.country = c.country
order by a1.country;

--13. Find the top 3 companies by profit in each country.
with top_3_companies as (
	select *,
	rank() over(partition by country order by profit desc) as top
	from largest_companies
	)
select top_3_companies.top, top_3_companies.name, top_3_companies.profit, top_3_companies.country
from top_3_companies
where top_3_companies.top <= 3
order by top_3_companies.country desc;

--14. Rank companies within each industry by employees.
with emp_rnk as (
	select name, industry, employees,
	rank() over(partition by industry order by employees desc) as top_emp
	from largest_companies)

select *
from emp_rnk;

--15. Find companies whose profits are above the average profit of all companies.
with average_profit as (
	select cast(avg(profit) as int) as avg_comps_profit
	from largest_companies
	)

select c1.name, c1.profit, average_profit.avg_comps_profit
from largest_companies c1
join average_profit 
on c1.profit > average_profit.avg_comps_profit;

--16. Rank companies within each country by assets.
select name, country, assets,
rank() over(partition by country order by assets desc) as rank_assests
from largest_companies;

--17. Compare a company’s profit with the previous one in the same industry ordered by sales.
select name, industry, sales, profit,
lag(profit) over(partition by industry order by sales desc) as comparison_with_precomp
from largest_companies;

--18. List the first company alphabetically by name in each country.
select * from (
	select name, country, 
	row_number() over (partition by country order by name asc) as rnk_country
	from largest_companies) r1
where r1.rnk_country = 1;

--19. Calculate the running total of market value by country.
select name, market_value, country, 
sum(market_value) over(partition by country order by market_value) as market_share
from largest_companies;

--20. Create a view showing essential info for dashboard: Name, Country, Sales, Profit, Market Value, Industry.
create view dashboard as 
select name, country, sales, profit, market_value, industry
from largest_companies;

select * from dashboard;

--21. Create a view of top 5 companies per industry by sales.
create view top_5 as
select * from (	
	select name, industry, sales, rank() over(partition by industry order by sales desc) as top_comps
	from largest_companies) t5
where t5.top_comps <=5;

select * from top_5;
