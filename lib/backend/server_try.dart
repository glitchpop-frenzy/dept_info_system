import 'package:mongo_dart/mongo_dart.dart';
import 'package:sevr/sevr.dart';

void main() async {
  final db = await Db.create(
      'mongodb+srv://saksham:saksham@cluster0.ayj3r.mongodb.net/apptest?retryWrites=true&w=majority');
  await db.open();

  const port = 3000;
  final serv = Sevr();

  final prof = db.collection('prof');
  final Aprof = db.collection('Aprof');
  final phd = db.collection('phd');
  final resources = db.collection('resources');
  final users = db.collection('users');

  serv.listen(port, callback: () {
    print('listening of 3000');
  });

  //REGISTER
  serv.post('/register/:type', [
    (ServRequest req, ServResponse res) async {
      if (req.params['type'] != 'resources') {
        await users.insert(
            {'userId': req.body['login'], 'password': req.body['password']});
        print('inserted');
      }
      print(req.params['type']);
      if (req.params['type'] == 'prof') {
        await prof.insert({
          'userId': req.body['login'],
          //  'password': req.body['password'],
          'name': req.body['name'],
          'dept': req.body['dept'],
          'education': req.body['education'],
          'DoJ': req.body['date'],
          'additional': req.body['additional']
        });
        print('prof inserted');
      } else if (req.params['type'] == 'Aprof') {
        await Aprof.insert({
          'userId': req.body['login'],
          //'password': req.body['password'],
          'name': req.body['name'],
          'dept': req.body['dept'],
          'education': req.body['education'],
          'DoJ': req.body['date'],
          'additional': req.body['additional']
        });
      } else if (req.params['type'] == 'phd') {
        await phd.insert({
          'userId': req.body['login'],
          // 'password': req.body['password'],
          'name': req.body['name'],
          'dept': req.body['dept'],
          'education': req.body['education'],
          'DoJ': req.body['date'],
          'thesis': req.body['thesis']
        });
      } else if (req.params['type'] == 'resources') {
        await resources.insert({
          'id': req.body['id'],
          'type': req.body['type'],
          'dept': req.body['dept'],
          'capacity': req.body['capacity'],
          'LabAsst': req.body['LabAsst'],
        });
      }
      return res.status(200).json({'inserted': 'Ok'});
    }
  ]);

  //LOGIN
  serv.get('/login', [
    (ServRequest req, ServResponse res) async {
      print('InLogin');
      var user = await users.findOne(where.eq('userId', req.query['login']));

      if (user != null) {
        // If user exists
        if (user['password'] == req.query['password']) {
          // If input password is correct
          return res
              .status(200)
              .json({'user_exists': 'Yes', 'verified': 'Yes'});
        } else {
          // If input password is incorrect
          return res.status(200).json({'user_exists': 'Yes', 'verified': 'No'});
        }
      } else {
        // If user does not exist
        return res.status(200).json({'user_exists': 'No', 'verified': 'No'});
      }
    }
  ]);

  //SHOW INDIVIDUAL PAGE
  serv.get('/individualPage/:type', [
    // /individualPage/prof?userId=$userId
    (ServRequest req, ServResponse res) async {
      print('Insearch');
      if (req.params['type'] == 'prof') {
        var user = await prof.findOne(where.eq('userId', req.query['userId']));
        if (user != null) {
          return res.status(200).json({'userdata': user, 'found': 'true'});
        } else {
          return res.status(200).json({'found': 'false'});
        }
      } else if (req.params['type'] == 'Aprof') {
        var user = await Aprof.findOne(where.eq('userId', req.query['userId']));
        if (user != null) {
          return res.status(200).json({'userdata': user});
        } else {
          return res.status(200).json({'found': 'false'});
        }
      } else if (req.params['type'] == 'phd') {
        var user = await phd.findOne(where.eq('userId', req.query['userId']));
        if (user != null) {
          return res.status(200).json({'userdata': user});
        } else {
          return res.status(200).json({'found': 'false'});
        }
      } else if (req.params['type'] == 'resources') {
        var user = await resources.findOne(where.eq('id', req.query['id']));
        if (user != null) {
          return res.status(200).json({'userdata': user});
        } else {
          return res.status(200).json({'found': 'false'});
        }
      } else {
        return res.status(200).json({'status': 'notFound'});
      }
    }
  ]);

  //SHOW DEPARTMENT PAGE
  serv.get('/department/:type', [
    (ServRequest req, ServResponse res) async {
      /*  var profList = prof.find(where.eq('dept', req.query['dept']).and(where.eq())).toList();
      var AprofList = Aprof.find(where.eq('dept', req.query['dept'])).toList();
      var phdList = phd.find(where.eq('dept', req.query['dept'])).toList();
      var resourcesList =resources.find(where.eq('dept', req.query['dept'])).toList();
      */
      if (req.params['type'] == 'prof') {
        var list =
            await prof.find(where.eq('dept', req.query['dept'])).toList();
        return res.status(200).json({'list': list});
      } else if (req.params['type'] == 'Aprof') {
        var list =
            await Aprof.find(where.eq('dept', req.query['dept'])).toList();
        return res.status(200).json({'list': list});
      } else if (req.params['type'] == 'phd') {
        var list = await phd.find(where.eq('dept', req.query['dept'])).toList();
        return res.status(200).json({'list': list});
      } else if (req.params['type'] == 'resources') {
        var list =
            await resources.find(where.eq('dept', req.query['dept'])).toList();
        return res.status(200).json({'list': list});
      }
    }
  ]);

  //SHOW PROF/APROF/PHD/RESOURCES PAGE
  serv.get('/listPage/:type', [
    (ServRequest req, ServResponse res) async {
      if (req.params['type'] == 'prof') {
        var list = await prof.find().toList();
        return res.status(200).json({'list': list});
      } else if (req.params['type'] == 'Aprof') {
        var list = await Aprof.find().toList();
        return res.status(200).json({'list': list});
      } else if (req.params['type'] == 'phd') {
        var list = await phd.find().toList();
        return res.status(200).json({'list': list});
      } else if (req.params['type'] == 'resources') {
        var list = await resources.find().toList();
        return res.status(200).json({'list': list});
      }
    }
  ]);

  //USER LIST
  serv.get('/user', [
    (ServRequest req, ServResponse res) async {
      var userList = users.find().toList();
      return res.status(200).json({'userList': userList});
    }
  ]);

//Change password
//UPDATE
  serv.post('/editProfile/:type', [
    // local/editProfile/prof, body: {}
    (ServRequest req, ServResponse res) async {
      if (req.params['type'] == 'prof') {
        await prof.update(
            await where.eq('userId', req.body['userId']),
            req.body[
                'newData']); // newData = {'userId': a001, newData: {name, userId, DoJ, education, additional, dept}}
        return res.status(200).json({'updated': 'true'});
      } else if (req.params['type'] == 'Aprof') {
        await Aprof.update(
            await where.eq('userId', req.body['userId']), req.body['newData']);
        return res.status(200).json({'updated': 'true'});
      } else if (req.params['type'] == 'phd') {
        await phd.update(
            await where.eq('userId', req.body['userId']), req.body['newData']);
        return res.status(200).json({'updated': 'true'});
      } else if (req.params['type'] == 'resources') {
        await resources.update(
            await where.eq('name', req.body['name']), req.body['newData']);
        return res.status(200).json({'updated': 'true'});
      } else if (req.params['type'] == 'password') {
        await users.update(
            where.eq('userId', req.body['username']), req.body['newData']);
      }
    }
  ]);
}
