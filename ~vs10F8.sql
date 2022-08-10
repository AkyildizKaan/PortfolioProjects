--Cleaning Data in SQL Queries
Select *
From dbo.nashville

--Standardize Data Format
Select SaleDateConverted, Convert (Date,SaleDate) 
From dbo.nashville

Update dbo.nashville
Set SaleDateConverted=Convert(Date,SaleDate)

ALTER TABLE nashville
Add SaleDateConverted Date;

--Populate Property Address data
Select *
From dbo.nashville
--where PropertyAddress is NULL
order by ParcelID

Select a.ParcelID, a.propertyAddress, b.parcelID,b.propertyAddress
From dbo.nashville a
join dbo.nashville b
on a.ParcelID=b.ParcelID
aND a.UniqueID <> b.uNIqueID
Where a.PropertyAddress is null

Update a
SET propertyaddress = ISNULL (a.propertyaddress, b.propertyaddress)
from dbo.nashville a
join dbo.nashville b 
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

SELECT 
SUBSTRING (propertyaddress,1, CHARINDEX(',',propertyAddress)-1) as address,
SUBSTRING (propertyaddress, CHARINDEX(',',propertyAddress)+1, len(propertyAddress)) as address

from dbo.nashville

---

use VELI
Select owneraddress
from dbo.nashville

use veli

select * 
from dbo.nashville

---
Select distinct (soldasvacant),count(soldasvacant)
from dbo.nashville
group by SoldAsVacant
order by 2

----
select soldasvacant,
case when soldasvacant = 'y' then 'yes'
when soldasvacant = 'n' then 'no'
else SoldAsVacant
end
from dbo.nashville

----
update nashvillehousing

--remove dublicates
with rownumcte as (
SELECT *,
row_number() over (
partition by parcelId,
Propertyaddress,
saleprice,
saledate,
legalreference
order by uniqueId) row_numb
from dbo.nashville
---order by parcelID
)
select * 
from dbo.nashville

alter table dbo.nashville
drop column owneraddress,taxdistrict,propertyaddress

alter table dbo.nashville
drop column saledate