//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<barcode_scan/BarcodeScanPlugin.h>)
#import <barcode_scan/BarcodeScanPlugin.h>
#else
@import barcode_scan;
#endif

#if __has_include(<geocoding/GeocodingPlugin.h>)
#import <geocoding/GeocodingPlugin.h>
#else
@import geocoding;
#endif

#if __has_include(<geolocator/GeolocatorPlugin.h>)
#import <geolocator/GeolocatorPlugin.h>
#else
@import geolocator;
#endif

#if __has_include(<google_maps_flutter/FLTGoogleMapsPlugin.h>)
#import <google_maps_flutter/FLTGoogleMapsPlugin.h>
#else
@import google_maps_flutter;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BarcodeScanPlugin registerWithRegistrar:[registry registrarForPlugin:@"BarcodeScanPlugin"]];
  [GeocodingPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeocodingPlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [FLTGoogleMapsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleMapsPlugin"]];
}

@end
