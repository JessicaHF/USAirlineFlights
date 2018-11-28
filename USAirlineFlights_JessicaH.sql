/*1-. Quantitat de registres de la taula de vols:*/
SELECT count(*) 
FROM Flights
/*2-. Retard promig de sortida i arribada segons l'aeroport origen.*/
SELECT Origin, avg(DepTime) as DepartureTime, avg(ArrTime) as ArrivalTime
FROM Flights
GROUP BY Origin
/*3- Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen. A més,
volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files)*/
SELECT Origin,colYear as Year,colMonth as Month,if(avg(ArrDelay) >0,'RETARD',"") as Retrasos
FROM Flights
GROUP BY Origin, colYear, colMonth
ORDER BY Origin ASC, colYear ASC, colMonth ASC;
/*4-. Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen (mateixa
consulta que abans i amb el mateix ordre). Però a més, ara volen que en comptes
del codi de l’aeroport es mostri el nom de la ciutat.*/
SELECT City,colYear as Year,colMonth as Month,if(avg(ArrDelay) >0,'RETARD',"") as Retrasos
FROM Flights
INNER JOIN USAirports
ON Origin=IATA
GROUP BY City, colYear, colMonth;
/*5-. Les companyies amb més vols cancelats. A més, han d’estar ordenades de forma
que les companyies amb més cancelacions apareguin les primeres.*/
SELECT Description, count(Cancelled) as Cancelled
FROM carriers
INNER JOIN Flights
ON Code = UniqueCarrier
GROUP BY Description
ORDER BY Cancelled;
/*6-.L’identificador dels 10 avions que més distància han recorregut fent vols.*/
SELECT Distance, FlightNum
FROM Flights
ORDER BY Distance ASC LIMIT 10
/*7-. Companyies amb el seu retard promig només d’aquelles les quals els seus vols
arriben al seu destí amb un retràs promig major de 10 minuts.*/
SELECT Description as Airline,Dest as Destination, avg(ArrDelay) as Retrasos
FROM Flights
INNER JOIN carriers
ON code=UniqueCarrier
GROUP BY Description, Dest
HAVING Retrasos > 10
ORDER BY Description;
