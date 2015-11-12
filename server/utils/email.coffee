Eztrucker.Utils.Emails={
  prepareEnrollmentEmail:(user)->

    userId=user._id
    email= Meteor._get(user,'emails',0,'address')
    unless email or userId
      throw new Error("No such email for user.")
    token = Random.secret()
    tokenRecord = {
      token: token,
      email: email,
      when: new Date()
    }

    Meteor.users.update(userId, {$set: {"services.password.reset": tokenRecord }});

    Meteor._ensure(user, 'services', 'password').reset = tokenRecord;

    Accounts.urls.enrollAccount(token);
}