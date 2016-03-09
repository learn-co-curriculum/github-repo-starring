# Star Github Repo

## The Constants File

We've gone ahead and brought in code that fetches the list of public repositories from Github and displays it in a table view. To get htat code working, you'll need to create the `FISConstants.m` file add your client ID and secret to it, in a format like this:

```objc
NSString *const GITHUB_CLIENT_ID = @"your app ID";
NSString *const GITHUB_CLIENT_SECRET = @"your app secret";
```

This is how the exising API client builds URLs for talking to the API; check out the API client to see the details. It's good practice to put your constants into one file like this so they can be changed easily.

Once you've set up that done that, run the app to make sure the table view is being populated correctly.

## Goal

We want to be able to tap on repos in the table view and have it star or unstar the repository appropriately, using Github's API. You can see the overview of the relevant API calls [here](https://developer.github.com/v3/activity/starring/).

## Instructions

  1. Create the method in `FISGithubAPIClient` called `isRepositoryStarred:completion:` that accepts a repo full name (e.g. `githubUser/repoName`) and checks to see if it is currently starred. The completion block should take a boolean (true for starred, false otherwise). Checkout the [Github Documentation](https://developer.github.com/v3/activity/starring/#check-if-you-are-starring-a-repository) on how this works on the API side. 
  2. Make a method in `FISGithubAPIClient` that stars a repo given its full name. Checkout the [Github Documentation](https://developer.github.com/v3/activity/starring/#star-a-repository).
  3. Make a method in `FISGithubAPIClient` that unstars a repo given its full name. Checkout the [Github Documentation](https://developer.github.com/v3/activity/starring/#unstar-a-repository).
  4. Create a method in `FISReposDataStore` that, given a `FISGithubRepository` object, checks to see if it's starred or not and then either stars or unstars the repo. That is, it should toggle the star on a given repository. In the completion block, there should be a `BOOL` parameter called `starred` that is `YES` if the repo was just starred, and `NO` if it was just unstarred.
  5. Finally, when a cell in the table view is selected, it should call your `FISReposDataStore` method to toggle the starred status and display a `UIAlertController` saying either "You just starred <REPO NAME>" or "You just unstarred <REPO NAME>".


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/github-repo-starring' title='Star Github Repo'>Star Github Repo</a> on Learn.co and start learning to code for free.</p>
