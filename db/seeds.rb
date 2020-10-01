require 'pry'

User.destroy_all
Game.destroy_all
UserGame.destroy_all

jacqueline = User.create ({username: "Jacqueline", password: "1234", score: 10})
kevin = User.create ({username: "Kevin", password: "5678", score: 5})
bryan = User.create ({username: "Bryan", password: "0234", score: 8})
bob = User.create ({username: "Bob", password: "0234", score: 7})
will = User.create ({username: "Will", password: "0234", score: 6})
carl = User.create ({username: "Carl", password: "0234", score: 1})
rachel = User.create ({username: "Rachel", password: "0234", score: 4})

game1 = Game.create({difficulty: "easy" })
game2 = Game.create({difficulty: "hard" })
game3 = Game.create({difficulty: "easy" })
game4 = Game.create({difficulty: "easy" })
game5 = Game.create({difficulty: "hard" })
game6 = Game.create({difficulty: "hard" })
game7 = Game.create({difficulty: "easy" })
game8 = Game.create({difficulty: "medium" })
game9 = Game.create({difficulty: "easy" })

ug1 = UserGame.create({user_id: jacqueline.id, game_id: game1.id, won_game: true })
ug2 = UserGame.create({user_id: kevin.id, game_id: game2.id, won_game: true})
ug3 = UserGame.create({user_id: jacqueline.id, game_id: game3.id, won_game: false})
ug4 = UserGame.create({user_id: jacqueline.id, game_id: game4.id, won_game: false})
ug5 = UserGame.create({user_id: kevin.id, game_id: game5.id, won_game: true})
ug6 = UserGame.create({user_id: bryan.id, game_id: game6.id, won_game: false})
ug7 = UserGame.create({user_id: kevin.id, game_id: game7.id, won_game: true})
ug8 = UserGame.create({user_id: jacqueline.id, game_id: game8.id, won_game: true})
ug9 = UserGame.create({user_id: bryan.id, game_id: game9.id, won_game: false})

