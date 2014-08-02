mongoose = require('mongoose')
Schema = mongoose.Schema
passportLocalMongoose = require('passport-local-mongoose');

# Username and password fields are auto added by passport
UserSchema   = new Schema
  name:
    first: String
    last: String
  email:
    type: String
    unique: true

UserSchema.plugin(passportLocalMongoose);

module.exports = mongoose.model 'User', UserSchema
