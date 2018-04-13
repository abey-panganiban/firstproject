-- 1.How much from 2010 - 2014 were total funding given for Acquisitions?
select acquired_year, sum(price_amount) as year_raised
from datasets.crunchbase_acquisitions
where acquired_year between 2010 and 2014
group by acquired_year
order by year_raised DESC;

--2. How much from 2010 - 2014 were total funding for Investments? 
Select funded_year, sum(raised_amount_usd) 
From datasets.crunchbase_investments
Where funded_year between 2010 and 2014
Group by funded_year
Order by sum DESC;

--3. Which acquisition categories received the most funding in the most funded year?
SELECT acquirer_category_code, sum(price_amount) as totalprice
from datasets.crunchbase_acquisitions
where acquired_year = 2013 and price_amount is not null
group by acquirer_category_code
order by totalprice DESC
limit 10;

--4.What investment categories received the most funding in the most funded year? 
Select investor_category_code, sum(raised_amount_usd)
From datasets.crunchbase_investments
Where funded_year = 2013 and raised_amount_usd is not NULL
Group by investor_category_code
Order by sum desc
limit 10;

--5. What kind of funding round types did these investment categories have in 2013?
Select  investor_category_code,funding_round_type, count(funding_round_type)
From datasets.crunchbase_investments
where investor_category_code 
    in ('other','finance','enterprise','biotech') 
    and funded_year = 2013
Group by funding_round_type, investor_category_code
order by investor_category_code;

--6. How much did these funding rounds for these categories raise in total in 2013? 
Select  investor_category_code,funding_round_type, count(funding_round_type), sum(raised_amount_usd)
From datasets.crunchbase_investments
where investor_category_code in ('other','finance','enterprise','biotech') 
    and funded_year = 2013
    and raised_amount_usd is not NULL
Group by funding_round_type, investor_category_code
Order by sum desc
limit 10;

--7. What are the names of the most funded Finance Companies? 
SELECT category_code, name, funding_rounds, funding_total_usd
from datasets.crunchbase_companies
where category_code = 'finance' 
    and funding_total_usd >= 100000
order by funding_total_usd  DESC;

--8. What are the funding round types achieved by each Finance Company? 
SELECT c.name, i.funding_round_type, count(i.funding_round_type), sum(c.funding_total_usd)
FROM datasets.crunchbase_investments i 
JOIN datasets.crunchbase_companies c 
ON i.company_permalink = c.permalink
WHERE i.company_category_code = 'finance' 
    AND funding_total_usd is not null
GROUP BY c.name, i.funding_round_type
ORDER BY sum desc;
	
--9. Where are the most funded Finance Companies located?
SELECT name, region, city, funding_total_usd
From datasets.crunchbase_companies
Where  category_code = 'finance'
Order by funding_total_usd DESC
LIMIT 10;

--10. How old are the most funded Finance Companies?
SELECT name, founded_year, funding_total_usd
From datasets.crunchbase_companies
Where  category_code = 'finance' AND
    funding_total_usd IS NOT NULL
    and founded_year is not NULL
GROUP by name, founded_year, funding_total_usd
ORDER by funding_total_usd DESC
LIMIT 10;
