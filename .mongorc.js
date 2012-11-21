
function runShell(cmd) {
	run("bash", "-c", cmd);
}


function underscore() {
	runShell("cp -f $SPX_DEV_ROOT/wf/config/underscore.js /tmp/mongo_underscore.js");
	load("/tmp/mongo_underscore.js");
}


// Load underscore.js on the MongoDB server
function server_underscore(force) {
  force = force || false;
  if (force || typeof(spxUnderscoreLoadedInServer) === 'undefined') {
    print("Loading underscore.js on the MongoDB server using db.eval()");
	  db.eval(cat("/tmp/mongo_underscore.js"));
	  spxUnderscoreLoadedInServer = true;
  }
}


////////////////////////////////////////////////////////////////
//
//  Debugging & display
//
////////////////////////////////////////////////////////////////


// printjson is all lowercase; this helps
function printJson(what) {
  printjson(what);
}


// JSON print every item
function pp(what) {
	if (what['forEach']) {
  		what.forEach(printjson);
	} else {
		printjson(what);
	}
}


////////////////////////////////////////////////////////////////
//
//  Data formatting & manipulation
//
////////////////////////////////////////////////////////////////


// Builds an array of all the elements of a result set
function toArray(what) {
  var a = new Array();
  what.forEach(function(o) {
    a.push(o);
  });
  return a;
}


// tojson() is all lowercase; this helps
function toJson(o) {
  return tojson(o);
}


////////////////////////////////////////////////////////////////
//
//  Generic MongoDB utilities
//
////////////////////////////////////////////////////////////////


// Save an item to the temp collection
function saveToTemp(o) {
  db.temp.save(o);
}


// Returns the biggest document in a collection
function biggest(cursor) {
  var biggest = 0, doc = {};
  cursor.forEach(function(o) {
    var obj_size = Object.bsonsize(o);
    if (obj_size > biggest) {
      biggest = obj_size;
      doc = o;
    }
  });
  return doc;
}


// Returns the size of the biggest document in a collection
function biggestSize(cursor) {
  return Object.bsonsize(biggest(cursor));
}


// Shows all indexes per collection
function allIndexes() {
  db.getCollectionNames().forEach(function(x) {
    print("Collection: " + x);
    printjson(db[x].getIndexes());
  });
}


// Returns an array of collections matching a regular expression
function collectionsByRegex(re) {
  var collections = [];
  db.getCollectionNames().forEach(function(name) {
    if (re.test(name)) collections.push(db[name]);
  });
  return collections;
}


// Copies all documents from a collection to another collection
function copyCollection(source, dest) {
  dest = dest || (source + "_copy");

  var fnCopy = function (source, dest) {
    db[dest].drop();
    db[source].find({}).forEach(function(doc) {
      db[dest].insert(doc);
    });
  };

  db.eval(fnCopy, source, dest);
}


// Copies many collections using a prefix naming scheme
function copyCollections(sources, key) {

  var fnCopy = function (sources, key) {
    sources.forEach(function(source) {
      var dest = "c_" + key + "_" + source;
      db[dest].drop();
      db[source].find({}).forEach(function(doc) {
        db[dest].insert(doc);
      });
    });
  };

  db.eval(fnCopy, sources, key);
}


// Callstack printing on exception -- wraps a function
function dbg(f) {
  try {
    f();
  } catch (e) {
    print("\n**** Exception: " + e.toString());
    print("\n");
    print(e.stack);
    print("\n");
    if (arguments.length > 1) {
      printjson(arguments);
      print("\n");
    }
    throw e;
  }
}


// Updates documents in a collection with a provided function
function updateDocs(coll_name, query, fn) {
  return db.eval(
      function (collection, query, fn) {
        db[collection].find(query).forEach(function (doc) {
          if (fn.apply(doc)) {
            db[collection].save(doc);
          }
        });
      },
      coll_name,
      query,
      fn
  );
}


// Generates a hash from a keys array with a provided function that operates on the keys
function generateHash(keys, fn) {
  var h = {};
  for (var i in keys) h[keys[i]] = fn(keys[i]);
  return h;
}


////////////////////////////////////////////////////////////////
//
//  Date helper functions
//
////////////////////////////////////////////////////////////////


function minutesAgo(minutes, d) {
  d = d || new Date();
  return new Date(d.valueOf() - minutes * 60 * 1000);
}


function hoursAgo(hours, d) {
  d = d || new Date();
  return minutesAgo(60 * hours, d);
}


function daysAgo(days, d) {
  d = d || new Date();
  return hoursAgo(24 * days, d);
}


////////////////////////////////////////////////////////////////
//
//  SPX-related utilities
//
////////////////////////////////////////////////////////////////


// Load internal utilities file
function li() {
  load("internal.js");
}


