

mixin Validator {
  String? validateName(String value){
    if( value == null || value.isEmpty ) {
        return 'Name is required, please.';
    }
    return null;
  }
}