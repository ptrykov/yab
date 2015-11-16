after :posts do
  post = Post.find(1)
  user = User.find(2)
  Comment.seed(:id,
    { id: 1, body: 'Interesting film!',  user: user, post: post },
    { id: 2, body: "I'm pretty excited", user: user, post: post },
  )
end
