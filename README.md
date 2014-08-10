# About
Roughly what I want to start with when creating a new API for use with web, iOS, or what ever.

## Setup
Install:
 * [Homebrew](http://brew.sh/)
 * [MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)
 * Nodemon: `npm install -g nodemon`
 * Coffeescript: `npm install -g coffee-script`

## Run
`./go.sh`

## Routing
There are 5 methods for routing.

#### Router.resource
Use this if you just want to implement some, or all of:

|Verb   |Path   	|Action   	   |Description |
|---	  |---	    |---	         |---	|
|GET   	|/users   |users#index   |display a list of all users |
|POST   |/users   |users#create  |create a new user   	      |
|GET   	|/users   |users#show    |display a specific user   	|
|PUT    |/users   |users#update  |update a specific user      |
|DELETE |/users   |users#destroy |delete a specific user   	  | 

```
# create all 5 routes
Router.resource 'u', controller: 'users' 

# create only the actions (of the 5 above) you list
Router.resource 'u', controller: 'users', only: [index, create] 
```
