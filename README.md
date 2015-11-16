# Rails api Backend

To initialize application run
```
db:setup
```

Models:

 * User
 * Post
 * Comment
 * Role

For example you can curl resources:
```ruby
#get posts list
curl 'http://127.0.0.1:3000/api/v1/posts'

#list comments
curl 'http://127.0.0.1:3000/api/v1/posts/1/comments'

#create new user
curl -X POST 'http://127.0.0.1:3000/api/v1/users.json' -d 'user[email]=test@test.com&user[password]=qwerty123&password_confirmation=qwerty123&user[firstname]=John&user[lastname]=Snow'

#delete user
curl -X DELETE 'http://127.0.0.1:3000/api/v1/users/1' -u 'admin@example.com:qwerty123'
```
:alien:
