enum UserType { parent, child , none}

extension UserTypeParser on String {
  
  UserType toUserType() {
    switch (this) {
      case 'parent':
        return UserType.parent;
      case 'child':
        return UserType.child;
      case 'none':
        return UserType.none;
      
      default:
        throw ArgumentError('Invalid user type: $this');
    }
  }
}
