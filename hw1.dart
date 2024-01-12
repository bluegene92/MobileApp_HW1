

void main() {
  Student person = Student("Tom", "Holland", 20, SchoolYear.Senior, 3.5);
  
  
  List<Feature> likes = [
    Feature("Type Safety",
    """I like Dart Static typing because it can detect type-related errors 
                          during development with predictive behavior.
    """, true),
    Feature("Async Future",
    """Dart async feature is very similar to Javascript async Promise, 
                          which is great for dealing with long running tasks 
                          have unknown completion time.
    """, true),
    Feature("Interoperability",
    """It is easy to integrate Dart code with existing Javascript 
                          Frameworks and libraries.
   """, true)
  ];
  
  List<Feature> dislikes = [
    Feature("Record",
           """I find Dart Record feature verbose and difficult to read.
                          Though it is use to make class like data immutable, 
                          I think its syntax could be improve.
           """, false),
    Feature("Generic",
           """Even though Generic helps with type safety, I have seen
                          from other languages how over abstraction with 
                          Generic can make code difficult to understand.
           """, false),
    Feature("Document",
           """The Dart documentation feels out of date and it would be 
                          nice if Google revamp it with more examples and 
                          tutorial. Alot of changes with Javascript ES6 and 
                          it would be nice to go back and compare it with Dart now.
           """, false)
  ];
  
  person.addReview(likes[0]);
  person.addReview(likes[1]);
  person.addReview(likes[2]);
  person.addReviews(dislikes);
  
  
  print(person.info());
  List<Feature> allFeatures = [...person.getLikeFeatures(), ...person.getUnlikeFeatures()];
  FeatureReviewPrinter.printFeature(allFeatures);
}

enum SchoolYear { Freshmen, Sophmore, Junior, Senior }

class Person {
  String firstName;
  String lastName;
  int age;
  
  Person(this.firstName, this.lastName, this.age);
  
  String info() {
    return """ 
      ${padLeftLabel('Name', 6)}: ${firstName} ${lastName}
      ${padLeftLabel('Age', 6)}: ${age}""";
  }
  
  String padLeftLabel(String s, int width) {
    return s.padLeft(width);
  }
}

class Student extends Person {
  String firstName;
  String lastName;
  int age;
  SchoolYear schoolYear;
  double gpa;
  List<Feature> reviews = [];
  Student(this.firstName, this.lastName, this.age, this.schoolYear, this.gpa) : super(firstName, lastName, age);
  
  String info() {
    return """${super.info()}
      ${super.padLeftLabel('Year', 6)}: ${schoolYear.name}
      ${super.padLeftLabel('GPA', 6)}: ${gpa}
    """;
  }
  
  void addReview(Feature feature) {
    reviews.add(feature);
  }
  
  void addReviews(List<Feature> features) {
    reviews.addAll(features);
  }
  
  List<Feature> getLikeFeatures() {
    return reviews.where((r) => r.isLike).toList();
  }
  
  List<Feature> getUnlikeFeatures() {
    return reviews.where((r) => !r.isLike).toList();
  }
}

class Feature {
  String featureName;
  String review;
  bool isLike;
  
  Feature(this.featureName, this.review, this.isLike);
}

class FeatureReviewPrinter {
  static printFeature(List<Feature> features) {
    String featureLabel = "Feature".padRight(16);
    String likeLabel = "Like".padRight(8);
    String reviewLabel = "Review".padRight(30);
    print("$featureLabel $likeLabel $reviewLabel");
    print('------------------------------------------------------------------------------');
    
    for(Feature feature in features) {
      String featureNamePad = feature.featureName.padRight(16);
      String featureLikePad = feature.isLike? "Like" : "Unlike";
      String featureReviewPad = feature.review;
      
      print("""${featureNamePad} ${featureLikePad.padRight(8)} ${featureReviewPad}""");
    }
  }
}