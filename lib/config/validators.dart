class Validators {
  static String? validateName(String? value, String type) {
    if (value!.isEmpty) {
      return "$type is Required";
    } else if (value.length < 6) {
      return "$type must be more than 6 charater";
    }
    return null;
  }

  static String? validateRequired(value, {String? type}) {
    if (value == null || value!.length == 0) {
      return "Required field";
    }
    return null;
  }

  static String? validatePostalCode(String? value, {String? type}) {
    if (value!.length < 6) {
      return "Should contain 6 digits";
    } else if (value.isEmpty) {
      return "Required";
    }

    return null;
  }

  String? validateMobile(String? value) {
    String patttern = r'(^\(?([0-9]{3})\)?[-.●]?([0-9]{3})[-.●]?([0-9]{4,5})$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Phone number is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Phone number is not valid (Minimum 10 digits)";
    }
    return null;
  }

  //For Email Verification we using RegEx.
  static String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Password is Required";
    } else {
      return null;
    }
  }

  static String validatepass(String value) {
    if (value.isEmpty) {
      return 'Please enter Password';
    }
    if (value.length < 6) {
      return 'Must be more than 6 charater';
    } else {
      return "";
    }
  }

  String? validateBusinessMobile(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Mobile is Required";
    } else if (value.length != 10) {
      return "Mobile number must 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String? validateestablishedyear(String value) {
    var date = DateTime.now();
    int currentYear = date.year;
    int userinputValue = 0;

    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    // int numValue = int.parse(value);
    if (!regExp.hasMatch(value)) {
      return "Year must be number only";
    } else if (value.isEmpty) {
      return "Established Year is Required";
    } else {
      userinputValue = int.parse(value);
    }

    if (userinputValue < 1850 || userinputValue > currentYear) {
      return "Year must be between 1850 and $currentYear";
    }
    return null;
  }

  String? validateLicenseno(String value) {
    if (value.isEmpty) {
      return "License No is Required";
    }
    return null;
  }

  String? validatenumberofemployee(String value) {
    String patttern = r'(^[1-9]\d*(\.\d+)?$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Number of employee is Required";
    } else if (value.length > 4) {
      return "Number of employee is not more than 9999";
    } else if (!regExp.hasMatch(value)) {
      return "Number of employee must be digits";
    }
    return null;
  }

  String? validatedate(String value) {
    String patttern = r'([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Date is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid date";
    }
    return null;
  }

  String? validateLicenseissuingauthority(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "License Issuing Authority is Required";
    } else if (!regExp.hasMatch(value)) {
      return "License Issuing Authority must be a-z and A-Z";
    }
    return null;
  }
}

bool validate(data) {
  if (data != "" && data != null) {
    return true;
  } else {
    return false;
  }
}
