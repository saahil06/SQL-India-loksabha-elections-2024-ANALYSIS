CREATE DATABASE elections;
USE elections;

CREATE TABLE constituencywise_details
(
Sr	INT,
Candidate	VARCHAR(50),
Party	VARCHAR(50),
EVM_Votes	INT,
Postal_Votes INT,
Total_Votes	INT,
Per_of_Votes	FLOAT,
Constituency_ID VARCHAR(15)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constituencywise_details.csv'
INTO TABLE constituencywise_details
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM constituencywise_results;

CREATE TABLE constituencywise_results
(
Sr	INT ,
Parliament_Constituency	VARCHAR(100),
Constituency_Name	VARCHAR(100),
Winning_Candidate	VARCHAR(100),
Total_Votes	INT,
Margin	INT,
Constituency_ID	VARCHAR(20),
Party_ID	INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/constituencywise_results.csv'
INTO TABLE constituencywise_results
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

SELECT * from constituencywise_results;

CREATE TABLE partywise_results
(
Party	VARCHAR(100),
Won	INT,
Party_ID INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/partywise_results.csv'
INTO TABLE partywise_results
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE statewise_results
(
	Constituency VARCHAR(50),
    Const_No	INT,
    Parliament_Constituency	VARCHAR(50),
    Leading_Candidate	VARCHAR(50),
    Trailing_Candidate	VARCHAR(50),
    Margin	INT,
    Status	VARCHAR(50),
    State_ID VARCHAR(50),
    State VARCHAR(50)

);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/statewise_results.csv'
INTO TABLE statewise_results
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE TABLE states
(
	State_ID VARCHAR(10),	
    State VARCHAR(50)

);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/states.csv'
INTO TABLE states
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Q1.total seats in election

SELECT COUNT(Parliament_Constituency) as total_seats
FROM constituencywise_results;

-- Q2.What is the total number of seats available for elections in each state

SELECT s.State,COUNT(cr.Parliament_Constituency) as Total_Seats
FROM statewise_results as sr
JOIN constituencywise_results as cr
ON sr.Parliament_Constituency=cr.Parliament_Constituency
JOIN states as s
ON s.State_ID=sr.State_ID
GROUP BY s.State
ORDER BY State;

-- Q3.Total Seats Won by NDA Allianz

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN Won
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_results;
    
-- Q4.Seats Won by NDA Allianz Parties

SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC;

-- Q5.Total Seats Won by I.N.D.I.A. Allianz

SELECT SUM(
	CASE 
		WHEN Party in (
                        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'

        )THEN Won
        ELSE 0 
        END 
)as total_seats_WON_by_INDIA
FROM partywise_results;

-- Q6.Seats Won by I.N.D.I.A. Allianz Parties
SELECT Party,Won
FROM partywise_results
WHERE party in (
'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'

)
order by Won DESC;

-- Q7.Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

SET SQL_SAFE_UPDATES=0;

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

UPDATE partywise_results 
SET 
    party_alliance = 'OTHER'
WHERE
    party_alliance IS NULL;

-- Q8.Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats ?

SELECT 
    party, party_alliance, SUM(WON) AS Won
FROM
    partywise_results
GROUP BY party_alliance
ORDER BY Won DESC;

-- Q9.Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT 
    cr.Winning_Candidate,
    pr.Party,
    pr.party_alliance,
    cr.Total_Votes,
    cr.Margin,
    cr.Constituency_Name,
    s.State
FROM
    constituencywise_results AS cr
        JOIN
    partywise_results AS pr ON cr.Party_ID = pr.Party_ID
        JOIN
    statewise_results AS sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        JOIN
    states AS s ON s.State_ID = sr.State_ID;
    
    
--     Q9.What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
SELECT 
    cd.Candidate,
    cd.Party,
    cd.EVM_Votes,
    cd.Postal_Votes,
    cd.Total_Votes,
    cr.Constituency_Name
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE 
    cr.Constituency_Name = 'MATHURA'
ORDER BY cd.Total_Votes DESC;

-- Q10.Which parties won the most seats in s State, and how many seats did each party win?

SELECT 
    pr.Party, s.State, SUM(pr.Won)
FROM
    constituencywise_results AS cr
        JOIN
    partywise_results AS pr ON cr.Party_ID = pr.Party_ID
        JOIN
    statewise_results AS sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        JOIN
    states AS s ON sr.State_ID = s.State_ID
WHERE
    s.State = 'maharashtra'
GROUP BY pr.Party
ORDER BY pr.Won DESC;

-- Q11.What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT s.State,
SUM(CASE WHEN pr.party_alliance='NDA' then 1 else 0 end) as NDA_SEATS_WON,
SUM(CASE WHEN pr.party_alliance='OTHER' then 1 else 0 end) as OTHER_SEATS_WON,
SUM(CASE WHEN pr.party_alliance='I.N.D.I.A' then 1 else 0 end) as INDIA_SEATS_WON

FROM  constituencywise_results AS cr
        JOIN
    partywise_results AS pr ON cr.Party_ID = pr.Party_ID
        JOIN
    statewise_results AS sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        JOIN
    states AS s ON sr.State_ID = s.State_ID
GROUP BY s.State;

-- Q12.Which candidate received the highest number of EVM votes in each constituency (Top 10)?
SELECT 
    cd.Candidate,
    cr.Constituency_Name,
    MAX(cd.EVM_Votes) AS EVM_VOTES
FROM
    constituencywise_details AS cd
        JOIN
    constituencywise_results AS cr ON cd.Constituency_ID = cr.Constituency_ID
GROUP BY Constituency_Name
ORDER BY EVM_VOTES DESC
LIMIT 10;

-- Q13. For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, 
-- total votes (including EVM and postal), and the breakdown of EVM and postal votes?


SELECT 
    COUNT(DISTINCT cr.Parliament_Constituency) AS total_seats,
    COUNT(DISTINCT cd.Candidate) AS Total_candidate,
    COUNT(DISTINCT pr.Party) AS Total_parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS total_votes,
    SUM(cd.EVM_Votes) AS EVM_VOTES,
    SUM(cd.Postal_Votes) AS Postal_Votes
FROM
    constituencywise_results AS cr
        JOIN
    constituencywise_details AS cd ON cr.Constituency_ID = cd.Constituency_ID
        JOIN
    statewise_results AS sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        JOIN
    states AS s ON s.State_ID = sr.State_ID
        JOIN
    partywise_results AS pr ON cr.Party_ID = pr.Party_ID
WHERE
    s.State = 'maharashtra';














