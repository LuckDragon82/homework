##Hireology Software Engineer Homework

### Instructions

There are two parts to the Software Engineer Homework set. Part 1 is written answer, and Part 2 is a set of programmable problems. Please fork this repo to your GitHub account, add your work to the forked repo, and send a pull request when your work is complete.

###Part 1 - Written Questions

1. How can Memcache improve a site’s performance? Include a description about how data is stored and retrieved in a multi-node configuration.

Memcache can improve a web sites performance by decreasing the number of calls to the database. Memcached is an in memory key-value store for small chuncks of data (http://memcached.org/). Memcache servers can be stand alone servers or they may on the same server as a rails server. Each client has the list of all of the memcache servers and share the same hashing algorithm. Whenever a client needs data from the database it first checks if the data is stored in the memcache server. If it is, then it is retrieved. If it is not, then the client makes the request from the database. After it has the data from the database it stores the data in memcache. The clients know which server to request the data from (and where to send the data) because they all have a list of servers and the same hashing algorithm. The memcache servers do not talk directly to each other or sync.


2. Please take a look at [this controller action](https://github.com/Hireology/homework/blob/master/some_controller.rb). Please tell us what you think of this code and how you would make it better.

###Part 2 - Programming Problems

1) Write a program using regular expressions to parse a file where each line is of the following format:

`$4.99 TXT MESSAGING – 250 09/29 – 10/28 4.99`

For each line in the input file, the program should output three pieces of information parsed from the line in the following JSON format (using the above example line):

```
{
  “feature” : “TXT MESSAGING – 250”,
  “date_range” : “09/29 – 10/28”,
  “price” : 4.99 // use the last dollar amount in the line
}
```

2) Please complete a set of classes for the problem described in [this blog post](http://www.adomokos.com/2012/10/the-organizations-users-roles-kata.html). Please do not create a database backend for this. Test doubles should work fine.

- Had some trouble using Test Doubles instead of sqlite for testing. I would need to come up to speed on this on the job. After I submitted my pull request, I decided to checkout what the other candidates were doing. I realized I forgot about just doing a simple Plain Old Ruby version for question 4. so I wrote organization.rb . The work is entirely my own, I didn't look long enough to copy anything. But the idea for it came from one of the other submissions.
