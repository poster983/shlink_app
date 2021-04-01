class SupportedFeatures {
  final bool slug;
  final bool multipleDomains;
  final bool clickAnalytics;
  final bool locationAnalytics;

  SupportedFeatures(
      {this.slug = false,
      this.multipleDomains = false,
      this.clickAnalytics = false,
      this.locationAnalytics = false});
}
