enum EikeRoute {
  home('/home'),
  contact('/contact'),
  settings('/settings'),
  imprint('/imprint'),
  privacyPolicy('/privacyPolicy')
  ;

  const EikeRoute(this.route);
  final String route;
}
