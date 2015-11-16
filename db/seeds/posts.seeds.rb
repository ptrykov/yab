post_1 = <<-TEXT
Game of Thrones is an American fantasy drama television series created by showrunners David Benioff and D. B. Weiss.
It is an adaptation of A Song of Ice and Fire, George R. R. Martin's series of fantasy novels, the first of which is titled A Game of Thrones.
It is filmed in a Belfast studio and on location elsewhere in Croatia, Iceland, Malta, Morocco, Northern Ireland, Spain, Scotland, and the United States, and premiered on HBO in the United States on April 17, 2011. 
The series completed airing its fifth season on June 14, 2015, and has been renewed for a sixth season.
TEXT
post_2 = <<-TEXT
Game of Thrones has attracted record numbers of viewers on HBO and attained an exceptionally broad and active international fan base.
It has received widespread acclaim by critics, particularly for its acting, complex characters, story, scope, and production values, 
although its frequent use of nudity, violence, and sexual violence has attracted criticism. The series has won 26 Primetime Emmy Awards,
including the Primetime Emmy Award for Outstanding Drama Series in 2015—when it set a record for most wins for a series in a single year—and 
numerous other awards and nominations, including three Hugo Award for Best Dramatic Presentation, a Peabody Award, and two Golden Globe Award 
nominations. From among the ensemble cast, Peter Dinklage won two Emmy Awards for Outstanding Supporting Actor in a Drama Series and a Golden 
Globe Award for Best Supporting Actor – Series, Miniseries or Television Film for his performance as Tyrion Lannister.
TEXT
after :users do 
  john = User.find(1)
  Post.seed(:id,
    { id: 1, title: 'Introduction', body: post_1, user: john },
    { id: 2, title: 'Chapter: 1', body: post_2, user: john },
  )
end
