# By using the symbol :user, we get factory girl to simulate the user model
Factory.define :user do |user|
  user.name                   "Ben Zittlau"
  user.email                  "bzittlau@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end