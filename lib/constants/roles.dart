enum Roles {
  COMPETENCIES,
  FRONTEND,
  BACKEND,
  MOBILE,
  OTHER,
}

Roles mapRolesFromString(String role) {
  Roles selectedRole = Roles.OTHER;
  roles.forEach((key, value) {
    if (value.contains(role?.toLowerCase())) selectedRole = key;
  });
  return selectedRole;
}

String mapRolesToString(Roles role) {
  switch (role) {
    case Roles.FRONTEND:
      return 'frontend';
    case Roles.BACKEND:
      return 'backend';
    case Roles.MOBILE:
      return 'mobile';
    case Roles.COMPETENCIES:
      return 'competencies';
    default:
      return 'other';
  }
}

// contains variants of role name for parsing from Calendar Api
final Map<Roles, Set<String>> roles = {
  Roles.FRONTEND: {
    'frontend',
    'FrontEnd',
    'Front-End',
    'Front-end',
    'Frontend',
    'front-end',
  },
  Roles.BACKEND: {
    'backend',
    'BackEnd',
    'Back-End',
    'Back-end',
    'Backend',
    'back-end',
  },
  Roles.MOBILE: {
    'mobile',
    'Mobile',
    'MOBILE',
  },
  Roles.COMPETENCIES: {
    'comp',
    'competencies',
    'compet',
  }
};
