# About
Roughly what I want to start with when creating a new API for use with web, iOS, or what ever.

## Setup
Install:
 * [Homebrew](http://brew.sh/)
 * [MongoDB](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-os-x/)
 * Nodemon: `npm install -g nodemon`
 * Coffeescript: `npm install -g coffee-script`
 * Mocha: `npm install -g mocha`
 
## Run
`./go.sh`

## Routing
There are 5 methods for routing. You will want to put them in `api/routes/index.coffee`

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

#### Router.[verb]
If you need more flexibility, you can specify routes the following way:

```
# A post to /login will run the create action in the sessions controller
Router.post 'login', controller: 'sessions', action: create

# A get to /book/moby_dick will run the find method of the books controller, for id = moby_dick
Router.get '/book/:id', controller: 'books', action: find
```

These methods are available for: `GET`, `POST`, `PUT`, and `DELETE`
