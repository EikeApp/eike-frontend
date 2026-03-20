enum EikeRoute {
  home('/home'),
  contact('/contact'),
  settings('/settings'),
  imprint('/imprint'),
  licenses('/licenses'),
  privacyPolicy('/privacyPolicy')
  ;

  const EikeRoute(this.route);
  final String route;
}
