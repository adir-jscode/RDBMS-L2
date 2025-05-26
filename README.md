## What is the purpose of a database schema in PostgreSQL?
schema হলো টেবিল, ভিউ এবং ফাংশনের মতো ডাটাবেস অবজেক্টের একটি লজিক্যাল গ্রুপিং। এটি বিভিন্ন ব্যবহারকারী বা অ্যাপ্লিকেশনের জন্য ডেটা সংগঠিত করতে এবং আলাদা করতে সাহায্য করে।
PostgreSQL একটি একক ডাটাবেসের মধ্যে একাধিক schema সমর্থন করে :
* Namespace Management: আপনার বিভিন্ন স্কিমাতে একই নাম সহ টেবিল থাকতে পারে।
*  Access Control: আপনি স্কিমা প্রতি নির্দিষ্ট সুবিধাগুলি বরাদ্দ করতে পারেন।
*   Modularity: অ্যাপ্লিকেশনটির বিভিন্ন অংশ পৃথক স্কিমাতে থাকতে পারে।

## Explain the Primary Key and Foreign Key concepts in PostgreSQL.
Primary Key একটি কলাম (বা কলামগুলির গোষ্ঠী) যা একটি টেবিলের প্রতিটি সারি অনন্যভাবে সনাক্ত করে। কোনও দুটি সারি একই প্রাথমিক কী মান থাকতে পারে না এবং এটি বাতিল হতে পারে না।
Foreign Key দুটি টেবিলের মধ্যে একটি লিঙ্ক তৈরি করে। এটি নিশ্চিত করে যে একটি টেবিলের মান অবশ্যই অন্য টেবিলের উপস্থিত থাকতে হবে।

CREATE TABLE species (
  species_id SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  species_id INT REFERENCES species(species_id),
  location TEXT
);

##  What is the difference between VARCHAR and CHAR?
VARCHAR : VARCHAR হল এমন একটি স্ট্রিং টাইপ যা ভ্যারিয়েবল দৈর্ঘ্যের হয়। এটি যতটুকু ক্যারেক্টার দেওয়া হয় ততটুকুই জায়গা ব্যবহার করে।
CHAR(n) :  CHAR হল একটি ফিক্সড দৈর্ঘ্যের স্ট্রিং টাইপ যা সর্বদা n সংখ্যক ক্যারেক্টার জায়গা নেয়, এমনকি যদি ডেটা ছোটও হয়।

* যদি ফিল্ডের দৈর্ঘ্য বিভিন্ন হয় তাহলে VARCHAR ব্যবহার করা ভালো।
* যদি সবসময় নির্দিষ্ট দৈর্ঘ্য দরকার হয়, তখন CHAR উপযোগী।

CREATE TABLE Department (
    department_name VARCHAR(10), 
    department_code CHAR(4)
);
## What is the purpose of the WHERE clause in a SELECT statement?
WHERE ক্লজ একটি শর্তের ভিত্তিতে রেকর্ড ফিল্টার করে। Select ক্যোয়ারী একটি টেবিল থেকে সমস্ত সারি ফেরত দেয়।
WHERE দিয়ে:
১. নির্দিষ্ট অবস্থান বা শর্ত অনুযায়ী ডেটা ফিল্টার করা যায়
২. কমপ্লেক্স কন্ডিশন (AND, OR, NOT) প্রয়োগ করা যায়
৩. তুলনামূলক অপারেটর (=, >, <, LIKE) ব্যবহার করা যায়

SELECT * FROM person WHERE name = 'Adir';

## How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?
Aggregate ফাংশনগুলি সারিগুলির একটি সেটে একটি গণনা সম্পাদন করতে এবং একক মান ফেরত দিতে ব্যবহৃত হয়।
এটি সাধারণত GROUP BY ক্লজের সাথে ব্যবহার করা হয়।

COUNT() – কতগুলো রো আছে তা গণনা করে।
SUM() – সব ভ্যালুর যোগফল বের করে।
AVG() – গড় মান বের করে।

SELECT COUNT(*) FROM Products;
SELECT SUM(Quantity) FROM OrderDetails;
SELECT AVG(Price) FROM Products;
