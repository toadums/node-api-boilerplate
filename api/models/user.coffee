mongoose = require('mongoose')
Schema = mongoose.Schema
bcrypt = require 'bcrypt'
SALT_WORK_FACTOR = 10

# Username and password fields are auto added by passport
UserSchema   = new Schema
  name:
    first: String
    last: String
  email:
    type: String
  username:
    type: String
    unique: true
  password: String

UserSchema.pre 'save', (next) ->
  user = this

  if not user.isModified('password') then return next()

  bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->
    if err then return next err

    bcrypt.hash user.password, salt, (err, hash) ->
      if err then return next err
      user.password = hash
      next()

UserSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, this.password, (err, isMatch) ->
    if err then return cb err
    cb null, isMatch


module.exports = mongoose.model 'User', UserSchema
