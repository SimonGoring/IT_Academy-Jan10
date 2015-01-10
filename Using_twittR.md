An Introduction to APIs
========================================================

Websites like Twitter, Instagram or Facebook are really programs with input and output that come from and go to people's web browsers.  There are other ways to interface these programs, and they're called APIs, or Application Program Interfaces.  It is an interface between an application and a program.  In this case we'll look at Twitter, and try to interface Twitter with R.

R has a big user group, and people are interested in accessing all sorts of data.  Because of that the APIs for a number of programs have been translated into R code.  You can find more of them [here](http://cran.r-project.org/web/views/WebTechnologies.html) at the CRAN Web Technologies and Services task view.

Each of the packages in the task view are like smaller programs, with specific functions.  There are over 6000 contributed packages to R, so it doesn't make sense to install them all.  Most people use somewhere around 10 or 20 to do all of their analysis.  Because of this when we want to use a particular package we need to download it and install it.  Luckily, R can do that directly from the command line:

```{}
install.packages('twitteR')
```

`twitteR` is one package that we can use to access twitter data from R.  Here the input comes not from a file, or manual entry, but directly from Twitter through its API.  Take a look at the help file for the [package](http://cran.r-project.org/web/packages/twitteR/twitteR.pdf).

Some APIs are free to use, some are more complicated and require pre-registration.  In the case of the Twitter API you need a special code.  For our purposes we'll use a common code that I'll give you directly.  It's hidden in a file called `unread.R`.  Because this tutorial is online I don't want everyone to have access to the API code so we'll just pretend it's there.  If you are doing this independently I found [this](http://bogdanrau.com/blog/collecting-tweets-using-r-and-the-twitter-search-api/) tutorial helpful for setting up the API and getting the key codes.  It also shows you how to do some more advanced analysis.

So let's look for a specific tweet.  I sent out a tweet the other day that used a nonsense hashtag, can the Twitter API find it?


```r
#  To Use this example you need your own twitter account.

library(twitteR)
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

#  This is where the keys are, but they're hidden.
source('R/unread.R')

twitCred <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret,
                             requestURL=reqURL,
                             accessURL=accessURL,
                             authURL=authURL)

twitCred$handshake(ssl.verifypeer = FALSE) #Pause here for the Handshake Pin Code

registerTwitterOAuth(twitCred) #Wait till you see True

#  Takes about 1 min to register.
test_tweet <- searchTwitter("#mamdmamgasfd", n=2000, ssl.verifypeer = FALSE) #Get the Tweets
```

Okay, this code should have worked and you should get a resonse that looks something like this:



What does that one tweet look like?


```r
test_tweet
```

Not much, but that's because the variable `test_tweet` is a special kind of variable, or `class`.  We've already seen `character` (the 'Red' and 'White' example) and `numeric` variable, there are lots of other classes, and each have special methods associated with them, one of which is `print`.

`print` is the function that prints things to the screen.  If you just type a variable name that invokes the `print` function.  You can find the `class` of a variable using the `class` function:

```{}
class(test_tweet)
```

To get these tweets into a more usable format, and one we're familiar with we can use the command `twListToDF`.  If we do that to the tweet that we found it will look something like this:

```{}
                                                                            text favorited favoriteCount replyToSN
1 This is a test tweet for tomorrow's @UWMadison IT Academy course #mamdmamgasfd     FALSE             0        NA
              created truncated replyToSID                 id replyToUID
1 2015-01-10 01:32:52     FALSE         NA 553726131892150272         NA
                                                        statusSource screenName retweetCount isRetweet retweeted
1 <a href="http://twitter.com" rel="nofollow">Twitter Web Client</a>   sjGoring            0     FALSE     FALSE
  longitude latitude
1        NA       NA
```

So we can see different column names, data about the tweet and the tweet itself (the column `text`).  So lets break and think up some wuestions we can ask about twitter and twitter data and come back and actually apply some of this knowledge to a real exercise.
