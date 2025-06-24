import 'dart:io';
String validateName(){
  stdout.write("Enter your name: ");
  String name = stdin.readLineSync()?.trim() ?? "";
  while (name.isEmpty||RegExp(r'\d').hasMatch(name)) {
    stdout.write("Invalid. Enter a valid name (no digits): ");
    name=stdin.readLineSync()?.trim() ?? "";
  }
  return name;
}
String validateCNIC(){
  stdout.write("Enter CNIC (XXXXX-XXXXXXX-X): ");
  String cnic=stdin.readLineSync()?.trim() ?? "";
  while(!RegExp(r'^\d{5}-\d{7}-\d{1}$').hasMatch(cnic)){
    stdout.write("Invalid CNIC. Format should be XXXXX-XXXXXXX-X: ");
    cnic=stdin.readLineSync()?.trim() ?? "";
  }
  return cnic;
}
String validateEmail(){
  stdout.write("Enter your email: ");
  String email=stdin.readLineSync()?.trim() ?? "";
  while (!RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,4}$').hasMatch(email)){
    stdout.write("Invalid email. Try again: ");
    email=stdin.readLineSync()?.trim() ?? "";
  }
  return email;
}
String validatePassword(){
  stdout.write("Enter your password: ");
  String password=stdin.readLineSync()?.trim() ?? "";
  while(
    password.length<8||
    !RegExp(r'[a-zA-Z]').hasMatch(password)||
    !RegExp(r'\d').hasMatch(password) ||
    !RegExp(r'[!@#\$%^&*()_{}\[\]:;<,>.?/\\\-]').hasMatch(password)){
    stdout.write("Weak password. Must be 8+ characters, include letters, numbers & symbols: ");
    password=stdin.readLineSync()?.trim() ?? "";
  }
  return password;
}
String validateContact(){
  stdout.write("Enter contact number (XXXX XXXXXXX): ");
  String contact=stdin.readLineSync()?.trim() ?? "";
  while (!RegExp(r'^\d{4}\s\d{7}$').hasMatch(contact)) {
    stdout.write("Invalid contact. Format: XXXX XXXXXXX: ");
    contact=stdin.readLineSync()?.trim() ?? "";
  }
  return contact;
}
int validateAge(){
  stdout.write("Enter your age: ");
  String input=stdin.readLineSync()?.trim() ?? "";
  int? age=int.tryParse(input);
  while(age==null||age<=0){
    stdout.write("Invalid age. Enter a positive number: ");
    input=stdin.readLineSync()?.trim() ?? "";
    age=int.tryParse(input);
  }
  return age;
}
Map<String, dynamic> getInput(){
  Map<String, dynamic> user={};
  user["Name"]=validateName();
  user["CNIC"]=validateCNIC();
  user["Email"]=validateEmail();
  user["Password"]=validatePassword();
  user["Contact Number"]=validateContact();
  user["Age"] = validateAge();
  return user;
}
List<Map<String, dynamic>> registerUsers(){
  List<Map<String,dynamic>> users=[];
  bool moreUsers=true;
  while(moreUsers){
    print("\nRegistering new user:");
    Map<String,dynamic> user=getInput();
    users.add(user);
    stdout.write("\nRegister another user? (y/n): ");
    String? choice=stdin.readLineSync()?.trim().toLowerCase();
    moreUsers=(choice=='y');
  }
  return users;
}
void printMaskedUsers(List<Map<String, dynamic>> users) {
  print("\nRegistered Users Summary:\n");
  for (int i = 0; i < users.length; i++) {
    print("User ${i + 1}");
    users[i].forEach((key,value) {
      if ((key.toLowerCase())=="password") {
        print("$key: ${'*'*value.length}"); // Mask password
      }else{
        print("$key: $value");
      }
    });
    print("____________________________________");
  }
}
void main(){
  List<Map<String,dynamic>> allUsers=registerUsers();
  printMaskedUsers(allUsers);
}