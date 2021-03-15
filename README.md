### Assumptions
```text
1. User can only be added via rails console. There are no validations on uniqness of username and email.
2. Only text posts are supported.
3. A user can have multiple posts.
4. A post belongs to only one user.
5. Application security features like authentication, etc. have to be handled separately and not part of this implementation.
```

### System Requirements
- Ruby 3.0.0
- Rails 6.1.1
- Neo4j community edition v3.5.26

### To setup the project, use the following command:
```shell
bundle install
rake neo4j:start
```

### To run rails console:
```shell
rails console
```

### To run rails server:
```shell
rails server
```

### To run tests, use the following command:
```shell
rspec spec
```

### Steps to access UI:
```text
1. Run rails server.
2. To view Users dashboard, go to: http://127.0.0.1:3000/users
3. Click on Show to view more information.
```

### UI features and steps:
```text
1. Add new post
2. Follow more people
3. View the list of followers
4. User can see his own posts.
5. User can see posts of people he/she follow under 'News Feed'.
```

### Developer Notes:
```text
1. If using oh-my-zsh and rake commands are not working, update the command to:
```
```shell
noglob bundle exec rake neo4j:start
```
```text
2. If facing the following error, ensure that neo4j's server is up and running.
```
```shell
Neo4j::Driver::Exceptions::ServiceUnavailableException (unable to acquire connection)
```
```text
3. Neo4j server credentials:
- Username: 'neo4j'
- Password: 'password'
```
